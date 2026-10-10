"""Hardware attribution only; never substitutes guessed suspension physics."""
from pathlib import Path
import hashlib, json
ROOT = Path(__file__).resolve().parent
MANIFEST = ROOT / "references" / "production-variants.json"


def hardware_scope(model="planar"):
    if model not in ("planar", "source_mod"):
        raise ValueError("Unknown hardware scope model: " + model)
    spec = json.loads(MANIFEST.read_text(encoding="utf-8"))
    return {
        "hardwareVariant": None,
        "sourceModClassification": spec["sourceMod"]["classification"],
        "targetProfiles": list(spec["targetProfiles"]),
        "hardwareProfilesApplied": False,
        "suspensionDynamicsSimulated": False if model == "planar" else None,
        "expectedNativeSuspensionInGame": model == "source_mod",
        "gameRuntimeVerified": False,
        "suspensionModel": "not modeled" if model == "planar" else "source mod single fixed spring/damper set; variant unclassified",
        "controlModeIsHardwareVariant": False,
        "manifestSha256": hashlib.sha256(MANIFEST.read_bytes()).hexdigest(),
        "note": "Street/Sport/Track are experimental ECU settings. No validated air-versus-coilover performance comparison exists.",
    }
