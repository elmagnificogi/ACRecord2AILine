"""Four-wheel planar experiment for the shared Lua SU7 controller.

This is an offline hypothesis model, not the Assetto Corsa engine or Xiaomi ECU.
Original torque LUT/MAP_1 are read without modifying the mod. Each controller
sample runs the same Lua core used by the adapter; no Python mirror is used.
"""
from __future__ import annotations
import argparse, json, math, sys, hashlib
from dataclasses import dataclass
from pathlib import Path
from vehicle_variants import hardware_scope
import numpy as np

ROOT = Path(__file__).resolve().parent
DATA = ROOT.parent / "car" / "msk_stw_xiaomi_su7_ultra - 2.0" / "data"
sys.path.insert(0, str(ROOT / ".runtime"))
from lupa.luajit21 import LuaRuntime

WHEELS = ("FL", "FR", "RL", "RR")


def lut(path):
    rows = []
    for line in path.read_text(encoding="utf-8-sig").splitlines():
        raw = line.split(";", 1)[0].strip()
        if "|" in raw:
            try:
                a, b = raw.split("|", 1)
                rows.append((float(a), float(b)))
            except ValueError:
                pass
    return np.array(sorted(rows), dtype=float)


POWER = lut(DATA / "power.lut")
MAP = lut(DATA / "engine_map1.lut")


def torque_budget(rpm):
    # The original aggregate shaft curve, including original MAP_1 and limiter.
    if rpm >= 27200:
        return 0.0
    rpm = max(1.0, rpm)
    return float(np.interp(rpm, POWER[:, 0], POWER[:, 1])
                 * np.interp(rpm, MAP[:, 0], MAP[:, 1]))


@dataclass
class PlantParams:
    mass: float = 2435.0
    wheelbase: float = 3.0
    track_front: float = 1.672
    track_rear: float = 1.649
    cg_height: float = 0.40  # Explicit assumption, not measured Xiaomi CG.
    efficiency: float = 1.0  # Original equivalent torque LUT already includes author loss convention.
    discharge_efficiency: float = 0.94
    charge_efficiency: float = 0.90
    battery_kwh: float = 93.7
    gear: float = 1.315 * 7
    air_density: float = 1.225
    cd_area: float = 0.63  # Assumed drag product, not complete AC aero.
    rolling_coefficient: float = 0.012
    tire_kappa_gain: float = 9.0  # Normalized force stiffness, assumed.
    tire_alpha_gain: float = 11.0
    lateral_load_front_share: float = 0.56  # Assumed roll-load split.
    control_dt: float = 0.003
    plant_dt: float = 0.0005

    @property
    def radii(self):
        return np.array([0.355, 0.355, 0.352, 0.352])

    @property
    def hub_masses(self):
        return np.array([59., 59., 75., 75.])

    @property
    def static_loads(self):
        sprung = self.mass - self.hub_masses.sum()
        return (sprung * np.array([.49, .49, .51, .51]) / 2
                + self.hub_masses) * 9.81

    @property
    def a(self):
        return self.wheelbase * self.static_loads[2:].sum() / (self.mass * 9.81)

    @property
    def b(self):
        return self.wheelbase - self.a

    @property
    def positions(self):
        return np.array([[self.a, self.track_front / 2],
                         [self.a, -self.track_front / 2],
                         [-self.b, self.track_rear / 2],
                         [-self.b, -self.track_rear / 2]])

    @property
    def inertia_yaw(self):
        # AC INERTIA is box dimensions, not kg*m2. Approximation is declared.
        return self.mass * (1.96 ** 2 + 4.99 ** 2) / 12

    @property
    def wheel_inertia(self):
        # Original wheel inertia plus aggregate shaft inertia reflected to wheels.
        reflected = (.050 + .022) * self.gear ** 2
        return np.array([1.68, 1.68, 1.98, 1.98]) + reflected * np.array([.11, .11, .39, .39])


class LuaController:
    def __init__(self,disable_stability=False):
        self.disable_stability=disable_stability
        self.lua = LuaRuntime(unpack_returned_tuples=True)
        self.lua.execute("package.path = " + json.dumps(ROOT.as_posix() + "/?.lua;")
                         + " .. package.path")
        self.obj = self.lua.eval("require('su7_control').new(require('su7_config'))")
        self.config = self.lua.eval("require('su7_config')")

    def step(self, state, dt):
        if self.disable_stability: state=dict(state,disableStability=True)
        table = self.lua.table()
        for key, val in state.items():
            table[key] = self.lua.table_from(val.tolist() if isinstance(val, np.ndarray) else val) \
                if isinstance(val, (list, tuple, np.ndarray)) else val
        out = self.obj.step(self.obj, table, dt)
        result = {}
        for key, value in out.items():
            if hasattr(value, "items"):
                ints = list(range(1, 5))
                if all(value[i] is not None for i in ints):
                    result[key] = np.array([float(value[i]) for i in ints])
                else:
                    result[key] = {k: v for k, v in value.items()}
            elif isinstance(value, (int, float, str, bool)) or value is None:
                result[key] = value
        return result


class FixedSplitReference:
    """Documented reference, not a reproduction of the original AC solver.

    Original aggregate torque budget; fixed 22/78; simple scalar TC target .28;
    per-wheel ABS .12; original mechanical brake caps; original COAST_REF as
    non-recoverable coast drag. It has no active yaw target or torque vectoring.
    """
    def __init__(self, params):
        self.p = params
        self.tc = 1.0
        self.abs = np.ones(4)

    def step(self, s, dt):
        p = self.p
        kappa = (p.radii * s["wheelsOmega"] - s["wheelLongSpeed"]) / np.maximum(np.abs(s["wheelLongSpeed"]), 1.0)
        excess = max(0.0, float(kappa.max()) - .28) if s["vx"] >= 12 / 3.6 else 0.0
        self.tc += (max(0.0, 1 - 5 * excess) - self.tc) * min(1.0, dt / .06)
        targets = np.clip(1 - 7 * np.maximum(-kappa - .12, 0), 0, 1)
        self.abs += (targets - self.abs) * min(1.0, dt / .04)
        share = np.array([.11, .11, .39, .39])
        drive = s["gas"] * s["engineTorqueBudget"] * p.gear * p.efficiency * self.tc * share
        drive *= max(0.0, 1.0 - s["brake"])
        if s["vx"] < -.3:
            drive[:] = 0
        caps = 4650 * np.array([.64, .64, .36, .36])
        friction = caps * s["brake"] * self.abs
        rpm = max(0., float(np.mean(np.maximum(s["wheelsOmega"], 0))) * p.gear * 60 / (2 * math.pi))
        coast = 350 * min(rpm / 28500, 1.0) * p.gear * p.efficiency * (1 - s["gas"]) * share
        # Coast is included once, marked separately, and is not charged to SOC.
        return dict(driveTorque=drive, regenTorque=np.zeros(4), frictionTorque=friction,
                    coastTorque=coast, yawReference=0., yawRequested=0., yawAchieved=0.,
                    gasCommand=s["gas"] * self.tc, tcFactors=np.full(4, self.tc),
                    absFactors=self.abs.copy(), regenPowerW=0.,
                    drivePowerW=float(np.sum(drive * np.maximum(s["wheelsOmega"], 0))))


class FourWheelPlant:
    def __init__(self, params, vx=20., vy=0., yaw=0., soc=.5, mu=.95):
        self.p = params
        self.vx, self.vy, self.r = vx, vy, yaw
        self.heading = 0.
        self.x = self.y = 0.
        self.omega = vx / params.radii
        self.soc = soc
        self.mu = np.full(4, mu) if np.isscalar(mu) else np.array(mu, dtype=float)
        self.loads = params.static_loads.copy()
        self.fy = np.zeros(4)
        self.ax = self.ay = 0.
        self.last = {}
        self.recovered_j = 0.

    def local_speeds(self, delta):
        pos = self.p.positions
        vx = self.vx - self.r * pos[:, 1]
        vy = self.vy + self.r * pos[:, 0]
        angles = np.array([delta, delta, 0., 0.])
        u = np.cos(angles) * vx + np.sin(angles) * vy
        v = -np.sin(angles) * vx + np.cos(angles) * vy
        return u, v, angles

    def state(self, gas, brake, delta, mode):
        u, _, _ = self.local_speeds(delta)
        rpm = float(np.mean(np.maximum(self.omega, 0))) * self.p.gear * 60 / (2 * math.pi)
        return dict(vx=self.vx, vy=self.vy, yaw=self.r, delta=delta,
                    gas=float(gas), brake=float(brake), mode=int(mode),
                    engineTorqueBudget=torque_budget(rpm), soc=self.soc,
                    wheelsOmega=self.omega.copy(), wheelLongSpeed=u,
                    wheelLoads=self.loads.copy(), wheelFy=self.fy.copy())

    def advance(self, out, delta, dt):
        p = self.p
        u, v, angles = self.local_speeds(delta)
        # Weight transfer uses actual inertial force accelerations, not body dv.
        front = p.static_loads[:2].sum() - p.mass * p.cg_height * self.ax / p.wheelbase
        rear = p.mass * 9.81 - front
        front = float(np.clip(front, .06 * p.mass * 9.81, .94 * p.mass * 9.81))
        rear = p.mass * 9.81 - front
        # Positive leftward ay loads the right (outside) wheels.
        lat_f = p.lateral_load_front_share * p.mass * p.cg_height * self.ay / p.track_front
        lat_r = (1 - p.lateral_load_front_share) * p.mass * p.cg_height * self.ay / p.track_rear
        lat_f = float(np.clip(lat_f, -.49 * front, .49 * front))
        lat_r = float(np.clip(lat_r, -.49 * rear, .49 * rear))
        self.loads = np.array([front / 2 - lat_f, front / 2 + lat_f,
                               rear / 2 - lat_r, rear / 2 + lat_r])
        capacity = np.maximum(self.mu * self.loads, 1.)
        kappa = (p.radii * self.omega - u) / np.maximum(np.abs(u), 1.)
        alpha = np.arctan2(v, np.maximum(np.abs(u), 1.))
        fx_t = capacity * np.tanh(p.tire_kappa_gain * kappa)
        fy_t = -capacity * np.tanh(p.tire_alpha_gain * alpha)
        ratio = np.sqrt((fx_t / capacity) ** 2 + (fy_t / capacity) ** 2)
        scale = np.maximum(ratio, 1.)
        fx_t /= scale
        fy_t /= scale
        # Exact rotation to body x-forward/y-left; all yaw comes from wheel forces.
        fx = np.cos(angles) * fx_t - np.sin(angles) * fy_t
        fy = np.sin(angles) * fx_t + np.cos(angles) * fy_t
        drive = np.array(out["driveTorque"], dtype=float)
        regen = np.array(out["regenTorque"], dtype=float)
        friction = np.array(out["frictionTorque"], dtype=float)
        coast = np.array(out.get("coastTorque", np.zeros(4)), dtype=float)
        brake = regen + friction + coast
        brake_sign = np.where(np.abs(self.omega) > .05, np.sign(self.omega), np.sign(u))
        wheel_acc = (drive - brake * brake_sign - p.radii * fx_t) / p.wheel_inertia
        new_omega = self.omega + wheel_acc * dt
        # Forward-only plant: brake torque cannot numerically spin a wheel backwards.
        stopped = (self.omega >= 0) & (new_omega < 0) & (u >= 0)
        new_omega[stopped] = 0.
        self.omega = new_omega
        drag = .5 * p.air_density * p.cd_area * self.vx * abs(self.vx)
        rolling = p.rolling_coefficient * p.mass * 9.81 * math.tanh(self.vx)
        self.ax = (fx.sum() - drag - rolling) / p.mass
        self.ay = fy.sum() / p.mass
        mz = float(np.sum(p.positions[:, 0] * fy - p.positions[:, 1] * fx))
        dvx = self.ax + self.r * self.vy
        dvy = self.ay - self.r * self.vx
        self.vx += dvx * dt
        self.vy += dvy * dt
        self.r += mz / p.inertia_yaw * dt
        self.heading += self.r * dt
        self.x += (math.cos(self.heading) * self.vx - math.sin(self.heading) * self.vy) * dt
        self.y += (math.sin(self.heading) * self.vx + math.cos(self.heading) * self.vy) * dt
        self.fy = fy_t.copy()  # Per-wheel lateral force in tire axes for grip budgeting.
        mechanical_regen = float(np.sum(regen * np.maximum(self.omega, 0)))
        recovered = p.charge_efficiency * mechanical_regen  # Assumed efficiency, shared with Lua config.
        self.recovered_j += recovered * dt
        mechanical_drive = float(np.sum(drive * np.maximum(self.omega, 0)))
        battery_delta = recovered - mechanical_drive / p.discharge_efficiency
        self.soc = float(np.clip(self.soc + battery_delta * dt / (p.battery_kwh * 3.6e6),0,1))
        self.last = dict(kappa=kappa, tireFx=fx_t, tireFy=fy_t, bodyYawMoment=mz,
                         normalLoads=self.loads.copy(), actualRegenPowerW=mechanical_regen,
                         drivePowerActualW=float(np.sum(drive * np.maximum(self.omega, 0))))


@dataclass
class Scenario:
    name: str
    duration: float
    initial_vx: float = 20.
    initial_vy: float = 0.
    initial_yaw: float = 0.
    soc: float = .5
    mu: float | tuple = .95

    def inputs(self, t):
        if self.name == "corner_throttle":
            return (.18 if t < 2 else .85, 0., .028, 1)
        if self.name == "low_mu_exit":
            return (.18 if t < 2 else .90, 0., .024, 0)
        if self.name == "yaw_disturbance":
            return (.12, 0., .018, 0)
        if self.name == "brake_blend":
            return (0., .16 if t < 2 else (.42 if t < 4 else .72), 0., 0)
        if self.name == "high_soc_brake":
            return (0., .35, 0., 0)
        if self.name == "mode_switch":
            return (.65, 0., .023, 0 if t < 3 else (2 if t < 6 else 0))
        raise ValueError(self.name)


SCENARIOS = [
    Scenario("corner_throttle", 8., initial_vx=18.),
    Scenario("low_mu_exit", 8., initial_vx=15., mu=.55),
    Scenario("yaw_disturbance", 7., initial_vx=22., initial_vy=-.7, initial_yaw=.40),
    Scenario("brake_blend", 7., initial_vx=30.),
    Scenario("high_soc_brake", 5., initial_vx=27., soc=.995),
    Scenario("mode_switch", 9., initial_vx=17.),
]


def record(t, plant, state, out):
    beta = math.atan2(plant.vy, max(abs(plant.vx), .5))
    row = dict(t=t, vx=plant.vx, vy=plant.vy, yaw=plant.r, beta=beta,
               gas=state["gas"], brake=state["brake"], mode=state["mode"],
               yawReference=float(out.get("yawReference", 0)),
               yawRequested=float(out.get("yawRequested", 0)),
               yawAchieved=float(out.get("yawAchieved", 0)),
               gasCommand=float(out.get("gasCommand", 0)),
               drivePowerW=float(out.get("drivePowerW", 0)),
               regenPowerW=float(out.get("regenPowerW", 0)),
               recoveredJ=plant.recovered_j, soc=plant.soc,
               engineTorqueBudget=state["engineTorqueBudget"])
    for key in ("driveTorque", "regenTorque", "frictionTorque", "tcFactors", "absFactors"):
        row[key] = np.asarray(out.get(key, np.ones(4) if "Factors" in key else np.zeros(4))).tolist()
    for key, value in plant.last.items():
        row[key] = value.tolist() if isinstance(value, np.ndarray) else value
    return row


def run_scenario(scenario, kind, params=None):
    p = params or PlantParams()
    controller = LuaController(disable_stability=(kind=="experimental_no_yaw")) if kind.startswith("experimental") else FixedSplitReference(p)
    plant = FourWheelPlant(p, scenario.initial_vx, scenario.initial_vy,
                           scenario.initial_yaw, scenario.soc, scenario.mu)
    trace = []
    n_sub = int(round(p.control_dt / p.plant_dt))
    dt = p.control_dt / n_sub
    terminated = None
    for sample in range(int(round(scenario.duration / p.control_dt))):
        t = sample * p.control_dt
        gas, brake, delta, mode = scenario.inputs(t)
        state = plant.state(gas, brake, delta, mode)
        out = controller.step(state, p.control_dt)
        for _ in range(n_sub):
            plant.advance(out, delta, dt)
        trace.append(record(t + p.control_dt, plant, state, out))
        if not np.isfinite([plant.vx, plant.vy, plant.r, *plant.omega]).all():
            terminated = "Non-finite plant state"
            break
        if plant.vx < -.3:
            terminated = "Plant exited its forward-driving validity domain"
            break
    data = trace
    arr = lambda key: np.array([row[key] for row in data])
    # Same kinematic reference for both controllers; do not treat baseline's zero
    # target as a meaningful yaw error comparison.
    target = np.array([row["vx"] * scenario.inputs(row["t"])[2] / p.wheelbase for row in data])
    metrics = dict(durationCompletedS=float(data[-1]["t"]), terminated=terminated,
                   finalSpeedKmh=float(data[-1]["vx"] * 3.6),
                   peakAbsBetaDeg=float(np.max(np.abs(arr("beta"))) * 180 / math.pi),
                   yawErrorRmsRadS=float(np.sqrt(np.mean((arr("yaw") - target) ** 2))),
                   peakAbsSlip=float(np.max(np.abs(arr("kappa")))),
                   maxDrivePowerKW=float(np.max(arr("drivePowerW")) / 1000),
                   maxRegenPowerKW=float(np.max(arr("regenPowerW")) / 1000),
                   recoveredKWh=float(data[-1]["recoveredJ"] / 3.6e6),
                   minimumTcFactor=float(np.min(arr("tcFactors"))),
                   minimumAbsFactor=float(np.min(arr("absFactors"))))
    return dict(scenario=scenario.name, controller=kind, metrics=metrics, trace=data)


def generate_plots(results, output):
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    for name in dict.fromkeys(r["scenario"] for r in results):
        cases = [r for r in results if r["scenario"] == name]
        fig, axes = plt.subplots(2, 3, figsize=(13.4, 7.2), constrained_layout=True)
        colors = {"reference": "#888888", "experimental": "#168c8c", "experimental_no_yaw":"#b97827"}
        for case in cases:
            tr = case["trace"]
            t = np.array([q["t"] for q in tr])
            v = lambda key: np.array([q[key] for q in tr])
            color = colors[case["controller"]]
            label = case["controller"]
            axes[0, 0].plot(t, v("vx") * 3.6, label=label, color=color)
            axes[0, 1].plot(t, v("yaw"), label=label, color=color)
            axes[0, 2].plot(t, v("beta") * 180 / math.pi, label=label, color=color)
            torques = v("driveTorque")
            axes[1, 0].plot(t, torques[:, 3] - torques[:, 2], label=label, color=color)
            axes[1, 1].plot(t, v("drivePowerW") / 1000, label=label + " drive", color=color)
            axes[1, 1].plot(t, v("regenPowerW") / 1000, "--", label=label + " regen", color=color)
            axes[1, 2].plot(t, np.min(v("tcFactors"), axis=1), label=label + " TC", color=color)
            axes[1, 2].plot(t, np.min(v("absFactors"), axis=1), "--", label=label + " ABS", color=color)
        titles = ["Speed [km/h]", "Yaw rate [rad/s]", "Sideslip [deg]",
                  "Rear RR-RL drive torque [Nm]", "Mechanical power [kW]", "Min intervention factors"]
        for ax, title in zip(axes.flat, titles):
            ax.set_title(title)
            ax.set_ylabel(title)
            ax.set_xlabel("Time [s]")
            ax.grid(alpha=.18)
            ax.legend(fontsize=7)
        fig.suptitle(name.replace("_", " ").title() + " — hypothetical planar plant", fontsize=15)
        fig.text(0.01,0.002,"Source: original mod MAP_1 + shared Lua controller; hypothetical plant, 2026-10-09",fontsize=8)
        fig.savefig(output / (name + ".png"), dpi=140)
        plt.close(fig)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    parser.add_argument("--scenario", choices=[s.name for s in SCENARIOS])
    parser.add_argument("--no-plots", action="store_true")
    parser.add_argument("--ablation",action="store_true",help="Same experimental profile with yaw/TV/ESC disabled")
    args = parser.parse_args()
    args.output=args.output or (ROOT / "outputs" / "yaw-ablation" if args.ablation else ROOT / "outputs")
    args.output.mkdir(parents=True, exist_ok=True)
    results = []
    for scenario in SCENARIOS:
        if args.scenario and args.scenario != scenario.name:
            continue
        for kind in (("experimental_no_yaw", "experimental") if args.ablation else ("reference", "experimental")):
            result = run_scenario(scenario, kind)
            results.append(result)
            print(scenario.name, kind, json.dumps(result["metrics"]), flush=True)
    metadata = dict(hardwareScope=hardware_scope(), luaRuntime="LuaJIT 2.1 via Lupa 2.6, numeric core only", traceSamplePeriodS=PlantParams().control_dt*10,
                    purpose="Offline control experiment, not Xiaomi calibration or AC game measurement",
                    units="SI internally; x forward, y left, z up; wheel order FL FR RL RR",
                    controllerSha256=hashlib.sha256((ROOT/"su7_control.lua").read_bytes()).hexdigest(),
                    configSha256=hashlib.sha256((ROOT/"su7_config.lua").read_bytes()).hexdigest(),
                    metricsPolicy="Common kinematic yaw target vx*delta/L for RMS; not a manufacturer path target. Whole-profile comparison mixes pedal, caps, TC, yaw and braking; ablation disables yaw-request TV and ESC only.",
                    sourceTorqueCurve=str(DATA / "power.lut"),
                    sourceEngineMap=str(DATA / "engine_map1.lut"),
                    sourceMapPolicy="MAP_1 fixed in all control modes to isolate ECU changes",
                    reference="Fixed 22/78 + simple .28 TC/.12 ABS + 64% brake bias + original nonrecoverable COAST_REF",
                    assumptions=PlantParams().__dict__,
                    yawInertiaApproxKgM2=PlantParams().inertia_yaw,
                    wheelInertiasKgM2=PlantParams().wheel_inertia.tolist(),
                    tireModel="Warm constant-mu tanh forces plus combined force circle; no thermal or DWB reconstruction",
                    batteryCapacityKWhNominal=93.7, chargeEfficiencyAssumed=.90, dischargeEfficiencyAssumed=.94,
                    validDomain="Forward planar driving; no roll, pitch, wheel-hop, full aerodynamics, or hardware delays")
    stored=[]
    for result in results:
        trace=result["trace"][::10]
        if trace[-1] is not result["trace"][-1]: trace=trace+[result["trace"][-1]]
        stored.append(dict(result,trace=trace))
    def compact(value):
        if isinstance(value,float): return round(value,6)
        if isinstance(value,list): return [compact(v) for v in value]
        if isinstance(value,dict): return {k:compact(v) for k,v in value.items()}
        return value
    payload = dict(metadata=metadata, results=stored)
    (args.output / ("ablation.json" if args.ablation else "simulation.json")).write_text(json.dumps(compact(payload),separators=(",",":")), encoding="utf-8")
    summary = dict(metadata=metadata, results=[{k: v for k, v in r.items() if k != "trace"} for r in results])
    (args.output / ("ablation-summary.json" if args.ablation else "simulation-summary.json")).write_text(json.dumps(summary, indent=2), encoding="utf-8")
    if not args.no_plots:
        generate_plots(results, args.output)


if __name__ == "__main__":
    main()
