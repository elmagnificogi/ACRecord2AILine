"""Independent longitudinal checks against reported SU7 Ultra road-test figures.

Reuses the existing hypothetical plant/controllers without changing their maps.
Outputs are neither AC telemetry nor identified Xiaomi tire/ECU parameters.
"""
from __future__ import annotations
import argparse
from dataclasses import asdict
import hashlib
import json
from pathlib import Path
import time

import numpy as np
from simulate import ROOT, DATA, PlantParams, FourWheelPlant, FixedSplitReference, LuaController
from vehicle_variants import hardware_scope

OUTPUT = ROOT / "outputs" / "video-validation"
SOURCE = "https://www.autohome.com.cn/drive/202503/1304491.html"
TARGETS = {
    "reportedBest0To100S": 2.36,
    "reportedBest0To200S": 5.82,
    "reportedSeparateVenue400mS": 9.13,
    "reportedSeparateVenue400mTerminalKmh": 253.25,
    "reported100To0AsphaltM": 33.98,
    "reported100To0ConcreteM": 35.67,
}


def interpolate_crossing(previous, current, value_key, target, rising=True):
    """Linear interpolation of time and distance at the first threshold crossing."""
    a, b = previous[value_key], current[value_key]
    crossed = a < target <= b if rising else b <= target < a
    if not crossed:
        return None
    fraction = (target - a) / (b - a)
    return {key: previous[key] + fraction * (current[key] - previous[key])
            for key in ("t", "speed", "distance")}


def residual_report(speed, mass, last_deceleration):
    return {
        "residualSpeedKmh": speed * 3.6,
        "residualKineticEnergyJ": .5 * mass * speed ** 2,
        "constantLastDecelerationResidualDistanceEstimateM":
            speed ** 2 / (2 * last_deceleration) if last_deceleration > .05 else None,
        "residualEstimatePolicy": "Last-deceleration extrapolation only; not a simulated complete stop.",
    }


def self_checks():
    checks = []
    # For v(t)=a*t, linear speed interpolation must find the exact target time.
    c = interpolate_crossing({"t": 1., "speed": 2., "distance": 1.},
                             {"t": 2., "speed": 4., "distance": 4.}, "speed", 3.)
    assert c and abs(c["t"] - 1.5) < 1e-12
    checks.append("Constant-acceleration speed crossing time agrees with analytic target.")
    # Distance interpolation is deliberately linear between adjacent integration
    # points, not claimed exact for a 1 s interval under acceleration.
    c = interpolate_crossing({"t": 1., "speed": 2., "distance": 2.},
                             {"t": 2., "speed": 2., "distance": 4.}, "distance", 3.)
    assert c == {"t": 1.5, "speed": 2., "distance": 3.}
    checks.append("Constant-speed distance crossing finds exact time and speed.")
    c = interpolate_crossing({"t": 0., "speed": 20., "distance": 0.},
                             {"t": 1., "speed": 10., "distance": 15.}, "speed", 15., False)
    assert c == {"t": .5, "speed": 15., "distance": 7.5}
    assert interpolate_crossing({"t": 0., "speed": 20., "distance": 0.},
                                {"t": 1., "speed": 10., "distance": 15.}, "speed", 25., False) is None
    checks.append("Descending speed crossing and uncrossed-target exclusion behave correctly.")
    # Trapezoidal integration of a linear velocity is exact and nondecreasing.
    speeds = np.linspace(0., 30., 101)
    cumulative = np.r_[0., np.cumsum(.5 * (speeds[:-1] + speeds[1:]) * .01)]
    assert np.all(np.diff(cumulative) >= 0) and abs(cumulative[-1] - 15.) < 1e-12
    checks.append("Distance integration is monotonic and exact for constant acceleration.")
    r = residual_report(.5 / 3.6, 2435., 10.)
    assert r["residualSpeedKmh"] == .5 and 0 < r["residualKineticEnergyJ"] < 25
    checks.append("Brake cutoff retains nonzero residual speed and kinetic energy.")
    return {"passed": len(checks), "checks": checks}


def run_case(kind, mu, phase, params):
    controller = LuaController() if kind == "experimental_track" else FixedSplitReference(params)
    start_speed = 0. if phase == "launch" else 100. / 3.6
    plant = FourWheelPlant(params, vx=start_speed, soc=.96, mu=mu)
    n_sub = int(round(params.control_dt / params.plant_dt))
    dt = params.control_dt / n_sub
    distance = 0.
    current = {"t": 0., "speed": start_speed, "distance": 0.}
    crossings = {}
    terminated = None
    peak_power = peak_regen = peak_slip = 0.
    peak_acceleration_g = 0.
    minimum_tc = minimum_abs = 1.
    checkpoints = [dict(current)]
    last_checkpoint = 0.
    last_deceleration = 0.
    monotonic = True
    gas, brake = (1., 0.) if phase == "launch" else (0., 1.)
    max_duration = 15.
    for sample in range(int(round(max_duration / params.control_dt))):
        state = plant.state(gas, brake, 0., 2)
        out = controller.step(state, params.control_dt)
        minimum_tc = min(minimum_tc, float(np.min(out["tcFactors"])))
        minimum_abs = min(minimum_abs, float(np.min(out["absFactors"])))
        for sub in range(n_sub):
            previous = current
            previous_v = plant.vx
            plant.advance(out, 0., dt)
            step_t = (sample * n_sub + sub + 1) * dt
            if not np.isfinite([plant.vx, plant.vy, plant.r, plant.x, *plant.omega, plant.soc]).all():
                terminated = "Non-finite plant state"
                break
            if plant.vx < -.3:
                terminated = "Plant exited its forward-driving validity domain"
                break
            new_distance = distance + .5 * (max(0., previous_v) + max(0., plant.vx)) * dt
            monotonic &= new_distance >= distance
            distance = new_distance
            current = {"t": step_t, "speed": plant.vx, "distance": distance}
            peak_power = max(peak_power, float(plant.last["drivePowerActualW"]) / 1000.)
            peak_regen = max(peak_regen, float(plant.last["actualRegenPowerW"]) / 1000.)
            peak_slip = max(peak_slip, float(np.max(np.abs(plant.last["kappa"]))))
            peak_acceleration_g = max(peak_acceleration_g, plant.ax / 9.81)
            last_deceleration = max(0., (previous_v - plant.vx) / dt)
            if phase == "launch":
                for label, target in (("speed100", 100./3.6), ("speed200", 200./3.6)):
                    if label not in crossings:
                        crossed = interpolate_crossing(previous, current, "speed", target)
                        if crossed: crossings[label] = crossed
                if "distance400" not in crossings:
                    crossed = interpolate_crossing(previous, current, "distance", 400.)
                    if crossed: crossings["distance400"] = crossed
                if all(k in crossings for k in ("speed100", "speed200", "distance400")):
                    terminated = "Completed speed and 400 m thresholds"
                    break
            else:
                crossed = interpolate_crossing(previous, current, "speed", .5/3.6, False)
                if crossed:
                    crossings["speed0p5"] = crossed
                    terminated = "Reached 0.5 km/h brake cutoff; complete stop not simulated"
                    break
        if current["t"] - last_checkpoint >= .5:
            checkpoints.append(dict(current, soc=plant.soc))
            last_checkpoint = current["t"]
        if terminated:
            break
    checkpoints.append(dict(current, soc=plant.soc))
    assert monotonic, "Cumulative longitudinal distance decreased"
    result = {
        "controller": kind, "phase": phase, "muDiagnosticAssumption": mu,
        "initialSocAssumption": .96, "input": "step full throttle" if phase == "launch" else "step full brake",
        "steerRoadWheelRad": 0., "mode": "track (2); default initial ramp states retained",
        "durationCompletedS": current["t"], "termination": terminated or "15 s time limit",
        "forwardValiditySatisfied": terminated not in ("Non-finite plant state", "Plant exited its forward-driving validity domain"),
        "finalSpeedKmh": current["speed"] * 3.6, "distanceQuadratureM": current["distance"],
        "plantXEndM": plant.x, "plantXMinusDistanceQuadratureM": plant.x - distance,
        "distanceMonotonic": bool(monotonic), "peakActualDrivePowerKW": peak_power,
        "peakActualRegenPowerKW": peak_regen, "peakAbsWheelSlipRatio": peak_slip,
        "peakLongitudinalAccelerationG": peak_acceleration_g,
        "minimumTcFactor": minimum_tc, "minimumAbsFactor": minimum_abs,
        "finalSoc": plant.soc, "crossingsSI": crossings, "checkpointsSI": checkpoints,
    }
    if phase == "launch":
        values = {
            "zeroTo100S": crossings.get("speed100", {}).get("t"),
            "zeroTo200S": crossings.get("speed200", {}).get("t"),
            "distance400TimeS": crossings.get("distance400", {}).get("t"),
            "distance400SpeedKmh": crossings["distance400"]["speed"] * 3.6 if "distance400" in crossings else None,
        }
        targets = (2.36, 5.82, 9.13, 253.25)
        result["metrics"] = values
        result["differenceFromReportedBestOrSeparateSession"] = {
            key: value - target if value is not None else None for (key, value), target in zip(values.items(), targets)
        }
    else:
        cutoff = crossings.get("speed0p5")
        result["metrics"] = {"hundredTo0p5KmhDistanceM": cutoff["distance"] if cutoff else None,
                             "hundredTo0p5KmhTimeS": cutoff["t"] if cutoff else None,
                             **residual_report(.5/3.6 if cutoff else current["speed"], params.mass, last_deceleration)}
        result["distanceDifferenceFromReported100To0M"] = {
            "asphalt": cutoff["distance"] - 33.98 if cutoff else None,
            "concrete": cutoff["distance"] - 35.67 if cutoff else None,
            "caution": "Simulated 100→0.5 km/h compared with reported 100→0; no zero-speed claim."
        }
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=OUTPUT)
    parser.add_argument("--self-test-only", action="store_true")
    args = parser.parse_args()
    checks = self_checks()
    print(json.dumps({"selfChecks": checks}, ensure_ascii=False), flush=True)
    if args.self_test_only:
        return
    params = PlantParams()
    results = []
    started = time.monotonic()
    for mu in (.95, 1.20):
        for kind in ("reference_fixed_split", "experimental_track"):
            for phase in ("launch", "brake"):
                print(f"Starting {kind} mu={mu:.2f} {phase}", flush=True)
                result = run_case(kind, mu, phase, params)
                results.append(result)
                print(json.dumps({"controller": kind, "mu": mu, "phase": phase,
                                  "metrics": result["metrics"], "termination": result["termination"],
                                  "elapsedWallS": round(time.monotonic()-started, 1)}, ensure_ascii=False), flush=True)
    paths = {"plantAndHarness": ROOT/"simulate.py", "controller": ROOT/"su7_control.lua",
             "config": ROOT/"su7_config.lua", "validation": Path(__file__),
             "sourcePowerLut": DATA/"power.lut", "sourceMap1Lut": DATA/"engine_map1.lut"}
    metadata = {
        "hardwareScope": hardware_scope(),
        "purpose": "Auxiliary validation of an unchanged hypothetical longitudinal model against published road-test results; not AC telemetry or fitted vehicle physics.",
        "sourceUrl": SOURCE, "reportedTargets": TARGETS,
        "sourceSessionPolicy": "Reported 0–100 and 0–200 are best figures, not proven same run. Published launch test uses 96% SOC/straight racing mode with stability retained. 400 m used another venue with SOC unknown; braking SOC and tire model unknown. All simulations use 96% SOC only as a scenario assumption.",
        "reportedBrakeLabel": "reported 100–0 km/h",
        "muPolicy": "0.95 and 1.20 are diagnostic plant assumptions, not fitted or measured real tire friction coefficients; controller grip estimates remain unchanged.",
        "plantParams": asdict(params), "maxPhaseDurationS": 15.,
        "timerPolicy": "Time zero is full pedal command from standstill; no rollout, hardware input delay, thermal/aero upgrade or launch-control precharge.",
        "crossingPolicy": "First crossing linearly interpolated between adjacent 0.5 ms plant steps. Distance is trapezoidal integration of nonnegative longitudinal velocity; straight-only.",
        "brakePolicy": "Independent fresh 100 km/h initialization and full pedal; cut at 0.5 km/h with residual kinetic energy and optional last-deceleration estimate. Not complete-stop distance.",
        "powertrainPolicy": "Original MAP_1 plus same source equivalent torque budget; experiment also uses public motor envelope and unchanged guessed ratios/TC caps. No target fitting.",
        "referenceLaunchCouplingCaveat": "The fixed-split reference uses a mean-wheel-speed shaft budget with independently integrated wheels, rather than the native AC transmission/differential constraints. Large launch slip can make weighted wheel power exceed the real motor envelope; do not identify these reference launch numbers as original AC mod measurements or predictions.",
        "units": "Internal SI, reported speed km/h. Planar warm constant-mu plant, no tire temperature, pitch/roll/active suspension, complete aerodynamics or AC solver.",
        "luaRuntime": "LuaJIT 2.1 via Lupa 2.6, core only",
        "sourceHashesSha256": {name: hashlib.sha256(path.read_bytes()).hexdigest() for name,path in paths.items()},
        "wallTimeS": time.monotonic() - started,
    }
    args.output.mkdir(parents=True, exist_ok=True)
    (args.output/"longitudinal-summary.json").write_text(json.dumps({"metadata": metadata, "selfChecks": checks, "results": results}, indent=2, ensure_ascii=False, allow_nan=False), encoding="utf-8")
    print(f"Saved {args.output/'longitudinal-summary.json'}", flush=True)


if __name__ == "__main__":
    main()
