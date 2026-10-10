from pathlib import Path
p=Path(r'E:\Github\ACRecord2AILine\tools\su7-analysis\analysis.zh-CN.md')
s=p.read_text(encoding='utf-8')
s=s.replace('这次检查的是驾驶物理。已读取量产版的 data 和扩展脚本，并将原型版 data.acd 解包到独立分析目录进行对照。','这次检查的是驾驶物理。已读取量产版的 data 和扩展脚本，并将原型版 data.acd 解包到独立分析目录进行对照。')
s=s.replace('刚出维修区时更容易触及极限。这一现象有明确配置依据，且半热熔胎需要预热符合官方使用说明。','刚出维修区时更容易触及极限。这一现象有明确配置依据，且半热熔胎需要预热符合官方使用说明。原型默认光头胎在 20°C 的因子是 0.80，冷胎敏感并非量产版独有的问题。')
s=s.replace('不能笼统说量产 TC 一定更松。','不能笼统说量产 TC 一定更松。原型的最低介入速度甚至设为 25 km/h，因此低速不介入也不是量产独有错误。')
s=s.replace('量产更软符合公路车与赛车的区别。应根据','量产更软符合公路车与赛车的区别。用单轮簧上质量和线性轮率估算，量产前后频率约 2.07 / 1.89 Hz，原型约 2.79 / 2.84 Hz；这个近似未计轮胎柔度、渐进轮率与整车耦合。应根据')
s=s.replace('优先测 100→0、200→0 的停车距离、四轮滑移与 ABS 介入，随后再调整总扭矩、前后分配和混合回收。','按名义胎半径和最大机械扭矩粗算，忽略气动、附着、ABS 和拖曳回收，量产机械扭矩上限对应约 1.10 g，原型约 1.40 g；这是检查合成制动力的线索，不是实测刹车减速度。优先测 100→0、200→0 的停车距离、四轮滑移与 ABS 介入，随后再调整总扭矩、前后分配和混合回收。')
s=s.replace('STEP=1 不能直接理解成 1° 一格，Content Manager 对 CAMBER 使用专门的缩放与步长规则。','STEP=1 不能直接理解成 1° 一格，Content Manager 对 CAMBER 使用专门的缩放与步长规则。[作者源码](https://github.com/gro-ove/actools/blob/master/AcManager.Tools/Objects/CarSetupEntry.cs#L99) 默认前 −1.5° 已是菜单允许的负外倾最多的一端；若热胎遥测证实外侧前胎外肩过热，可以先开放小范围调节。')
s += '\n更多底盘参数、计算假设和引用见 [底盘审计补充](<E:/Github/ACRecord2AILine/tools/su7-analysis/chassis-findings.zh-CN.md>)。\n'
p.write_text(s,encoding='utf-8')
import re
links=re.findall(r'\]\(<(E:/[^>]+)>\)',s)
missing=[]
for target in links:
    name=re.sub(r':\d+$','',target)
    if not Path(name).exists():missing.append(target)
print('Report chars:',len(s),'local links:',len(links),'missing:',missing)
