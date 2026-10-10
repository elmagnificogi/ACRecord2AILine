# SU7 Ultra 开发工具

提交包含物理审计工具、共用 Lua 电控核心、离线模拟与验证、双车生成器和配置窗口。当前版本仍是开发模型；TC 接入原生实验映射，ESC/TVC 只预测，执行器尚未游戏标定。

- `su7-analysis`：原量产/原型物理审计，第三方 ACD 读取模块附来源和许可。
- `su7-sim`：离线模型、控制测试、CSP 适配及观测包生成器。
- `su7-mod`：空悬/绞牙独立车型生成、尾翼和轮胎选择、整数电控档位与包核查。

## 本地输入与生成物

原始 mod、模型、声音和贴图不包含在提交中。请将自己的原始车放在 `tools/car/msk_stw_xiaomi_su7_ultra - 2.0` 和 `tools/car/negi_su7_ultra_prototype`；生产车需保留完整资源和展开的 data，原型审计读取 data.acd。它们不会被生成器改写。

`su7-mod/dist`、`su7-sim/csp-shadow`、`su7-sim/csp-active-bench`、`su7-analysis/prototype-data`、Python 缓存、下载文件及大体积轨迹是本地生成物，Git 不收录。小型模拟摘要和验证记录随源码保留；完整轨迹与图片通过模拟脚本重建。官方图片和完整 CSP SDK 快照也只作本地审计输入，公开来源与哈希清单保留在 references。

## 复现

Python 3 需有 Tkinter；模拟依赖列在 `su7-sim/requirements.txt`。当前本机使用 D:/Python/Python312。仓库根目录执行：

```powershell
& 'D:\Python\Python312\python.exe' -X utf8 tools/su7-sim/verify_controller.py
& 'D:\Python\Python312\python.exe' -X utf8 tools/su7-sim/build_patch.py
& 'D:\Python\Python312\python.exe' -X utf8 tools/su7-sim/verify_adapter.py
& 'D:\Python\Python312\python.exe' -X utf8 tools/su7-mod/build_mod.py
& 'D:\Python\Python312\python.exe' -X utf8 tools/su7-mod/verify_package.py
```

配置窗口入口是 `su7-mod/Configure_SU7.cmd`。原车准备好后，双击它生成新车，再按 `su7-mod/README.zh-CN.md` 复制到游戏。

完整离线场景及图表的复现见 `su7-sim/README.zh-CN.md`；原型解包入口是 `su7-analysis/unpack_prototype_acd.py`。`save_api_evidence.py` 是可选审计工具，需要先取得来源清单指定的官方 SDK，本身不参与控制运行或车型生成。

本次验证：30 项核心、13 项模拟接口、412 项默认双车包检查通过。没有进入 AC 实测；这些检查不能证明实车标定或真实圈速。
