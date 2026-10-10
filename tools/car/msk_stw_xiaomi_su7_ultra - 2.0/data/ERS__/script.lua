function script.update(dt)
  local carPh = ac.accessCarPhysics()
  local powerBase = ac.DataLUT11.carData(car.index, 'power.lut')
  local powerAlt = ac.DataLUT11.carData(car.index, 'power_alt.lut')
  local gearR = car.gear == -1
  local activeLUT = gearR and powerAlt or powerBase
  local data = ac.accessCarPhysics()
  local autoHoldON = data.gear == 1
  ac.overrideEngineTorque(activeLUT:get(carPh.rpm))  
  
  if autoHoldON then
    data.brake = data.brake
  end      
end