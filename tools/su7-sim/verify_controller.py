"""Verify physical constraints and signs on the SAME Lua controller, no mirror."""
from pathlib import Path
import json, math, random
import numpy as np
from simulate import LuaController, ROOT

checks=[]
def check(name, condition, detail=None):
    if not condition: raise AssertionError((name,detail))
    checks.append({'name':name,'passed':True,'detail':detail})

def state(v=20,gas=.7,brake=0,delta=0,yaw=0,vy=0,soc=.5,mode=1):
    r=np.array([.355,.355,.352,.352])
    track=np.array([1.672,1.672,1.649,1.649])
    y=track*np.array([.5,-.5,.5,-.5])
    wheelv=np.array([v-yaw*y[i] for i in range(4)])
    return dict(vx=v,vy=vy,yaw=yaw,delta=delta,gas=gas,brake=brake,mode=mode,
      engineTorqueBudget=1300.,soc=soc,wheelsOmega=wheelv/r,wheelLongSpeed=wheelv,
      wheelLoads=np.array([5787,5787,6157,6157]),wheelFy=np.zeros(4))

def settle(ctrl,s,n=400,dt=.003):
    out=None
    for _ in range(n): out=ctrl.step(s,dt)
    return out

c=LuaController(); base=settle(c,state())
check('Straight symmetry, no unrequested yaw',np.allclose(base['driveTorque'][::2],base['driveTorque'][1::2]) and abs(base['yawAchieved'])<1e-7)
left=state(delta=.03)
a=settle(LuaController(),left)
check('Left turn increases outer RR drive',a['driveTorque'][3]>a['driveTorque'][2] and a['yawRequested']>0)
right=state(delta=-.03)
b=settle(LuaController(),right)
check('Left/right mirror',np.allclose(a['driveTorque'],b['driveTorque'][[1,0,3,2]],rtol=1e-9) and abs(a['yawRequested']+b['yawRequested'])<1e-8)
for beta_sign in [-1,1]:
    out=settle(LuaController(),state(vy=beta_sign*2.0))
    check('Sideslip correction sign '+str(beta_sign),out['yawRequested']*beta_sign>0)
full=settle(LuaController(),state(gas=0,brake=.5,soc=1))
check('Full SOC prevents regen, retains friction',sum(full['regenTorque'])==0 and sum(full['frictionTorque'])>0)
empty=settle(LuaController(),state(soc=0))
check('Empty SOC no positive drive',sum(empty['driveTorque'])==0)
reverse=settle(LuaController(),state(v=-5,gas=.7,brake=.3))
check('Forward-only reverse guard',sum(reverse['driveTorque'])==0 and sum(reverse['regenTorque'])==0 and sum(reverse['frictionTorque'])>0)
zero=settle(LuaController(),state(v=0,gas=0,brake=.4))
check('Standstill no regen/no NaN',zero['regenPowerW']==0 and all(np.isfinite(zero[k]).all() for k in ['driveTorque','regenTorque','frictionTorque']))
low=state(v=15);low['wheelsOmega']*=1.6
out=settle(LuaController(),low)
check('TC responds to driven-wheel spin',min(out['tcFactors'])<.1)
locked=state(v=20,gas=0,brake=.7);locked['wheelsOmega']*=.3
out=settle(LuaController(),locked,n=150)
check('ABS reduces both electric and friction lock demand',max(out['absFactors'])<.1 and sum(out['regenTorque'])<1 and sum(out['frictionTorque'])<1)
# Normal corner wheel speeds must not be mistaken for wheelspin.
s=state(v=20,yaw=.35,delta=.03); s['disableStability']=True
out=settle(LuaController(),s)
check('No false TC from normal outside-wheel speed',min(out['tcFactors'])>.999)
startup_ok=True
startup_detail=[]
for mode,expected in enumerate((.82,.94,1.0)):
    for dt in (0.00001,.003,.04):
        ctrl=LuaController()
        first=ctrl.step(state(gas=1,mode=mode),dt)
        startup_ok &= abs(first['powerScale']-expected)<1e-12
        startup_ok &= first['gasCommand']<=float(ctrl.config['modes'][mode+1]['gasRise'])*dt+1e-12
        settle(ctrl,state(mode=(mode+1)%3))
        ctrl.obj.reset(ctrl.obj)
        reset_first=ctrl.step(state(gas=1,mode=mode),dt)
        startup_ok &= abs(reset_first['powerScale']-expected)<1e-12
        startup_ok &= reset_first['gasCommand']<=float(ctrl.config['modes'][mode+1]['gasRise'])*dt+1e-12
        startup_detail.append({'mode':mode,'dt':dt,'firstPowerScale':first['powerScale'],'resetPowerScale':reset_first['powerScale']})
check('Selected initial/reset profile has no false mode ramp; pedal ramp retained',bool(startup_ok),startup_detail)
ctrl=LuaController();prev=settle(ctrl,state(mode=0))
new=ctrl.step(state(mode=2),.003)
track=settle(ctrl,state(mode=2)); down=ctrl.step(state(mode=0),.003)
check('Live mode switches smooth pedal and power in both directions',abs(new['gasCommand']-prev['gasCommand'])<=.01501 and abs(new['powerScale']-prev['powerScale'])<=.00301 and abs(down['powerScale']-track['powerScale'])<=.00301 and abs(down['gasCommand']-track['gasCommand'])<=.06001)

# ESC/TC/TVC are independent integer controls. Freeze the plant state and reset
# each sweep so different outcomes cannot be caused by different trajectories.
def levels(s,esc=4,tc=8,tvc=0):
    return dict(s,escLevel=esc,tcLevel=tc,tvcLevel=tvc)

def same_output(a,b):
    return all(np.array_equal(a[k],b[k]) if isinstance(a[k],np.ndarray) else a[k]==b[k] for k in a)

omitted=LuaController(); explicit=LuaController(); legacy_equal=True
for n in range(150):
    sample=state(v=20+n*.08,gas=.65,brake=(.3 if n>90 else 0),
      delta=.035*math.sin(n*.07),yaw=.08,vy=.3,soc=.5,mode=n//50)
    sample['wheelsOmega'][2]*=1.1
    legacy_equal &= same_output(omitted.step(sample,.003),explicit.step(levels(sample),.003))
check('Omitted levels exactly equal explicit ESC4 TC8 TVC0',bool(legacy_equal))

sanitized=True
for raw in (-20,-.2,.9,1.9,100,float('nan'),float('inf'),float('-inf'),'invalid',False):
    s=state();s.update(escLevel=raw,tcLevel=raw,tvcLevel=raw)
    o=LuaController().step(s,.003)
    finite=isinstance(raw,(int,float)) and not isinstance(raw,bool) and math.isfinite(raw)
    expected=tuple(min(maximum,max(0,math.floor(raw))) if finite else default
      for maximum,default in ((4,4),(8,8),(3,0)))
    sanitized &= (o['escLevel'],o['tcLevel'],o['tvcLevel'])==expected
check('Runtime levels floor/clamp; invalid or nonfinite input uses ESC4 TC8 TVC0',bool(sanitized))

spin=state(v=20,gas=.7);spin['wheelsOmega']*=1.3
reductions=[]
for level in range(9):
    o=settle(LuaController(),levels(spin,tc=level),n=10)
    reductions.append(float(1-np.min(o['tcFactors'])))
check('TC0..8 strictly increases slip intervention; TC0 retains positive control',
  reductions[0]>0 and all(b>a for a,b in zip(reductions,reductions[1:])),reductions)

# No drive budget ensures TVC cannot satisfy this yaw request before ESC acts.
braking_turn=state(v=20,gas=0,brake=.3,delta=.012)
esc_brakes=[]
for level in range(5):
    o=settle(LuaController(),levels(braking_turn,esc=level),n=150)
    esc_brakes.append(float(sum(o['escBrakeTorque'])))
check('ESC0..4 strictly increases selective braking; ESC0 retains positive control',
  esc_brakes[0]>0 and all(b>a for a,b in zip(esc_brakes,esc_brakes[1:])),esc_brakes)

turn=state(v=20,gas=.7,delta=.012)
tvc_diffs=[]
for level in range(4):
    o=settle(LuaController(),levels(turn,tvc=level),n=150)
    tvc_diffs.append(float(o['driveTorque'][3]-o['driveTorque'][2]))
check('TVC0..3 strictly decreases rear drive difference; TVC3 retains positive control',
  tvc_diffs[-1]>0 and all(b<a for a,b in zip(tvc_diffs,tvc_diffs[1:])),tvc_diffs)

mixed=state(v=20,gas=.7,delta=.012);mixed['wheelsOmega']*=1.2
strong=settle(LuaController(),levels(mixed),n=20)
weak_esc=settle(LuaController(),levels(mixed,esc=0),n=20)
check('Changing ESC leaves TC factors and rear TVC request independent',
  np.array_equal(strong['tcFactors'],weak_esc['tcFactors'])
  and strong['tvcYawRequested']==weak_esc['tvcYawRequested']
  and weak_esc['escStrength']>0)
weak_tvc=settle(LuaController(),levels(mixed,tvc=3),n=20)
check('Changing TVC leaves TC factors and common yaw request independent',
  np.array_equal(strong['tcFactors'],weak_tvc['tcFactors'])
  and strong['yawRequested']==weak_tvc['yawRequested']
  and weak_tvc['tvcYawRequested']<strong['tvcYawRequested'])
weak_tc=settle(LuaController(),levels(mixed,tc=0),n=20)
check('Changing TC leaves the yaw target and ESC/TVC gains independent',
  min(weak_tc['tcFactors'])>min(strong['tcFactors'])
  and weak_tc['yawRequested']==strong['yawRequested']
  and weak_tc['escStrength']==strong['escStrength']
  and weak_tc['tvcStrength']==strong['tvcStrength'])

zero=settle(LuaController(),levels(mixed,esc=0,tc=0,tvc=0),n=20)
check('Numeric zero retains every channel; TVC0 is its strongest setting',
  zero['escStrength']>0 and zero['tcStrength']>0 and zero['tvcStrength']==1
  and min(zero['tcFactors'])<1 and zero['tvcYawRequested']>0)

minimum=levels(state(v=20,gas=0,brake=.7,soc=1),esc=0,tc=0,tvc=3)
minimum['wheelsOmega']*=.3
o=settle(LuaController(),minimum,n=150)
assert sum(o['regenTorque'])==0 and max(o['absFactors'])<.1
empty_min=settle(LuaController(),levels(state(soc=0),esc=0,tc=0,tvc=3))
overspeed_min=levels(state(gas=1),esc=0,tc=0,tvc=3);overspeed_min['wheelsOmega'][2]=400
rev_min=LuaController().step(overspeed_min,.003)
check('Minimum intervention retains ABS, SOC and independent motor overspeed limits',
  sum(empty_min['driveTorque'])==0 and rev_min['driveTorque'][2]==0 and rev_min['driveTorque'][3]>0)
ctrl=LuaController();settle(ctrl,levels(mixed),n=20)
disabled=ctrl.step(dict(levels(mixed),disableStability=True),.003)
check('Separate stability-disable flag immediately gates ESC/TVC while retaining TC',
  disabled['escStrength']==0 and disabled['tvcStrength']==0 and disabled['yawRequested']==0
  and disabled['tvcYawRequested']==0 and sum(disabled['escBrakeTorque'])==0 and min(disabled['tcFactors'])<1)

rng=random.Random(937); worst_drive=worst_regen=0
config=LuaController().config
for case in range(700):
    speed=rng.uniform(0,99.5)
    s=state(v=speed,gas=rng.random(),brake=(rng.random() if rng.random()<.45 else 0),
      delta=rng.uniform(-.2,.2),yaw=rng.uniform(-.7,.7),vy=rng.uniform(-3,3),
      soc=rng.uniform(.01,1),mode=rng.randrange(3))
    s.update(escLevel=rng.randrange(5),tcLevel=rng.randrange(9),tvcLevel=rng.randrange(4))
    s['engineTorqueBudget']=rng.uniform(0,1500)
    s['wheelLoads']=np.array([rng.uniform(0,13000) for _ in range(4)])
    s['wheelFy']=np.array([rng.uniform(-2000,2000) for _ in range(4)])
    s['wheelsOmega']=np.array([rng.uniform(0,310) for _ in range(4)])
    s['chargeAcceptanceW']=rng.uniform(0,400000)
    o=settle(LuaController(),s,n=12)
    for key in ['driveTorque','regenTorque','frictionTorque','tcFactors','absFactors']:
        assert np.isfinite(o[key]).all(),(case,key,o[key])
        assert np.min(o[key])>=-1e-8,(case,key)
    assert np.max(o['tcFactors'])<=1 and np.max(o['absFactors'])<=1
    assert abs(o['driveTorque'][0]-o['driveTorque'][1])<1e-7
    assert abs(o['regenTorque'][0]-o['regenTorque'][1])<1e-7
    for i in range(4):
        motor=config['motors'][1 if i<2 else i]
        divisor=2 if i<2 else 1
        shaft_nm=o['driveTorque'][i]/(motor['gear']*config['mechanicalEfficiency'])
        assert shaft_nm<=motor['torqueNm']/divisor+1e-7,(case,'motor torque')
        wheel_p=o['driveTorque'][i]*s['wheelsOmega'][i]
        assert wheel_p<=motor['powerW']*config['mechanicalEfficiency']/divisor+1e-5,(case,'motor power')
    assert o['regenPowerW']<=min(400000,s['chargeAcceptanceW'])+1e-6,(case,'regen power')
    assert o['drivePowerW']<=1138000*config['mechanicalEfficiency']+1e-5
    front_p=sum(o['driveTorque'][:2]*s['wheelsOmega'][:2])
    assert front_p<=288000*config['mechanicalEfficiency']+1e-5
    total_f=sum(o['driveTorque']/np.array([.355,.355,.352,.352]))
    max_f=s['engineTorqueBudget']*9.205/.352*o['gasCommand']*o['powerScale']
    max_f*=min(1,max(0,(s['soc']-.02)/.05))
    assert total_f<=max_f+1e-5,(case,'longitudinal budget',total_f,max_f)
    worst_drive=max(worst_drive,o['drivePowerW']);worst_regen=max(worst_regen,o['regenPowerW'])
check('700 mixed states: finite, motor/shared-front caps, force budget, regen power',True,
  {'maxDriveKW':worst_drive/1000,'maxRegenKW':worst_regen/1000})
# Mixed braking cannot increase demand when ESC is disabled.
s=state(v=20,gas=0,brake=.5);s['disableStability']=True
out=settle(LuaController(),s)
force=sum((out['regenTorque']+out['frictionTorque'])/np.array([.355,.355,.352,.352]))
check('Friction fills regen to requested brake force',abs(force-2435*9.80665*1.2*.5)<1e-5,force)
s=state(v=55.555,gas=1,mode=2,soc=.8);s['engineTorqueBudget']=2200.;s['wheelLoads']=np.full(4,20000.);s['disableStability']=True
out=settle(LuaController(),s)
check('Full-power state reaches and respects three-motor ceiling',abs(out['drivePowerW']-1138000*.94)<1e-5,out['drivePowerW'])
s['soc']=.2;out=settle(LuaController(),s)
check('Conservative modeled SOC20 discharge ceiling',abs(out['drivePowerW']-800000*.94)<1e-5,out['drivePowerW'])
s=state(gas=1);s['wheelsOmega'][2]=400;out=LuaController().step(s,.003)
check('One overspeed rear motor independently cuts drive',out['driveTorque'][2]==0 and out['driveTorque'][3]>0)
p=ROOT/'outputs'/'verification.json';p.parent.mkdir(exist_ok=True)
p.write_text(json.dumps({'checks':checks,'count':len(checks),'status':'passed'},indent=2),encoding='utf-8')
print(json.dumps({'status':'passed','count':len(checks),'checks':checks},indent=2))
