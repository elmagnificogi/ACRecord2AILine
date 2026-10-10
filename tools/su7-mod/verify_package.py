"""Independent structural checks for generated SU7 mod packages.

This reads real installed-layout outputs and the frozen original hashes; it does
not import the builder or validate its internal template strings. Passing these
checks is not an Assetto Corsa runtime test or a vehicle calibration result.
"""
from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import json
import math
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[1]
SOURCE = REPO / "tools/car/msk_stw_xiaomi_su7_ultra - 2.0"
BASELINE = REPO / "tools/su7-sim/references/video-evidence.json"
KNOWN_IDS = {"acr_su7_ultra_air": "air", "acr_su7_ultra_coilover": "coilover"}
WING_NODES = {"SU7UA00", "SU7UA01", "Su7WingNO00", "Su7WingNO01", "Su7WingNO02", "Su7WingNO03", "Su7WingNO04", "SU7A01", "wing_ani00", "wing_ani01", "wing_ani02"} | {f"SU7RearPartTailGate{i:02d}" for i in range(1, 11)}


ELECTRONIC_RANGES = {"esc": (0, 4), "tc": (0, 8), "tvc": (0, 3)}
TC_SLIP_LIMITS = (0.40, 0.34, 0.28, 0.22, 0.18, 0.15, 0.12, 0.10, 0.08)


def text(path: Path) -> str:
    return path.read_text(encoding="utf-8-sig", errors="strict")


def ini_sections(content: str) -> list[tuple[str, dict[str, str]]]:
    """Accept original AC comments/free text without concealing duplicate blocks."""
    result: list[tuple[str, dict[str, str]]] = []
    current: dict[str, str] | None = None
    for line in content.splitlines():
        line = line.split(";", 1)[0].strip()
        if not line or line.startswith(("//", "#")):
            continue
        match = re.fullmatch(r"\[([^]]+)\]", line)
        if match:
            current = {}
            result.append((match.group(1).strip().upper(), current))
        elif current is not None and "=" in line:
            key, value = line.split("=", 1)
            current[key.strip().upper()] = value.strip()
    return result


def section(items: list[tuple[str, dict[str, str]]], name: str) -> dict[str, str]:
    matches = [values for key, values in items if key == name.upper()]
    if len(matches) != 1:
        raise ValueError(f"Expected one [{name}], found {len(matches)}")
    return matches[0]


def finite(value: str) -> float:
    number = float(value)
    if not math.isfinite(number):
        raise ValueError(f"Non-finite numeric value: {value}")
    return number


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def original_hashes(source: Path) -> dict[str, str]:
    hashes = json.loads(text(BASELINE))["originalSourceSHA256"]
    return {name: sha256(source / "data" / name) if (source / "data" / name).is_file() else "MISSING" for name in hashes}


def manifest_default(manifest: dict, fallback: int) -> int:
    """Recognize human-readable selections without relying on builder helpers."""
    aliases = {"pz5": 0, "trofeo_rs": 1, "trofeo rs": 1, "pt01": 2}
    for key in ("defaultTyreIndex", "defaultCompoundIndex", "tyreIndex"):
        if key in manifest:
            return int(manifest[key])
    for key in ("defaultTyre", "tyreDefault", "tyre", "defaultCompound"):
        value = manifest.get(key)
        if isinstance(value, str) and value.lower() in aliases:
            return aliases[value.lower()]
    for key in ("selection", "configuration", "options", "selected", "variant"):
        nested = manifest.get(key)
        if isinstance(nested, dict):
            answer = manifest_default(nested, -1)
            if answer != -1:
                return answer
    return fallback


def verify_electronics(car: Path, source: Path, manifest: dict, add, expected: dict[str, int | None]) -> dict:
    """Read the packaged menu, defaults and native TC independently of the builder."""
    data = car / "data"
    record = manifest["electronics"]
    levels = {}
    for name, (low, high) in ELECTRONIC_RANGES.items():
        actual = record[name]
        valid = type(actual) is int and low <= actual <= high
        add(f"{car.name}: {name.upper()} manifest is an integer in range", valid, {"actual": actual, "range": [low, high]})
        if not valid:
            raise ValueError(f"Invalid {name.upper()} default in manifest")
        levels[name] = actual
        if expected.get(name) is not None:
            add(f"{car.name}: selected {name.upper()} matches requested level", actual == expected[name], {"actual": actual, "expected": expected[name]})
    add(f"{car.name}: level zero retains intervention", record.get("zeroMeansOff") is False)
    add(f"{car.name}: native TC uses one-based level mapping", type(record.get("nativeTCMode")) is int and record["nativeTCMode"] == levels["tc"] + 1)
    add(f"{car.name}: engineering level mapping disclosed", record.get("levelMapping") == "engineering-assumption")
    add(f"{car.name}: ESC/TVC actuation remains disabled", record.get("escActuation") is False and record.get("tvcActuation") is False and manifest.get("actuationECU") is False)
    add(f"{car.name}: native TC experimental actuation disclosed", record.get("tcActuation") == "native-experimental")
    add(f"{car.name}: catalog digest matches packaged build selection", manifest.get("catalogSha256") == sha256(ROOT / "catalog.json"))

    setup = ini_sections(text(data / "setup.ini"))
    mode = section(setup, "CUSTOM_SCRIPT_ITEM_0")
    add(f"{car.name}: mode selector retains its independent 0..2 range", finite(mode["MIN"]) == 0 and finite(mode["MAX"]) == 2 and finite(mode["STEP"]) == 1)
    for index, name in enumerate(ELECTRONIC_RANGES, start=1):
        row = section(setup, f"CUSTOM_SCRIPT_ITEM_{index}")
        low, high = ELECTRONIC_RANGES[name]
        add(f"{car.name}: setup {name.upper()} exposes the full integer range", finite(row["MIN"]) == low and finite(row["MAX"]) == high and finite(row["STEP"]) == 1)
        add(f"{car.name}: setup {name.upper()} default matches manifest", re.fullmatch(r"[0-9]+", row["DEFAULT"]) is not None and int(row["DEFAULT"]) == levels[name])
        add(f"{car.name}: setup {name.upper()} identity is unambiguous", name.upper() in row["NAME"].upper())

    for name in ("su7_config.lua", "su7_runtime.lua", "su7_control.lua", "su7_csp_adapter.lua", "su7_base_power.lut", "su7_base_throttle_m1.lut"):
        path = data / name
        add(f"{car.name}: electronics module {name} packaged", path.is_file() and path.stat().st_size > 0)
    runtime = re.sub(r"--[^\n]*", "", text(data / "su7_runtime.lua"))
    for name, value in (("active", False), ("calibrated", False), ("nativeTC", True)):
        match = re.search(r"\b" + name + r"\s*=\s*(true|false)\b", runtime)
        add(f"{car.name}: runtime {name} is explicit and correct", bool(match) and match[1] == str(value).lower())
    for name, level in levels.items():
        match = re.search(r"\bdefault" + name.upper() + r"\s*=\s*([0-9]+)(?![.0-9])\b", runtime)
        add(f"{car.name}: runtime {name.upper()} default matches manifest", bool(match) and int(match[1]) == level)
    shim = text(data / "script.lua")
    add(f"{car.name}: original script entry loads the electronics adapter", "su7_csp_adapter" in shim)
    for generated, original in (("su7_config.lua", "su7_config.lua"), ("su7_control.lua", "su7_control.lua"), ("su7_csp_adapter.lua", "csp_adapter.lua")):
        add(f"{car.name}: {generated} matches reviewed shared source", sha256(data / generated) == sha256(REPO / "tools/su7-sim" / original))

    electronics = ini_sections(text(data / "electronics.ini"))
    donor = ini_sections(text(source / "data/electronics.ini"))
    for name in ("ABS", "EDL"):
        add(f"{car.name}: {name} remains separate from ESC/TC/TVC levels", section(electronics, name) == section(donor, name))
    tc = section(electronics, "TRACTION_CONTROL")
    add(f"{car.name}: native TC present and active even at zero level", tc["PRESENT"] == "1" and tc["ACTIVE"] == "1")
    add(f"{car.name}: native TC default slip threshold matches selected level", math.isclose(finite(tc["SLIP_RATIO_LIMIT"]), TC_SLIP_LIMITS[levels["tc"]], abs_tol=1e-9))
    curve = []
    for line in text(data / tc["CURVE"]).splitlines():
        line = line.split(";", 1)[0].strip()
        if not line or line.startswith(("//", "#")):
            continue
        cols = line.split("|")
        if len(cols) != 2:
            raise ValueError("Invalid native TC curve row")
        curve.append((finite(cols[0]), finite(cols[1])))
    add(f"{car.name}: native TC curve has all nine contiguous levels", len(curve) == 9 and [row[0] for row in curve] == list(range(9)))
    add(f"{car.name}: native TC curve matches explicit engineering assumptions", len(curve) == 9 and all(math.isclose(row[1], threshold, abs_tol=1e-9) for row, threshold in zip(curve, TC_SLIP_LIMITS)))
    add(f"{car.name}: higher native TC levels allow strictly less slip", len(curve) == 9 and all(a[1] > b[1] > 0 for a, b in zip(curve, curve[1:])))
    return {"levels": levels, "zeroMeansOff": False, "nativeTCMode": record["nativeTCMode"], "escActuation": False, "tcActuation": "native-experimental", "tvcActuation": False}


def verify_car(car: Path, source: Path, add, notes: list[str], expected_tyre: int | None, expected_wing: str | None, expected_electronics: dict[str, int | None]) -> dict:
    data = car / "data"
    manifest = json.loads(text(car / "variant_manifest.json"))
    suspension_kind = KNOWN_IDS[car.name]
    output: dict = {"id": car.name, "suspension": suspension_kind, "runtimeTested": False}
    add(f"{car.name}: isolated output directory", not car.resolve().is_relative_to(source.resolve()))
    add(f"{car.name}: unfolded data without data.acd", data.is_dir() and not (car / "data.acd").exists())
    add(f"{car.name}: provisional calibration disclosed", bool(re.search(r"provisional|experimental|uncalibrated|未标定|实验|待标定", json.dumps(manifest, ensure_ascii=False), re.I)))
    for name in ("car.ini", "suspensions.ini", "tyres.ini", "aero.ini", "engine.ini", "drivetrain.ini", "setup.ini", "electronics.ini", "brakes.ini", "lods.ini", "wing_animations.ini", "script.lua"):
        add(f"{car.name}: data/{name} exists", (data / name).is_file())
    for name in ("collider.kn5", "body_shadow.png", "driver_base_pos.knh", "extension/ext_config.ini", "extension/video_preset.lua", "extension/tyreload.lua", "extension/siren.lua", "ui/ui_car.json"):
        add(f"{car.name}: resource {name} exists", (car / name).is_file())
    for name in ("tyre_0_shadow.png", "tyre_1_shadow.png", "tyre_2_shadow.png", "tyre_3_shadow.png"):
        add(f"{car.name}: {name} exists", (car / name).is_file())

    for path in sorted((source / "animations").glob("*")):
        if path.is_file():
            add(f"{car.name}: animation {path.name} exists", (car / "animations" / path.name).is_file())
    lods = ini_sections(text(data / "lods.ini"))
    for key, values in lods:
        if key.startswith("LOD_"):
            model = car / values["FILE"]
            add(f"{car.name}: LOD {key} asset resolves", model.is_file() and model.stat().st_size > 0)
            if model.is_file() and (source / values["FILE"]).is_file():
                add(f"{car.name}: model byte size preserved", model.stat().st_size == (source / values["FILE"]).stat().st_size)

    tyre = ini_sections(text(data / "tyres.ini"))
    for stem in ("FRONT", "REAR", "THERMAL_FRONT", "THERMAL_REAR"):
        wanted = {stem, stem + "_1", stem + "_2"}
        actual = {name for name, _ in tyre if re.fullmatch(re.escape(stem) + r"(?:_\d+)?", name)}
        add(f"{car.name}: contiguous {stem} compound sections", actual == wanted)
    default = int(section(tyre, "COMPOUND_DEFAULT")["INDEX"])
    wanted_default = expected_tyre if expected_tyre is not None else manifest_default(manifest, 0 if suspension_kind == "air" else 1)
    add(f"{car.name}: selected default compound", default == wanted_default and default in (0, 1, 2), {"actual": default, "expected": wanted_default})
    output["defaultCompoundIndex"] = default
    for index, expected in enumerate(("pz5", "trofeo", "pt01")):
        suffix = "" if index == 0 else f"_{index}"
        front, rear = section(tyre, "FRONT" + suffix), section(tyre, "REAR" + suffix)
        add(f"{car.name}: compound {index} identity at both axles", expected in front["NAME"].lower() and expected in rear["NAME"].lower() and front["NAME"] == rear["NAME"])
        for axle, values in (("front", front), ("rear", rear)):
            add(f"{car.name}: compound {index} {axle} positive geometry/load/grip", all(finite(values[name]) > 0 for name in ("WIDTH", "RADIUS", "RIM_RADIUS", "ANGULAR_INERTIA", "RATE", "FZ0", "DX_REF", "DY_REF")))
            add(f"{car.name}: compound {index} {axle} tyre radius exceeds rim", finite(values["RADIUS"]) > finite(values["RIM_RADIUS"]))
    add(f"{car.name}: PT01 has distinct tyre physics", any(section(tyre, "FRONT_2").get(key) != section(tyre, "FRONT_1").get(key) for key in ("DX_REF", "DY_REF", "FALLOFF_LEVEL", "FALLOFF_SPEED", "RATE", "LS_EXPY", "PRESSURE_IDEAL")))
    add(f"{car.name}: PT01 has independent thermal curve", section(tyre, "THERMAL_FRONT_2")["PERFORMANCE_CURVE"] != section(tyre, "THERMAL_FRONT_1")["PERFORMANCE_CURVE"])

    lut_references = []
    for ini in sorted(data.rglob("*.ini")):
        blocks = ini_sections(text(ini))
        for block, values in blocks:
            for key, value in values.items():
                if not value.lower().endswith(".lut"):
                    continue
                relative = ini.relative_to(data).as_posix()
                # The original uses FROM_COAST_REF, leaving a dormant missing coast.lut branch.
                if ini.name == "engine.ini" and block == "COAST_CURVE" and section(blocks, "HEADER").get("COAST_CURVE") == "FROM_COAST_REF":
                    notes.append(f"{car.name}: ignored dormant engine.ini COAST_CURVE/{value}; FROM_COAST_REF is selected")
                    continue
                resolved = next((candidate for candidate in (ini.parent / value, data / value) if candidate.is_file()), None)
                add(f"{car.name}: LUT resolves {relative}[{block}].{key}", resolved is not None, value)
                if resolved is not None:
                    lut_references.append(resolved)
    output["lutReferenceCount"] = len(lut_references)
    for lut in sorted(set(lut_references)):
        rows = []
        for line in text(lut).splitlines():
            line = line.split(";", 1)[0].strip()
            if not line or line.startswith(("//", "#")):
                continue
            columns = line.split("|")
            if len(columns) != 2:
                raise ValueError(f"Invalid LUT row in {lut}: {line}")
            # Native setup LUTs use textual labels in the first column.
            if lut.name.lower().endswith("setup.lut"):
                finite(columns[1])
            else:
                finite(columns[0]); finite(columns[1])
            rows.append(columns)
        if not rows:
            original = source / "data" / lut.relative_to(data)
            inherited_empty = original.is_file() and original.stat().st_size == 0
            add(f"{car.name}: empty LUT is inherited, never new", inherited_empty, lut.relative_to(data).as_posix())
            if inherited_empty:
                notes.append(f"{car.name}: inherited empty {lut.relative_to(data).as_posix()}; brake thermal behavior remains unverified")
        else:
            add(f"{car.name}: finite LUT {lut.relative_to(data).as_posix()}", True, {"rows": len(rows)})

    susp = ini_sections(text(data / "suspensions.ini"))
    rates = {side: finite(section(susp, side)["SPRING_RATE"]) for side in ("FRONT", "REAR")}
    add(f"{car.name}: positive spring/damping hardware", all(value > 0 for value in rates.values()) and all(finite(section(susp, side)[key]) > 0 for side in rates for key in ("DAMP_BUMP", "DAMP_REBOUND", "DAMP_FAST_BUMP", "DAMP_FAST_REBOUND")))
    output["springRatesNm"] = rates

    aero = ini_sections(text(data / "aero.ini"))
    rear_controllers = [values for key, values in aero if key.startswith("DYNAMIC_CONTROLLER_") and values.get("WING") == "2"]
    animations = [values for key, values in ini_sections(text(data / "wing_animations.ini")) if key.startswith("ANIMATION_") and values.get("WING") == "2"]
    # Deciding by actual controllers also catches a fixed-car manifest mislabeled active.
    actual_wing = "active" if rear_controllers else "fixed"
    wanted_wing = expected_wing or manifest.get("wing", manifest.get("configuration", {}).get("wing", actual_wing))
    if isinstance(wanted_wing, dict): wanted_wing = wanted_wing.get("id", actual_wing)
    add(f"{car.name}: wing configuration matches selection", actual_wing == wanted_wing, {"actual": actual_wing, "expected": wanted_wing})
    add(f"{car.name}: wing animation/physics coherent", bool(animations) if actual_wing == "active" else not animations)
    rear = section(aero, "WING_2")
    add(f"{car.name}: rear wing finite positive aero/geometry", all(finite(rear[key]) > 0 for key in ("CHORD", "SPAN", "CD_GAIN", "CL_GAIN")))
    output["wing"] = actual_wing
    ext_content = text(car / "extension/ext_config.ini")
    ext = ini_sections(ext_content)
    switches = [values for _, values in ext if values.get("ID") == "SU7_VARIANT_WING"]
    if not switches and ext_content.count("; SU7_VARIANT_WING:") == 1:
        marked = ini_sections(ext_content.split("; SU7_VARIANT_WING:", 1)[1])
        switches = [values for name, values in marked if name.startswith("MODEL_REPLACEMENT_") and values.get("FILE") == "su7ultra.kn5"]
    add(f"{car.name}: unified hardware wing visual rule", len(switches) == 1)
    if switches:
        hidden = set(part.strip() for part in switches[0].get("HIDE", "").split(","))
        add(f"{car.name}: visible wing matches physical hardware", {"SU7UA00", "SU7UA01"}.issubset(hidden) if actual_wing == "active" else "SU7A01" in hidden and not ({"SU7UA00", "SU7UA01"} & hidden))
    skin_files = sorted((car / "skins").glob("*/ext_config.ini"))
    add(f"{car.name}: usable skin resources included", bool(skin_files))
    for skin in skin_files:
        conflicts = []
        for _, values in ini_sections(text(skin)):
            hidden = set(x.strip() for x in values.get("HIDE", "").split(","))
            conflicts.extend(sorted(hidden & WING_NODES))
        add(f"{car.name}: skin {skin.parent.name} cannot override wing hardware", not conflicts, conflicts)

    bank = car / "sfx" / f"{car.name}.bank"
    add(f"{car.name}: correctly named FMOD bank", bank.is_file() and bank.stat().st_size > 0)
    if bank.is_file():
        add(f"{car.name}: FMOD bank binary preserved", sha256(bank) == sha256(source / "sfx" / f"{source.name}.bank"))
    guids = text(car / "sfx/GUIDs.txt")
    event_paths = re.findall(r"\{[^}]+\}\s+event:/cars/([^/]+)/([^\r\n]+)", guids)
    add(f"{car.name}: all FMOD event paths rebound", bool(event_paths) and all(identity == car.name for identity, _ in event_paths))
    add(f"{car.name}: required engine/skid/wheel sound events", {"engine_ext", "engine_int", "skid_ext", "skid_int", "wheel"}.issubset({event for _, event in event_paths}))
    add(f"{car.name}: original ID absent from GUID paths", source.name not in guids)
    output["electronics"] = verify_electronics(car, source, manifest, add, expected_electronics)
    return output


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dist", type=Path, default=ROOT / "dist")
    parser.add_argument("--source", type=Path, default=SOURCE)
    parser.add_argument("--report", type=Path, default=ROOT / "verification.json")
    parser.add_argument("--expect-tyre", choices=("pz5", "trofeo_rs", "pt01"))
    parser.add_argument("--expect-wing", choices=("active", "fixed"))
    for name, (low, high) in ELECTRONIC_RANGES.items():
        parser.add_argument("--expect-" + name, type=int, choices=range(low, high + 1))
    args = parser.parse_args()
    source = args.source.resolve()
    if args.report.resolve().is_relative_to(source):
        parser.error("Verification report must never overwrite or add files inside the source mod")
    checks, notes, cars = [], [], []
    def add(name, passed, detail=None):
        record = {"check": name, "passed": bool(passed)}
        if detail is not None: record["detail"] = detail
        checks.append(record)
    catalog = json.loads(text(ROOT / "catalog.json"))["electronics"]
    add("Catalog electronic ranges match the specified integer controls", catalog.get("ranges") == {name: list(bounds) for name, bounds in ELECTRONIC_RANGES.items()})
    defaults = catalog.get("defaults", {})
    add("Catalog electronic defaults are integer 4/8/0", defaults == {"esc": 4, "tc": 8, "tvc": 0} and all(type(defaults.get(name)) is int for name in ELECTRONIC_RANGES))
    add("Catalog preserves zero intervention and the separate TVC direction", catalog.get("zeroMeansOff") is False and catalog.get("directions") == {"esc": "higher-more", "tc": "higher-more", "tvc": "higher-less"})
    strengths = catalog.get("assumedCoreStrengths", {})
    for name, (_, high) in ELECTRONIC_RANGES.items():
        values = strengths.get(name, [])
        valid = len(values) == high + 1 and all(type(value) in (int, float) and math.isfinite(value) and 0 < value <= 1 for value in values)
        ordered = all(a > b for a, b in zip(values, values[1:])) if name == "tvc" else all(a < b for a, b in zip(values, values[1:]))
        add(f"Catalog {name.upper()} assumptions retain nonzero correctly ordered intervention", valid and ordered)
    add("Catalog TC thresholds match the native nine-level mapping", catalog.get("nativeTCSlipThresholds") == list(TC_SLIP_LIMITS) and type(catalog.get("nativeTCModeOffset")) is int and catalog["nativeTCModeOffset"] == 1)
    add("Catalog native TC mapping is not claimed game verified", catalog.get("nativeTCMappingVerifiedInGame") is False)
    add("Catalog distinguishes predicted ESC/TVC from native TC", catalog.get("actuatorStatus") == {"esc": "prediction-only", "tc": "native-experimental", "tvc": "prediction-only"})
    baseline = json.loads(text(BASELINE))["originalSourceSHA256"]
    before = original_hashes(source)
    add("Original source data matches frozen SHA256 baseline", before == baseline, {"files": len(baseline), "mismatches": [name for name in baseline if before.get(name) != baseline[name]]})
    car_root = args.dist.resolve() / "content/cars"
    add("Package output is separate from original source", not car_root.is_relative_to(source))
    candidates = [car_root / name for name in KNOWN_IDS if (car_root / name).is_dir()]
    add("At least one new production variant exists", bool(candidates))
    for car in candidates:
        try:
            cars.append(verify_car(car, source, add, notes, {"pz5": 0, "trofeo_rs": 1, "pt01": 2}.get(args.expect_tyre), args.expect_wing, {name: getattr(args, "expect_" + name) for name in ELECTRONIC_RANGES}))
        except (OSError, ValueError, KeyError, TypeError) as error:
            add(f"{car.name}: package parse succeeds", False, f"{type(error).__name__}: {error}")
    by_type = {car["suspension"]: car for car in cars}
    if "air" in by_type and "coilover" in by_type:
        add("Air and coilover have distinct spring rates at both axles", all(by_type["air"]["springRatesNm"][side] != by_type["coilover"]["springRatesNm"][side] for side in ("FRONT", "REAR")))
    after = original_hashes(source)
    add("Verification left original source data unchanged", after == before)
    result = {"checkedAtUtc": datetime.now(timezone.utc).isoformat(), "passed": all(x["passed"] for x in checks), "checkCount": len(checks), "passedChecks": sum(x["passed"] for x in checks), "failedChecks": [x for x in checks if not x["passed"]], "runtimeTested": False, "physicalCalibrationValidated": False, "originalDataFilesChecked": len(baseline), "cars": cars, "inheritedLimitations": sorted(set(notes)), "checks": checks}
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({key: result[key] for key in ("passed", "checkCount", "passedChecks", "failedChecks", "runtimeTested", "originalDataFilesChecked")}, ensure_ascii=False))
    return 0 if result["passed"] else 1


if __name__ == "__main__":
    sys.exit(main())
