"""Read-only baseline comparison for the two SU7 mods.
INI parsing retains actual values and physical line references.
Static aero is an explanatory estimate, not a simulation result.
"""
from pathlib import Path
import json, re, numpy as np
base=Path(__file__).resolve().parent
roots={'production':base.parent/'car'/'msk_stw_xiaomi_su7_ultra - 2.0'/'data','prototype':base/'prototype-data'}
filenames=['car.ini','suspensions.ini','tyres.ini','brakes.ini','electronics.ini','drivetrain.ini','aero.ini','engine.ini','setup.ini','escmode.ini']
def ini(path):
    sections={}; s=None
    for line,text in enumerate(path.read_text(encoding='utf-8-sig',errors='replace').splitlines(),1):
        val=text.split(';',1)[0].strip()
        if not val: continue
        if val.startswith('[') and val.endswith(']'):
            s=val[1:-1]; sections.setdefault(s,{})
        elif s and '=' in val:
            k,v=val.split('=',1); sections[s][k.strip()]=dict(value=v.strip(),line=line,path=str(path))
    return sections
models={key:{f:ini(root/f) for f in filenames if (root/f).is_file()} for key,root in roots.items()}
def lut(root,name):
    text=(root/name).read_text(encoding='utf-8-sig',errors='replace')
    vals=[]
    for raw in text.splitlines():
        raw=raw.split(';',1)[0].strip()
        if '|' not in raw: continue
        a,b=raw.split('|',1)
        try: vals.append((float(a),float(b)))
        except ValueError: pass
    return sorted(vals)
def at(root,name,x):
    vals=lut(root,name)
    return float(np.interp(x,[v[0] for v in vals],[v[1] for v in vals]))
def value(d,f,s,k,default=None):
    return d.get(f,{}).get(s,{}).get(k,{}).get('value',default)
calculations=[]
for model,root in roots.items():
    d=models[model]
    for height in [.04,.05,.08,.11]:
        wings=[]
        for name,sect in d['aero.ini'].items():
            if not re.fullmatch('WING_[0-9]+',name): continue
            val=lambda k: sect[k]['value']
            angle=float(val('ANGLE'))
            cl=at(root,val('LUT_AOA_CL'),angle)*float(val('CL_GAIN'))
            height_table=val('LUT_GH_CL')
            hm=at(root,height_table,height) if height_table else 1
            area=float(val('SPAN'))*float(val('CHORD'))
            wings.append(dict(name=val('NAME'),wing=name,angle=angle,area=area,raw_cl=at(root,val('LUT_AOA_CL'),angle),cl_gain=float(val('CL_GAIN')),height_multiplier=hm,cl_area=cl*hm*area,z=float(val('POSITION').split(',')[2])))
        coef=sum(w['cl_area'] for w in wings)
        cg=float(value(d,'suspensions.ini','BASIC','CG_LOCATION'))
        wheelbase=float(value(d,'suspensions.ini','BASIC','WHEELBASE'))
        rear_distance=cg*wheelbase
        front_coefficient=sum(w['cl_area']*(w['z']+rear_distance)/wheelbase for w in wings)
        for speed in [100,200,300,350]:
            q=.5*1.225*(speed/3.6)**2
            calculations.append(dict(model=model,assumed_height_m=height,speed_kmh=speed,rho=1.225,total_N=q*coef,total_kgf=q*coef/9.80665,front_kgf=q*front_coefficient/9.80665,rear_kgf=q*(coef-front_coefficient)/9.80665,aero_front_share=front_coefficient/coef,wings=wings))
report=dict(models=models,aero_estimates=calculations,notes=['Aero estimate uses configured ANGLE, zero pitch/yaw, equal assumed height at every ground-effect wing, rho=1.225kg/m3 and no damage.','At >66km/h production WING_2 SPEED controller has multiplier 1, so static angle22deg is consistent with its configured controller.','The prototype archive was unpacked to the analysis directory only and verified with unchanged source SHA256.'])
(base/'physics_baseline_comparison.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
for model,d in models.items():
    print(model)
    for f,s in [('car.ini','BASIC'),('suspensions.ini','BASIC'),('suspensions.ini','ARB'),('suspensions.ini','FRONT'),('suspensions.ini','REAR'),('brakes.ini','DATA'),('electronics.ini','ABS'),('electronics.ini','TRACTION_CONTROL'),('drivetrain.ini','TRACTION'),('drivetrain.ini','AWD'),('engine.ini','ENGINE_DATA')]:
        params=d.get(f,{}).get(s,{})
        if s in ('FRONT','REAR'): params={k:v for k,v in params.items() if k in ['BASEY','SPRING_RATE','ROD_LENGTH','PACKER_RANGE','BUMPSTOP_UP','TRACK','TOE_OUT','STATIC_CAMBER','DAMP_BUMP','DAMP_REBOUND']}
        print(f,s,{k:v['value'] for k,v in params.items()})
    ti=int(value(d,'tyres.ini','COMPOUND_DEFAULT','INDEX'))
    for side in ['FRONT','REAR']:
        sect=side+('_'+str(ti) if ti else '')
        keys=['NAME','WIDTH','RADIUS','FZ0','DY_REF','DX_REF','LS_EXPY','LS_EXPX','FALLOFF_LEVEL','FALLOFF_SPEED','PRESSURE_STATIC','PRESSURE_IDEAL','FRICTION_LIMIT_ANGLE']
        print('DEFAULT TYRE',sect,{k:value(d,'tyres.ini',sect,k) for k in keys})
for r in calculations:
    if r['assumed_height_m']==.05 and r['speed_kmh'] in [100,200,300,350]:
        print('AERO', {k:round(v,3) if isinstance(v,float) else v for k,v in r.items() if k not in ['wings']})
