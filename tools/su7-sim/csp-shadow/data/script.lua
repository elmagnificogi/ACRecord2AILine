-- Shadow by default; nativeTC optionally synchronizes native TC only.
-- Experimental electric/brake actuation requires measured runtime calibration.
-- Same numerical controller as the offline harness; no use of rendering wheel state.
local C=require('su7_config')
local R=require('su7_runtime')
local control=require('su7_control').new(C)
local power=ac.DataLUT11.carData(car.index,'su7_base_power.lut')
local map=ac.DataLUT11.carData(car.index,'su7_base_throttle_m1.lut')
local ph=ac.accessCarPhysics()
local elapsed=0
local previousLook,previousLeft=nil,nil
local function dot(a,b) return a.x*b.x+a.y*b.y+a.z*b.z end
local function vec(x,y,z) return {x=x,y=y,z=z} end
local function subtract(a,b) return vec(a.x-b.x,a.y-b.y,a.z-b.z) end
local function copy(a) return vec(a.x,a.y,a.z) end
local function atan2(y,x)
  if x>0 then return math.atan(y/x) end
  if x<0 then return math.atan(y/x)+(y>=0 and math.pi or -math.pi) end
  return y>0 and math.pi/2 or (y<0 and -math.pi/2 or 0)
end
local setupRefs={}
for i=0,3 do setupRefs[i]=ac.getScriptSetupValue('CUSTOM_SCRIPT_ITEM_'..i) end
local function getLevel(index,maximum,default)
  local ref=setupRefs[index]
  local value=ref and ref() or default
  if type(value)~='number' or value~=value or math.abs(value)==math.huge then value=default end
  return math.max(0,math.min(maximum,math.floor(value)))
end
local previousNativeTC=nil
local function syncNativeTC(level)
  if not R.nativeTC or R.active then return end
  assert(type(ac.setTC)=='function','Native TC setup requires CSP ac.setTC')
  -- Native 0 is OFF. Custom 0 retains the weakest enabled threshold.
  -- Mode 1 -> LUT index 0 is an AC convention still requiring game verification.
  local desired=level+1
  if previousNativeTC~=desired or ph.tractionControlMode~=desired then
    ac.setTC(desired);previousNativeTC=desired
  end
end
local function observe(dt)
  local d=subtract(ph.wheels[0].position,ph.wheels[1].position)
  local basisSign=dot(d,ph.side)>=0 and 1 or -1
  local left=vec(ph.side.x*basisSign,ph.side.y*basisSign,ph.side.z*basisSign)
  local yaw=0
  if previousLook then yaw=atan2(dot(ph.look,previousLeft),dot(ph.look,previousLook))/math.max(dt,1e-5) end
  previousLook,previousLeft=copy(ph.look),copy(left)
  local vx,vy=ph.localVelocity.z,ph.localVelocity.x*basisSign
  local s={vx=vx,vy=vy,yaw=yaw,gas=ph.gas,brake=ph.brake,mode=getLevel(0,2,R.defaultMode or 0),
    escLevel=getLevel(1,4,R.defaultESC or 4),tcLevel=getLevel(2,8,R.defaultTC or 8),tvcLevel=getLevel(3,3,R.defaultTVC or 0),
    reverse=ph.gear==0,soc=control.soc,wheelsOmega={},wheelLongSpeed={},wheelLoads={},wheelFy={}}
  local frontDelta=0
  for k=0,3 do
    local w=ph.wheels[k]
    local delta=atan2(dot(w.look,left),dot(w.look,ph.look))
    if k<2 then frontDelta=frontDelta+delta*0.5 end
    local p=subtract(w.position,ph.position)
    local x,y=dot(p,ph.look),dot(p,left)
    s.wheelLongSpeed[k+1]=(vx-yaw*y)*math.cos(delta)+(vy+yaw*x)*math.sin(delta)
    s.wheelsOmega[k+1]=w.angularSpeed*R.omegaSigns[k+1]
    s.wheelLoads[k+1]=w.load
    s.wheelFy[k+1]=w.fy
  end
  s.delta=frontDelta
  local virtualRPM=0
  for i=1,4 do virtualRPM=virtualRPM+math.max(s.wheelsOmega[i],0)*0.25*C.virtualGear*60/(2*math.pi) end
  s.engineTorqueBudget=virtualRPM>=27200 and 0 or power:get(math.max(virtualRPM,1))*map:get(math.max(virtualRPM,1))
  local speed3d=math.sqrt(ph.localVelocity.x^2+ph.localVelocity.y^2+ph.localVelocity.z^2)
  local consistency=math.abs(speed3d-ph.speedKmh/3.6)
  return s,consistency
end
function script.reset()
  control:reset();previousLook,previousLeft=nil,nil;elapsed=0;previousNativeTC=nil
end
function script.update(dt)
  local s,error=observe(dt)
  local out=control:step(s,dt)
  syncNativeTC(out.tcLevel)
  if R.active then
    -- All mechanical drive/coast must already be cancelled in the generated data.
    -- Sign and torque scale are measurements; no invented latest-preview APIs.
    assert(R.calibrated,'SU7 experimental actuation requires measured calibration')
    assert(type(ac.addElectricTorque)=='function' and type(ac.overrideBrakesTorque)=='function','Required CSP physics APIs missing')
    assert(error<math.max(.5,math.abs(s.vx)*.05),'SU7 physical speed/basis mismatch')
    ac.overrideEngineTorque(0)
    ac.overrideABS(1,1,1,1) -- Lua already regulates friction AND regen slip.
    for k=0,3 do
      local electric=(out.driveTorque[k+1]-out.regenTorque[k+1])*R.torqueSigns[k+1]*R.torqueUnitsPerNm
      ac.addElectricTorque(k,electric,true)
      ac.overrideBrakesTorque(k,out.frictionTorque[k+1],k>=2 and 1000*ph.handbrake or 0)
    end
  else
    -- Preserve the original speed cut, with no other actuator calls in shadow mode.
    if ph.speedKmh>360 then ph.gas=0 end
  end
  elapsed=elapsed+dt
  if elapsed>.10 then
    elapsed=0
    ac.debug('SU7 mode',R.active and 'EXPERIMENTAL ACTIVE' or (R.nativeTC and 'NATIVE TC / ESC TVC PREDICTIONS' or 'SHADOW: no actuation'))
    ac.debug('SU7 ESC TC TVC integers',string.format('%d / %d / %d',out.escLevel,out.tcLevel,out.tvcLevel))
    ac.debug('SU7 predicted ESC TC TVC strengths',string.format('%.3f / %.3f / %.3f',out.escStrength,out.tcStrength,out.tvcStrength))
    ac.debug('SU7 native TC expected/actual',string.format('%d / %s',out.tcLevel+1,tostring(ph.tractionControlMode)))
    ac.debug('SU7 native TC available modes',car.tractionControlModes)
    ac.debug('SU7 predicted ESC/TVC yaw Nm',string.format('%.1f / %.1f',out.escYawRequested,out.tvcYawRequested))
    ac.debug('SU7 CSP',ac.getPatchVersion())
    ac.debug('SU7 dt s',dt)
    ac.debug('SU7 physical speed mismatch m/s',error)
    ac.debug('SU7 roadwheel rad',s.delta)
    ac.debug('SU7 yaw measured/reference rad/s',string.format('%.4f / %.4f',s.yaw,out.yawReference))
    ac.debug('SU7 forward/lateral m/s',string.format('%.3f / %.3f',s.vx,s.vy))
    ac.debug('SU7 predicted RR-RL Nm',out.driveTorque[4]-out.driveTorque[3])
    ac.debug('SU7 predicted drive/regen kW',string.format('%.1f / %.1f',out.drivePowerW/1000,out.regenPowerW/1000))
    ac.debug('SU7 virtual SOC',out.soc)
    for k=0,3 do
      ac.debug('SU7 raw wheel omega '..k,ph.wheels[k].angularSpeed)
      ac.debug('SU7 expected wheel long speed '..k,s.wheelLongSpeed[k+1])
      ac.debug('SU7 predicted slip '..k,out.slipRatios[k+1])
    end
  end
end
