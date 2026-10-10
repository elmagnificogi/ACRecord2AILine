With 0.1.77 update it is now possible to use a Lua script to extend car physics. Simply create a “script.lua” in car data folder and it’ll work if extended physics is enabled. And if data is unpacked, it would reload live if script has been edited.

### Available functions

- Basic:
  - Access current car state;
  - Access frequently updating detailed car physics state;
  - Modify car state:
    - Gear grinding flag;
    - Car damage;
    - Engine damage;
    - Gearbox damage;
    - Engine RPM;
    - If stalling is enabled or not;
    - Tyres inflation (set to 0 to blow them up);
  - Modify user controls;
  - Use up to 8 values accessible by dynamic physics controllers and car instrument inputs (for example, a complex logic can be tied to a differential this way);
  - Add extra forces to car body.
- Added in 0.1.78:
  - Move car box colliders;
  - Set aero wings gain.

More functions will be added soon.

### A few short examples

- Use Extra A switch to toggle between engine power LUTs:

  ```lua
  local carPh = ac.accessCarPhysics()
  local powerBase = ac.DataLUT11.carData(car.index, 'power.lut')
  local powerAlt = ac.DataLUT11.carData(car.index, 'power_alt.lut')

  function script.update(dt)
    local activeLUT = car.extraA and powerAlt or powerBase
    ac.overrideEngineTorque(activeLUT:get(carPh.rpm))
  end
  ```

- Exploding engine if engine water temperature exceeds 95 degrees:

  ```lua
  function script.update(dt)
    if car.waterTemperature > 95 then
      ac.accessCarPhysics().engineLifeLeft = 0
    end
  end
  ```

- Rearranging gears in a car with H-shifter so that first gear becomes reverse, for [a dog-leg gearbox](https://www.youtube.com/watch?v=rQf2MYU5QC0):

  ```lua  
  function script.update(dt)
    local data = ac.accessCarPhysics()
    if data.requestedGearIndex == 2 then
      -- If first gear is requested, change to reverse
      data.requestedGearIndex = 0
    elseif data.requestedGearIndex > 2 then
      -- If above frist gear is requested, bump it one down
      data.requestedGearIndex = data.requestedGearIndex - 1
    else
      -- Otherwise, set it to neutral
      data.requestedGearIndex = 1
    end
  end
  ```

- Kill engine for a second if g-forces get too extreme for more than a second:

  ```lua
  local counter = 0
  local stalledFor = 0

  function script.update(dt)
    local data = ac.accessCarPhysics()
    if math.abs(data.gForces.x) > 2 then
      counter = counter + dt
    else
      counter = 0
    end

    if counter > 2 then
      -- If g-force was above threshold for more than two seconds, activate stall for a second
      stalledFor = 1
    end

    if stalledFor > 0 then
      -- If stalled, lock gas pedal at 0
      stalledFor = stalledFor - dt
      data.gas = 0
    end
  end
  ```

- Jet engine activating with Extra A switch when car drives above 40 km/h (regular car script can add audio and particle effects, also `[EXTRA_SWITCHES] SWITCH_A_FLAGS = HOLD_MODE` in car config might help):

  ```lua
  function script.update(dt)
    local data = ac.accessCarPhysics()
    local jetActive = car.extraA and car.speedKmh > 40
    data.controllerInputs[0] = jetActive and 1 or 0
    if jetActive then
      ac.addForce(vec3(0, 0, -2), true, vec3(0, 0, 5000), true)
    end
  end
  ```

- Using custom script setup items 

  ```ini
  [CUSTOM_SCRIPT_ITEM_0]
  ID=SOME_ID_0
  SHOW_CLICKS=0
  TAB=SOME TAB
  NAME=Some Setup Item
  MIN=70
  MAX=95
  STEP=1
  DEFAULT=88
  POS_X=0.5
  POS_Y=1
  HELP=This does something
  ```

  ```lua
  ac.setScriptSetupValue(("CUSTOM_SCRIPT_ITEM_0", 72)

  function script.update(dt)
    ac.debug("Some Setup Item",ac.getScriptSetupValue("CUSTOM_SCRIPT_ITEM_0")()) -- Outputs 72
  end
  ```

- Forcing more air into the engine when turbo is spinning (requires 0.3.0-preview445 or newer for `carPh.turboBoost` to work, older builds, if necessary, can use a value from `car`):


  ```lua
  local carPh = ac.accessCarPhysics()

  function script.update()
    ac.overrideGasInput(carPh.turboBoost > 0 and math.lerp(carPh.gas, 1, math.min(1, carPh.turboBoost)) or math.huge)
  end
  ```

### Lua introduction

[Here](https://github.com/ac-custom-shaders-patch/acc-lua-sdk) is an introduction in Lua scripting. Some more examples can be found [here](https://github.com/ac-custom-shaders-patch/acc-lua-examples/tree/main/cars_physics).
