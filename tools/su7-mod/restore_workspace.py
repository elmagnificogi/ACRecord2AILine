"""Restore Git LFS assets and a portable local Python environment."""
from pathlib import Path
import argparse, subprocess, sys, venv
from verify_assets import ROOT, verify


def run(command):
    subprocess.run([str(arg) for arg in command], cwd=ROOT, check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--verify-only", action="store_true", help="Check local asset bytes without downloads or environment changes")
    args = parser.parse_args()
    if sys.version_info < (3, 11):
        parser.error("Python 3.11 or newer is required; Python 3.12 was tested")
    if not args.verify_only:
        run(["git", "lfs", "install", "--local"])
        run(["git", "lfs", "pull", "origin"])
    result = verify()
    print(f"Asset integrity: {result['filesChecked']} files, {'passed' if result['passed'] else 'FAILED'}", flush=True)
    if not result["passed"]:
        for failure in result["failedFiles"]:
            print(failure["path"], failure["reason"], flush=True)
        return 1
    if args.verify_only:
        return 0
    import tkinter  # Python installation must include Tk for the configurator.
    folder = ROOT / ".venv"
    interpreter = folder / ("Scripts/python.exe" if sys.platform == "win32" else "bin/python")
    if not interpreter.is_file():
        venv.EnvBuilder(with_pip=True).create(folder)
    run([interpreter, "-m", "pip", "install", "-r", ROOT / "tools/su7-sim/requirements.txt"])
    run([interpreter, "-c", "import tkinter, numpy, matplotlib; from lupa.luajit21 import LuaRuntime"])
    for script in ("tools/su7-sim/verify_controller.py", "tools/su7-sim/verify_adapter.py", "tools/su7-mod/verify_package.py"):
        command = [interpreter, "-X", "utf8", ROOT / script]
        if script.endswith("verify_package.py"):
            command += ["--report", folder / "su7-package-verification.json"]
        run(command)
    print("Restored. Configure_SU7.cmd now prefers this workspace's .venv.", flush=True)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, subprocess.CalledProcessError, ImportError, ValueError) as error:
        print(f"Restore failed: {error}", file=sys.stderr)
        raise SystemExit(1)
