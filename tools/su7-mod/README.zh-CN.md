# SU7 Ultra 可配置量产 mod：开发版 0.2

已生成两辆独立车型，位于 [dist/content/cars](dist/content/cars)：

- acr_su7_ultra_air：普通量产空悬等效版，默认升降尾翼和 P ZERO 5。
- acr_su7_ultra_coilover：赛道绞牙实验版，默认固定碳纤维大尾翼和 Trofeo RS。

两辆车都能独立选择升降/固定尾翼，以及 P ZERO 5、Trofeo RS、赛轮 PT01。绞牙也可配升降翼，空悬也可配固定翼；轮胎不绑定悬架。首版采用启动前配置硬件、游戏维修区原生菜单选择轮胎的方式。

## 使用

1. 双击 [Configure_SU7.cmd](Configure_SU7.cmd)，选择悬架车型、尾翼、默认轮胎、实验阻尼档、车高偏移，以及 ESC / TC / TVC 整数档位，点击“生成所选车型”。不修改原 mod 或游戏安装。这个配置器需要 Python 3.11+/Tk；换电脑先按[恢复说明](../README.su7.zh-CN.md)执行 Restore_SU7.cmd，配置器优先使用仓库 .venv。
2. 将 dist/content/cars 下的两个 acr_su7_ultra_* 目录复制到自己的 Assetto Corsa/content/cars，保留目录 ID。它们是两辆新车，不覆盖原量产或原型车。
3. Content Manager 中选择 Xiaomi SU7 Ultra Air - Dev 或 Xiaomi SU7 Ultra Track Coilover - Dev，使用 CSP 扩展物理。当前实现按 0.2.11 稳定版接口/机制核对，尚未游戏试驾。
4. 维修区轮胎列表中可选 P ZERO 5、Trofeo RS、Sailun PT01 (Experimental)。配置器只设默认胎，不删除其他胎。
5. 维修区 GENERIC 调校页中，ESC 为 0–4、TC 为 0–8、TVC 为 0–3，步长为 1。ESC/TC 越大干预越强；TVC 越大干预越少，0 最强、3 最少。三项 0 都不表示关闭。当前 TC 已接入原生实验映射；ESC/TVC 项明确标为 Prediction only，仅改变预测值，不改变游戏车轮扭矩或制动力。
6. 再改尾翼、悬架或阻尼时，重新生成并复制该新车目录，重新进入场次。它们不是驾驶过程中更换的硬件。选择“恢复默认双车型”会重建上述默认组合，并设 ESC 4 / TC 8 / TVC 0。这是保持原实验核心行为的默认值，不是查到的原厂默认。

原车需要的字体等外部依赖仍需保留。仅在独立目录 ID 下使用展开的 data，新包不带旧 data.acd。不要手动改车辆目录名，否则需要重新处理声音 GUID 和 bank。

## 已改变的实际物理

尾翼选择同时改模型隐藏项、气动配置与动画：升降翼保留原速度控制和三段动画；固定翼保留固定翼网格、隐藏升降翼与重复网格，关闭升降动画，采用固定角度。清理各皮肤的尾翼决定权，避免选颜色后改变硬件。主动翼的 CL/CD 分解仍是明确的近似，没有 CFD 标定。

两种悬架写入不同的弹簧、渐进刚度、阻尼、杆长和防倾杆。空悬首版沿用原固定参数作为单一工况等效模型；绞牙以原值为基准，提高前/后轮率为 1.35/1.45 倍，阻尼按其平方根缩放，并调整防倾杆和杆长。所有变化记录在 catalog.json，都是实验设定，不能说成 Bilstein 原厂调校。

阻尼 1–10 档以第 5 档为参考、每档倍率差 0.05，是配置器的实验档位，不是厂家的十档曲线。车高选项实际改变 ROD_LENGTH 偏移；静态车高还受载荷和几何影响，不保证车身离地恰好改变同样的毫米数。

PT01 不是只改轮胎名：加入完整前后物理与热模型组，使用独立温度和磨损 LUT；峰值参考系数、极限后衰减与温度曲线和 Trofeo RS 不同。它采用原半热熔模型作代理，压力、热传递、负荷敏感、惯量与磨损暂借用；未知值没有冒充实测。其温度曲线不是赛轮推荐温窗，不能用于实车胎压/胎温决策，也没有宣称始终比 Trofeo RS 快。

[赛轮官方](https://en.sailungroup.com/content/details117_1504.html)确认 PT01 与小米合作开发。[2026 赛轮型录](https://fliphtml5.com/sailun/uwkq/)列有 265/35ZR21、305/30ZR21 等规格，但 Ultra 专用配方身份和数值性能仍待核实。首版使用前 265/后 305，未把 325 后胎与现有轮毂简单拼接。轮胎网格/侧壁贴图仍复用原资源，尚未制作 PT01 专属视觉。

整备与驾驶员质量约定、原动力地图、传动、ABS及回收近似保留，TC 改为九个实验档。独立电控核心已接入这些新车用于预测；ESC/TVC 未接管执行器。空悬双腔切换、自动调平、CDC 未实现，当前是可配置的驾驶物理开发包，不能称为实车还原完成。

## 电控档位如何实现

用户提供的是档位范围和方向，没有原厂每档的阈值或增益。离线核心分别缩放 ESC 选择性制动、TC 减扭响应和 TVC 后双电机差动扭矩，不通过统一减马力模拟三项。三者的作用不同，不能把“干预更强”直接换算成圈速更慢；驾驶员、路面和轮胎都会影响结果。

当前离线工程映射为 ESC 强度 0.20 → 1.00、TC 强度 0.25 → 1.00、TVC 强度 1.00 → 0.30，均不等于厂家百分比。ABS、回收、电机功率和转速包络仍是独立限制，最低档也不会取消这些限制。相应来源和强度记录在 catalog.json。

生成车的原生 TC 使用九条递减滑移阈值：0.40、0.34、0.28、0.22、0.18、0.15、0.12、0.10、0.08。自定义 TC 0–8 映射到启用的 native mode 1–9；native 0 表示关闭，所以不会发送 0。这与离线核心按减扭速率缩放 TC 不完全相同，两者尚未对齐响应。原生 TC 的滑移曲线机制参照 [CSP 官方说明](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Traction-Control)，ac.setTC 在本地正式 0.2.11 SDK 中已核对；mode 1 对应 LUT 第 0 行的实际加载映射仍需游戏核验，不能把模拟 API 测试当成实机验证。

请用 SU7 的 TC 自定义调校项切换。原生 HUD 可能显示 1–9，比 SU7 菜单大 1；脚本会同步 SU7 菜单值，原生键盘 TC 调节会被同步回这个值。即使自定义 TC 为 0，仍保留最弱的启用档；原 MIN_SPEED_KMH=12 机制仍保留，不能理解成静止时必然持续减扭。

ESC/TVC 的所有档位已进入共用核心和模拟测试，但生成车只显示预测结果。要实际接管，还需测量轮速/坐标方向、电扭矩单位与正负号、传动隔离和制动接口；不能凭空将校准标记改为 true。[主动实验构建说明](../su7-sim/README.zh-CN.md)已有这一入口，目前未生成主动包。

CSP Lua Debug 显示所选整数、预测强度、预测横摆请求以及原生 TC 期望/实际档位。这些是现场调试显示；脚本不自动保存行驶记录，也不回传数据。

## 命令与核查

仓库根目录生成默认两辆车：

```powershell
& 'D:\Python\Python312\python.exe' -X utf8 tools/su7-mod/build_mod.py
```

例如生成空悬＋固定尾翼＋PT01（参数仍为实验模型）：

```powershell
& 'D:\Python\Python312\python.exe' -X utf8 tools/su7-mod/build_mod.py --suspension air --wing fixed --tyre pt01 --damper-click 5 --height-mm 0 --esc 2 --tc 4 --tvc 1
```

[核查程序](verify_package.py)独立读取生成车，检查资源、声音 ID、三组轮胎、LUT、悬架差异、尾翼物理与皮肤冲突、三项电控整数范围与默认值、原生 TC 曲线和模块，以及原车物理哈希。结构与参数核查不能代替游戏加载、音效播放、动画和驾驶测试。

[catalog.json](catalog.json)记录选择与估计来源；每辆车的 variant_manifest.json 记录实际生成组合和原物理 SHA256。原模型、声音、基础物理的作者署名保留在车辆 UI 中。

本轮文件核查：默认包 412/412 项通过；空悬/绞牙 × 两种尾翼 × 三种轮胎的 12 种组合、阻尼/杆长偏移的两组边界设置均通过。三种电控强度组合与 12 个 CLI / 12 个 API 无效输入拒绝检查也通过。最终恢复默认双车型。见 [electronics-verification.json](electronics-verification.json)、 [selection-matrix.json](selection-matrix.json) 与 [verification.json](verification.json)。未进入 AC，检查不包含实际加载、声音播放、尾翼动画或驾驶表现。

原始 mod 与生成的新车现已随仓库保存，二进制通过 Git LFS 拉取。[资产清单](asset-manifest.json)记录文件字节和 SHA256；换电脑的恢复入口是 [Restore_SU7.cmd](Restore_SU7.cmd)，详细步骤见[工作环境恢复说明](../README.su7.zh-CN.md)。
