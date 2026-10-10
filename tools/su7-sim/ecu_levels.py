"""User-specified controls; numeric gains and native slip thresholds are assumptions."""
DEFAULTS = {"esc": 4, "tc": 8, "tvc": 0}
MAXIMUMS = {"esc": 4, "tc": 8, "tvc": 3}
NATIVE_TC_THRESHOLDS = (.40, .34, .28, .22, .18, .15, .12, .10, .08)


def validate_levels(esc=4, tc=8, tvc=0):
    levels = dict(esc=esc, tc=tc, tvc=tvc)
    for name, value in levels.items():
        if type(value) is not int or not 0 <= value <= MAXIMUMS[name]:
            raise ValueError(f"{name.upper()} must be an integer 0..{MAXIMUMS[name]}")
    return levels


def setup_controls(levels=None, native_tc=False, active=False):
    levels = validate_levels(**(levels or DEFAULTS))
    rows = ["", "[CUSTOM_SCRIPT_ITEM_0]", "ID=SU7_CONTROL_MODE", "SHOW_CLICKS=0",
            "TAB=GENERIC", "NAME=ECU prediction: Street 0 / Sport 1 / Track 2",
            "MIN=0", "MAX=2", "STEP=1", "DEFAULT=0", "POS_X=0.5", "POS_Y=5",
            "HELP=Experimental control profile; does not select suspension hardware."]
    for index, name in enumerate(("esc", "tc", "tvc"), 1):
        status = "Experimental active" if active else ("Native TC estimate" if name == "tc" and native_tc else "Prediction only")
        direction = "higher = less intervention" if name == "tvc" else "higher = more intervention"
        rows += ["", f"[CUSTOM_SCRIPT_ITEM_{index}]", f"ID=SU7_{name.upper()}_LEVEL",
                 "SHOW_CLICKS=0", "TAB=GENERIC", f"NAME={name.upper()} ({status})",
                 "MIN=0", f"MAX={MAXIMUMS[name]}", "STEP=1", f"DEFAULT={levels[name]}",
                 "POS_X=0.5", f"POS_Y={5+index}",
                 f"HELP=Integer levels; {direction}; 0 retains intervention. Experimental mapping, not OEM calibration."]
    return "\n".join(rows) + "\n"
