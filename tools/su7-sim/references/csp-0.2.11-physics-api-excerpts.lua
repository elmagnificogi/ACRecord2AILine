-- Official CSP 0.2.11 generated physics SDK excerpts.
-- Original line numbers refer to csp-0.2.11-ac_car_cphys-lib.lua.
-- Source archive: https://acstuff.club/patch/?get=0.2.11
-- Definitions are documentation stubs; do NOT require this file as runtime code.

-- ORIGINAL LINES 146-167
---Wheel index (from 0 to 3) or a special value for wheel mask.
---@alias ac.Wheel
---| `ac.Wheel.FrontLeft` @Value: 0.
---| `ac.Wheel.FrontRight` @Value: 1.
---| `ac.Wheel.RearLeft` @Value: 2.
---| `ac.Wheel.RearRight` @Value: 3.
---| `ac.Wheel.Front` @Value: 12.
---| `ac.Wheel.Rear` @Value: 48.
---| `ac.Wheel.Left` @Value: 20.
---| `ac.Wheel.Right` @Value: 40.
---| `ac.Wheel.All` @Value: 60.
ac.Wheel = {
  FrontLeft = 0, ---@type ac.Wheel #Value: 0.
  FrontRight = 1, ---@type ac.Wheel #Value: 1.
  RearLeft = 2, ---@type ac.Wheel #Value: 2.
  RearRight = 3, ---@type ac.Wheel #Value: 3.
  Front = 12, ---@type ac.Wheel #Value: 12.
  Rear = 48, ---@type ac.Wheel #Value: 48.
  Left = 20, ---@type ac.Wheel #Value: 20.
  Right = 40, ---@type ac.Wheel #Value: 40.
  All = 60, ---@type ac.Wheel #Value: 60.
}

-- ORIGINAL LINES 3771-3830
---@return number
function physics.getExtendedDamperTravel(carIndex, corner) end
---@class ac.StateWheel : ClassBase
---@field tyreRadius number @Tyre radius in meters.
---@field tyreWidth number @Tyre width in meters.
---@field rimRadius number @Rim radius in meters (older cars might not have it).
---@field tyreDirty number @Dirt levels for tyres, four values, from 0 to 1.
---@field tyreWear number @Tyre wear, from 0 to 1.
---@field tyreVirtualKM number @Driven distance for each tyre in km (resets when tyres change, not an actual distance, rate of change depends on wear multiplier).
---@field tyreGrain number
---@field tyreBlister number
---@field tyreFlatSpot number
---@field tyreStaticPressure number @Static tyre pressure.
---@field tyrePressure number @Dynamic tyre pressure.
---@field temperatureMultiplier number
---@field tyreCoreTemperature number @Core tyre temperature, in °C.
---@field tyreInsideTemperature number @Inside tyre temperature, in °C.
---@field tyreMiddleTemperature number @Middle tyre temperature, in °C.
---@field tyreOutsideTemperature number @Outside tyre temperature, in °C.
---@field tyreOptimumTemperature number @Optimum tyre temperature, in °C.
---@field brakeTemperature number @Brakes temperature, in °C, or 0 if it’s not available (for most cars).
---@field discTemperature number
---@field angularSpeed number
---@field slip number
---@field slipAngle number @Angle between the desired direction and the actual direction of the vehicle, in degrees.
---@field slipRatio number
---@field ndSlip number
---@field load number @Tyre load in N (warning: does not have correct values for remote cars online or in replays, use `.loadK` if you want a rough but stable estimation instead)
---@field loadK number
---@field speedDifference number @Difference in speed between tyre and ground surface in contact point.
---@field camber number @Camber angle in degrees.
---@field toeIn number @Toe angle in degrees.
---@field suspensionDamage number
---@field suspensionTravel number
---@field tyreLoadedRadius number
---@field waterThickness number @Water thickness in meters.
---@field dx number
---@field dy number
---@field mz number @Self aligning torque.
---@field fx number
---@field fy number
---@field contactNormal vec3 @Normal of a contact point surface.
---@field contactPoint vec3 @Contact point position in world coordinates.
---@field position vec3 @Wheel position in world coordinates.
---@field look vec3 @Wheel (SUSP_…) heading vector.
---@field up vec3 @Wheel (SUSP_…) vector directed updwards.
---@field outside vec3 @Points outside of car (to the left of tyre for left tyres, to the right for right).
---@field velocity vec3
---@field transform mat4x4 @Wheel (SUSP_…) transformation.
---@field transformWheel mat4x4 @Wheel (WHEEL_…) transformation.
---@field surfaceDirt number @Dirt additive coefficient of the surface below the wheel.
---@field surfaceSectorID integer @Sector ID of the surface below the wheel.
---@field surfaceSectionIndex integer @Index of section in “surfaces.ini” corresponding with surface the wheel is on, or -1 if it’s not available
---@field surfaceGrip number @Grip of the surface below the wheel.
---@field surfaceDamping number @Damping of the surface below the wheel.
---@field surfaceGranularity number @Damping of the surface below the wheel.
---@field surfaceVibrationGain number @Vibration gain of the surface below the wheel.
---@field surfaceVibrationLength number @Vibration length of the surface below the wheel.
---@field surfacePitlane boolean @If surface below the wheel is in pitlane.
---@field surfaceValidTrack boolean @If surface below the wheel is valid track.

-- ORIGINAL LINES 3880-3910
---@field hasAnalogTelltale boolean @Car has max RPM arrow.
---@field tractionControlModes integer @0 if TC is not present. Physics-only (see `ac.CarState.physicsAvailable`)
---@field absModes integer @0 if ABS is not present. Physics-only (see `ac.CarState.physicsAvailable`)
---@field fuelMaps integer
---@field tractionControl2Modes integer
---@field hasEngineBrakeSettings boolean
---@field pitTransform mat4x4 @Transformation of pit position.
---@field timestamp number @Time of last physics state record, in milliseconds (counting from the same point as ac.SimState.time)
---@field transform mat4x4 @Car physics transformation in world space (does not match body transformation! for it, use `bodyTransform`)
---@field bodyTransform mat4x4 @Car visual transformation (the one applied to 3D model).
---@field worldToLocal mat4x4 @Inverse of car visual transformation.
---@field position vec3 @Car position in the world (corresponds to 0 coordinate in its model space).
---@field velocity vec3 @Car velocity in m/s.
---@field acceleration vec3 @G-forces, X for sideways relative to car, Z for forwards/backwards.
---@field angularVelocity vec3
---@field localAngularVelocity vec3
---@field localVelocity vec3
---@field up vec3 @Vector facing upwards (normalized).
---@field look vec3 @Vector facing forward (normalized).
---@field side vec3 @Vector facing sideways (normalized).
---@field driverEyesPosition vec3 @In-car coordinates for driver eyes position (can be changed by user).
---@field groundNormal vec3 @Normal of ground below car.
---@field groundDistance number @Distance of ground below car (defines ground plane together with normal).
---@field gas number @Throttle, from 0 to 1.
---@field brake number @Brake, from 0 to 1.
---@field clutch number @Clutch, from 0 to 1 (1 for pedal fully depressed).
---@field steer number @Angle of steering wheel in degrees.
---@field handbrake number @Handbrake, from 0 to 1.
---@field gear integer @Current gear, 0 for neutral, -1 for reverse. Does not go through 0 on sequential shifts
---@field engagedGear integer @Current gear, 0 for neutral, -1 for reverse. Goes through 0 on sequential shifts
---@field fuel number @Remaining fuel in liters.

-- ORIGINAL LINES 4117-4170
---@field durationMinutes number
---@field isTimedRace boolean
---@field hasAdditionalLap boolean
---@field startTime number @Starting time in milliseconds (compares with `ac.SimState.time`)
---@field overtimeMs number
---@field forcedPosition integer
---@field leaderCompletedLaps integer
---@field isOver boolean
---@field leaderboard ac.StateLeaderboardEntry[] @Items start with 0. To get number of elements, use `#state.leaderboard`.

---@class ac.StateWheelPhysics : ClassBase
---@field brakeTorque number
---@field handbrakeTorque number
---@field electricTorque number
---@field feedbackTorque number
---@field angularInertia number
---@field shaftVelocity number
---@field shaftInertia number
---@field tyreCarcassTemperature number @Only available with custom physics tyres.
---@field roadTemperature number @Can vary from AC road temperature in shadows if option is enabled.
---@field discCoreTemperature number @Can vary from AC road temperature in shadows if option is enabled.

---@class ac.StateWingPhysics : ClassBase
---@field cd number @Drag coefficient (wing area is already taken into account here).
---@field cl number @Lift coefficient, negative for downforce (wing area is already taken into account here).
---@field aoa number @Angle of attack.
---@field angle number
---@field yawAngle number
---@field groundHeight number

---@class ac.StateCarPhysics : ClassBase
---@field isAvailable boolean
---@field gearRatio number
---@field finalRatio number
---@field airDensity number @Air density affected by slip stream.
---@field awd2MaxTorque number
---@field awd2CurrentLockTorque number
---@field awd2Ramp number
---@field engineInertia number
---@field drivetrainInertia number
---@field drivetrainVelocity number
---@field clutchInertia number
---@field clutchState number
---@field wheels ac.StateWheelPhysics[] @4 items, starts with 0.
---@field scriptControllerInputs number[] @256 items, starts with 0.
---@field gearRatios number[] @Items start with 0. To get number of elements, use `#state.gearRatios`.
---@field wings ac.StateWingPhysics[] @Items start with 0. To get number of elements, use `#state.wings`.

---@class ac.StateSim : ClassBase
---@field windowWidth integer @Width of AC window in pixels (set in AC video settings). Might not be the same as UI screen size if scaling is used.
---@field windowHeight integer @Height of AC window in pixels (set in AC video settings). Might not be the same as UI screen size if scaling is used.
---@field msaaSamples integer @1 for MSAA disabled, 2 for MSAA 2x, 4 for 4x, 8 for 8x.
---@field worldDetailLevel integer @0 for very low, 5 for very high. Set in AC video settings
---@field windowSize vec2 @Size of AC window (not affected by UI scale).

-- ORIGINAL LINES 8431-8490
---@alias ac.CarPhysicsValueID
---| `ac.CarPhysicsValueID.ERSRecovery` @-Value from 0 to 1.
---| `ac.CarPhysicsValueID.ERSHeatCharging` @-`true` or `false`.
---| `ac.CarPhysicsValueID.AWD2MaxTorque` @-Won’t work if there is an AWD2 controller present.
---| `ac.CarPhysicsValueID.ForcelessTyres` @-`true` or `false`. If forceless, tyre is pretty much non-existent, but rim-ground collisions can still occur. Uses `tyres` param.
ac.CarPhysicsValueID = {
  ERSRecovery = 0, ---@type ac.CarPhysicsValueID #-Value from 0 to 1.
  ERSHeatCharging = 1, ---@type ac.CarPhysicsValueID #-`true` or `false`.
  AWD2MaxTorque = 2, ---@type ac.CarPhysicsValueID #-Won’t work if there is an AWD2 controller present.
  ForcelessTyres = 10001, ---@type ac.CarPhysicsValueID #-`true` or `false`. If forceless, tyre is pretty much non-existent, but rim-ground collisions can still occur. Uses `tyres` param.
}

---For any physics calculations avoid using structures provided by `ac.getCar()` and such: those update with graphics thread, so
--- not often enough, plus if graphics thread would experience a freeze that data might get very out of date.
---@return ac.StateCphysCar
function ac.accessCarPhysics() end

---Access damper data (for both reading and writing). Note: if you’re overwriting a certain value, make sure it’s not accessible
---via setup menu.
---@param index integer @0-based wheel index.
---@return ac.StateCphysDamper
function ac.accessCarDamper(index) end

---Access wheel surface data (for both reading and writing). Note: if you’re overwriting a certain value, make sure it’s not accessible
---via setup menu.
---@param index integer @0-based wheel index.
---@return ac.StateCphysSurface
function ac.getCarWheelSurface(index) end

---Adds force to a car body.
---@param position vec3 @Point of force application.
---@param posLocal boolean|`true`|`false` @If `true`, position is treated like position relative to car coordinates, otherwise as world position.
---@param force vec3 @Force vector in N.
---@param forceLocal boolean|`true`|`false` @If `true`, force is treated like vector relative to car coordinates, otherwise as world vector.
function ac.addForce(position, posLocal, force, forceLocal) end

---Adds force to a car wheel.
---@param tyres ac.Wheel @0-based wheel index.
---@param position vec3 @Point of force application.
---@param force vec3 @Force vector in N.
function ac.addHubForce(tyres, position, force) end

---Adds force to a car wheel (version with working feedback and steer torque).
---@param tyres ac.Wheel @0-based wheel index.
---@param position vec3 @Point of force application.
---@param force vec3 @Force vector in N.
---@param addFeedbackTorque boolean? @Set to `true` to add torque as feedback torque to the engine (does not have any effect with non-driven wheels). Default value: `false`.
---@param addSteerTorque number? @Set a non-zero value (a multiplier) if force should translate to FFB as well (does not have any effect with non-steering wheels). Default value: 0.
function ac.addHubForce2(tyres, position, force, addFeedbackTorque, addSteerTorque) end

---Adds torque to a car or hub body.
---@param torque vec3 @Torque vector in N×m.
---@param torqueLocal boolean|`true`|`false` @If `true`, torque is treated like vector relative to body coordinates, otherwise as world vector.
---@param hubIndex integer? @If set to a value from 0 to 3, adds torque to a hub body instead of car body. Added in 0.2.8. Default value: -1.
function ac.addTorque(torque, torqueLocal, hubIndex) end

---Updates position of a certain box collider.
---@param index integer
---@param offset vec3
---@return boolean @Returns `false` if there is no such collider.

-- ORIGINAL LINES 8506-8526

---Changes final gear ratio, can be overriden by setup if available.
---@param finalRatio number
function ac.setGearsFinalRatio(finalRatio) end

---Changes differential coast value, can be overriden by setup if available.
---@param coast number
function ac.setDifferentialCoast(coast) end

---Changes differential power value, can be overriden by setup if available.
---@param power number
function ac.setDifferentialPower(power) end

---Changes differential power value, can be overriden by setup if available.
---@param value number
function ac.setDifferentialPreload(value) end

---Changes AWD center differential power value.
---@param value number
function ac.setAWDCenterDifferentialPreload(value) end


-- ORIGINAL LINES 8545-8550
---Overrides gas pedal value passed to engine. Unlike changing `.gas` property of car data, this one doesn’t show up in instruments, UI widgets and such.
---@param value number @Pass `math.huge` to disable override.
function ac.overrideGasInput(value) end

---Deactivates engine limiter. Use `ac.overrideGasInput()` to implement custom logic.
---@param disable boolean? @Default value: `true`.

-- ORIGINAL LINES 8696-8740
---@param id ac.CarPhysicsValueID
---@param value number|boolean
---@param tyres ac.Wheel? @Used by per-wheel values, 0-based wheel index. Default value: `ac.Wheel.All`.
function ac.overrideSpecificValue(id, value, tyres) end

---Overrides turbo BOV value used for audio. Doesn’t affect physics.
---@param value number? @Pass `nil` (or `math.huge`) to disable override. Default value: `nil`.
function ac.overrideTurboBlowOffValve(value) end

---Overrides engine torque (as in, replaces whole torque curve with a single data point for the entire RPM range). Make sure to
--- call each frame if you want torque to depend on RPM and such.
---@param newTorque number @Pass not-a-number to revert to original curve.
function ac.overrideEngineTorque(newTorque) end

---Set extra torque added to engine. Gets added after all the other logic, including turbos and such.
---@param torque number
function ac.setExtraTorque(torque) end

---@param tyres ac.Wheel @0-based wheel index.
---@param torque number
---@param overrideExisting boolean? @Pass `true` to remove original torque (from components such as ERS). Default value: `false`.
function ac.addElectricTorque(tyres, torque, overrideExisting) end

---Overrides brakes. Once called, original braking system will be disabled for entirely of the race, so make sure to keep using
---this function and set torque for all four wheels. Disc temperature is optional, but if set it will be used by visual part (eventually).
---Key difference betweeen braking and handbrake is that handbrake is not affected by ABS (also keep in mind original AC only applies
---handbrake to rear wheels).
---
---If a new braking system from extended physics is enabled, this call will have no effect. Make sure to use inputs from `ac.accessCarPhysics()`
---and not from `car` to operate at physics rate.
---@param tyres ac.Wheel @0-based wheel index.
---@param torque number @Value in Nm. Pass not-a-number to revert to original behaviour (for CSP v0.2.3-preview20 or newer).
---@param handbrakeTorque number
---@param discTemperature number? @Does not affect physics. Default value: 0.
function ac.overrideBrakesTorque(tyres, torque, handbrakeTorque, discTemperature) end

---Overrides ABS. Once called, original ABS system will be disabled (pass `nil` or call without arguments to restore original behavior).
---Expected values are within 0…1 range and act as multipliers for braking intensity. ABS only affects brakes and not handbrake.
---@param wheelLf number? @Default value: `nil`.
---@param wheelRf number? @Default value: `nil`.
---@param wheelLr number? @Default value: `nil`.
---@param wheelRr number? @Default value: `nil`.
function ac.overrideABS(wheelLf, wheelRf, wheelLr, wheelRr) end

---@param sleepMs integer

-- ORIGINAL LINES 9043-9142
function physics.raycastTrack(pos, dir, length, point, normal) end
---@class ac.StateCphysWheel : ClassBase
---@field angularSpeed number
---@field coreTemperature number
---@field insideTemperature number
---@field middleTemperature number
---@field outsideTemperature number
---@field slip number
---@field slipAngle number @Slip angle in radians.
---@field slipRatio number
---@field ndSlip number
---@field load number
---@field depth number
---@field abs number @ABS intensity. `1 - wheel.abs` is a multiplier for braking intensity.
---@field dx number
---@field dy number
---@field fx number @Force along car tyre.
---@field fy number @Force across car tyre.
---@field mz number @Self-align torque.
---@field inflation number @For changing use `ac.setTyreInflation(tyreIndex, pressure)`
---@field suspensionTravel number
---@field damperSpeed number
---@field surfaceExtendedType ac.SurfaceExtendedType
---@field transform mat4x4
---@field side vec3 @Redirects to a corresponding value from `transform`
---@field up vec3 @Redirects to a corresponding value from `transform`
---@field look vec3 @Redirects to a corresponding value from `transform`
---@field position vec3 @Redirects to a corresponding value from `transform`
---@field velocity vec3
---@field contactPoint vec3
---@field contactNormal vec3
---@field finalForceMult vec2
---@field finalForceOffset vec2
---@field test_FinalForceMult vec2 @Alias for `finalForceMult`

---@class ac.StateCphysCar : ClassBase
---@field inputMethod ac.InputMethod
---@field transform mat4x4
---@field side vec3 @Redirects to a corresponding value from `transform`
---@field up vec3 @Redirects to a corresponding value from `transform`
---@field look vec3 @Redirects to a corresponding value from `transform`
---@field position vec3 @Redirects to a corresponding value from `transform`
---@field gForces vec3
---@field localAngularVelocity vec3
---@field localVelocity vec3 @Car velocity relative to car.
---@field damageLevel number[] @4 items, starts with 0.
---@field speedKmh number
---@field ffb number @For changing use `ac.setSteeringFFB()`
---@field rpm number @For changing use `ac.setEngineRPM()`
---@field rpmLimit number @For changing use `ac.setEngineRPMLimit()`
---@field engineLifeLeft number @For changing use `ac.setEngineLifeLeft()`
---@field drivetrainDamageRPMWindow number @For changing use `ac.setDrivetrainDamageRPMWindow()`
---@field drivetrainOriginalRPMWindow number
---@field drivetrainRootVelocity number
---@field drivetrainDriveVelocity number
---@field fuelConsumption number
---@field antirollBarFront number
---@field antirollBarRear number
---@field gearsFinalRatio number
---@field engineTorque number
---@field waterTemperature number
---@field ambientTemperature number @Value in C°.
---@field airDensity number @Value in kg/m³.
---@field engineAirConditionMultiplier number @“Engine Air Condition Mult.” value, 1 for 100%
---@field absMode integer
---@field tractionControlMode integer
---@field gear integer @0 for rear, 1 for neutral, 2 for first gear, etc.
---@field limiterInAction boolean
---@field tractionControlInAction boolean
---@field areControlsLocked boolean
---@field isEngineStallEnabled boolean @For changing use `ac.setEngineStalling()`
---@field isBlackFlagged boolean
---@field enforceCustomInputScheme boolean @If set to `true`, use custom input scheme even if input method is not wheel (if not possible, disable input entirely).
---@field isGearGrinding boolean @For changing use `ac.setGearsGrinding()`
---@field gas number @Can be changed (unless controls are locked or car has black flag).
---@field brake number @Can be changed (unless controls are locked or car has black flag).
---@field steer number @Can be changed (unless controls are locked or car has black flag).
---@field clutch number @Can be changed (unless controls are locked or car has black flag).
---@field handbrake number @Can be changed (unless controls are locked or car has black flag).
---@field requestedGearIndex integer @Can be changed (unless controls are locked or car has black flag).
---@field gearUp boolean @Can be changed (unless controls are locked or car has black flag).
---@field gearDown boolean @Can be changed (unless controls are locked or car has black flag).
---@field isShifterSupported boolean @Can be changed (unless controls are locked or car has black flag).
---@field wheels ac.StateCphysWheel[] @4 items, starts with 0.
---@field controllerInputs number[] @Set values here and access them as SCRIPT_0...SCRIPT_255 inputs in dynamic controllers. For emissives and such, can be accessed as CPHYS_SCRIPT_0..., other Lua scripts can access via car physics state. 256 items, starts with 0.

---Holds state of an AC damper available for both reading and writing.
---@class ac.StateCphysDamper
---@field reboundSlow number
---@field reboundFast number
---@field bumpSlow number
---@field bumpFast number
---@field fastThresholdBump number
---@field fastThresholdRebound number
local _ac_StateCphysDamper = nil

---Holds state of an AC track surface available for reading only.
---@class ac.StateCphysSurface
---@field grip number
---@field sectorID integer

-- ORIGINAL LINES 9156-9184
---Override a rendering thread value. Doesn’t affect actual physics (unless your physics script uses data from `ac.getCar()`, which might
---be a bad idea to begin with).
---@param key 'steer'|'gas'|'brake'|'clutch'|'handbrake'|'gear'|'rpm'|'limiter'|'limiterActive'|'turbo'|'drivetrain'|'fuel'|'bodyworkVolume'|'wheelAngularSpeed'|'wheelSlipAngle'|'wheelSlipRatio'|'wheelTyreSlip'|'wheelNDSlip'|'wheelLoad'|'wheelLoadedRadius'|'wheelLiveRadius'|'wheelFlexOffsetX'|'wheelFlexOffsetZ'|'wheelFlexTwist'
---@param value number|boolean @For `limiterActive`, pass boolean. Other types expect numbers. Pass `nil` to cancel out overriding.
---@param index ac.Wheel? @For `wheel…` values, this value specifies affected wheels.
function ac.overrideCarState(key, value, index) end

---Reference to information about state of associated car.
---@type ac.StateCar
car = nil

---Reference to information about state of simulation.
---@type ac.StateSim
sim = nil

---Note: joypad assist script runs from physics thread, so update rate is much higher. Please keep it in mind and keep
---code as fast as possible.
---@class ScriptData
---@field update fun(dt: number) @Called each physics frame. Param `dt` is time since the last call of `.update()` in seconds. Usually would be around 0.003.
---@field reset fun() @Called when car resets or teleports, for example teleporting to pits, or when a new session starts.
---@single-instance
script = {}

--[[ common/ac_extras_binaryinput.lua ]]

---@param id string @Name of a section in “controls.ini”. If you are adding a new input, use something like “your.namespace/Nice Name” (without square brackets or colons) to ensure there won’t be collisions and it would integrate nicely.
---@param defaults {keyboard: nil|{key: ui.KeyIndex?, ctrl: boolean?, shift: boolean?, alt: boolean?}, gamepad: nil|ac.GamepadButton, period: nil|number, hold: nil|boolean}? @Default settings if user has not configured input yet. Parameter `period` can be used to create buttons which would keep reporting as pressed (or call `:onDown()`) while held, can be configured in “controls.ini” as “REPEAT_PERIOD”; by default repeating is disable. Set parameter `hold` to a boolean value and control widget will get a “hold” switch. Buttons configured in “hold” mode return `true` on `:pressed()` when both pressed and released, as well as trigger `:onPressed()` when released too. Note: if `ac.ControlButton()` is called multiple times within a race session, only defaults from the first run will be taken into account (but if subsequent calls will have a “hold” value, button editing widget will still get a “hold” switch).
---@return ac.ControlButton
function ac.ControlButton(id, defaults) end
