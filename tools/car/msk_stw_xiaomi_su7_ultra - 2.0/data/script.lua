function script.update(dt)
  local data = ac.accessCarPhysics()
  
  if car.speedKmh > 360 then
    data.gas = 0
  end      
end