-- SU7 Ultra experimental controller settings. SI units; assumptions are not OEM maps.
return {
  mass=2435, wheelbase=3.0, cgFrontSprung=0.49,
  hubMass={59,59,75,75}, trackFront=1.672, trackRear=1.649,
  radii={0.355,0.355,0.352,0.352}, steerRatio=12.2,
  virtualGear=9.205, referenceRadius=0.352,
  -- Front gear is inferred for the envelope, not an identified production ratio.
  motors={
    {powerW=288000, torqueNm=500, maxRPM=21000, gear=8.0, regenTorqueNm=300},
    {powerW=425000, torqueNm=635, maxRPM=27200, gear=9.205, regenTorqueNm=400},
    {powerW=425000, torqueNm=635, maxRPM=27200, gear=9.205, regenTorqueNm=400}
  },
  mechanicalEfficiency=0.94, dischargeEfficiency=0.94, chargeEfficiency=0.90,
  batteryKWh=93.7, initialSOC=0.80,
  -- Conservative SOC envelope: 20%/800kW and peak1330kW are public capability
  -- statements; using them as caps and full power at50% is a modeling assumption.
  batteryDischargePeakW=1330000, batteryDischarge20W=800000, batteryFullPowerSOC=0.50,
  socDriveMinimum=0.02, socDriveFull=0.07,
  -- Conservative simulation setting; official statement says OVER 400 kW.
  regenMechanicalPowerW=400000, regenMaxDecelG=0.6,
  brakeFrontShare=0.64, frictionMaxTorquePerSide=4650,
  yawUndersteer=0.0015, yawGain=18000, betaGain=40000,
  yawSlewNmPerS=18000, tcReduceRate=24, tcRecoverRate=1.5,
  absReduceRate=38, absRecoverRate=4.0,
  modes={
    {name='street',powerScale=0.82,gasExponent=1.8,gasRise=1.2,slipTarget=0.08,
      muEstimate=1.15,yawLimit=2500,betaLimit=0.040,maxBrakeG=1.2,coastG=0.04},
    {name='sport',powerScale=0.94,gasExponent=1.3,gasRise=2.5,slipTarget=0.11,
      muEstimate=1.30,yawLimit=2000,betaLimit=0.055,maxBrakeG=1.2,coastG=0.08},
    {name='track',powerScale=1.0,gasExponent=1.0,gasRise=5.0,slipTarget=0.15,
      muEstimate=1.40,yawLimit=1200,betaLimit=0.080,maxBrakeG=1.2,coastG=0.12}
  }
}
