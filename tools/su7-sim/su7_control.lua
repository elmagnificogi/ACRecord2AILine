-- Portable controller, also executed by the Python simulation through Lupa.
-- Coordinates: x forward, y left, z up; yaw is rad/s, delta is road-wheel rad.
-- Wheel order: FL, FR, RL, RR (Lua 1..4). No CSP calls in this module.
local M={}
local abs,min,max,sqrt,exp,tan,pi=math.abs,math.min,math.max,math.sqrt,math.exp,math.tan,math.pi
local function clamp(x,a,b) return min(b,max(a,x)) end
local function number(x,fallback)
  if type(x)=='number' and x==x and abs(x)<1e12 then return x end
  return fallback or 0
end
-- Engineering level map, not a measured Xiaomi ECU calibration.
-- Missing/nonfinite inputs retain the legacy full intervention. Runtime fractional
-- values are floored after clipping; configurators should accept integers only.
local function integerLevel(x,maximum,default) return math.floor(clamp(number(x,default),0,maximum)) end
local function sign(x) return x<0 and -1 or (x>0 and 1 or 0) end
local function atan2(y,x)
  if x>0 then return math.atan(y/x) end
  if x<0 then return math.atan(y/x)+(y>=0 and pi or -pi) end
  return y>0 and pi/2 or (y<0 and -pi/2 or 0)
end
local function approach(x,target,rate,dt)
  return x+clamp(target-x,-rate*dt,rate*dt)
end
local function four(x) return {x,x,x,x} end

function M.new(config)
  assert(config and config.mass and config.motors,'controller requires SI configuration')
  local self={config=config}
  function self:reset()
    self.gas=0; self.yawReference=0; self.yawMoment=0; self.powerScale=config.modes[1].powerScale
    self.profileInitialized=false
    self.tc=four(1); self.antiLock=four(1); self.brakingActive=four(false); self.soc=config.initialSOC or 0.8
  end
  self:reset()
  function self:step(s,dt)
    local c=self.config
    dt=clamp(number(dt,0.003),0.00001,0.05)
    local mode=c.modes[clamp(math.floor(number(s.mode)),0,#c.modes-1)+1]
    -- A selected startup profile is not a live Street-to-profile transition.
    -- Keep subsequent profile changes smooth and retain the separate pedal ramp.
    if not self.profileInitialized then
      self.powerScale=mode.powerScale; self.profileInitialized=true
    end
    local escLevel=integerLevel(s.escLevel,4,4)
    local tcLevel=integerLevel(s.tcLevel,8,8)
    local tvcLevel=integerLevel(s.tvcLevel,3,0)
    -- User-specified directions: ESC/TC increase with their level; TVC decreases.
    -- Zero is not an off command. Positive floors are engineering assumptions.
    local escStrength=0.20+0.80*escLevel/4
    local tcStrength=0.25+0.75*tcLevel/8
    local tvcStrength=1.0-0.70*tvcLevel/3
    if s.disableStability then escStrength=0; tvcStrength=0 end
    local vx=number(s.vx); local vy=number(s.vy); local yaw=number(s.yaw)
    local delta=clamp(number(s.delta),-0.60,0.60)
    local gas=clamp(number(s.gas),0,1); local brake=clamp(number(s.brake),0,1)
    local forward=vx>=-0.3 and s.reverse~=true
    local speed=abs(vx)
    local soc=clamp(number(s.soc,self.soc),0,1)
    local out={driveTorque=four(0),regenTorque=four(0),frictionTorque=four(0),
      tcFactors=four(1),absFactors=four(1),slipRatios=four(0),escBrakeTorque=four(0),
      escLevel=escLevel,tcLevel=tcLevel,tvcLevel=tvcLevel,
      escStrength=escStrength,tcStrength=tcStrength,tvcStrength=tvcStrength,
      escYawRequested=0,tvcYawRequested=0,
      yawReference=0,yawRequested=0,yawAchieved=0,gasCommand=0,
      regenPowerW=0,drivePowerW=0,soc=self.soc,mode=mode.name}
    local omega,loads,vel,driveCaps,regenCaps={},{},{},{},{}
    local frontMass=(c.mass-c.hubMass[1]-c.hubMass[2]-c.hubMass[3]-c.hubMass[4])*c.cgFrontSprung
    local loadDefault={frontMass/2+c.hubMass[1],frontMass/2+c.hubMass[2],
      (c.mass-frontMass-c.hubMass[1]-c.hubMass[2])/2,
      (c.mass-frontMass-c.hubMass[1]-c.hubMass[2])/2}
    for i=1,4 do
      omega[i]=number(s.wheelsOmega and s.wheelsOmega[i])
      vel[i]=number(s.wheelLongSpeed and s.wheelLongSpeed[i],vx)
      loads[i]=max(0,number(s.wheelLoads and s.wheelLoads[i],loadDefault[i]*9.80665))
      local slip=(omega[i]*c.radii[i]-vel[i])/max(abs(vel[i]),2.0)
      out.slipRatios[i]=slip
      if forward and gas>0.01 and loads[i]>100 and slip>mode.slipTarget then
        self.tc[i]=max(0,self.tc[i]-c.tcReduceRate*tcStrength*(slip-mode.slipTarget)*dt)
      elseif slip<mode.slipTarget-0.015 or gas<0.01 then
        self.tc[i]=min(1,self.tc[i]+c.tcRecoverRate*dt)
      end
      local brakingSlip=forward and -slip or slip
      if brake>0.001 or gas<0.02 or self.brakingActive[i] then
        if brakingSlip>0.12 then
          self.antiLock[i]=max(0,self.antiLock[i]-c.absReduceRate*(brakingSlip-0.12)*dt)
        elseif brakingSlip<0.09 then
          self.antiLock[i]=min(1,self.antiLock[i]+c.absRecoverRate*dt)
        end
      else self.antiLock[i]=min(1,self.antiLock[i]+c.absRecoverRate*dt) end
      if speed<0.3 then self.antiLock[i]=1 end
      out.tcFactors[i]=self.tc[i]; out.absFactors[i]=self.antiLock[i]
      local motor=c.motors[i<=2 and 1 or i-1]
      local divisor=i<=2 and 2 or 1
      local motorRPM=abs(omega[i])*motor.gear*60/(2*pi)
      local revFactor=clamp((motor.maxRPM-motorRPM)/(0.05*motor.maxRPM),0,1)
      local wheelNm=min(motor.torqueNm*motor.gear*c.mechanicalEfficiency/divisor,
        motor.powerW*c.mechanicalEfficiency/divisor/max(abs(omega[i]),0.5))*revFactor
      local fy=number(s.wheelFy and s.wheelFy[i])
      local muF=mode.muEstimate*loads[i]
      local longitudinal=max(0,sqrt(max(0,muF*muF-fy*fy)))
      driveCaps[i]=min(wheelNm/c.radii[i],longitudinal)*self.tc[i]
      regenCaps[i]=min(motor.regenTorqueNm*motor.gear*c.mechanicalEfficiency/divisor/c.radii[i],
        longitudinal)*self.antiLock[i]
      if loads[i]<100 then driveCaps[i]=0; regenCaps[i]=0 end
    end
    local desiredGas=(forward and brake<0.01) and gas^mode.gasExponent or 0
    self.gas=approach(self.gas,desiredGas,desiredGas>self.gas and mode.gasRise or 20,dt)
    if brake>=0.01 then self.gas=0 end
    out.gasCommand=self.gas
    self.powerScale=approach(self.powerScale,mode.powerScale,1.0,dt)
    out.powerScale=self.powerScale
    local budget=max(0,number(s.engineTorqueBudget))*c.virtualGear/c.referenceRadius*self.gas*self.powerScale
    budget=budget*clamp((soc-c.socDriveMinimum)/(c.socDriveFull-c.socDriveMinimum),0,1)
    if not forward or speed>100 then budget=0 end -- preserves 360 km/h cut
    local frontSlip=(max(0,out.slipRatios[1])+max(0,out.slipRatios[2]))*0.5
    local rearSlip=(max(0,out.slipRatios[3])+max(0,out.slipRatios[4]))*0.5
    local frontShare=clamp(0.22+0.15*(rearSlip-frontSlip),0.18,0.35)
    local frontF=budget*frontShare
    -- One front motor: equal wheel torques, shared power budget, no independent front TV.
    local frontNm=min(frontF*0.5*c.radii[1],driveCaps[1]*c.radii[1],driveCaps[2]*c.radii[2])
    local fx={frontNm/c.radii[1],frontNm/c.radii[2],budget*(1-frontShare)*0.5,budget*(1-frontShare)*0.5}
    local gate=forward and clamp((speed-3)/5,0,1) or 0
    local yawRef=vx*tan(delta)/(c.wheelbase+c.yawUndersteer*vx*vx)
    local yawCeiling=0.85*mode.muEstimate*9.80665/max(speed,3)
    yawRef=clamp(yawRef,-yawCeiling,yawCeiling)*gate
    self.yawReference=self.yawReference+(yawRef-self.yawReference)*(1-exp(-dt/0.08))
    local beta=atan2(vy,max(vx,1))
    local betaError=sign(beta)*max(0,abs(beta)-mode.betaLimit)
    local wantedMoment=(c.yawGain*(self.yawReference-yaw)+c.betaGain*betaError)*gate
    if s.disableStability then wantedMoment=0; self.yawMoment=0 end
    wantedMoment=clamp(wantedMoment,-mode.yawLimit,mode.yawLimit)
    self.yawMoment=approach(self.yawMoment,wantedMoment,c.yawSlewNmPerS,dt)
    -- TVC only redistributes positive rear drive. Its integer level is independent
    -- of ESC braking and TC slip reduction; the legacy disable flag gates both yaw channels.
    local tvcMoment=self.yawMoment*tvcStrength
    out.tvcYawRequested=tvcMoment
    fx[3]=clamp(fx[3]-tvcMoment/c.trackRear,0,driveCaps[3])
    fx[4]=clamp(fx[4]+tvcMoment/c.trackRear,0,driveCaps[4])
    -- Never create longitudinal drive budget while redistributing TV.
    local forceSum=fx[1]+fx[2]+fx[3]+fx[4]
    if forceSum>budget and forceSum>0 then
      local factor=budget/forceSum; for i=1,4 do fx[i]=fx[i]*factor end
    end
    local drivePower=0
    for i=1,4 do drivePower=drivePower+fx[i]*c.radii[i]*max(0,omega[i]) end
    local batteryCap=c.batteryDischarge20W+(c.batteryDischargePeakW-c.batteryDischarge20W)*clamp((soc-0.2)/(c.batteryFullPowerSOC-0.2),0,1)
    batteryCap=batteryCap*clamp(soc/0.2,0,1)
    local grossCap=min((c.motors[1].powerW+c.motors[2].powerW+c.motors[3].powerW)*c.mechanicalEfficiency,batteryCap*c.dischargeEfficiency)
    if drivePower>grossCap then
      local factor=grossCap/drivePower; for i=1,4 do fx[i]=fx[i]*factor end
    end
    local coast=(gas<0.02 and brake<0.01 and forward) and mode.coastG*9.80665*c.mass or 0
    local brakeDemand=max(brake*mode.maxBrakeG*9.80665*c.mass,coast)
    local regenDemand=forward and min(brakeDemand,c.regenMaxDecelG*9.80665*c.mass)*clamp(speed/4,0,1) or 0
    local headroom=clamp((1-soc)/0.05,0,1)
    local regenF={}; local wantedBrake={}
    for i=1,4 do
      wantedBrake[i]=brakeDemand*(i<=2 and c.brakeFrontShare or 1-c.brakeFrontShare)*0.5
      regenF[i]=min(wantedBrake[i]*self.antiLock[i],regenCaps[i],regenDemand*(i<=2 and c.brakeFrontShare or 1-c.brakeFrontShare)*0.5)*headroom
    end
    local frontRegenNm=min(regenF[1]*c.radii[1],regenF[2]*c.radii[2])
    regenF[1]=frontRegenNm/c.radii[1]; regenF[2]=frontRegenNm/c.radii[2]
    local regenPower=0
    for i=1,4 do regenPower=regenPower+regenF[i]*c.radii[i]*abs(omega[i]) end
    local chargeCap=min(c.regenMechanicalPowerW,max(0,number(s.chargeAcceptanceW,c.regenMechanicalPowerW)))
    if regenPower>chargeCap and regenPower>0 then
      local factor=chargeCap/regenPower; for i=1,4 do regenF[i]=regenF[i]*factor end
    end
    local frictionF={}; local actualMoment=c.trackRear*0.5*(fx[4]-fx[3])
    local remaining=self.yawMoment-actualMoment
    local escWheel=remaining>0 and 1 or 2
    -- ESC supplies a selective-brake correction independently of TVC. Scaling
    -- the residual retains the original allocation at ESC4/TVC0.
    -- ESC0 retains a small correction; pedal/coast braking and ABS remain independent.
    out.escYawRequested=remaining*escStrength
    local extraBrake=min(2*abs(remaining)/c.trackFront,c.mass*9.80665*0.12)*gate*escStrength
    for i=1,4 do
      local frictionMax=c.frictionMaxTorquePerSide*(i<=2 and c.brakeFrontShare or 1-c.brakeFrontShare)/c.radii[i]
      -- Recovery brakes always give friction priority for any unmet pedal demand.
      frictionF[i]=min(max(0,wantedBrake[i]*self.antiLock[i]-regenF[i]),frictionMax*self.antiLock[i])
      if i==escWheel then
        local withoutESC=frictionF[i]
        frictionF[i]=min(frictionMax,frictionF[i]+extraBrake*self.antiLock[i])
        out.escBrakeTorque[i]=max(0,frictionF[i]-withoutESC)*c.radii[i]
      end
      if loads[i]<100 then frictionF[i]=0; out.escBrakeTorque[i]=0 end
      out.driveTorque[i]=fx[i]*c.radii[i]
      out.regenTorque[i]=regenF[i]*c.radii[i]
      out.frictionTorque[i]=frictionF[i]*c.radii[i]
      self.brakingActive[i]=out.regenTorque[i]+out.frictionTorque[i]>1
      out.drivePowerW=out.drivePowerW+out.driveTorque[i]*max(0,omega[i])
      out.regenPowerW=out.regenPowerW+out.regenTorque[i]*abs(omega[i])
    end
    out.yawAchieved=c.trackFront*0.5*((fx[2]-regenF[2]-frictionF[2])-(fx[1]-regenF[1]-frictionF[1]))
      +c.trackRear*0.5*((fx[4]-regenF[4]-frictionF[4])-(fx[3]-regenF[3]-frictionF[3]))
    out.yawReference=self.yawReference; out.yawRequested=self.yawMoment
    self.soc=clamp(soc+(out.regenPowerW*c.chargeEfficiency-out.drivePowerW/c.dischargeEfficiency)*dt/(c.batteryKWh*3600000),0,1)
    out.soc=self.soc
    return out
  end
  return self
end
return M
