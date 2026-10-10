# SU7 Ultra 量产 mod：动力系统补充核查

核查日期：2026-10-09。源 mod 保持只读。结论针对 tools/car/msk_stw_xiaomi_su7_ultra - 2.0/data 的静态配置，未观察运行时扭矩或控制器状态。

## 官方正文来源

[小米官方页面](https://www.mi.com/global/discover/article?id=3768)，标题：Xiaomi SU7 Ultra Unveiled: The Ultimate Performance Technology Sedan。正文日期为 2024-10-29，这是量产车型预发布资料，不能直接代表此后所有 OTA。

[公开正文 API](https://go.buy.mi.com/global/discovery/land?id=3768&from=pc) 本次返回 errno=0，data.id=3768，data.add_time=1730195018，data.online_time=1730212226；完整正文位于 data.content。网站公开文章组件从 /discovery/land 读取数据后渲染此字段，不是从 JavaScript 页面壳推测所得。为控制转载量，本文件保留来源、字段与短句，不复制全文。

原文短句：**“500 times per second”**、**“maximum deceleration of 0.6g”**。正文描述三电机独立、动态分配扭矩，转弯时向外侧轮分配更多扭矩，快速调整左右轮扭矩。制动能量回收最大减速度为 0.6g，最大回收功率超过 400kW。0.6g 不是恒定松电门减速度，400kW 也不是硬性上限。正文还区分耐力、排位、漂移、大师自定义等赛道模式，以及新手、经济、湿地、运动、自定义等日常模式。

## 已确认配置与证据边界

1. 单一总扭矩源加 AWD：engine.ini:3 指向 power.lut，drivetrain.ini:5 为 TYPE=AWD，drivetrain.ini:19 的 FRONT_SHARE=22 是 22%，不是 2200%。[Girellu Physics Pipeline 固定修订](https://github.com/archibaldmilton/Girellu/wiki/Physics-Pipeline/686faddc31d1ae226258ba28a0cdc1be11f2e4a2) 明确此参数使用 0–100 的完整百分数；这是社区物理作者资料。

2. 根 data/script.lua:4-5 仅在速度超过 360km/h 时切断加速踏板，没有独立三电机扭矩矢量脚本。但不能据此说 CSP 原生差速器、ABS、TC 或 EDL 没有工作。

3. engine.ini:30-35 与 engine_map_setup.lut:1-4 提供运动、排位、耐力、直线模式，内容主要是转速相关的总扭矩倍率。[CSP Powertrain 文档](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Powertrain) 确认 engine map LUT 的这一用途。未找到由模式联动扭矩矢量、回收、稳定控制和踏板响应的自编逻辑；不能据此否定全部原生控制。

4. engine.ini:4 选择 FROM_COAST_REF，14-16 行配置 28500rpm、350Nm、线性。按总减速比 9.205、后轮半径 0.352m、质量 2435kg，忽略传动损失、空气和滚动阻力，100/200/300km/h 的 coast 等效减速度约 0.093/0.187/0.280g，机械吸收功率约 62/248/557kW。这些用于说明曲线形状，不等于真实电池回收功率；不能直接证明超过实车回收上限。另一个未使用的 coast.lut 缺失不是已确认故障。

5. electronics.ini:8-14 配置 TC、最低介入速度 12km/h，TC LUT 覆盖 0.10–0.40；16-24 行配置 EDL，驱动制动扭矩 300Nm。实际有效阈值受 TC 档位和运行状态影响，不能把单个 0.28 当作全部模式阈值。

6. **ctrl_single_lock.ini 生效对象待核。** 它是已知特殊控制器文件名，不能因没有显式引用就断言未加载。当前 TYPE=AWD 下究竟作用于哪个差速器、是否生效，尚无充分权威说明或运行证据。其 LUT 是差速锁扭矩控制，也不能仅凭此文件认定已模拟三电机独立驱动。应通过动态锁止/各轮扭矩记录，或副本中的 A/B 测试确认。

7. **ERS__ 子目录的运行连接未找到。** 检查根配置和脚本未发现调用其中 ERS 文件的引用；[CSP Physics scripts 文档](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Physics-scripts) 说明 data 根目录 script.lua 在扩展物理启用时加载，并未提供自动递归加载任意 ERS__ 子目录的依据。其异常应列为实验/遗留配置待核，不能直接当作当前驾驶问题。

8. **TORQUE_MODE_EX=2 本身不是错误。** [CSP Suspension 文档](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Suspension) 推荐此模式用于更准确的悬架扭矩作用；核查时应记录 CSP 版本。

## 优化顺序

先在相同轮胎、温度、路面、载荷和 CSP 版本下记录直线加速、松电门减速、低速出弯的轮速/滑移率、各轮驱动与制动扭矩、横摆率、TC/EDL 介入，并核实特殊控制器。随后依据实车模式目标增加受限、渐进的前后轴与左右轮扭矩分配，把踏板响应、稳定控制和回收协调起来。四份总扭矩倍率不足以代表整套驾驶模式。

总扭矩 LUT 与倍率算出的机械峰值不可直接与官方电机峰值对比后判错：作者可能已把传动损失计入 LUT，需用轮上扭矩和加速实测确定约定。0.6g 只适合作为特定条件下最大制动回收能力的参考，不能设成全速域松电门目标。
