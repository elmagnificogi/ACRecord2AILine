"""CSP adapter wiring tests using a mock API; these are NOT runtime calibration."""
from pathlib import Path
import json, sys
R=Path(__file__).resolve().parent;sys.path.insert(0,str(R/'.runtime'))
from lupa.luajit21 import LuaRuntime
mock='''
script={};car={index=0};calls={electric={},brakes={},abs=0,engine=0,debug=0,tc={},debugValues={}};setupValues={[0]=0,[1]=4,[2]=8,[3]=0}
ph={position={x=0,y=0,z=0},look={x=0,y=0,z=1},side={x=1,y=0,z=0},
 up={x=0,y=1,z=0},localVelocity={x=0,y=0,z=20},gear=2,gas=.7,brake=0,
 handbrake=0,speedKmh=72,tractionControlMode=0,wheels={}}
for k=0,3 do
 local r=k<2 and .355 or .352
 ph.wheels[k]={position={x=k%2==0 and .83 or -.83,y=0,z=k<2 and 1.5 or -1.5},
 look={x=0,y=0,z=1},angularSpeed=20/r,load=6000,fy=0}
end
ac={DataLUT11={carData=function(index,file)
 return {get=function(self,rpm) return file=='su7_base_throttle_m1.lut' and .98 or 1300 end}
end},accessCarPhysics=function() return ph end,
 getScriptSetupValue=function(id)
 local index=tonumber(id:match('(%d+)$'))
 return function() return setupValues[index] end
end,
 setTC=function(mode) table.insert(calls.tc,mode);ph.tractionControlMode=mode end,
 getPatchVersion=function() return 'MOCK: not a CSP validation' end,
 debug=function(key,value) calls.debug=calls.debug+1;calls.debugValues[key]=value end,
 overrideEngineTorque=function(t) calls.engine=calls.engine+1 end,
 overrideABS=function(...) calls.abs=calls.abs+1 end,
 addElectricTorque=function(i,t,o) calls.electric[i]={t,o} end,
 overrideBrakesTorque=function(i,t,h) calls.brakes[i]={t,h} end}
'''
def run(active, native_tc=False):
    lua=LuaRuntime(unpack_returned_tuples=True)
    lua.execute('package.path='+json.dumps((R/'csp-shadow'/'data').as_posix()+'/?.lua;')+'..package.path')
    lua.execute(mock)
    if active:lua.execute("package.loaded['su7_runtime']={active=true,calibrated=true,defaultMode=0,omegaSigns={1,1,1,1},torqueSigns={1,1,1,1},torqueUnitsPerNm=1}")
    if native_tc:lua.execute("package.loaded['su7_runtime']={active=false,calibrated=false,nativeTC=true,defaultMode=0,defaultESC=4,defaultTC=8,defaultTVC=0,omegaSigns={1,1,1,1},torqueSigns={1,1,1,1},torqueUnitsPerNm=1}")
    lua.execute((R/'csp_adapter.lua').read_text(encoding='utf-8-sig'))
    for i in range(100):lua.execute('script.update(.003)')
    return lua
checks=[]
x=run(False);c=x.globals().calls
assert c.engine==0 and c.abs==0 and not list(c.electric.items()) and not list(c.brakes.items())
assert c.debug>0 and not list(c.tc.items())
checks.append('Shadow never calls engine/electric/brake/ABS actuators')
x.execute('ph.speedKmh=361;script.update(.003)');assert x.globals().ph.gas==0
checks.append('Shadow preserves original 360km/h cut')
x.execute('script.reset();ph.speedKmh=72;ph.gas=.7;script.update(.003)')
checks.append('Reset clears observer history without actuator calls')
x=run(True);c=x.globals().calls
assert c.engine==100 and c.abs==100
assert all(c.electric[k] is not None and c.brakes[k] is not None for k in range(4))
assert all(c.electric[k][2] is True for k in range(4))
checks.append('Active writes ALL 4 electric/friction actuators each frame')
assert c.electric[0][1]>0 and abs(c.electric[0][1]-c.electric[1][1])<1e-8
checks.append('One front motor uses equal left/right wheel torque')
x.execute('ph.gas=0;ph.brake=.5;ph.handbrake=.4;for j=1,100 do script.update(.003) end')
c=x.globals().calls
assert all(c.electric[k][1]<=0 for k in range(4))
assert all(c.brakes[k][1]>=0 for k in range(4))
assert c.brakes[0][2]==0 and c.brakes[1][2]==0 and c.brakes[2][2]==400 and c.brakes[3][2]==400
checks.append('Braking sends negative electric torque and rear-only handbrake')
# Native TC path must never turn experimental yaw predictions into actuation.
x=run(False, True);c=x.globals().calls
assert list(c.tc.values())==[9] and c.engine==0 and c.abs==0
assert not list(c.electric.items()) and not list(c.brakes.items())
checks.append('Native TC default 8 maps to enabled mode 9; ESC/TVC remain predictions')
for level in range(9):
    x.execute(f'setupValues[2]={level};script.update(.003)')
    assert x.globals().ph.tractionControlMode==level+1
assert all(mode>0 for mode in x.globals().calls.tc.values())
checks.append('All nine custom TC levels map to nonzero native modes 1..9')
count=len(list(x.globals().calls.tc.values()))
x.execute('script.update(.003)')
assert len(list(x.globals().calls.tc.values()))==count
x.execute('ph.tractionControlMode=0;script.update(.003)')
assert x.globals().ph.tractionControlMode==9
checks.append('Native TC keeps unchanged mode and restores an accidental native OFF')
x.execute('setupValues[1]=0;setupValues[2]=0;setupValues[3]=3;for j=1,50 do script.update(.003) end')
c=x.globals().calls
assert c.debugValues['SU7 ESC TC TVC integers']=='0 / 0 / 3'
assert c.debugValues['SU7 predicted ESC TC TVC strengths']=='0.200 / 0.250 / 0.300'
assert c.engine==0 and c.abs==0 and not list(c.electric.items()) and not list(c.brakes.items())
checks.append('Minimum interventions are positive; reversed TVC reaches 0.300 at level 3')
x.execute('setupValues[1]=0/0;setupValues[2]=math.huge;setupValues[3]=nil;for j=1,50 do script.update(.003) end')
assert x.globals().calls.debugValues['SU7 ESC TC TVC integers']=='4 / 8 / 0'
checks.append('Invalid or missing setup refs fall back to safe experimental defaults')
x.execute('setupValues[1]=9.7;setupValues[2]=-1;setupValues[3]=2.9;for j=1,50 do script.update(.003) end')
assert x.globals().calls.debugValues['SU7 ESC TC TVC integers']=='4 / 0 / 2'
checks.append('Runtime setup values clamp and floor to integer ranges')
x.execute('script.reset();script.update(.003)')
assert x.globals().ph.tractionControlMode==1
checks.append('Reset resynchronizes native TC without experimental torque or brake calls')
(R/'outputs'/'adapter-verification.json').write_text(json.dumps({'status':'passed','scope':'Mock wiring only, NOT CSP actuator unit or sign calibration','checks':checks},indent=2),encoding='utf-8')
print(json.dumps({'status':'passed','checks':checks},indent=2))
