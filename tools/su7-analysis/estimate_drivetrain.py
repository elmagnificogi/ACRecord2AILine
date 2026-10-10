from pathlib import Path
import json, math
import numpy as np
out=Path(__file__).resolve().parent
root=out.parent/'car'/'msk_stw_xiaomi_su7_ultra - 2.0'/'data'
def points(name):
    data=[]
    for raw in (root/name).read_text(encoding='utf-8-sig',errors='replace').splitlines():
        raw=raw.split(';',1)[0].strip()
        if '|' in raw:
            try: data.append(tuple(map(float,raw.split('|',1))))
            except ValueError: pass
    return np.array(sorted(data))
p=points('power.lut')
rpm=np.arange(1.,27201.,1.)
t=np.interp(rpm,p[:,0],p[:,1])
curves=[]
for index,label in enumerate(['运动','排位','耐力','直线']):
    mp=points(f'engine_map{index}.lut')
    mapped=t*np.interp(rpm,mp[:,0],mp[:,1])
    power=mapped*rpm*math.pi/30000
    i=int(np.argmax(power))
    curves.append({'map_index':index,'name':label,'peak_model_kw':round(float(power[i]),2),'rpm':int(rpm[i]),'torque_nm':round(float(mapped[i]),2)})
coast=[]
for kph in [100,200,300]:
    v=kph/3.6; r=.352; gear=1.315*7; m=2435
    motor=v/r*gear*60/(2*math.pi)
    drag_nm=motor/28500*350
    force=drag_nm*gear/r
    coast.append({'speed_kmh':kph,'motor_rpm':round(motor,1),'coast_motor_nm':round(drag_nm,1),'wheel_force_N':round(force,1),'deceleration_g':round(force/m/9.80665,3),'motor_coast_kw':round(drag_nm*motor*math.pi/30000,1)})
result={'method':'LUT linear interpolation at 1 rpm resolution within limiter; model power is torque*rpm*pi/30000. Coast is an idealized no-loss motor-to-wheel estimate, excludes aero and rolling resistance, uses unloaded rear radius0.352m. These are not AC telemetry.','maps':curves,'coast':coast}
(out/'drivetrain-estimates.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(result,ensure_ascii=False,indent=2))
