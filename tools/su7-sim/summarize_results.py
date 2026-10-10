from pathlib import Path
import hashlib, json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
r=Path(__file__).resolve().parent
summary=json.loads((r/'outputs/simulation-summary.json').read_text(encoding='utf-8'))
ab=json.loads((r/'outputs/yaw-ablation/ablation-summary.json').read_text(encoding='utf-8'))
for data in [summary,ab]:
    assert data['metadata']['controllerSha256']==hashlib.sha256((r/'su7_control.lua').read_bytes()).hexdigest()
    assert data['metadata']['configSha256']==hashlib.sha256((r/'su7_config.lua').read_bytes()).hexdigest()
    assert all(x['metrics']['terminated'] is None for x in data['results'])
checks=json.loads((r/'outputs/verification.json').read_text(encoding='utf-8'))
assert checks['status']=='passed' and checks['count']==30
adapter=json.loads((r/'outputs/adapter-verification.json').read_text(encoding='utf-8'))
assert adapter['status']=='passed'
adapter_count=len(adapter['checks'])
manifest=json.loads((r/'csp-shadow/manifest.json').read_text(encoding='utf-8'))
source=r.parent/'car'/'msk_stw_xiaomi_su7_ultra - 2.0'/'data'
assert all(hashlib.sha256((source/name).read_bytes()).hexdigest()==digest for name,digest in manifest['originalSourceSHA256'].items())
scenarios={}
for case in summary['results']:scenarios.setdefault(case['scenario'],{})[case['controller']]=case['metrics']
labels={'corner_throttle':'出弯加电门','low_mu_exit':'低附着出弯','yaw_disturbance':'横摆/侧滑扰动','brake_blend':'分级制动','high_soc_brake':'99.5% SOC制动','mode_switch':'驾驶模式切换'}
text=f'''# 电控模拟结果与可用范围

日期：2026-10-10。运行LuaJIT 2.1/Lupa 2.6，共用su7_control.lua。原mod未修改。以下是简化平面车辆上的数值试验，不是AC遥测或厂家标定。当前量产mod的空悬/绞牙归属未确认；Street/Sport/Track仅为电控模式，平面模型没有悬架动态，结果不能作为两种底盘的性能对照。

{checks['count']}项核心检查（含700组混合输入）与{adapter_count}项模拟CSP接线检查通过；6个场景各比较固定分配参考与实验控制，均无非有限状态或退出前进行驶域。结果文件中的控制核心及配置SHA256与当前文件一致，原mod源数据SHA256与观测包构建前一致。

ESC/TC/TVC 为独立整数：ESC 0–4、TC 0–8 越大干预越强；TVC 0–3 越大干预越少。零档不关闭。默认 ESC4/TC8/TVC0 保持之前整套实验行为，以下六场景默认数值与旧版一致。这不是已测得的原厂档位响应，也不代表圈速单调变化。

## 整套控制对照

参考采用同一平面车辆和原MAP_1动力曲线，固定前22/后78、简化TC/ABS及原coast；实验同时改变电门请求、功率倍率、各轮TC、横摆控制和回收。因此不能将全部差异归因于后轮扭矩矢量。

'''
for name,pair in scenarios.items():
    a,b=pair['reference'],pair['experimental']
    text+=f"- **{labels[name]}**：侧滑峰值 {a['peakAbsBetaDeg']:.2f}° → {b['peakAbsBetaDeg']:.2f}°；滑移绝对峰值 {a['peakAbsSlip']:.3f} → {b['peakAbsSlip']:.3f}；场景结束车速 {a['finalSpeedKmh']:.1f} → {b['finalSpeedKmh']:.1f} km/h。\n"
text+='''
低附着场景改善较大，但实验输出功率更低、结束车速也略低，电门和TC限制占了很大作用。不能据此承诺实车侧滑也同比下降。

分级制动中，实验模型回收能量约0.208 kWh，但滑移峰值比参考高（0.209对0.144）。因此混合制动结构已经可测，控制增益和踏板映射仍有校准空间。接近满电时回收降低，摩擦制动承担更多请求；机械扭矩有限，不能无限补足最大踏板需求。

## 单独开关横摆反馈

同一实验电门、动力和TC参数，只关闭横摆目标对应的差动分配与ESC制动。各轮TC及载荷限扭仍可能使左右扭矩不完全相等。

'''
a,b=ab['results'][0]['metrics'],ab['results'][1]['metrics']
text+=f"低附着出弯侧滑峰值由 {a['peakAbsBetaDeg']:.2f}° 降至 {b['peakAbsBetaDeg']:.2f}°，结束车速为 {a['finalSpeedKmh']:.1f} / {b['finalSpeedKmh']:.1f} km/h；相对共同几何横摆参考的RMS误差由 {a['yawErrorRmsRadS']:.3f} 增至 {b['yawErrorRmsRadS']:.3f} rad/s。这个几何参考没有包含附着和转向不足约束，不能当成真实路径误差。当前整定更重视减小侧滑，转向跟随也更保守。\n"
text+='''
## 交付物

- [使用说明与边界](<E:/Github/ACRecord2AILine/tools/su7-sim/README.zh-CN.md>)
- [公开数据来源](<E:/Github/ACRecord2AILine/tools/su7-sim/references/public-data.zh-CN.md>)
- [六场景摘要JSON](<E:/Github/ACRecord2AILine/tools/su7-sim/outputs/simulation-summary.json>)
- [横摆开关对照JSON](<E:/Github/ACRecord2AILine/tools/su7-sim/outputs/yaw-ablation/ablation-summary.json>)
- [核心验证结果](<E:/Github/ACRecord2AILine/tools/su7-sim/outputs/verification.json>)
- [CSP观测脚本](<E:/Github/ACRecord2AILine/tools/su7-sim/csp-shadow/data/script.lua>)

观测包保留原物理，仅计算预测输出，未启用实验扭矩。电扭矩单位/方向、传动隔离及实际制动接口仍需游戏内校准；脚本接线测试不替代这些校准。主动构建器是前进实验用途，未生成或安装正式驾驶版本。
'''
text=text.replace('E:/Github/ACRecord2AILine',r.parent.parent.as_posix())
(r/'RESULTS.zh-CN.md').write_text(text,encoding='utf-8')
normal=json.loads((r/'outputs/simulation.json').read_text(encoding='utf-8'))
abl=json.loads((r/'outputs/yaw-ablation/ablation.json').read_text(encoding='utf-8'))
cases=[x for x in normal['results'] if x['scenario']=='low_mu_exit' and x['controller']=='reference']+abl['results']
styles={'reference':('#777777','Fixed-split reference'),'experimental_no_yaw':('#b67621','New control, yaw off'),'experimental':('#168c8c','New control, yaw on')}
fig,axs=plt.subplots(1,2,figsize=(11.4,4.1),constrained_layout=True)
for case in cases:
    color,label=styles[case['controller']]
    tr=case['trace'];t=np.array([v['t'] for v in tr]);slip=np.array([max(v['kappa']) for v in tr]);beta=np.array([v['beta']*180/np.pi for v in tr])
    axs[0].plot(t,slip,color=color,label=label);axs[1].plot(t,beta,color=color,label=label)
for ax,title,ylabel in zip(axs,['Driven-wheel spin','Body sideslip'],['Maximum wheel slip ratio [dimensionless]','Sideslip angle [deg]']):
    ax.set_title(title);ax.set_xlabel('Time [s]');ax.set_ylabel(ylabel);ax.grid(alpha=.18);ax.legend(fontsize=8)
fig.suptitle('Low-friction corner exit: hypothetical control experiment')
fig.text(.01,.001,'Source: original mod MAP_1 + shared Lua controller; not AC telemetry. 2026-10-10; 0–8 s, mu=0.55.',fontsize=8)
fig.savefig(r/'outputs/control-comparison.png',dpi=150);plt.close(fig)
print(json.dumps({'sourceHashesMatched':True,'originalModUnchanged':True,'scenarios':len(scenarios),'coreChecks':checks['count'],'adapterChecks':adapter_count,'traceBytes':(r/'outputs/simulation.json').stat().st_size,'figure':str(r/'outputs/control-comparison.png')}))
