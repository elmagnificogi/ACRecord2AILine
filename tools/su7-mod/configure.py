"""Local pre-session SU7 configuration window; standard Python/Tk only."""
from pathlib import Path
import json, queue, subprocess, sys, threading
import tkinter as tk
from tkinter import ttk, messagebox

ROOT = Path(__file__).resolve().parent
CATALOG = json.loads((ROOT / "catalog.json").read_text(encoding="utf-8"))


def main():
    app = tk.Tk()
    app.title("SU7 Ultra 配置")
    app.geometry("710x650")
    app.minsize(660, 620)
    frame = ttk.Frame(app, padding=24)
    frame.pack(fill="both", expand=True)
    ttk.Label(frame, text="SU7 Ultra 量产车型配置", font=("Microsoft YaHei UI", 16)).grid(row=0, column=0, columnspan=2, sticky="w", pady=(0, 8))
    ttk.Label(frame, text="生成独立车型；尾翼、悬架和轮胎分别选择。", font=("Microsoft YaHei UI", 10)).grid(row=1, column=0, columnspan=2, sticky="w", pady=(0, 18))
    categories = ("suspensions", "wings", "tyres")
    labels = ("车型 / 悬架", "尾翼", "默认轮胎")
    variables, mappings, boxes = {}, {}, {}
    for row, category, label in zip(range(2, 5), categories, labels):
        choices = {value["labelZh"]: key for key, value in CATALOG[category].items()}
        mappings[category] = choices
        ttk.Label(frame, text=label).grid(row=row, column=0, sticky="w", pady=7)
        variable = tk.StringVar(value=next(iter(choices)))
        variables[category] = variable
        box = ttk.Combobox(frame, textvariable=variable, values=list(choices), state="readonly", width=38)
        box.grid(row=row, column=1, sticky="ew", pady=7)
        boxes[category] = box
    click = tk.IntVar(value=5)
    height = tk.IntVar(value=0)
    ttk.Label(frame, text="阻尼档位（实验 1–10）").grid(row=5, column=0, sticky="w", pady=7)
    ttk.Spinbox(frame, from_=1, to=10, textvariable=click, width=10).grid(row=5, column=1, sticky="w", pady=7)
    ttk.Label(frame, text="附加车高调节（±10 mm）").grid(row=6, column=0, sticky="w", pady=7)
    ttk.Spinbox(frame, from_=-10, to=10, textvariable=height, width=10).grid(row=6, column=1, sticky="w", pady=7)
    ecu_vars = {}
    for row, name, maximum, default in ((7, "esc", 4, 4), (8, "tc", 8, 8), (9, "tvc", 3, 0)):
        direction = "越大干预越少；仅预测" if name == "tvc" else ("越大干预越强；仅预测" if name == "esc" else "越大干预越强；原生实验")
        ttk.Label(frame, text=f"{name.upper()} 0–{maximum}（{direction}）").grid(row=row, column=0, sticky="w", pady=7)
        ecu_vars[name] = tk.StringVar(value=str(default))
        ttk.Combobox(frame, textvariable=ecu_vars[name], values=[str(i) for i in range(maximum + 1)], state="readonly", width=10).grid(row=row, column=1, sticky="w", pady=7)
    ttk.Label(frame, text="轮胎还可在游戏维修区调校中切换；硬件改动后需重新进入场次。", wraplength=600).grid(row=10, column=0, columnspan=2, sticky="w", pady=(12, 8))
    ttk.Label(frame, text="三项 0 都不关闭；TVC 0 最强、3 最少。ESC/TVC 未接管车轮；参数待校准。", wraplength=600).grid(row=11, column=0, columnspan=2, sticky="w", pady=(0, 10))
    status = tk.StringVar(value="输出：tools/su7-mod/dist/content/cars；原车和游戏安装不受影响。")
    ttk.Label(frame, textvariable=status, wraplength=600).grid(row=13, column=0, columnspan=2, sticky="w", pady=(12, 0))
    frame.columnconfigure(1, weight=1)
    jobs = queue.Queue()
    buttons = ttk.Frame(frame)
    buttons.grid(row=12, column=0, columnspan=2, sticky="w")

    def apply_defaults(event=None):
        key = mappings["suspensions"][variables["suspensions"].get()]
        profile = CATALOG["suspensions"][key]
        for category, selection in (("wings", profile["defaultWing"]), ("tyres", profile["defaultTyre"])):
            variables[category].set(CATALOG[category][selection]["labelZh"])
        click.set(5)
        height.set(0)

    boxes["suspensions"].bind("<<ComboboxSelected>>", apply_defaults)
    apply_defaults()

    def run(defaults=False):
        try:
            selected_click, selected_height = int(click.get()), int(height.get())
            levels = {name: int(value.get()) for name, value in ecu_vars.items()}
            if any(not 0 <= levels[name] <= CATALOG["electronics"]["ranges"][name][1] for name in levels):
                raise ValueError()
            if not 1 <= selected_click <= 10 or not -10 <= selected_height <= 10:
                raise ValueError()
        except (ValueError, tk.TclError):
            messagebox.showerror("设置无效", "阻尼档位为 1–10；附加车高调节为 −10 至 +10 mm；ESC 0–4、TC 0–8、TVC 0–3，均为整数。")
            return
        args = [sys.executable, "-X", "utf8", str(ROOT / "build_mod.py")]
        if not defaults:
            args += ["--suspension", mappings["suspensions"][variables["suspensions"].get()],
                     "--wing", mappings["wings"][variables["wings"].get()],
                     "--tyre", mappings["tyres"][variables["tyres"].get()],
                     "--damper-click", str(selected_click), "--height-mm", str(selected_height)]
            for name, value in levels.items():
                args += ["--" + name, str(value)]
        for button in (one, both):
            button.configure(state="disabled")
        status.set("正在生成车型…")

        def worker():
            try:
                result = subprocess.run(args, cwd=ROOT, capture_output=True, text=True, encoding="utf-8", creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0))
                jobs.put((result.returncode, result.stdout, result.stderr))
            except Exception as err:
                jobs.put((1, "", str(err)))
        threading.Thread(target=worker, daemon=True).start()

    one = ttk.Button(buttons, text="生成所选车型", command=run)
    one.pack(side="left", padx=(0, 12))
    both = ttk.Button(buttons, text="恢复默认双车型", command=lambda: run(True))
    both.pack(side="left")

    def poll():
        try:
            code, out, err = jobs.get_nowait()
        except queue.Empty:
            app.after(150, poll)
            return
        for button in (one, both):
            button.configure(state="normal")
        if code:
            status.set("生成失败；原车未修改。")
            messagebox.showerror("生成失败", err or out)
        else:
            status.set("已生成。将 dist/content/cars 中对应新车目录复制到 AC/content/cars。")
            messagebox.showinfo("生成完成", "车型已更新。尾翼和悬架改动需要复制新包并重新进入游戏场次；轮胎可在维修区切换。")
        app.after(150, poll)

    app.after(150, poll)
    app.mainloop()


if __name__ == "__main__":
    main()
