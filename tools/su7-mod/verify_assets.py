"""Verify restored SU7 workspace files against their exact-byte manifest."""
from pathlib import Path
import argparse, hashlib, json

ROOT = Path(__file__).resolve().parents[2]
MANIFEST = Path(__file__).resolve().parent / "asset-manifest.json"
ASSET_ROOTS = {
    "originalMods": "tools/car",
    "generatedMods": "tools/su7-mod/dist",
    "observerPackage": "tools/su7-sim/csp-shadow",
    "prototypePhysics": "tools/su7-analysis/prototype-data",
    "auditReferences": "tools/su7-analysis/references",
    "controllerReferences": "tools/su7-sim/references",
    "simulationOutputs": "tools/su7-sim/outputs",
}


def sha(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def refresh():
    rows = []
    for role, directory in ASSET_ROOTS.items():
        folder = ROOT / directory
        if not folder.is_dir():
            raise FileNotFoundError(folder)
        for path in sorted(folder.rglob("*")):
            if path.is_file():
                with path.open("rb") as stream:
                    if stream.read(64).startswith(b"version https://git-lfs.github.com/spec/v1"):
                        raise ValueError(f"Cannot refresh a manifest from LFS pointers: {path}")
                rows.append({"role": role, "path": path.relative_to(ROOT).as_posix(),
                             "bytes": path.stat().st_size, "sha256": sha(path)})
    unique = {row["sha256"]: row["bytes"] for row in rows}
    record = {"schemaVersion": 1, "hashPolicy": "SHA256 of original file bytes, no newline conversion",
              "assetRoots": ASSET_ROOTS, "fileCount": len(rows),
              "totalBytes": sum(row["bytes"] for row in rows),
              "uniqueContents": len(unique), "uniqueBytes": sum(unique.values()), "files": rows}
    MANIFEST.write_text(json.dumps(record, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return record


def verify():
    record = json.loads(MANIFEST.read_text(encoding="utf-8"))
    failures = []
    for row in record["files"]:
        path = (ROOT / row["path"]).resolve()
        if not path.is_relative_to(ROOT):
            raise ValueError("Asset path must remain within this workspace")
        if not path.is_file():
            failures.append({"path": row["path"], "reason": "missing"})
            continue
        size = path.stat().st_size
        if size != row["bytes"]:
            with path.open("rb") as stream:
                pointer = stream.read(64).startswith(b"version https://git-lfs.github.com/spec/v1")
            failures.append({"path": row["path"], "reason": "LFS pointer: run git lfs pull" if pointer else "size mismatch"})
        elif sha(path) != row["sha256"]:
            failures.append({"path": row["path"], "reason": "SHA256 mismatch"})
    return {"passed": not failures, "filesChecked": len(record["files"]),
            "bytesChecked": record["totalBytes"], "failedFiles": failures,
            "scope": "Workspace file integrity only; not game loading or actuator calibration"}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--refresh", action="store_true", help="Record the intentionally updated local asset snapshot")
    args = parser.parse_args()
    if args.refresh:
        record = refresh()
        print(json.dumps({key: record[key] for key in ("fileCount", "totalBytes", "uniqueContents", "uniqueBytes")}))
    result = verify()
    print(json.dumps(result, ensure_ascii=False))
    return 0 if result["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
