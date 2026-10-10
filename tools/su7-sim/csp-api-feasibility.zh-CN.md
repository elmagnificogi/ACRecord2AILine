# SU7 Ultra 电控模拟：CSP 接口可行性

核对日期：2026-10-09。本文核对的是官方 CSP 0.2.11 发布包中的生成 SDK。GitHub 主分支还包括 0.3.0 preview 的接口，不能直接作为 0.2.11 的兼容性依据。没有在本机注册的 E:/Steam、D:/SteamLibrary 中找到 Assetto Corsa 和 CSP，用户实际安装版本仍未知；没有做游戏内动态验证。

可以在 CSP 中按轮加入电扭矩、按轮接管摩擦制动，并在物理帧读取反馈。因而前轴一个电机、后轴两个独立电机的控制结构可以搭建。仍需处理原机械动力、ERS、ABS 和制动实现之间的冲突，并通过游戏内探针确认符号与量纲。仅有离线模型通过测试，不能称为已经复原小米电控。

## 已核实的执行接口

- `ac.addElectricTorque(tyres, torque, overrideExisting)`：轮索引从 0 开始；可四轮分别调用。`overrideExisting=true` 清除原有电扭矩，例如 ERS 的扭矩。文档没有说它会清除原发动机和机械传动的扭矩。因此把完整三电机输出再加到原 `power.lut` 上会有重复动力的风险。接口注释只把 torque 标为 number，没有写 Nm；Nm 是与轮端电扭矩一致的工程解释，必须用规定扭矩的轮速增量实验核对，不能把它包装为已被官方注释证明的单位。
- `ac.overrideBrakesTorque(tyres, torque, handbrakeTorque, discTemperature)`：`torque` 明确为 Nm。首次调用后接管整场原制动，之后必须每个物理帧对四个轮子都写值。手刹扭矩独立，不受 ABS 影响。`discTemperature` 只影响视觉，不改变物理。CSP 0.2.3-preview20 起，可传 NaN 恢复原制动。文档明确说：启用新的 extended physics 制动系统时，此调用无效。
- `ac.overrideABS(lf, rf, lr, rr)`：输入是 0 到 1 的制动力乘数；全参数省略或 nil 恢复原 ABS。这一乘数和 `ph.wheels[i].abs` 的显示值不同，后者对应的制动乘数是 `1 - abs`。接管摩擦制动时可先保留原 ABS；接管 ABS 后必须自行完成滑移闭环。
- `ac.overrideEngineTorque(torque)`：替代原发动机整条扭矩曲线，需要逐帧调用。传 NaN 恢复原曲线。它的说明没有承诺同步清除原 coast/发动机制动、传动惯量或差速耦合。
- `ac.overrideGasInput(value)`：替代送往发动机的油门值，不改仪表显示；`math.huge` 取消替代。控制器必须先读取原输入，再决定写入值。
- `ac.addTorque(vec3, torqueLocal, hubIndex)`：单位明确为 N·m，但作用于车身刚体或 hub 刚体。它不是前述轮端电扭矩接口。直接用它施加横摆力矩，会绕过轮胎纵向附着和电机约束，只适合调试对照，不应成为扭矩矢量分配的主执行器。

来源是官方发布包中的 `extension/internal/lua-sdk/ac_car_cphys/lib.lua`。本地完整定义保存在 `references/csp-0.2.11-ac_car_cphys-lib.lua`；精选接口及原行号在 `references/csp-0.2.11-physics-api-excerpts.lua`。关键原行号：轮枚举 146–167、物理读取 8443–8446、电扭矩 8714–8717、制动和 ABS 8719–8740。

## 轮索引、坐标和输入

官方枚举：0=前左，1=前右，2=后左，3=后右。`ph.wheels` 同样是四项、从 0 开始的数组。数组不是通常 Lua 的 1 到 4；不能用 `ipairs(ph.wheels)` 或默认从 1 开始迭代。Front/Rear/All 等是特殊轮掩码，分别为 12/48/60。适配器为方便核对，应明确逐轮写入。

闭环数据必须来自 `local ph = ac.accessCarPhysics()`。官方文档指出 `ac.getCar()` 和全局 `car` 在图形线程更新，图形卡顿会使数据过期。`script.update(dt)` 每个物理帧调用，dt 单位秒，通常约 0.003。`script.reset()` 在回坑、传送或新场次执行，需要清除控制器积分、滤波、轮速历史和电池估计缓存。

可以读取 `ph.localVelocity`、`ph.localAngularVelocity`、`ph.speedKmh`、四轮 `angularSpeed/slipRatio/slipAngle/load` 和 wheel `look/up/side`。物理 `slipAngle` 明确用 radians；渲染 `car.wheels[i].slipAngle` 却用 degrees。`speedKmh` 应先除以 3.6。局部轴可从本地模型确认是 X 横向、Y 向上、Z 前向，但本地模型约定不能替代运行时符号确认。

以下字段在发布 SDK 中没有完整单位或符号说明：`ph.steer`、`localAngularVelocity`、wheel `angularSpeed/slipRatio`。尤其渲染 `car.steer` 明确是方向盘角度 deg，而物理 `ph.steer` 只标成可修改的控制值。不要直接把 `ph.steer` 当道路轮角度。可用两个前轮 heading 相对车体 heading 的夹角，或运行时校准后的输入映射，求实际道路轮转角；前轮 heading 法还需要确认向量同属世界坐标。

最少做三种读数核验：直行时 `length(ph.localVelocity)` 对照 `ph.speedKmh/3.6`；已知方向的转弯中对照 heading 变化和 `localAngularVelocity.y`；匀速滚动时对照 `abs(wheel.angularSpeed)*有效轮胎半径` 和沿 wheel.look 的速度。检查符号后再定义统一的控制核心坐标，避免右转时给出左转修正。

## 前后分配、ERS 与版本边界

0.2.11 SDK 没有发现能够直接改原 AWD `FRONT_SHARE` 的公开函数。它包含 `setDifferentialPower/Coast/Preload` 和 `setAWDCenterDifferentialPreload`，但没有证明这些调用能完整控制 AWD 前后两套差速器。另一条明确的通道是 `ph.controllerInputs[0..255]`，可在原动态控制器里用 `SCRIPT_0...SCRIPT_255` 读取；这需要配置 INI 和 LUT。第三条通道是按轮电扭矩：将前轴目标按前轴机械约束拆到两轮，将后轴目标分别交给两个后电机。

三电机模式建议明确分出两种适配方案：保留原发动机模型，只加入受限的每轮电扭矩修正；或由 Lua 完整提供电机轮端输出，同时在独立 patch 中取消原正向动力、coast、ERS 和不适用的差速锁。两者不能混用。取消原动力后，还须实测原传动惯量和差速器是否继续影响车轮。前轴共享一个电机意味着两前轮输出受同一个前电机功率/扭矩预算约束，不能把它默认为四个独立电机。

0.2.11 的 `ac.CarPhysicsValueID` 只确认 `ERSRecovery`、`ERSHeatCharging`、`AWD2MaxTorque`、`ForcelessTyres` 等少量键。GitHub 主分支现有 `OriginalTCPresent/TCThrottleOverride/BlockOriginalTC/BrakeTorque/BrakeFrontBias` 等键，部分明确标记为 0.3.0 preview 新增。0.2.11 适配器不能无条件使用它们，也不能根据字段名自行造字符串接口。先以 `type(ac.addElectricTorque)=='function'` 等检查函数；如果调用较新枚举，必须同时验证枚举值存在。

`overrideBrakesTorque` 能处理制动混合的摩擦端，电扭矩能承担回收端的候选执行器。但电扭矩接口没有承诺替我们计算电池 SOC、回收功率、热损耗、低速退出或充电功率限制。控制核心应显式计算回收机械功率 `T*omega`、效率和能量积分，再把剩余驾驶员制动需求补到摩擦端。施加负电扭矩的方向和是否受 ABS 影响需实测；不能只因 API 名含 Electric，就当成完整 ERS 系统。

## 游戏内验证顺序

1. 在原 mod 的独立副本加载只读探针，记录 CSP 版本、物理帧 dt、0..3 轮坐标、局部速度/角速度、前轮 heading、原油门/制动、轮速和滑移。不开电控，先确认数据与符号。
2. 在举升轮或安全低速场景，对一个轮子给有界、短时电扭矩脉冲，其余三轮给零。检查扭矩只影响对应轮，负值有可解释的减速效果，且不同 dt 下冲量一致。因为缺少注释单位，采用已知轮惯量和 `delta_omega/dt` 核对扭矩比例；落地试验还需计入地面反力。
3. 取消脉冲，接管四轮摩擦制动并用小驾驶员制动需求核验。确认 API 生效、ABS仍工作、手刹仍工作、回坑后控制器重置正常。需要先检查 mod 是否启用新制动实现。
4. 完成单轮执行器核验后，再启用三电机、滑移控制和横摆反馈，逐步扩大幅度。每步记录输入/输出和限幅原因。离线单车模型无法证明路肩、腾空、轮胎温度、方向盘反馈和 CSP 更新顺序下都稳定。

## 来源与保留文件

- [官方 CSP 下载及版本列表](https://acstuff.club/patch/)；本次检查包为 [0.2.11 发布包](https://acstuff.club/patch/?get=0.2.11)。ZIP 未安装，已保留所需 SDK 定义及源地址/哈希；原始下载缓存已清理。
- [官方 physics script 文档](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Physics-scripts)，本地副本 `references/official-physics-scripts.md`。这页仍提 8 个 SCRIPT 输入，而发布 SDK 是 256；按已核对发布包处理。
- [官方 Lua SDK physics 入口](https://github.com/ac-custom-shaders-patch/acc-lua-sdk/blob/main/ac_car_cphys.lua)，本地副本 `references/upstream-ac_car_cphys.lua`。
- [官方当前物理枚举](https://github.com/ac-custom-shaders-patch/acc-lua-sdk/blob/main/common/ac_car_cphys_enums.lua)，本地副本 `references/upstream-ac_car_cphys_enums.lua`，用于识别新旧版本差异。
- `references/csp-api-source-manifest.json` 保存源地址、文件 SHA256 和本机检查范围。

没有修改原 mod，也没有编辑主控制器。下一步接口适配应以实际 CSP 运行探针结果为准。
