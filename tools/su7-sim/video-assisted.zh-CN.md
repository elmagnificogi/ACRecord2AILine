# SU7 Ultra 视频与公开实测辅助校验

日期：2026-10-09。已核对素材来源和测试条件、加入直线校验，并修正实验控制器的首次模式初始化。原量产和原型mod未修改；重建的CSP包仍只显示预测数据。

本次没有读取视频帧。浏览器因Windows sandbox helper错误无法启动，测试图像资源也未能读取。数值来自原作者文字测试报告，不能说成已经从视频提取的遥测。GT7素材只核对了公开页面、时长和作者说明。

## 已采用的依据

[汽车之家原作者实测](https://www.autohome.com.cn/drive/202503/1304491.html)给出最好零百2.36秒、零至200为5.82秒；另场地400米9.13秒、尾速253.25 km/h。零百前SOC为96%，使用直线竞速模式且保留稳定辅助；悬架版本、胎型、rollout计时及其他场次SOC未核实，成绩不归入空悬或绞牙的确证基准。制动报道值为沥青33.98米、混凝土35.67米。不能将不同最佳成绩拼成同一趟时序。

[小米量产纽北车载](https://www.youtube.com/watch?v=I2EjtbqkZIU)和[赛道发布视频](https://www.youtube.com/watch?v=byxvitfAdao)是同一圈。[小米说明](https://www.xiaomiauto.com/global/prototype)注明专业赛道套装、双风道碳纤前盖、空气动力底板和安全改装；[倍耐力](https://www.pirelli.com/global/en-ww/road/cars/nurburgring-turns-100-182431/)确认Trofeo RS。整圈成绩适合核验赛道版整体表现，不足以标定普通胎、冷胎或低电量。

[GT7 Monza素材](https://www.youtube.com/watch?v=CfXUZdEkqZk)页面声明版本1.67；第三方[赛事目录](https://gtplus.app/gt7/sport/events/4fb04242-f52e-4ef9-aecb-29a6cd7028be)列SS胎及BoP。实际功率、质量、辅助和HUD未确认，没有将其当作原厂性能目标或生成GT7速度曲线。

## 实际修正与结果

控制器reset原先总将功率倍率置为Street，再爬升到首次输入模式。现在首次或reset后直接采用所选模式倍率；后续切换仍平滑，电门继续从零按模式斜率增加。修正对象是初始化逻辑，不是原厂控制参数。

截至2026-10-10，30项核心检查（含700组输入）、13项接口模拟检查通过。六场景与横摆开关对照已重跑，控制核心与电控配置hash匹配当前源码。独立直线测试另有5项自检和8个有效阶段。

直线校验使用同一Lua及简化车辆，mu=0.95/1.20仅为诊断假设，未拟合真实轮胎。统一96% SOC也是情景设定；起步从静止全电门、无rollout，没有弹射预充、热胎、完整气动或AC物理求解。实验Track/MAP_1与实车直线竞速模式不完全相同。

mu=1.20时，实验零百3.034秒、零至200为6.993秒；400米10.034秒、244.35 km/h；100至0.5 km/h制动40.662米，终点尚有23.5 J动能。初始化修正只改善零百5.30毫秒，无法解释主要差距。

![独立纵向校验](E:/Github/ACRecord2AILine/tools/su7-sim/outputs/video-validation/longitudinal-benchmarks.png)

固定分配参考的均值轴速预算与独立轮速积分，起步出现不合理的瞬时轮速、功率；其起步成绩不能作为原AC mod的性能预测。当前轮胎力、负载转移、TC/ABS、起步和动力请求仍有共同不确定性，仅凭汇总成绩不能分别识别它们。

## 对量产mod的判断

按100 km/h真实起速推算，报道制动距离对应约1.10至1.16 g的距离等效减速度，不是峰值G或轮胎摩擦系数。原mod机械扭矩上限按质量、半径粗算约1.10 g；完整表现还受ABS、回收、风阻和滚阻影响。目前不能把4650 Nm认定为明显不足，保留其数值。

真正逐帧校验需要平直路分段加速、明确无刹车的收电门、全刹及同一弯道再加电门。每段要保留时间戳、车速、可见输入、模式、胎型和辅助，并核查坡度、剪辑、帧率及速度表误差。画面能观察反打和振荡，但缺少轮载/输入时序时，不能唯一反推出阻尼、重心、回收或电机分配。尚缺的信号不会用模拟值冒充实测。

## 复现

仓库根目录执行：

```powershell
& 'D:\Python\Python312\python.exe' -X utf8 tools/su7-sim/longitudinal_validation.py
```

它更新独立JSON结果；本说明和图是本轮记录。阈值按0.5 ms积分点插值，制动终点明确为0.5 km/h。

[素材与条件JSON](E:/Github/ACRecord2AILine/tools/su7-sim/references/video-evidence.json) · [直线结果](E:/Github/ACRecord2AILine/tools/su7-sim/outputs/video-validation/longitudinal-summary.json) · [核心验证](E:/Github/ACRecord2AILine/tools/su7-sim/outputs/verification.json)

本轮追加车型归属：2026-10-10 已用新整数档位核心重跑直线测试，默认数值未变，运行时源码哈希已刷新；该平面模型没有悬架动态，不能比较空悬和绞牙。详见[空悬/绞牙版本与 mod 实现说明](E:/Github/ACRecord2AILine/tools/su7-sim/vehicle-variants.zh-CN.md)。
