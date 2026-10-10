"""Build independent SU7 Ultra development cars. Never edits the donor or game."""
from pathlib import Path
import argparse, configparser, hashlib, json, re, shutil, sys

ROOT = Path(__file__).resolve().parent
WORKSPACE = ROOT.parent.parent
SOURCE = ROOT.parent / "car" / "msk_stw_xiaomi_su7_ultra - 2.0"
DIST = ROOT / "dist" / "content" / "cars"
CATALOG = ROOT / "catalog.json"
SIM = ROOT.parent / "su7-sim"
sys.path.insert(0, str(SIM))
from ecu_levels import validate_levels, setup_controls, NATIVE_TC_THRESHOLDS
FIXED_NODES = {"SU7UA00", "SU7UA01"}
ACTIVE_NODES = {"SU7A01"} | {f"SU7RearPartTailGate{i:02d}" for i in range(1, 11)}
DUPLICATE_NODES = {f"Su7WingNO{i:02d}" for i in range(5)}
WING_NODES = FIXED_NODES | ACTIVE_NODES | DUPLICATE_NODES


def digest(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def load_ini(path):
    obj = configparser.ConfigParser(inline_comment_prefixes=(";",), strict=False, interpolation=None)
    obj.optionxform = str
    obj.read(path, encoding="utf-8-sig")
    return obj


def save_ini(path, obj):
    with path.open("w", encoding="utf-8", newline="\n") as stream:
        obj.write(stream, space_around_delimiters=False)


def clean_skin_wing_rules(text):
    rows = []
    for line in text.splitlines():
        match = re.match(r"^(\s*HIDE\s*=)(.*)$", line, flags=re.I)
        if match:
            names = [n.strip() for n in match[2].split(",") if n.strip() not in WING_NODES]
            if not names:
                continue
            line = match[1] + ",".join(names)
        rows.append(line)
    # Original repeated numeric section IDs can override earlier visual rules.
    return re.sub(r"\[MODEL_REPLACEMENT_\d+\]", "[MODEL_REPLACEMENT_...]", "\n".join(rows)) + "\n"


def copy_assets(dest):
    for original in SOURCE.rglob("*"):
        if not original.is_file():
            continue
        relative = original.relative_to(SOURCE)
        if original.suffix == ".backup" or original.name == "data.acd" or relative.parts[0] in ("data", "sfx"):
            continue
        if relative.parts[0] == "skins" and "无固定翼" in relative.parts[1]:
            continue  # Wing choice now belongs to hardware, not paint.
        target = dest / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        if not target.exists() or target.stat().st_size != original.stat().st_size or target.stat().st_mtime_ns != original.stat().st_mtime_ns:
            shutil.copy2(original, target)
    # Restore original configs on every build before applying the selected state.
    for original in (SOURCE / "extension").rglob("*.ini"):
        shutil.copy2(original, dest / original.relative_to(SOURCE))
    for original in (SOURCE / "skins").rglob("ext_config.ini"):
        if "无固定翼" in original.parent.name:
            continue
        target = dest / original.relative_to(SOURCE)
        target.write_text(clean_skin_wing_rules(original.read_text(encoding="utf-8-sig")), encoding="utf-8")


def write_tyres(data, selection, catalog):
    tyre = load_ini(data / "tyres.ini")
    for part in ("FRONT", "REAR", "THERMAL_FRONT", "THERMAL_REAR"):
        tyre[part + "_2"] = dict(tyre[part + "_1"])
    pt = catalog["tyres"]["pt01"]
    for axle in ("FRONT", "REAR"):
        part = tyre[axle + "_2"]
        part["NAME"] = pt["name"]
        part["SHORT_NAME"] = pt["shortName"]
        for key in ("DX_REF", "DY_REF"):
            part[key] = f"{float(part[key]) * pt['assumedPeakRefScale']:.8f}"
        part["FALLOFF_LEVEL"] = str(pt["assumedFalloffLevel"])
        part["FALLOFF_SPEED"] = str(pt["assumedFalloffSpeed"])
        wear = "pt01_wear_" + axle.lower() + ".lut"
        shutil.copy2(data / part["WEAR_CURVE"], data / wear)
        part["WEAR_CURVE"] = wear
        tyre["THERMAL_" + axle + "_2"]["PERFORMANCE_CURVE"] = "pt01_temperature_estimate.lut"
    (data / "pt01_temperature_estimate.lut").write_text("\n".join(f"{t}|{m}" for t, m in pt["assumedTemperatureCurve"]) + "\n", encoding="utf-8")
    tyre["COMPOUND_DEFAULT"]["INDEX"] = str(catalog["tyres"][selection]["index"])
    save_ini(data / "tyres.ini", tyre)


def write_electronics(data, levels):
    electronics = load_ini(data / "electronics.ini")
    tc = electronics["TRACTION_CONTROL"]
    tc["PRESENT"] = "1"
    tc["ACTIVE"] = "1"
    tc["SLIP_RATIO_LIMIT"] = str(NATIVE_TC_THRESHOLDS[levels["tc"]])
    tc["CURVE"] = "traction_control.lut"
    save_ini(data / "electronics.ini", electronics)
    (data / "traction_control.lut").write_text("\n".join(f"{i}|{limit:.2f}" for i, limit in enumerate(NATIVE_TC_THRESHOLDS)) + "\n", encoding="utf-8")
    for name in ("su7_config.lua", "su7_control.lua"):
        shutil.copy2(SIM / name, data / name)
    shutil.copy2(SIM / "csp_adapter.lua", data / "su7_csp_adapter.lua")
    shutil.copy2(data / "power.lut", data / "su7_base_power.lut")
    shutil.copy2(data / "engine_map1.lut", data / "su7_base_throttle_m1.lut")
    (data / "script.lua").write_text("require('su7_csp_adapter')\n", encoding="utf-8")
    runtime = ("-- Native TC only; ESC/TVC predictions. Unit/sign calibration not performed.\n"
               "return {active=false,calibrated=false,nativeTC=true,defaultMode=0,"
               f"defaultESC={levels['esc']},defaultTC={levels['tc']},defaultTVC={levels['tvc']},"
               "omegaSigns={1,1,1,1},torqueSigns={1,1,1,1},torqueUnitsPerNm=1}\n")
    (data / "su7_runtime.lua").write_text(runtime, encoding="utf-8")
    setup = (data / "setup.ini").read_text(encoding="utf-8-sig")
    if "[CUSTOM_SCRIPT_ITEM_" in setup:
        raise ValueError("Source custom setup IDs require explicit remapping")
    (data / "setup.ini").write_text(setup + setup_controls(levels, native_tc=True), encoding="utf-8")


def build_one(suspension, wing=None, tyre=None, damper_click=5, height_mm=0, esc=4, tc=8, tvc=0):
    levels = validate_levels(esc, tc, tvc)
    catalog = json.loads(CATALOG.read_text(encoding="utf-8"))
    profile = catalog["suspensions"][suspension]
    wing = wing or profile["defaultWing"]
    tyre = tyre or profile["defaultTyre"]
    if wing not in catalog["wings"] or tyre not in catalog["tyres"]:
        raise ValueError("Unknown wing or tyre")
    if not 1 <= damper_click <= 10 or not -10 <= height_mm <= 10:
        raise ValueError("Damper setting must be 1..10 and rod offset -10..10 mm")
    dest = (DIST / profile["carId"]).resolve()
    if not dest.is_relative_to(DIST.resolve()) or dest == SOURCE.resolve():
        raise ValueError("Invalid independent build target")
    if (dest / "data.acd").exists():
        raise ValueError("Generated target contains data.acd; inspect it before rebuilding")
    before = {p.name: digest(p) for p in (SOURCE / "data").iterdir() if p.is_file()}
    dest.mkdir(parents=True, exist_ok=True)
    copy_assets(dest)
    data = dest / "data"
    data.mkdir(exist_ok=True)
    for original in (SOURCE / "data").iterdir():
        if original.is_file():
            shutil.copy2(original, data / original.name)
    susp = load_ini(data / "suspensions.ini")
    # Click 5 preserves the profile reference; spacing is experimental, not Bilstein data.
    click_scale = 0.75 + 0.05 * damper_click
    for i, axle in enumerate(("FRONT", "REAR")):
        row = susp[axle]
        row["SPRING_RATE"] = str(round(float(row["SPRING_RATE"]) * profile["wheelRateScale"][i], 3))
        row["PROGRESSIVE_SPRING_RATE"] = str(round(float(row["PROGRESSIVE_SPRING_RATE"]) * profile["progressiveScale"][i], 3))
        row["ROD_LENGTH"] = f"{float(row['ROD_LENGTH']) + profile['rodOffsetM'] + height_mm / 1000:.6f}"
        for key in ("DAMP_BUMP", "DAMP_REBOUND", "DAMP_FAST_BUMP", "DAMP_FAST_REBOUND"):
            row[key] = str(round(float(row[key]) * profile["damperScale"][i] * click_scale, 3))
        susp["ARB"][axle] = str(round(float(susp["ARB"][axle]) * profile["antiRollScale"][i], 3))
    save_ini(data / "suspensions.ini", susp)
    wing_spec = catalog["wings"][wing]
    aero = load_ini(data / "aero.ini")
    rear = aero["WING_2"]
    rear["NAME"] = "ACTIVE_REAR" if wing == "active" else "FIXED_REAR"
    rear["SPAN"] = str(wing_spec["spanM"])
    rear["CL_GAIN"] = str(float(rear["CL_GAIN"]) * wing_spec["clGainScale"])
    rear["CD_GAIN"] = str(float(rear["CD_GAIN"]) * wing_spec["cdGainScale"])
    if not wing_spec["keepSpeedController"]:
        for section in list(aero.sections()):
            if section.startswith("DYNAMIC_CONTROLLER_") and aero.get(section, "WING", fallback="") == "2":
                aero.remove_section(section)
        (data / "wing_animations.ini").write_text("[HEADER]\nVERSION=2\n; Fixed wing: active-wing animation intentionally disabled.\n", encoding="utf-8")
    save_ini(data / "aero.ini", aero)
    hidden = (FIXED_NODES if wing == "active" else ACTIVE_NODES) | DUPLICATE_NODES
    ext = dest / "extension" / "ext_config.ini"
    visual = "\n; SU7_VARIANT_WING: single hardware source of truth\n[MODEL_REPLACEMENT_...]\nACTIVE=1\nFILE=su7ultra.kn5\nHIDE=" + ",".join(sorted(hidden)) + "\n"
    ext.write_text(clean_skin_wing_rules(ext.read_text(encoding="utf-8-sig")) + visual, encoding="utf-8")
    write_tyres(data, tyre, catalog)
    write_electronics(data, levels)
    car = load_ini(data / "car.ini")
    car["INFO"]["SCREEN_NAME"] = profile["name"]
    car["INFO"]["SHORT_NAME"] = "SU7 Ultra " + ("Air" if suspension == "air" else "Track")
    save_ini(data / "car.ini", car)
    sfx = dest / "sfx"
    sfx.mkdir(exist_ok=True)
    source_id = SOURCE.name
    shutil.copy2(SOURCE / "sfx" / (source_id + ".bank"), sfx / (profile["carId"] + ".bank"))
    guids = (SOURCE / "sfx" / "GUIDs.txt").read_text(encoding="utf-8-sig").replace(source_id, profile["carId"])
    (sfx / "GUIDs.txt").write_text(guids, encoding="utf-8")
    ui = json.loads((SOURCE / "ui" / "ui_car.json").read_text(encoding="utf-8-sig"))
    credits = ui.get("author", "Original mod authors")
    ui["name"] = profile["name"]
    ui["parent"] = "acr_su7_ultra_air" if suspension == "coilover" else ""
    ui["version"] = catalog["version"]
    ui["description"] = (profile["labelZh"] + "；" + wing_spec["labelZh"] + "。支持 P ZERO 5、Trofeo RS、赛轮 PT01（实验估计）。<br>ESC 0–4 / TC 0–8 / TVC 0–3（整数，0不关闭）。TC原生实验映射；ESC/TVC仅预测预览。<br>开发版：底盘、气动、电控和PT01参数尚未实车/游戏校准。<br>原模型、音效与基础物理作者：" + credits)
    ui["author"] = credits + "; local configurable physics development"
    ui["tags"] = ["EV", "Xiaomi", "SU7 Ultra", "development", suspension]
    ui["specs"]["acceleration"] = "Not validated"
    ui["specs"]["topspeed"] = "Not validated"
    (dest / "ui" / "ui_car.json").write_text(json.dumps(ui, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    after = {p.name: digest(p) for p in (SOURCE / "data").iterdir() if p.is_file()}
    if before != after:
        raise AssertionError("Donor physics changed")
    info = {"version": catalog["version"], "carId": profile["carId"], "suspension": suspension, "wing": wing,
            "defaultTyre": tyre, "damperClick": damper_click, "additionalRodOffsetMm": height_mm,
            "calibrated": False, "gameTested": False, "actuationECU": False,
            "electronics": {**levels, "zeroMeansOff": False, "nativeTCMode": tc + 1,
                            "escActuation": False, "tcActuation": "native-experimental", "tvcActuation": False,
                            "levelMapping": "engineering-assumption", "nativeTCMappingVerifiedInGame": False},
            "controllerSha256": digest(SIM / "su7_control.lua"),
            "catalogSha256": digest(CATALOG), "sourcePhysicsSha256": before,
            "originalPhysicsUnchanged": True, "assumptions": {"suspension": profile, "wing": wing_spec, "pt01": catalog["tyres"]["pt01"]}}
    (dest / "variant_manifest.json").write_text(json.dumps(info, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"built": str(dest), "suspension": suspension, "wing": wing, "defaultTyre": tyre, "electronics": levels, "sourceUnchanged": True}, ensure_ascii=False), flush=True)
    return dest


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--suspension", choices=("air", "coilover", "all"), default="all")
    ap.add_argument("--wing", choices=("active", "fixed"))
    ap.add_argument("--tyre", choices=("pz5", "trofeo_rs", "pt01"))
    ap.add_argument("--damper-click", type=int, default=5)
    ap.add_argument("--height-mm", type=int, default=0)
    ap.add_argument("--esc", type=int, default=4)
    ap.add_argument("--tc", type=int, default=8)
    ap.add_argument("--tvc", type=int, default=0)
    args = ap.parse_args()
    try:
        validate_levels(args.esc, args.tc, args.tvc)
    except ValueError as error:
        ap.error(str(error))
    for choice in (("air", "coilover") if args.suspension == "all" else (args.suspension,)):
        build_one(choice, args.wing, args.tyre, args.damper_click, args.height_mm, args.esc, args.tc, args.tvc)


if __name__ == "__main__":
    main()
