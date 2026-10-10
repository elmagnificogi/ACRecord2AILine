# Library ac_car_cphys

Documentation for ac_car_cphys. Please note: documentation generator is in development and needs more work, so some information might be missing and other bits might not be fully accurate.

# Module common/common.lua

## Class ac.GenericList
FFI-accelerated list, acts like a regular list (consequent items, size and capacity, automatically growing, etc.)
Doesn’t store nil values to act more like a Lua table.

Few notes:
• Use `:get()` and `:set()` to access elements instead of square brakets;
• Indices are 1-based;
• For fastest access to individual elements use `.raw` field: it’s a raw pointer, so use 0-based indices there and
make sure not to access things outside of list size.

For slightly better performance it might be benefitial to preallocate memory with `list:reserve(expectedSizeOrABitMore)`.

- `ac.GenericList:get(index)`

  Return an element at given index.

  Parameters:

    1. `index`: `integer` 1-based index.

  Returns:

    - `any`

- `ac.GenericList:set(index, value)`

  Sets an element at given index.

  Parameters:

    1. `index`: `integer` 1-based index.

    2. `value`: `any`

- `ac.GenericList:size()`

  Number of items in the list.

  Returns:

    - `integer`

- `ac.GenericList:sizeBytes()`

  Size of list in bytes (not capacity, for that use `list:capacityBytes()`).

  Returns:

    - `integer`

- `ac.GenericList:isEmpty()`

  Checks if list is empty.

  Returns:

    - `boolean`

- `ac.GenericList:capacity()`

  Capacity of the list.

  Returns:

    - `integer`

- `ac.GenericList:capacityBytes()`

  Size of list in bytes (capacity).

  Returns:

    - `integer`

- `ac.GenericList:reserve(newSize)`

  Makes sure list can fit `newSize` of elements without reallocating memory.

  Parameters:

    1. `newSize`: `integer`

  Returns:

    - `integer`

- `ac.GenericList:shrinkToFit()`

  If capacity is greater than current size, reallocates a smaller bit of memory and moves data there.
function _ac_genericList:shrinkToFit() end

- `ac.GenericList:clear()`

  Removes all elements.
function _ac_genericList:clear() end

- `ac.GenericList:clone()`

  Creates a new list with the same contents as the existing one.

  Returns:

    - `ac.GenericList`
## Class ffilibex
Custom FFI namespace. Be very careful around here.

- `ffilibex.cdef(def, params, ...)`

- `ffilibex.istype(ct, obj)`

  Parameters:

    1. `obj`: `any`

  Returns:

    - `boolean`

- `ffilibex.string(ptr, len)`

  Returns:

    - `string`

- `ffilibex.typeof(ct, params, ...)`

  Returns:

    - `ffi.ctype`

- `ffilibex.cast(ct, init)`

  Parameters:

    1. `init`: `any`

  Returns:

    - `ffi.cdata`

- `ffilibex.metatype(ct, metatable)`

  Parameters:

    1. `metatable`: `table`

  Returns:

    - `ffi.ctype`

- `ffilibex.gc(cdata, finalizer)`

  Returns:

    - `ffi.cdata`

- `ffilibex.copy(destination, data, size)`

  Parameters:

    1. `destination`: `any`

    2. `data`: `any|string`

    3. `size`: `integer?`
## Function worker.sleep(time)
Available only in background worker scripts. Sleep function pauses execution for a certain time. 
Before unpaused, any callbacks (such as `setTimeout()`, `setInterval()` and
other custom enqueued callbacks) will be called. This is the only way for those callbacks to fire in a background worker. Note:
if parent thread is closed, `worker.sleep()` won’t return back and instead script will be unloaded, this way worker can be reloaded
as well.

If your worker does a lot of async operations, consider using `worker.wait()` instead, setting resulting value with `worker.result`.
Or maybe not even use anything at all: for basic (non-repeating) callbacks, timers and intervals script will continue running until
all the postponed actions are complete (updating once every 100 ms).

  Parameters:

  1. `time`: `number` Time in seconds to pause worker by.
## Function worker.wait(time)
Wait for `worker.result` value to be set. Stops the worker once `worker.result` value has been provided (or any `error()` has been raised).
Works the best if your worker uses a lot of async operations.

  Parameters:

  1. `time`: `number?` Time in seconds for timeout. Default value: 60. Feel free to pass something like `math.huge` if you don’t need timeout for some reason.
## Function ac.onRelease(callback, item)
Adds a callback which might be called when script is unloading. Use it for some state reversion, but
don’t rely on it too much. For example, if Assetto Corsa would crash or just close rapidly, it would not
be called. It should be called when scripts reload though.

  Parameters:

  1. `callback`: `fun(item: T)`

  2. `item`: `T?` Optional parameter. If provided, will be passed to callback on release, but stored with a weak reference, so it could still be GCed before that (in that case, callback won’t be called at all).

  Returns:

  - `fun`
## Function package.add(dir)
For easy import of scripts from subdirectories. Provide it a name of a directory relative
to main script folder and it would add that directory to paths it searches for.

  Parameters:

  1. `dir`: `string`
## Function ac.onOnlineWelcome(callback)
Sets a callback which will be called when server welcome message and extended config arrive.

  Parameters:

  1. `callback`: `fun(message: string, config: ac.INIConfig)` Callback function.

  Returns:

  - `ac.Disposable`

# Module common/class.lua

## Function ClassBase.isInstanceOf(obj)
Checks if object is an instance of a class created by `class()` function.

  Parameters:

  1. `obj`: `any|nil` Any table, vector, nil, anything.

  Returns:

  - `boolean` True if type of `obj` is `ClassBase` or any class inheriting from it.
## Function ClassBase:isSubclassOf(classDefinition)
Checks if ClassBase is a subsclass of a class created by `class()` function. It wouldn’t be, function is here just for
keeping things even.

  Parameters:

  1. `classDefinition`: `ClassDefinition` Class created by `class()` function.

  Returns:

  - `boolean` Always false.
## Function ClassBase:subclass(...)
Creates a new class. Pretty much the same as calling `class()` (all classes are inheriting from `ClassBase` anyway).

  Returns:

  - `ClassDefinition` New class definition
## Function ClassBase:include(mixin)
Adds a mixin to all subsequently created classes. Use it early in case you want to add a method or some data to all of your objects.
If `mixin` has a property `included`, it would be called each time new class is created with a reference to the newly created class.

  Parameters:

  1. `mixin`: `ClassMixin`
## Function ClassBase:subclassed(classDefinition)
Define this function and it would be called each time a new class without a parent (or `ClassBase` for parent) is created.

  Parameters:

  1. `classDefinition`: `ClassDefinition`
## Function ClassPool.isInstanceOf(obj)
Checks if object is an instance of a class with pooling active.

  Parameters:

  1. `obj`: `any|nil` Any table, vector, nil, anything.

  Returns:

  - `boolean` True if type of `obj` is `ClassPool` or any class inheriting from it.
## Function ClassPool:isSubclassOf(classDefinition)
Checks if ClassPool is a subsclass of a class created by `class()` function. It wouldn’t be unless you’re passing `ClassBase`, function is here just for
keeping things even.

  Parameters:

  1. `classDefinition`: `ClassBase` Class created by `class()` function.

  Returns:

  - `boolean` True if you’ve passed ClassBase here.
## Function ClassPool:subclass(...)
Creates a new class with pooling. Pretty much the same as calling `class(class.Pool, ...)` (all classes with `class.Pool` are 
inheriting from `ClassPool` anyway).

  Returns:

  - `ClassDefinition` New class definition
## Function ClassPool:include(mixin)
Adds a mixin to subsequently created classes with pooling. Use it early in case you want to add a method or some data to all of your objects that use pooling.
If `mixin` has a property `included`, it would be called each time new class with pooling is created with a reference to the newly created class.

  Parameters:

  1. `mixin`: `ClassMixin`
## Function ClassPool:subclassed(classDefinition)
Define this function and it would be called each time a new pooling class without a parent (or `ClassPool` for parent) is created.

  Parameters:

  1. `classDefinition`: `ClassDefinition`
## Class ClassBase
A base class. Note: all classes are inheriting from this one even if they’re not using
`ClassBase` as a parent class explicitly. You might still want to put it in EmmyDoc comment to get hints for functions like `YourClass.isInstanceOf()`.

- `ClassBase:isInstanceOf(classDefinition)`

  Checks if object is an instance of this class. Can be used either as `obj:isInstanceOf(YourClass)` or, as a safer alternative,
`YourClass.isInstanceOf(obj)` — this one would work even if `obj` is nil, a number, a vector, anything like that. And in all of those
cases, of course, it would return `false`.

  Parameters:

    1. `classDefinition`: `ClassDefinition` Used with `obj:isInstanceOf(YourClass)` variant.

  Returns:

    - `boolean` True if argument is an instance of this class.

- `ClassBase:isSubclassOf(classDefinition)`

  Class method. Checks if class itself is a child class of a different class (or a child of a child, etc). 
Can be used as `YourClass:isInstanceOf(YourOtherClass)`.

  Parameters:

    1. `classDefinition`: `ClassDefinition` Class created by `class()` function.

  Returns:

    - `boolean` True if this class is a child of another class (or a child of a child, etc).

- `ClassBase:include(mixin)`

  Class method. Includes mixin, adding new methods to a preexising class. If mixin has a property `included`, it will be called
with an argument referencing a class mixin is being added to. Can be used as `YourClass:include({ newMethod = function(self, arg) end })`.

  Parameters:

    1. `mixin`: `ClassMixin` Any mixin.

- `ClassBase:subclass(...)`

  Class method. Creates a new child class.

  Returns:

    - `ClassDefinition` New class definition

- `ClassBase:subclassed(classDefinition)`

  Class method. Called when a new child class is created using this class as a parent one. Redefine this function for
your class if you need some advanced processing, like adding new methods to a child class.

  Parameters:

    1. `classDefinition`: `ClassDefinition` New class definition
## Class ClassPool
A base class for objects with pooling. Doesn’t add anything, but you can add it as a parent class
so that `recycled()` would be documented.

- `ClassPool:recycled()`

  Called when object is about to get recycled.

  Returns:

    - `boolean` Return false if this object should not be recycled and instead destroyed as usual.
## Function class(name, parentClass, flags)
Create a new class. Example:

```lua
local MyClass = class('MyClass')        -- class declaration

function MyClass:initialize(arg1, arg2) -- constructor
  self.myField = arg1 + arg2            -- field
end

function MyClass:doMyThing()            -- method
  print(self.myField)
end

local instance = MyClass(1, 2)          -- creating instance of a class
instance:doMyThing()                    -- calling a method
```

Whole thing is very similar to [middleclass](https://github.com/kikito/middleclass), but it’s a different
implementation that should be somewhat faster. Main differences:

1. Class name is stored in `YourClass.__name` instead of `YourClass.name`.

2. There is no `.static` subtable, all static fields and methods are instead stored in main class
   table and thus are available as instance fields and methods as well (that’s why `YourClass.name` was
   renamed to `YourClass.__name`, to avoid possible confusion with a common field name). It’s a bit
   messier, especially with class methods such as `:subclass()`, but it has some advantages as well:
   objects creation is faster, and it’s more EmmyLua-friendly (both of which is what it’s all about).

3. Overloaded `__tostring`, `__len` and `__call` are inherited, but not other operators.

4. Method `YourClass.allocate()` works differently here and is used to create a simple table which will be
   passed to `setmetatable()`. This can help with performance if objects are created often.

Everything else should work the same, including inheritance and mixins. As for performance, some simple
tests show up to 30% faster objects creation and 40% less memory used for objects with two fields when
using `YourClass.allocate()` method instead of `YourClass:initialize()` (that alone gives about 15% increase in speed
when creating an object with two fields):

```lua
function YourClass.allocate(arg1, arg2)  -- notice . instead of :
  return { myField = arg1 + arg2 }     -- also notice, methods are not available at this stage
end
```

Other differences (new features rather than something breaking compatibility) and important notes:

1. Function `class()` takes string for class name, another class to act like a parent,
   allocate and initialize functions and flags. Everything is optional and can go in any order (with one caveat:
   allocate function should go before initialize function unless you’re using `class.Pool`). Generally there is no
   benefit in passing allocate and initialize functions here though.

2. With flag `class.NoInitialize` constructor would not look for `YourClass:initialize()` method to call at all,
   instead using only `YourClass.allocate()`. Might speed things up a bit further.

3. If you’re creating new instances really often, there is a `class.Pool` flag. It would disable the use of
   `YourClass.allocate()`, but instead allow to reuse unused objects by using `class.recycle(object)`. Recycled objects
   would end up in a pool of objects to be reused next time an instance would need to be created. Of course, it
   introduces a whole new type of errors (imagine storing a reference to a recycled item somewhere not knowing it was
   recycled and now represents something else entirely), so please be careful.

   Note 1: Method `class.recycle()` can be used with nils or non-recycle, no need to have extra checks before calling it.
 
   Note 2: Instances of child classes won’t end up in parent class pool. For such arrangements, consider adding pooling
           flag to all of child classes where appropriate.

4. Before recycling, method `YourClass:recycled()` will be called. Good time to recycle any inner elements. Also,
   return `false` from it and object would not be recycled at all.

5. To check type, `YourClass.isInstanceOf(item)` can also be used. Notice that it’s a static method, no “:” here.

All classes are considered children classes of `ClassBase`, that one is mostly for EmmyLua to pick up methods like 
`YourClass.isInstanceOf(object)`. If you’re creating your own class and want to use such methods, just add `: ClassBase`
to its EmmyLua annotation. And objects with pooling are children of `ClassPool` which is a child of `ClassBase`. Note: 
to speed things up, those classes aren’t fully real, but you can access them and their methods and even call things like
`ClassBase:include()`. Please read documentation for those functions before using them though, just to check.

  Parameters:

  1. `name`: `string` Class name.

  2. `parentClass`: `ClassBase` Parent class.

  3. `flags`: `nil|integer|`class.NoInitialize`|`class.Pool`|`class.Minimal`` Flags.

  Returns:

  - `ClassDefinition` New class definition
## Function class.recycle(item)
Recycle an item to its pool, to speed up creation and reduce work for GC. Requires class to be created with
`class.Pool` flag.

This method has protection from double recycling, recycling nils or non-recycleable items, so don’t worry about it.

  Parameters:

  1. `item`: `ClassPool|nil`
## Function class.emmy(classFn, constructorFn) return constructorFn
A trick to get `class()` to work with EmmyLua annotations nicely. Call `class.emmy(YourClass, YourClass.initialize)`
or `class.emmy(YourClass, YourClass.allocate)` (whatever you’re using) and it would give you a constructor function.
Then, use it for local reference or as a return value from module. For best results add annotations to function you’re
passing here, such as return value or argument types.

In reality is simply returns the class back and ignores second argument, but because of this definition EmmyLua thinks
it got the constructor.

  Parameters:

  1. `classFn`: `T1`

  2. `constructorFn`: `T2`

  Returns:

  - `T1|T2`
## Function ac.getPatchVersion()

  Returns:

  - `string`
## Function ac.getPatchVersionCode()
Increments with every CSP build.

  Returns:

  - `integer`
## Function ac.loadINIppFile(iniFilename, includeDirs)
Load and parse INIpp configuration file (supports includes and such), return it as JSON. Deprecated, use `ac.INIConfig.load()` instead.

  Parameters:

  1. `iniFilename`: `string`

  2. `includeDirs`: `string|nil` Newline separated path to folders to search for included files in. Default value: `nil`.

  Returns:

  - `string`
## Function ac.getMGUKDeliveryName(carIndex, programIndex)
Returns name of MGUK delivery program. If there is no such car or program, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `programIndex`: `integer?` 0-based program index (if negative, name of currently selected program will be returned. Default value: -1.

  Returns:

  - `string`
## Function ac.getTyresName(carIndex, compoundIndex)
Get short name of a tyre set, either currently selected or with certain index. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `compoundIndex`: `integer?` 0-based tyre set index, if set to -1, short name of currently selected tyre set will be returned. Default value: -1.

  Returns:

  - `string`
## Function ac.getTyresIndex(carIndex, tyresShortName)
Get 0-based index of a tyres set with a given short name, or -1 if there is no such tyres set (or such car).

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `tyresShortName`: `string` Short tyres set name (usually a couple of symbols long).

  Returns:

  - `integer`
## Function ac.getTyresLongName(carIndex, compoundIndex, includePostfix)
Returns long name of a tyre set with certain index. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `compoundIndex`: `integer?` 0-based tyre set index, if set to -1, short name of currently selected tyre set will be returned. Default value: -1.

  3. `includePostfix`: `boolean?` Set to `false` to skip short name postfix. Default value: `true`.

  Returns:

  - `string`
## Function ac.getCarID(carIndex)
Get car ID (name of its folder) of a certain car. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.getCarName(carIndex, includeYearPostfix)
Get car name (from its JSON file) of a certain car. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `includeYearPostfix`: `boolean?` Set to `true` to add a year postfix. Default value: `false`.

  Returns:

  - `string`
## Function ac.getCarSkinID(carIndex)
Get selected skin ID of (name of skin’s folder) of a certain car. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.getCarBrand(carIndex)
Get name of a manufacturer of a certain car. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.getCarCountry(carIndex)
Get name of manufactoring country of a certain car. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.hasTrackSpline()
Refers to AI spline.

  Returns:

  - `boolean`
## Function ac.worldCoordinateToTrackProgress(v)
Finds nearest point on track AI spline (fast_lane) and returns its normalized position. If there is no track spline, returns -1.

  Parameters:

  1. `v`: `vec3`

  Returns:

  - `number`
## Function ac.getTrackAISplineSides(v)
Returns distance from AI spline to left and right track boundaries.

  Parameters:

  1. `v`: `number` Lap progress from 0 to 1.

  Returns:

  - `vec2` X for left side, Y for right side.
## Function ac.trackProgressToWorldCoordinate(v, linear)

  Parameters:

  1. `v`: `number`

  2. `linear`: `boolean?` Use linear interpolation. Default value: `false`.

  Returns:

  - `vec3`
## Function ac.trackProgressToWorldCoordinateTo(v, r, linear)

  Parameters:

  1. `v`: `number`

  2. `r`: `vec3`

  3. `linear`: `boolean?` Use linear interpolation. Default value: `false`.
## Function ac.worldCoordinateToTrack(v)
Converts world coordinates into track coordinates. Track coordinates:
 - X for normalized position (0 — right in the middle, -1 — left side of the track, 1 — right size);
 - Y for height above track in meters;
 - Z for track progress.

  Parameters:

  1. `v`: `vec3`

  Returns:

  - `vec3`
## Function ac.trackCoordinateToWorld(v)
Converts track coordinates into world coordinates. Track coordinates:
 - X for normalized position (0 — right in the middle, -1 — left side of the track, 1 — right size);
 - Y for height above track in meters;
 - Z for track progress.

  Parameters:

  1. `v`: `vec3`

  Returns:

  - `vec3`
## Function ac.getTrackCoordinatesDeg(worldPos)
Returns track world coordinates in degrees.

  Parameters:

  1. `worldPos`: `vec3|nil` Added in 0.2.8. If set, function returns coordinates of this point instead. Default value: `nil`.

  Returns:

  - `vec2` X for latitude, Y for longitude.
## Function ac.getTrackTimezoneBaseDst(time)
Returns timezone offset for the track in seconds.

  Parameters:

  1. `time`: `number?` If set, returns timezone for given timestamp (DST might differ). Default value: `nil`.

  Returns:

  - `vec2` X for base offset, Y for summer time offset.
## Function ac.getTrackSectorName(trackProgress)
Name of a sector.

  Parameters:

  1. `trackProgress`: `number` Track position from 0 to 1.

  Returns:

  - `string`
## Function ac.dirname()
Returns directory of the script.

  Returns:

  - `string`
## Function ac.findFile(fileName)
If `fileName` is not an absolute path, looks for a file in script directory, then relative to CSP folder,
then relative to AC root folder. If anything is found, returns an absolute path to found file, otherwise
returns input parameter. If such a filename is not allowed, or `fileName` is `nil`, returns an empty string.

  Parameters:

  1. `fileName`: `string` File name relative to script folder, or CSP folder, or AC root folder.

  Returns:

  - `path`
## Function ac.getFolder(folderID)
Returns full path to one of known folders. Some folders might not exist, make sure to create them before writing.

  Parameters:

  1. `folderID`: `ac.FolderID|string` Could also be a system GUID in “{XX…}” form.

  Returns:

  - `string` Returns empty string if there is no match.
## Function ac.lapTimeToString(time, allowHours)
Turns time in milliseconds into common lap time presentation, like 00:00.123. If minutes exceed 60,
hours will also be added, but only if `allow_hours` is `true` (default is `false`).

  Parameters:

  1. `time`: `number` Time in milliseconds.

  2. `allowHours`: `boolean?` Set to `true` to add hours as well. If `false` (default value), instead it would produce 99:99.999. If `true`, milliseconds will use two digits instead of three. Default value: `false`.

  Returns:

  - `string`
## Function ac.getCountryName(nationCode)
Returns country name based on nation code (three symbols for country ID).

  Parameters:

  1. `nationCode`: `ac.NationCode`

  Returns:

  - `string`
## Function ac.readDataFile(filename)
Can be used to access files in “data.acd” and, for example, read car specs.

  Parameters:

  1. `filename`: `string`

  Returns:

  - `string`
## Function ac.parseINIppFile(iniData)
Parse INIpp configuration file, return it as JSON. Deprecated, use `ac.INIConfig.parse()` instead.

  Parameters:

  1. `iniData`: `string`

  Returns:

  - `string`
## Function ac.getTrackId()
Use `ac.getTrackID()` instead.

  Returns:

  - `string`
## Function ac.getTrackID()
Returns track ID (name of its folder).

  Returns:

  - `string`
## Function ac.getTrackLayout()
Returns track layout ID (name of layout folder, without name of track folder), or empty string if there is no layout.

  Returns:

  - `string`
## Function ac.getTrackFullID(separator)
Returns full track ID (name of track folder and layout folder joined by some string, or just name of track folder if there is no layout).

  Parameters:

  1. `separator`: `string?` Default value: '-'.

  Returns:

  - `string`
## Function ac.getTrackName()
Returns track name (as set in its JSON file).

  Returns:

  - `string`
## Function ac.getTrackDataFilename(fileName)
Given name, returns a path like …/assettocorsa/content/tracks/[track ID]/data/[name], taking into account layout as well.

  Parameters:

  1. `fileName`: `string`

  Returns:

  - `string`
## Function ac.getCarTags(carIndex)
Get car tags. If there is no such car, returns `nil`. @nodiscard

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.uniqueMachineKey()
A key unique for each individual PC (uses serial numbers of processor and motherboard).
Use `ac.uniqueMachineKeyAsync()` instead.

  Returns:

  - `string`
## Function ac.uniqueMachineKeyAsync(callback)
A key unique for each individual PC (uses serial numbers of processor and motherboard). Asynchronous version. Returned value is in binary,
use something like `ac.encodeBase64()` to encode data in readable format.

  Parameters:

  1. `callback`: `fun(err: string?, response: string?)`
## Function ac.getCarDataFiles(carIndex)
Returns ordered list of data file names (not full paths, just the names) of a certain car. Works for both packed and unpacked cars. If failed,
returns empty list. @nodiscard

  Parameters:

  1. `carIndex`: `integer?` 0-based car index.

  Returns:

  - `string`
## Function ac.getCarColliders(carIndex, actualColliders)
Returns list of car colliders. @nodiscard

  Parameters:

  1. `carIndex`: `integer?` 0-based car index.

  2. `actualColliders`: `boolean?` Set to `true` to draw actual physics colliders (might differ due to some physics alterations). Default value: `false`.
## Function ac.distanceToRenderSquared(pos)
Returns squared distance to main camera. In splitscreen mode, returns smallest distance between to cameras. In the future, might be altered by
more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.

  Parameters:

  1. `pos`: `vec3`

  Returns:

  - `number`
## Function ac.distanceToRender(pos)
Returns distance to main camera. In splitscreen mode, returns smallest distance between to cameras. In the future, might be altered by
more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.

  Parameters:

  1. `pos`: `vec3`

  Returns:

  - `number`
## Function ac.closerToRenderThan(pos, distance)
Returns `true` if position is closer to main camera than the threshold. In splitscreen mode, considers secondary camera. In the future, might be altered by
more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.

  Parameters:

  1. `pos`: `vec3`

  2. `distance`: `number`

  Returns:

  - `boolean`
## Function ac.encodeHalf(v)
Encodes float into FP16 format and returns it as uint16.

  Parameters:

  1. `v`: `number`

  Returns:

  - `integer`
## Function ac.encodeHalf2(v)
Encodes two floats from a vector into FP16 format and returns it as uint32.

  Parameters:

  1. `v`: `number|vec2`

  Returns:

  - `integer`
## Function ac.decodeHalf(v)
Decodes float from FP16 format (represented as uint16) and returns a regular number.

  Parameters:

  1. `v`: `integer`

  Returns:

  - `number`
## Function ac.decodeHalf2(v)
Decodes two floats from FP16 format (represented as uint32) and returns a vector.

  Parameters:

  1. `v`: `integer`

  Returns:

  - `vec2`
## Function ac.checksumSHA256(data)
Computes SHA-256 checksum for given binary data. Very secure, but might be slow with large amounts of data. Data string can contain zero bytes.

  Parameters:

  1. `data`: `binary`

  Returns:

  - `string`
## Function ac.checksumXXH(data)
Computes 64-bit xxHash checksum for given binary data. Very fast, not that great for encryption purposes.
Use `bit.tohex()` to turn result into a hex representation. Data string can contain zero bytes.

  Parameters:

  1. `data`: `binary`

  Returns:

  - `integer`
## Function ac.compress(data, type, level)
Compresses data. First byte of resulting data is compression type, next four are uncompressed data size, rest is compressed data
itself. If data is failed to compress, returns `nil`. Data string can contain zero bytes.

  Parameters:

  1. `data`: `binary`

  2. `type`: `ac.CompressionType`

  3. `level`: `integer?` Higher level means better, but slower compression. Maximum value: 12. Default value: 9.

  Returns:

  - `string`
## Function ac.decompress(data)
Decompresses data. First byte of input data is compression type, next four are uncompressed data size. If data is damaged, returns `nil`.
Data string can contain zero bytes.

  Parameters:

  1. `data`: `binary`

  Returns:

  - `string`
## Function ac.encodeBase64(data, trimResult)
Encodes data in base64 format. Data string can contain zero bytes.

  Parameters:

  1. `data`: `binary`

  2. `trimResult`: `boolean?` If `true`, ending “=” will be trimmed. Default value: `false`.

  Returns:

  - `string`
## Function ac.decodeBase64(data)
Decodes data from base64 format (ending “=” are not needed).

  Parameters:

  1. `data`: `string`

  Returns:

  - `string`
## Function ac.utf8To16(data)
Converts string from UTF-8 to UTF-16 format (two symbols per character). All strings Lua operates with regularly are consired UTF-8. UTF-16 strings
can’t be used in any CSP API unless documentation states that function can take strings containing zeroes.

  Parameters:

  1. `data`: `string`

  Returns:

  - `string`
## Function ac.utf16To8(data)
Converts string from UTF-16 (two symbols per character) to common Lua UTF-8. All strings Lua operates with regularly are consired UTF-8. UTF-16 strings
can’t be used in any CSP API unless documentation states that function can take strings containing zeroes. Data string can contain zero bytes.

  Parameters:

  1. `data`: `binary`

  Returns:

  - `string`
## Function ac.structBytes(data)
Given an FFI struct, returns bytes with its content. Resulting string may contain zeroes.

  Parameters:

  1. `data`: `binary`

  Returns:

  - `string`
## Function ac.perfBegin(value)
Simple helper to measure time and analyze performance. Call `ac.perfBegin('someKey')` to start counting time and
 `ac.perfEnd('someKey')` to stop. Measured time will be shown in Lua App Debug app in CSP (moving average across all
 perfBegin/perfEnd calls). Note: keys on perfBegin() and perfEnd() should match.

  Parameters:

  1. `value`: `string`
## Function ac.perfEnd(value)
Simple helper to measure time and analyze performance. Call `ac.perfBegin('someKey')` to start counting time and
 `ac.perfEnd('someKey')` to stop. Measured time will be shown in Lua App Debug app in CSP (moving average across all
 perfBegin/perfEnd calls). Note: keys on perfBegin() and perfEnd() should match.

  Parameters:

  1. `value`: `string`
## Function ac.perfFrameBegin(value)
Unlike `ac.perfBegin('someKey')/ac.perfEnd('someKey')`, `ac.perfFrameBegin(0)/ac.perfFrameEnd(0)` will accumulate time
 between calls as frame progresses and then use the whole sum for moving average. This makes it suitable for measuring
 how much time in a frame repeatedly ran bit of code takes. To keep performance as high as possible (considering that
 it could be ran in a loop), it uses integer keys instead of strings.

  Parameters:

  1. `value`: `integer`
## Function ac.perfFrameEnd(value)
Unlike `ac.perfBegin('someKey')/ac.perfEnd('someKey')`, `ac.perfFrameBegin(0)/ac.perfFrameEnd(0)` will accumulate time
 between calls as frame progresses and then use the whole sum for moving average. This makes it suitable for measuring
 how much time in a frame repeatedly ran bit of code takes. To keep performance as high as possible (considering that
 it could be ran in a loop), it uses integer keys instead of strings.

  Parameters:

  1. `value`: `integer`
## Function ac.getCameraPosition()

  Returns:

  - `vec3`
## Function ac.getCameraUp()

  Returns:

  - `vec3`
## Function ac.getCameraSide()

  Returns:

  - `vec3`
## Function ac.getCameraForward()

  Returns:

  - `vec3`
## Function ac.getCameraDirection()
This vector is pointing backwards! Only kept for compatibility. For proper one, use `ac.getCameraForward()`.

  Returns:

  - `vec3`
## Function ac.getCameraFOV()
Value in degrees.

  Returns:

  - `number`
## Function ac.getCameraPositionTo(r)

  Parameters:

  1. `r`: `vec3` Destination.
## Function ac.getCameraUpTo(r)

  Parameters:

  1. `r`: `vec3` Destination.
## Function ac.getCameraSideTo(r)

  Parameters:

  1. `r`: `vec3` Destination.
## Function ac.getCameraForwardTo(r)

  Parameters:

  1. `r`: `vec3` Destination.
## Function ac.getCameraDirectionTo(r)

  Parameters:

  1. `r`: `vec3` Destination.
## Function ac.getCameraPositionRelativeToCar()
Returns camera position in car coordinates system.

  Returns:

  - `vec3`
## Function ac.getCompassAngle(dir)
Returns compass angle for given directory.

  Parameters:

  1. `dir`: `vec3`

  Returns:

  - `number` Angle from 0 to 360 (0/360 for north, 90 for east, etc.)
## Function ac.getSunAngle()
Value in degrees.

  Returns:

  - `number`
## Function ac.getSunPitchAngle()
Value in degrees.

  Returns:

  - `number`
## Function ac.getSunHeadingAngle()
Value in degrees.

  Returns:

  - `number`
## Function ac.isInteriorView()
Returns true if camera is focused on interior (interior audio is playing).

  Returns:

  - `boolean`
## Function ac.isInReplayMode()

  Returns:

  - `boolean`
## Function ac.compressTexture(filename, outputFilename)

  Parameters:

  1. `filename`: `string`

  2. `outputFilename`: `string`
## Function ac.getSoundSpeedMs()
Returns precalculated sound speed in m/s taking into account humidity, altitude, pressure, etc.

  Returns:

  - `number`
## Function ac.getAirPressure(p)
Returns air pressure in kPa.

  Parameters:

  1. `p`: `vec3`

  Returns:

  - `number`
## Function ac.getAirHumidity(p)
Returns air humidity in 0…1 range. Currently doesn’t use position parameter, but it might change later.

  Parameters:

  1. `p`: `vec3`

  Returns:

  - `number`
## Function ac.getLastError()
Returns string with last error thrown by this script, or `nil` if there wasn’t an error. Use it in case you would want to set some nicer error reporting.

  Returns:

  - `string`
## Function ac.getAudioVolume(audioChannelKey, carIndex, fallbackValue)
Returns audio volume for given channel, value from 0 to 1. If channel is not recognized, returns `fallbackValue` if specified, unless (since 0.2.4) you specify key in a
`'your.namespace/Readable name'` format: this will register a new volume level and show it in Audio Volume app for sessions where value was
accessed or set.

  Parameters:

  1. `audioChannelKey`: `ac.AudioChannel`

  2. `carIndex`: `integer?` If set and a Kunos car-related channel (`'dirt'`, `'engine'`, `'opponents'`, `'surfaces'`, `'transmission'`, `'tyres'`, `'wind'`) is used, returns a car-specific multiplier (1 by default). Default value: -1.

  3. `fallbackValue`: `number?` Default value: -1.

  Returns:

  - `number` Value from 0 to 1, or -1 if there is no such channel.
## Function ac.getAudioOutputDevice()
Returns name of output audio device.

  Returns:

  - `string`
## Function ac.getCarSpeedKmh(carIndex)
Consider using `ac.getCar(carIndex).speedKmh` instead.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `number`
## Function ac.getCarGearLabel(carIndex)
Returns 'R', 'N', number of engaged gear or value set by `ac.setGearLabel()` if used (for implementing automatic gearboxes).
If your code is displaying current gear, this might be a preferable choice.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.getGroundYApproximation()
Returns approximate Y coordinate of ground, calculated by using depth from reflection cubemap. Does not have a performance impact (that value
 will be calculated anyway for CSP to run.

  Returns:

  - `number`
## Function ac.getDeltaT()
Returns current delta time associated with UI (so values are non-zero if sim or replay are paused).

  Returns:

  - `number` Seconds.
## Function ac.getGameDeltaT()
Returns current delta time associated with simulation (so values are zero if sim or replay are paused).

  Returns:

  - `number` Seconds.
## Function ac.getScriptDeltaT()
Returns delta time for current script. If script only runs every N frames (like car display scripts by default),
this value will be greater than regular `dt` from simulation state.

  Returns:

  - `number`
## Function ac.getConditionsTimeScale()
Returns current time multiplier.

  Returns:

  - `number`
## Function ac.getPpFilter()
Returns name of current PP filter with “.ini”.

  Returns:

  - `string`
## Function ac.getWindVelocity()
Value is in m/s.

  Returns:

  - `vec3`
## Function ac.getWindVelocityTo(r)
Value is in m/s.

  Parameters:

  1. `r`: `vec3` Destination.
## Function ac.isWeatherFxActive()

  Returns:

  - `boolean`
## Function ac.getTrackUpcomingTurn(carIndex)
Distance and turn angle (in degrees) for the upcoming turn. If failed to compute, both would be -1. If car is facing wrong way, turn angle is either
180° or -180° depending on where steering wheel of a car is.

  Parameters:

  1. `carIndex`: `integer?` Default value: 0.

  Returns:

  - `vec2`
## Function ac.getDriverName(carIndex)
Get full driver name of a driver of a certain car. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.getDriverNationCode(carIndex)
Get three character nation code of a driver of a certain car. Nation code is a three-letter uppercase country identifier. If nationality is not set, a value from JSON
is returned. If it’s missing there, a fallback “ITA” is returned. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.getDriverNationality(carIndex)
Get full nationality of a driver of a certain car. Usually, it’s a full country name. If nationality is not set, a value from JSON
is returned. If it’s missing there, a fallback “Italy” is returned. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.getDriverTeam(carIndex)
Get name of a team of a driver of a certain car. Team names can be configured in entry list online. If nationality is not set, a value from JSON
is returned. If it’s missing there, an empty string is returned. If there is no such car, returns `nil`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `string`
## Function ac.getDriverNumber(carIndex)
Get number of a driver of a certain car. If number is set in skin JSON, it will be returned, otherwise it’s a unique 1-based number.
If there is no car with such index, 0 is returned.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `integer`
## Function ac.isCustomIconSet(carIndex)
Returns `true` if a certain driver is using custom icon. Use `'carN::special::driver'` as image filename to draw it (when not custom,
will give you a livery icon or a fallback dark image).

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `boolean`
## Function ac.getSessionName(sessionIndex)
Get session name for a session with given index. Use `ac.getSim()` to check number of sessions and more information about them.
If there is no such session, returns `nil`.

  Parameters:

  1. `sessionIndex`: `integer`

  Returns:

  - `string`
## Function ac.isKeyDown(keyIndex)
Is keyboard button being held.

  Parameters:

  1. `keyIndex`: `ui.KeyIndex`

  Returns:

  - `boolean`
## Function ac.isKeyPressed(keyIndex)
Is keyboard button just moved from not held to held in the last graphics frame (or, for physics scripts since 0.2.7, physics frame).
Still, if you’re working on car physics script, consider using `ac.ControlButton()` instead for better customization. If your script is skipping frames
(such as car display scripts), this might not work as expected, as the frame the button has changed the state in could be skipped.

  Parameters:

  1. `keyIndex`: `ui.KeyIndex`

  Returns:

  - `boolean`
## Function ac.isKeyReleased(keyIndex)
Is keyboard button just moved from held to not held in the last graphics frame (or, for physics scripts since 0.2.7, physics frame).
If you’re working on car physics script, consider using `ac.ControlButton()` instead for better customization. If your script is skipping frames
(such as car display scripts), this might not work as expected, as the frame the button has changed the state in could be skipped.

  Parameters:

  1. `keyIndex`: `ui.KeyIndex`

  Returns:

  - `boolean`
## Function ac.isVisibleInMainCamera(pos, radius, gSpace, includeFarPlane)
Can be called from anywhere. Checks if given point is within main camera frustum (or several, in triple screen mode) or not. For checking if something
is within current camera instead, try `render.isVisible()`.

  Parameters:

  1. `pos`: `vec3`

  2. `radius`: `number`

  3. `gSpace`: `boolean?` Pass `false` if your coordinates are in world-space rather than with origin shift applied (in most cases, you need to use `false`, this argument is added for backwards compatibility. Default value: `true`.

  4. `includeFarPlane`: `boolean?` Pass `false` to ignore far plane. Default value: `true`.

  Returns:

  - `boolean` Checks visibility with frustum culling.
## Function ac.getControllerSteerValue()
Returns steering input from -1 to 1.

  Returns:

  - `number`
## Function ac.isControllerGasPressed()
Is gas input pressed (pedal, gamepad axis, keyboard button but not mouse button).

  Returns:

  - `boolean`
## Function ac.isControllerGearUpPressed()
Is gear up input pressed (pedal, gamepad button, keyboard button).

  Returns:

  - `boolean`
## Function ac.isControllerGearDownPressed()
Is gear down input pressed (pedal, gamepad button, keyboard button).

  Returns:

  - `boolean`
## Function ac.getSessionSpawnSet(sessionIndex)
Get session spawn set (`'START'`, `'PIT'`, `'HOTLAP_START'`, `'TIME_ATTACK'`, etc.) for a session with given index. Use `ac.getSim()`
to check number of sessions and more information about them. If there is no such session, returns `nil`.

  Parameters:

  1. `sessionIndex`: `integer`

  Returns:

  - `string`
## Function ac.forceVisibleHeadNodes(carIndex, force)
Forces driver head to be visible even with cockpit camera.

  Parameters:

  1. `carIndex`: `integer`

  2. `force`: `boolean?` Default value: `true`.
## Function ac.isGamepadButtonPressed(gamepadIndex, gamepadButtonID)
Checks if a certain gamepad button is pressed.

  Parameters:

  1. `gamepadIndex`: `integer` 0-based index, from 0 to 7 (first four are regular gamepads, second four are Dual Shock controllers).

  2. `gamepadButtonID`: `ac.GamepadButton`

  Returns:

  - `boolean`
## Function ac.getGamepadAxisValue(gamepadIndex, gamepadAxisID)
Returns value of a certain gamepad axis.

  Parameters:

  1. `gamepadIndex`: `integer` 0-based index, from 0 to 7 (first four are regular gamepads, second four are Dual Shock controllers).

  2. `gamepadAxisID`: `ac.GamepadAxis`

  Returns:

  - `number`
## Function ac.getJoystickCount()
Returns number of DirectInput devices (ignore misleading name).

  Returns:

  - `integer`
## Function ac.getJoystickName(joystick)
Returns name of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.

  Parameters:

  1. `joystick`: `integer` 0-based index.

  Returns:

  - `string`
## Function ac.getJoystickInstanceGUID(joystick)
Returns instance GUID of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.

  Parameters:

  1. `joystick`: `integer` 0-based index.

  Returns:

  - `string`
## Function ac.getJoystickProductGUID(joystick)
Returns product GUID of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.

  Parameters:

  1. `joystick`: `integer` 0-based index.

  Returns:

  - `string`
## Function ac.getJoystickIndexByInstanceGUID(guid)
Returns index of a DirectInput device by its instance GUID, or `nil` if there is no such device (ignore misleading name).

  Parameters:

  1. `guid`: `string`

  Returns:

  - `integer`
## Function ac.getJoystickAxisCount(joystick)
While this function returns accurate number of device axis, consider using 8 instead if you need to iterate over them.
Actual axis can be somewhere within those 8. For example, if device has a single axis, it could be that you need to access
axis at index seven to get its value (rest will be zeroes).

  Parameters:

  1. `joystick`: `integer`

  Returns:

  - `integer`
## Function ac.getJoystickButtonsCount(joystick)
Returns number of buttons of a DirectInput device (ignore misleading name).

  Parameters:

  1. `joystick`: `integer`

  Returns:

  - `integer`
## Function ac.getJoystickDpadsCount(joystick)
Returns number of D-pads (aka POVs) of a DirectInput device (ignore misleading name).

  Parameters:

  1. `joystick`: `integer`

  Returns:

  - `integer`
## Function ac.isJoystickButtonPressed(joystick, button)
Checks if a button of a DirectInput device is currently held down (ignore misleading name).

  Parameters:

  1. `joystick`: `integer`

  2. `button`: `integer`

  Returns:

  - `boolean`
## Function ac.getJoystickAxisValue(joystick, axis)
Returns axis value of a DirectInput device (ignore misleading name).

  Parameters:

  1. `joystick`: `integer`

  2. `axis`: `integer`

  Returns:

  - `number`
## Function ac.isJoystickAxisValue(joystick, axis)
Use `ac.getJoystickAxisValue()` instead.

  Parameters:

  1. `joystick`: `integer`

  2. `axis`: `integer`

  Returns:

  - `number`
## Function ac.getJoystickDpadValue(joystick, dpad)
Returns D-pad (aka POV) value of a DirectInput device (ignore misleading name).

  Parameters:

  1. `joystick`: `integer`

  2. `dpad`: `integer`

  Returns:

  - `integer` If D-pad is not moved, -1, or a value from 0 to 36000 storing the angle (0: up, 9000: right).
## Function ac.isJoystickDpadValue(joystick, dpad)
Use `ac.getJoystickDpadValue()` instead.

  Parameters:

  1. `joystick`: `integer`

  2. `dpad`: `integer`

  Returns:

  - `integer`
## Function ac.getPenPressure()
Checks current stylus/pen/mouse using RealTimeStylus API (compatible with Windows Ink). Should support things like Wacom tables (if drivers are installed
and Windows Ink compatibility in options is not disabled).

Note: the moment its called, CSP initializes RealTimeStylus API to monitor pen state until game closes. With that, CSP will also use that data
for mouse (or pen) pointer interaction with UI in general, especially for IMGUI apps.
[There is a weird issue in Windows 10](https://answers.microsoft.com/en-us/windows/forum/all/windows-pen-tablet-click-and-drag-lag/9e4cac7d-69a0-4651-87e8-7689ce0d1027)
where it doesn’t register short click-and-drag events properly expecting a touchscreen gesture. Using RealTimeStylus API for UI in general solves that.

  Returns:

  - `number` Pen pressure from 0 to 1 (if mouse is used, pressure is 1).
## Function ac.getServerName()
Returns name of the current online server, or `nil` if it’s not available.

  Returns:

  - `string`
## Function ac.getServerIP()
Returns IP address of the current online server, or `nil` if it’s not available.

  Returns:

  - `string`
## Function ac.getServerPortHTTP()
Returns HTTP post of the current online server, or -1 if it’s not available.

  Returns:

  - `integer`
## Function ac.getServerPortTCP()
Returns TCP post of the current online server, or -1 if it’s not available.

  Returns:

  - `integer`
## Function ac.getServerPortUDP()
Returns UDP post of the current online server, or -1 if it’s not available.

  Returns:

  - `integer`
## Function ac.getCarByDriverName(driverName)
Returns index of a car with a driver with a certain name, or -1 if there is no such car.

  Parameters:

  1. `driverName`: `string`

  Returns:

  - `integer`
## Function ac.getCarLeaderboardPosition(carIndex)
Returns leaderboard car position, same as Python function with the same name. Does not work online. For an alternative solution,
get position calculated by CSP via `ac.getCar(N).racePosition`

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `integer` Returns -1 if couldn’t calculate the value.
## Function ac.getCarRealTimeLeaderboardPosition(carIndex)
Returns real time car position, same as Python function with the same name. Does not work online. For an alternative solution,
get position calculated by CSP via `ac.getCar(N).racePosition`.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `integer` Returns -1 if couldn’t calculate the value.
## Function ac.getMoonFraction()
How much of moon area is currently lit up.

  Returns:

  - `number`
## Function ac.getAltitude()

  Returns:

  - `number`
## Function ac.getSkyFeatureDirection(skyFeature, distance, time)
Get direction to a sky feature in world-space (corrected for track heading). If feature is not available, returns a zero vector.

  Parameters:

  1. `skyFeature`: `ac.SkyFeature`

  2. `distance`: `number|refnumber|nil` Default value: `nil`.

  3. `time`: `number?` If set, it’ll compute direction for the given time instead of the current time. Default value: `nil`.

  Returns:

  - `vec3`
## Function ac.getSkyStarDirection(declRad, rightAscRad)
Get direction to a star in the sky in world-space (corrected for track heading). If feature is not available, returns a zero vector.

  Parameters:

  1. `declRad`: `number`

  2. `rightAscRad`: `number`

  Returns:

  - `vec3`
## Function ac.refreshCarShape(carIndex)
Call this function if your script caused car shape to change and CSP would refresh interior masking, car heightmap and more.

  Parameters:

  1. `carIndex`: `integer?` Default value: 0.
## Function ac.refreshCarColor(carIndex)
Call this function if your script caused car color to change and CSP would refresh color map for bounced light and more.

  Parameters:

  1. `carIndex`: `integer?` Default value: 0.
## Function ac.updateDriverModel(carIndex, forceVisible)
Updates state of high-res driver model. Use it before moving driver nodes manually for extra animations: if called,
 next model update possibly overwriting your custom positioning will be skipped. Also, model update will be enforced
 so you can blend your custom state.

 Since 0.1.80-preview397, does not apply if HR driver model is currently hidden unless second argument is `true` (in which
 case it’ll activate driver model for a few frames).

  Parameters:

  1. `carIndex`: `integer?` For car scripts, always applied to associated car instead. Default value: -1.

  2. `forceVisible`: `boolean?` Set to `true` to forcefully switch to HR model for a few frames. Default value: `false`.
## Function ac.getDriverHeadTransformTo(ret, carIndex)

  Parameters:

  1. `ret`: `mat4x4`

  2. `carIndex`: `integer`

  Returns:

  - `boolean`
## Function ac.blockSystemMessages(regex)
Block system messages based on a given regular expression.

  Parameters:

  1. `regex`: `string` Any message with title or description containing this regex will be discarded.

  Returns:

  - `ac.Disposable`
## Function ac.onTrackPointCrossed(carIndex, progress, callback)
Sets a callback which will be called when car crosses a certain point on a track. Won’t be triggered if car is in pitlane or recently jumped.
Time is relative to the same point as `ac.SimState.time`. Tracking happens on physics thread and is interpolated based on car position, so it
should be precise more than within 3 ms steps.

  Parameters:

  1. `carIndex`: `integer` 0-based car index, or -1 for an event to be called for all cars.

  2. `progress`: `number` Track progress from 0 to 1.

  3. `callback`: `fun(carIndex: integer, timeMs: number)`

  Returns:

  - `ac.Disposable`
## Function ac.onSessionStart(callback)
Sets a callback which will be called when a new session starts (or restarts). Doesn’t get triggered at the start of the race (Lua scripts load when
the first session is already up and running to ensure the overall state of the sim is complete)!

  Parameters:

  1. `callback`: `fun(sessionIndex: integer, restarted: boolean)`

  Returns:

  - `ac.Disposable`
## Function ac.onResolutionChange(callback)
Sets a callback which will be called when AC resolution changes. Happens when window size changes, or when making a screenshot.
Note: some scripts, such as WeatherFX style or post-processing script, reload completely when resolution changes, but if they’d call
this function at any point, they would no longer reload. Instead CSP assumes they can handle resolution changes on their side.

  Parameters:

  1. `callback`: `fun(newSize: vec2, makingScreenshot: boolean)`

  Returns:

  - `ac.Disposable`
## Function ac.onTyresSetChange(carIndex, callback)
Sets a callback which will be called when selected tyres change for some car. For car scripts to track changes in their own car, use `car.index` as first argument.
 Note: for physics scripts this even might come a few frames late, but it shouldn’t be a major issue since tyres changes only happen when car is stationary anyway.

  Parameters:

  1. `carIndex`: `integer` 0-based car index, or -1 for an event to be called for all cars.

  2. `callback`: `fun(carIndex: integer, setIndex: integer, shortName: string, longName: string)`

  Returns:

  - `ac.Disposable`
## Function ac.onClientConnected(callback)
Sets a callback which will be called when new user connects the server and their car appears (doesn’t do anything outside of online race).

  Parameters:

  1. `callback`: `fun(connectedCarIndex: integer, connectedSessionID: integer)`

  Returns:

  - `ac.Disposable`
## Function ac.onClientDisconnected(callback)
Sets a callback which will be called when a user disconnects (doesn’t do anything outside of online race).

  Parameters:

  1. `callback`: `fun(connectedCarIndex: integer, connectedSessionID: integer)`

  Returns:

  - `ac.Disposable`
## Function ac.onControlSettingsChanged(callback)
Sets a callback which will be called when control settings change live.

  Parameters:

  1. `callback`: `fun()`

  Returns:

  - `ac.Disposable`
## Function ac.onTripleConfigurationChanged(callback)
Sets a callback which will be called when triple screen configuration changes.

  Parameters:

  1. `callback`: `fun()`

  Returns:

  - `ac.Disposable`
## Function ac.isLuaAppRunning(appID)
Returns `true` if a Lua app with given ID is loaded and currently active (not countring background services).

  Parameters:

  1. `appID`: `string`

  Returns:

  - `boolean`
## Function ac.getCarOptimalBrakingAmount(carIndex)
Returns an estimate of optimal braking amount based on current grip level, or -1 if it can’t be computed for a given car.

  Parameters:

  1. `carIndex`: `integer`

  Returns:

  - `number`
## Function ac.getCarMaxSpeedWithGear(carIndex, gearIndex)
Returns an estimate of maximum speed for a given gear in km/h, -1 if it can’t be computed for a given car, or 0 if there is no such gear. Returns negative
speed for the reverse gear.

  Parameters:

  1. `carIndex`: `integer`

  2. `gearIndex`: `integer` Gear index, 1 for first gear (same as `ac.getCar().gear`).

  Returns:

  - `number` Returns speed in km/h.
## Function ac.storageSetPath(relativePath, prefix)
Changes location of script storage. Scripts without I/O access will have “shared-” appended to their relative path and can’t use “.” or slashes in it
to ensure configs are contained within the directory. Note: before 0.2.4 calls to this function by scripts without I/O access would have no effect.

  Parameters:

  1. `relativePath`: `string` Path relative to directory with Lua configs. If empty, call won’t have an effect.*/.

  2. `prefix`: `string|nil` Optional prefix. Default value: `nil`.
## Function ac.broadcastSharedEvent(key, data)
Broadcasts a shared event. With shared events, different Lua scripts can exchange messages and data. Make sure to come up with
a unique name for your events to avoid collisions with other scripts and Lua apps.

Callbacks will be called next time the script is updating.

Note: if your scripts need to exchange data frequently, consider using `ac.connect()` instead, as it allows to establish a typed connection
with much less overhead.

  Parameters:

  1. `key`: `string`

  2. `data`: `serializable`

  Returns:

  - `integer` Returns number of listeners to the event with given key.
## Function ac.onSharedEvent(key, callback, processPostponed)
Subscribes to a shared event. With shared events, different Lua scripts can exchange messages and data. Make sure to come up with
a unique name for your events to avoid collisions with other scripts and Lua apps.

Callback will be called next time this script is updating.

  Parameters:

  1. `key`: `string`

  2. `callback`: `fun(data: string|number|boolean|nil, senderName: string, senderType: string, senderID: integer)`

  3. `processPostponed`: `boolean?` Set to `true` to process previously broadcasted and yet non-processed events (up to 40). Default value: `false`.

  Returns:

  - `ac.Disposable`
## Function ac.onLuaScriptDisposal(callback)

  Parameters:

  1. `callback`: `fun(senderName: string, senderType: string, senderID: integer)`

  Returns:

  - `ac.Disposable`
## Function ac.setVRHandBusy(hand, busy)

  Parameters:

  1. `hand`: `integer` 0 for left, 1 for right.

  2. `busy`: `boolean|`true`|`false`` Busy hand doesn’t have visual marks and doesn’t interact with UI and car elements.
## Function ac.setVRHandVibration(hand, frequency, amplitude, duration)

  Parameters:

  1. `hand`: `integer` 0 for left, 1 for right.

  2. `frequency`: `number`

  3. `amplitude`: `number`

  4. `duration`: `number?` Duration in seconds. Default value: 0.01.
## Function ac.isModuleActive(cspModuleID)

  Parameters:

  1. `cspModuleID`: `ac.CSPModuleID`

  Returns:

  - `boolean`
## Function ac.getPerformanceCPUAndGPUTime()

  Returns:

  - `number`
## Function ac.getCarIndexInFront(carMainIndex, distance)
Returns index of a car in front of other car (within 100 m), or -1 if there is no such car. Broken, not sure why is it even here, kept for compatibility.

  Parameters:

  1. `carMainIndex`: `integer`

  2. `distance`: `number|refnumber|nil` Default value: `nil`.

  Returns:

  - `integer`
## Function ac.getGapBetweenCars(carMainIndex, carComparingToIndex)
Calculates time gap between two cars in seconds. In race sessions uses total driven distance and main car speed, in other sessions simply
compares best lap times. If main car is ahead of comparing-to car (in front of, or has better lap time for non-race sessions), value will
be negative.

In the future implementation might change for something more precise.

  Parameters:

  1. `carMainIndex`: `integer` 0-based index.

  2. `carComparingToIndex`: `integer` 0-based index.

  Returns:

  - `number`
## Function ac.mediaCurrentPeak(output)
Returns audio peak level for the system, for left and right channels. Careful: AC audio is also included, but
it still might be used to fake some audio visualization.

  Parameters:

  1. `output`: `boolean?` Set to `false` to monitor peak from a microphone. Note: it would only work if there are other processes actually listening to audio. Default value: `true`.

  Returns:

  - `vec2`
## Function ac.store(key, value)
Stores value in session shared Lua/Python storage. This is not a long-term storage, more of a way for different scripts to exchange data.
Note: if you need to exchange a lot of data between Lua scripts, consider using ac.connect instead.

Data string can contain zeroes.

  Parameters:

  1. `key`: `string` Unique key. If starting with “.”, value won’t be shown in Lua Debug app and will be considered temporary and unimportant.

  2. `value`: `string|number|nil` Value to store. If not number or `nil`, will be converted into a string.
## Function ac.load(key)
Reads value from session shared Lua/Python storage. This is not a long-term storage, more of a way for different scripts to exchange data.
Note: if you need to exchange data between Lua scripts, use `ac.connect()` instead. And if despite that you need to exchange data between
car scripts, make sure to add car index to the key.

  Parameters:

  1. `key`: `string` Unique key. If starting with “.”, value won’t be shown in Lua Debug app and will be considered temporary and unimportant.

  Returns:

  - `string|number|nil`
## Function ac.setTextureKey(key)
Set texture key to load encoded textures.

  Parameters:

  1. `key`: `string?` Key to decode subsequently loading textures.
## Function ac.encodeTexture(filename, outputFilename, key, applyLz4Compression)
Encode texture. To load texture later, first call `ac.setTextureKey()`.

  Parameters:

  1. `filename`: `string` Input filename.

  2. `outputFilename`: `string` Should be inside of AC folder.

  3. `key`: `string?`

  4. `applyLz4Compression`: `boolean?`

  Returns:

  - `boolean` Returns `false` if file operations failed.
## Function ac.onAlbumCoverUpdate(callback)
Sets a callback which will be called when album cover changes.

  Parameters:

  1. `callback`: `fun(hasCover: boolean)`

  Returns:

  - `ac.Disposable`
## Function ac.mediaNextTrack()
Switches to the next track in currently active music player (by simulating media key press).
function ac.mediaNextTrack() end
## Function ac.mediaPreviousTrack()
Switches to the previous track in currently active music player (by simulating media key press).
function ac.mediaPreviousTrack() end
## Function ac.mediaPlayPause()
Pauses or unpauses current track in currently active music player (by simulating media key press).
function ac.mediaPlayPause() end
## Function ac.getCarSetupState()
Returns player’s car setup state.
## Function ac.console(message, withoutPrefix)
Prints message to AC console.

  Parameters:

  1. `message`: `string?`

  2. `withoutPrefix`: `boolean?` Default value: `false`.
## Function ac.areTyresLegal(name)
Returns `false` if tyres with this short name are illegal in this race. Note: if all of car tyres are illegal, all of them will be legal.

  Parameters:

  1. `name`: `string`

  Returns:

  - `boolean`
## Function ac.setMessage(title, description, type, time)
Show message using AC system messages UI. Pass empty `title` and `description` to hide currently shown message, if any.

 Types:
 - Default: regular message shown on top in white text.
 - 'illegal': message about an illegal violation. Can be used to warn driver about a crucial mistake, such as lap time
being invalidated, or wear plank wear exceeding allowed limit. Doesn’t apply any penalties on its own.

  Parameters:

  1. `title`: `string`

  2. `description`: `string`

  3. `type`: `nil|'illegal'` Optional message type.

  4. `time`: `number?` Time to show message for in seconds. Default value: 5.
## Function ac.onMessage(callback)
Listen to messages, including the ones shown by `ac.setMessage()` and `ac.setIllegalMessage()`.

  Parameters:

  1. `callback`: `fun(title: string, description: string, type: nil|'illegal', time: number)`

  Returns:

  - `ac.Disposable`
## Function ac.setSystemMessage(title, description)
Use `ac.setMessage()` instead.

  Parameters:

  1. `title`: `string`

  2. `description`: `string`
## Function ac.getUnreadChatMessages()
Return the number of unread chat messages, or 0 in an offline race.

  Returns:

  - `integer`
## Function ac.getCarBlindSpot(carIndex)
Return distances to the nearest left and right cars in meters within 20 meters, or `nil` if there are no cars nearby or blind spot detection is not available for this car.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  Returns:

  - `number`
## Function ac.setClipboardText(text)
Sets given text to the clipboard.

  Parameters:

  1. `text`: `string`

  Returns:

  - `boolean` Returns `false` if failed.
## Function ac.onCarJumped(carIndex, callback)
Sets a callback which will be called when a car teleports somewhere or its state gets reset.

  Parameters:

  1. `carIndex`: `integer` 0-based car index, or -1 for an event to be called for all cars.

  2. `callback`: `fun(carIndex: integer)`

  Returns:

  - `ac.Disposable`
## Function ac.onCarColorChanged(carIndex, callback)
Sets a callback which will be called when a car’s color changes.

  Parameters:

  1. `carIndex`: `integer` 0-based car index, or -1 for an event to be called for all cars.

  2. `callback`: `fun(carIndex: integer)`

  Returns:

  - `ac.Disposable`
## Function ac.onLapCompleted(carIndex, callback)
Sets a callback which will be called when a car completes a lap. Should work for remote cars as well.

  Parameters:

  1. `carIndex`: `integer` 0-based car index, or -1 for an event to be called for all cars.

  2. `callback`: `fun(carIndex: integer, lapTime: integer, valid: boolean, cuts: integer, lapCount: integer)`

  Returns:

  - `ac.Disposable`
## Function ac.onCarCollision(carIndex, callback)
Sets a callback which will be called when a car collides with a wall or another car. Note: collisions in AC are usually lasting a few frames,
but this callback will only be called once when collision starts (or when index of a car this car collided with has changed). Use
`ac.getCar().collisionDepth` and similar to analyze the collision in detail. Works in replays as well.

  Parameters:

  1. `carIndex`: `integer` 0-based car index, or -1 for an event to be called for all cars.

  2. `callback`: `fun(carIndex: integer)`

  Returns:

  - `ac.Disposable`
## Function ac.onCSPConfigChanged(cspModuleID, callback)
Sets a callback which will be called when config for certain CSP module has changed.

  Parameters:

  1. `cspModuleID`: `ac.CSPModuleID` ID of a module to monitor.

  2. `callback`: `fun()` Callback function.

  Returns:

  - `ac.Disposable`
## Function ac.onScreenshot(callback)
Sets a callback which will be called when a new screenshot is made.

  Parameters:

  1. `callback`: `fun()`

  Returns:

  - `ac.Disposable`
## Function ac.onOpenMainMenu(callback)
Sets a callback which will be called when a command opening a certain section in main menu has been called. More types of pages might be added later.

  Parameters:

  1. `callback`: `fun(section: 'info'|'setup'|'telemetry'|'time')`

  Returns:

  - `ac.Disposable`
## Function ac.onSetupsListRefresh(callback)
Sets a callback which will be called when list of setups changes.

  Parameters:

  1. `callback`: `fun()`

  Returns:

  - `ac.Disposable`
## Function ac.onSetupFile(callback)
Sets a callback which will be called when setup is loaded or saved. Use `ac.INIConfig.currentSetup()` to load the setup.

  Parameters:

  1. `callback`: `fun(operation: 'load'|'save', filename: string)` Callback function.

  Returns:

  - `ac.Disposable`
## Function ac.areCarsColliding(car0, car1)
Works even if collisions are disabled, actually checks collider state live. Invokes ODE OPCODE computation, so don’t use too much.

  Parameters:

  1. `car0`: `integer` 0-based car index.

  2. `car1`: `integer` 0-based car index.

  Returns:

  - `boolean`
## Function ac.areShapesColliding(shape1, transform1, shape2, transform2)
Check collisions between two shapes. Note: if you want to do something like check a car against a million of powerups on a track, consider doing
some prefiltering to speed things up. For example, `ac.HashSpace()` can hugely improve performance for such case.

  Parameters:

  1. `shape1`: `integer|physics.ColliderType` First entry to check intersection with, either `physics.ColliderType` or a car index.

  2. `transform1`: `mat4x4?` Optional transform for the first entry. If not set, identity for shapes and car transform for cars.

  3. `shape2`: `integer|physics.ColliderType` Second entry to check intersection with.

  4. `transform2`: `mat4x4?` Optional transform for the second entry.

  Returns:

  - `boolean`
## Function ac.setLogSilent(value)
Stops functions like `ac.log()` from logging things into CSP log file, in case you need to log a lot. With it, you
 can use Lua Debug app to see latest log entries.

  Parameters:

  1. `value`: `boolean?` Default value: `true`.
## Function ac.clearDebug(filter)
Removes `ac.debug()` entries matching filter.

  Parameters:

  1. `filter`: `string?` Default value: `?`.
## Function io.getAttributes(filename)
Gets file attributes.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `io.FileAttributes`
## Function io.load(filename, fallbackData)
Reads file content into a string, if such file exists, otherwise returns fallback data or `nil`.

  Parameters:

  1. `filename`: `path`

  2. `fallbackData`: `string|nil` Data to return if file could not be read.

  Returns:

  - `string|nil` Returns `nil` if file couldn’t be read and there is no fallback data.
## Function io.loadAsync(filename, callback)
Reads file content into a string, if such file exists, otherwise returns fallback data or `nil`. Asynchronous version.

  Parameters:

  1. `filename`: `path`

  2. `callback`: `fun(err: string?, response: string?)`
## Function io.exists(filename)
Checks if file or directory exists. If you need to know specifically if a file or directory exists, use `io.dirExists(filename)` or `io.fileExists(filename)`.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `boolean`
## Function io.dirExists(filename)
Checks if directory exists. If there is a file in its place, it would return `false`.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `boolean`
## Function io.fileExists(filename)
Checks if file exists. If there is a directory in its place, it would return `false`.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `boolean`
## Function io.fileSize(filename)
Calculates file size in bytes. Returns -1 if there was an error.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `integer`
## Function io.creationTime(filename)
Returns creation time as number of seconds since 1970, or -1 if there was an error.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `integer`
## Function io.lastAccessTime(filename)
Returns last access time as number of seconds since 1970, or -1 if there was an error.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `integer`
## Function io.lastWriteTime(filename)
Returns last write time as number of seconds since 1970, or -1 if there was an error.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `integer`
## Function io.getParentPath(filename, level)
Returns parent path for given filename.

  Parameters:

  1. `filename`: `string`

  2. `level`: `integer?` Default value: 1.

  Returns:

  - `string`
## Function io.getFileName(filename, noExtension)
Returns file name path for given filename.

  Parameters:

  1. `filename`: `string`

  2. `noExtension`: `boolean?` Default value: `false`.

  Returns:

  - `string`
## Function io.isFileNameAcceptable(fileName)
Checks if file name is acceptable, returns `true` if there are no prohibited symbols in it (unlike `io.isFileNameAcceptable()`, does not allow slashes).

  Parameters:

  1. `fileName`: `string`

  Returns:

  - `boolean`
## Function io.isFilePathAcceptable(filename)
Checks if full file name is acceptable, returns `true` if there are no prohibited symbols in it (unlike `io.isFileNameAcceptable()`, does allow slashes).

  Parameters:

  1. `filename`: `string`

  Returns:

  - `boolean`
## Function io.findFile(filename)
Given an absolute or a relative path, find an actual absolute path. If script doesn’t have I/O access to such file, returns `nil`.

  Parameters:

  1. `filename`: `path`

  Returns:

  - `string|nil`
## Function io.loadFromZip(zipFilename, entryFilename)
Loads file from an archive as a string. Archive would remain open for some time to speed up consequent reads. If failed, returns `nil`. Alternatively,
you can pass ZIP data instead.

  Parameters:

  1. `zipFilename`: `path`

  2. `entryFilename`: `string`

  Returns:

  - `string`
## Function io.checksumSHA256(filename, callback)
Computes SHA-256 checksum of a given file, returns result in a callback.

  Parameters:

  1. `filename`: `path`

  2. `callback`: `fun(err: string, checksum: string)`
## Function io.scanZip(zipFilename)
Returns list of entry names from a ZIP-file.

  Parameters:

  1. `zipFilename`: `binary?`

  Returns:

  - `string`
## Function os.preciseClock()
Returns time in seconds from script start (with high precision).

  Returns:

  - `number` Seconds.
## Function os.onURL(mask, callback, priority)
Sets a callback which will be called when CSP itself or a CSP Lua script tries to open an URL. Return `true` if you’re handling URL, so the event would be stopped.

  Parameters:

  1. `mask`: `string` Regular expression to check URLs against of.

  2. `callback`: `fun(url: string): boolean`

  3. `priority`: `integer?` Smaller values mean script would be the last to get URL (if other scripts wouldn’t intercept it). Default value: 0.

  Returns:

  - `ac.Disposable`
## Function os.setCurrentFolder(filename)
Changes current directory. Any argument `path`, when parsed and found not to be absolute, will be resolved against current directory.
By default, uses AC root folder. Any change only applies to the current script only. Current path resets when script is reloaded.

Changes behavior of images and assets lookup as well (by default it scans script folder, CSP folder and then root folder looking for a file,
which might cause some issues and negatively affect performance).

 For scripts without I/O access, only folders script can read from can be used here.

 Note: as of 0.2.6, some API functions might still use AC root folder. This will be fixed in the future, please do not rely on this behavior!

  Parameters:

  1. `filename`: `path`

  Returns:

  - `string`
## Function os.dateGlobal(format, timestamp)
Returns formatted date. Same as `os.date()`, but returned value does not include system timezome.

  Parameters:

  1. `format`: `string`

  2. `timestamp`: `integer`

  Returns:

  - `string`
## Function os.showMessage(msg, type)
Show a popup message using good old MessageBox. Please do not use it for debugging, instead consider using `ac.log()` and `ac.debug('key', 'value')`
with in-game Lua Debug App.
Note: do not rely on this function, most likely it might be removed in the future as obstructing.

  Parameters:

  1. `msg`: `string`

  2. `type`: `integer?` Type of MessageBox according to WinAPI. Default value: 0.

  Returns:

  - `integer`
## Function os.openURL(url, invokeListeners)
Opens URL in default system browser.

  Parameters:

  1. `url`: `string`

  2. `invokeListeners`: `boolean?` Default value: `true`.
## Function ac.getRealTrackHeadingAngle()

  Returns:

  - `number`
## Function ac.getTimeZoneOffset()

  Returns:

  - `number`
## Function ac.getTimeZoneDstOffset()

  Returns:

  - `number`
## Function ac.getTimeZoneBaseOffset()

  Returns:

  - `number`
## Function ac.getConditionsSet()
Returns original weather conditions without any filtering or sanity checks. For a faster and more filtered data check `ac.getSim().weatherConditions`.

  Returns:

  - `ac.ConditionsSet`
## Function ac.getConditionsSetTo(r)
Returns original weather conditions without any filtering or sanity checks. For a faster and more filtered data check `ac.getSim().weatherConditions`.

  Parameters:

  1. `r`: `ac.ConditionsSet`
## Function ac.getTrackDateTime()
Returns floading point number of seconds since 1970/01/01 that can be used for driving track animations in such a way that if time multiplier is set to
0 or above 1, things would still happen at normal speed, although out of sync with the clock. Ensures to keep things online as well. Currently might not
work that well with replays, futher updates will improve some edge cases.

Note: if time is still being estimated, returns 0, be sure to check for that case.

  Returns:

  - `number`
## Function ac.getSimState()
Use `ac.getSim()` instead

  Returns:

  - `ac.StateSim`
## Function ac.getUiState()
Use `ac.getUI()` instead

  Returns:

  - `ac.StateUi`
## Function ac.getCarState(index)
Use `ac.getCar()` instead. Here, index starts with 1! With `ac.getCar()` index starts with 0, to match the rest of API functions

  Parameters:

  1. `index`: `integer` 1-based index.

  Returns:

  - `ac.StateCar`
## Function ac.getSim()
Returns reference to a structure with various information about the state of Assetto Corsa. Very cheap to use.
 This is a new version with shorter name. Updates once per graphics frame.

  Returns:

  - `ac.StateSim`
## Function ac.getSession(index)
Returns reference to a structure with various information about certain session. Very cheap to use. Note: not all data
 might be available online.

  Parameters:

  1. `index`: `integer` 0-based index.

  Returns:

  - `ac.StateSession`
## Function ac.getUI()
Returns reference to a structure with various information about the state of the UI. Very cheap to use.
This is a new version with shorter name. Updates once per graphics frame.

Note: this information is about AC UI, not about, for example, a dynamic track texture you might be updating.

  Returns:

  - `ac.StateUi`
## Function ac.getTripleConfiguration()
Returns data regarding current triple screen configuration. If AC is not launched in triple screen mode, returns `nil` instead.

  Returns:

  - `ac.StateTriple`
## Function ac.getVR()
Returns reference to a structure with VR-related values, like hands and head positions. Very cheap to use.

Note: currently, accurate values are available with Oculus only.

  Returns:

  - `ac.StateVR`
## Function ac.getTrackIR()
Returns reference to a structure with TrackIR-related values. Very cheap to use.

  Returns:

  - `ac.StateTrackir`
## Function ac.getCarPhysics(index)
Returns additional details on physics state of a car. Not available in replays or for remote cars.

Updates once a frame at graphics rate. If you’re writing a physics script, consider using something else if you need
to access current state, this thing might be a few physics frames late.

Note: index starts with 0. Make sure to check result for `nil` if you’re accessing a car that might not be there. First car
with index 0 is always there.

  Parameters:

  1. `index`: `integer` 0-based index.

  Returns:

  - `ac.StateCarPhysics`
## Function ac.getDualSense(gamepadIndex)
Returns extras of PS5 DualSense gamepad, such as accelerometer, gyroscope or battery state. Accelerometer and gyroscope values might be different from values reported by `ac.getDualShock()` for different controllers in the same orientation.
Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.

  Parameters:

  1. `gamepadIndex`: `integer` 0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).

  Returns:

  - `ac.StateDualsense`
## Function ac.setDualSense(gamepadIndex, priority, holdFor)
Returns a structure with state of PS5 DualSense LEDs, change it to alter its state. Changes remain for some time, keep calling it for continuos adjustments.
Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.

  Parameters:

  1. `gamepadIndex`: `integer` 0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).

  2. `priority`: `number?` If multiple scripts try to set LEDs at the same time, the call with highest priority will be applied. Default value: 0.

  3. `holdFor`: `number?` Time to keep the changes for in seconds. Default value: 0.5.

  Returns:

  - `ac.StateDualsenseOutput`
## Function ac.getDualShock(gamepadIndex)
Returns extras of PS4 DualShock gamepad (or Nintendo gamepads), such as accelerometer, gyroscope or battery state. Accelerometer and gyroscope values might be different from values reported by `ac.getDualSense()` for different controllers in the same orientation.
Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.

  Parameters:

  1. `gamepadIndex`: `integer` 0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).

  Returns:

  - `ac.StateDualshock`
## Function ac.setDualShock(gamepadIndex, priority, holdFor)
Returns a structure with state of PS4 DualShock (or Nintendo) LEDs, change it to alter its state. Changes remain for some time, keep calling it for continuos adjustments.
Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.

  Parameters:

  1. `gamepadIndex`: `integer` 0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).

  2. `priority`: `number?` If multiple scripts try to set LEDs at the same time, the call with highest priority will be applied. Default value: 0.

  3. `holdFor`: `number?` Time to keep the changes for in seconds. Default value: 0.5.

  Returns:

  - `ac.StateDualshockOutput`
## Function ac.setXbox(gamepadIndex, priority, holdFor)
Returns a structure with state of Xbox One gamepad, change it to alter its state. Changes remain for some time, keep calling it for continuos adjustments.
Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.

  Parameters:

  1. `gamepadIndex`: `integer` 0-based index, from 0 to 3.

  2. `priority`: `number?` If multiple scripts try to set LEDs at the same time, the call with highest priority will be applied. Default value: 0.

  3. `holdFor`: `number?` Time to keep the changes for in seconds. Default value: 0.5.

  Returns:

  - `ac.StateXboxOutput`
## Function physics.getPointVelocity(carIndex, position, posLocal)
Returns velocity (in world coordinates) of a car point. If there is no such car or physics currently available, returns vector with zeroes.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `position`: `vec3` Point of force application.

  3. `posLocal`: `boolean|`true`|`false`` If `true`, position is treated like position relative to car coordinates, otherwise as world position.

  Returns:

  - `vec3`
## Function physics.getExtendedSuspensionTravel(carIndex, corner)

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `corner`: `integer` 0-based wheel index.

  Returns:

  - `number`
## Function physics.getExtendedDamperTravel(carIndex, corner)

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `corner`: `integer` 0-based wheel index.

  Returns:

  - `number`
## Class ac.StateWheel
## Class ac.StateCar
## Class ac.StateLeaderboardEntry
## Class ac.StateSession
## Class ac.StateWheelPhysics
## Class ac.StateWingPhysics
## Class ac.StateCarPhysics
## Class ac.StateSim
## Class ac.StateUi
## Class ac.StateTripleItem
## Class ac.StateTriple
## Class ac.StateVRHand
## Class ac.StateVR
## Class ac.StateTrackir
## Class ac.StateDualsenseTouch
## Class ac.StateDualsense
## Class ac.StateDualsenseOutput
## Class ac.StateDualshockTouch
## Class ac.StateDualshock
## Class ac.StateDualshockOutput
## Class ac.StateXboxOutput

# Module common/debug.lua

## Function ac.debug(key, value)
Displays value in Lua Debug app, great for tracking state of your values live.

  Parameters:

  1. `key`: `string`

  2. `value`: `any?`
## Function ac.log(...)
Prints a message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.log(...) end
## Function ac.warn(...)
Prints a warning message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.warn(...) end
## Function ac.error(...)
Prints an error message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.error(...) end
## Function print(...)
For compatibility, acts similar to `ac.log()`.
function print(...) end

# Module common/common_base.lua

## Function try(fn, catch, finally)
Calls a function in a safe way, catching errors. If any errors were to occur, `catch` would be
called with an error message as an argument. In either case (with and without error), if provided,
`finally` will be called.

Does not raise errors unless errors were thrown by `catch` or `finally`. Before CSP 0.2.5, if `catch`
throws an error, `finally` wouldn’t be called (fixed in 0.2.5).

  Parameters:

  1. `fn`: `fun(): T?`

  2. `catch`: `fun(err: string)|nil` If not set, error won’t propagate anyway.

  3. `finally`: `fun()|nil`

  Returns:

  - `T|nil`
## Function using(fn, dispose)
Calls a function and then calls `dispose` function. Note: `dispose` function will be called even if
there would be an error in `fn` function. But error would not be contained and will propagate.

Any error thrown by `fn()` will be raised and not captured, but `dispose()` will be called either way.

  Parameters:

  1. `fn`: `fun(): T?`

  2. `dispose`: `fun()?` CSPs before 0.2.5 require non-nil argument.

  Returns:

  - `T|nil`
## Function package.relative(path)
Resolves relative path to a Lua module (relative to Lua file you’re running this function from)
so it would be ready to be passed to `require()` function.

Note: performance might be a problem if you are calling it too much, consider caching the result.

  Parameters:

  1. `path`: `string`

  Returns:

  - `string`
## Function io.relative(path)
Resolves relative path to a file (relative to Lua file you’re running this function from)
so it would be ready to be passed to `io` functions (returns full path).

Note: performance might be a problem if you are calling it too much, consider caching the result.

  Parameters:

  1. `path`: `string`

  Returns:

  - `string`
## Function ac.fillStructWithBytes(destination, data)
Given an FFI struct and a string of data, fills struct with that data. Works only if size of struct matches size of data. Data string can contain zeroes.

  Parameters:

  1. `destination`: `T` FFI struct (type should be “cdata”).

  2. `data`: `binary` String with binary data.

  Returns:

  - `T`
## Function ac.stringToFFIStruct(src, dst, size)
Fills a string of an FFI struct with data up to a certain size. Make sure to not overfill the data.

  Parameters:

  1. `src`: `string` String to copy.

  2. `dst`: `string` A `const char[N]` field of a struct.

  3. `size`: `integer` Size of `const char[N]` field (N).

# Module common/const.lua

## Function const(value)
Does nothing, but with preprocessing optimizations inlines value as constant.

  Parameters:

  1. `value`: `T`

  Returns:

  - `T`

# Module common/ac_matrices.lua

## Function mat3x3.identity()
Creates a new neutral matrix.

  Returns:

  - `mat3x3`
## Function mat3x3(row1, row2, row3)

  Parameters:

  1. `row1`: `vec3?`

  2. `row2`: `vec3?`

  3. `row3`: `vec3?`

  Returns:

  - `mat3x3`
## Class mat3x3

- `mat3x3.identity()`

  Creates a new neutral matrix.

  Returns:

    - `mat3x3`

- `mat3x3:set(value)`

  Parameters:

    1. `value`: `mat3x3`

  Returns:

    - `mat3x3`

- `mat3x3:clone()`

  Returns:

    - `mat3x3`
## Function mat4x4.identity()
Creates a new neutral matrix.

  Returns:

  - `mat4x4`
## Function mat4x4.translation(offset)
Creates a translation matrix.

  Parameters:

  1. `offset`: `vec3`

  Returns:

  - `mat4x4`
## Function mat4x4.rotation(angle, axis)
Creates a rotation matrix.

  Parameters:

  1. `angle`: `number` Angle in radians.

  2. `axis`: `vec3`

  Returns:

  - `mat4x4`
## Function mat4x4.euler(head, pitch, roll)
Creates a rotation matrix from Euler angles in radians.

  Parameters:

  1. `head`: `number`

  2. `pitch`: `number`

  3. `roll`: `number`

  Returns:

  - `mat4x4`
## Function mat4x4.scaling(scale)
Creates a scaling matrix.

  Parameters:

  1. `scale`: `vec3`

  Returns:

  - `mat4x4`
## Function mat4x4.look(position, look, up)
Creates a look-at matrix from position and directional vectors. Ensures all vectors are properly normalized.

  Parameters:

  1. `position`: `vec3`

  2. `look`: `vec3`

  3. `up`: `vec3?` Default value: `vec3(0, 1, 0)`.

  Returns:

  - `mat4x4`
## Function mat4x4.perspective(fovY, aspect, zNear, zFar)
Creates a perspective matrix.

  Parameters:

  1. `fovY`: `number` Vertical view angle in radians.

  2. `aspect`: `number` Aspect ratio.

  3. `zNear`: `number` Near clipping plane.

  4. `zFar`: `number` Far clipping plane.

  Returns:

  - `mat4x4`
## Function mat4x4.ortho(extentMin, extentMax)
Creates an orthogonal matrix. Might act unexpected with Z values, shifting by range should help.

  Parameters:

  1. `extentMin`: `vec3`

  2. `extentMax`: `vec3`

  Returns:

  - `mat4x4`
## Function mat4x4(row1, row2, row3, row4)

  Parameters:

  1. `row1`: `vec4?`

  2. `row2`: `vec4?`

  3. `row3`: `vec4?`

  4. `row4`: `vec4?`

  Returns:

  - `mat4x4`
## Class mat4x4

- `mat4x4.identity()`

  Creates a new neutral matrix.

  Returns:

    - `mat4x4`

- `mat4x4.translation(offset)`

  Creates a translation matrix.

  Parameters:

    1. `offset`: `vec3`

  Returns:

    - `mat4x4`

- `mat4x4.rotation(angle, axis)`

  Creates a rotation matrix.

  Parameters:

    1. `angle`: `number` Angle in radians.

    2. `axis`: `vec3`

  Returns:

    - `mat4x4`

- `mat4x4.euler(head, pitch, roll)`

  Creates a rotation matrix from Euler angles in radians.

  Parameters:

    1. `head`: `number`

    2. `pitch`: `number`

    3. `roll`: `number`

  Returns:

    - `mat4x4`

- `mat4x4.scaling(scale)`

  Creates a scaling matrix.

  Parameters:

    1. `scale`: `vec3`

  Returns:

    - `mat4x4`

- `mat4x4.look(position, look, up)`

  Creates a look-at matrix from position and directional vectors. Ensures all vectors are properly normalized.

  Parameters:

    1. `position`: `vec3`

    2. `look`: `vec3`

    3. `up`: `vec3?` Default value: `vec3(0, 1, 0)`.

  Returns:

    - `mat4x4`

- `mat4x4.perspective(fovY, aspect, zNear, zFar)`

  Creates a perspective matrix.

  Parameters:

    1. `fovY`: `number` Vertical view angle in radians.

    2. `aspect`: `number` Aspect ratio.

    3. `zNear`: `number` Near clipping plane.

    4. `zFar`: `number` Far clipping plane.

  Returns:

    - `mat4x4`

- `mat4x4.ortho(extentMin, extentMax)`

  Creates an orthogonal matrix. Might act unexpected with Z values, shifting by range should help.

  Parameters:

    1. `extentMin`: `vec3`

    2. `extentMax`: `vec3`

  Returns:

    - `mat4x4`

- `mat4x4:set(value)`

  Parameters:

    1. `value`: `mat4x4`

  Returns:

    - `mat4x4`

- `mat4x4:transformVectorTo(destination, vec)`

  Parameters:

    1. `destination`: `vec3`

    2. `vec`: `vec3`

  Returns:

    - `vec3`

- `mat4x4:transformVector(vec)`

  Parameters:

    1. `vec`: `vec3`

  Returns:

    - `vec3`

- `mat4x4:transformTo(destination, vec)`

  Parameters:

    1. `destination`: `vec4`

    2. `vec`: `vec4`

  Returns:

    - `vec4`

- `mat4x4:transform(vec)`

  Parameters:

    1. `vec`: `vec4`

  Returns:

    - `vec4`

- `mat4x4:transformPointTo(destination, vec)`

  Parameters:

    1. `destination`: `vec3`

    2. `vec`: `vec3`

  Returns:

    - `vec3`

- `mat4x4:transformPoint(vec)`

  Parameters:

    1. `vec`: `vec3`

  Returns:

    - `vec3`

- `mat4x4:clone()`

  Returns:

    - `mat4x4`

- `mat4x4:inverse()`

  Creates a new matrix.

  Returns:

    - `mat4x4`

- `mat4x4:inverseSelf()`

  Modifies current matrix.

  Returns:

    - `mat4x4` Returns self for easy chaining.

- `mat4x4:normalize()`

  Creates a new matrix.

  Returns:

    - `mat4x4`

- `mat4x4:normalizeSelf()`

  Modifies current matrix.

  Returns:

    - `mat4x4` Returns self for easy chaining.

- `mat4x4:transpose()`

  Creates a new matrix.

  Returns:

    - `mat4x4`

- `mat4x4:transposeSelf()`

  Modifies current matrix.

  Returns:

    - `mat4x4` Returns self for easy chaining.

- `mat4x4:mul(other)`

  Note: unlike vector’s `:mul()`, this one creates a new matrix!

  Parameters:

    1. `other`: `mat4x4`

  Returns:

    - `mat4x4`

- `mat4x4:mulSelf(other)`

  Modifies current matrix.

  Parameters:

    1. `other`: `mat4x4`

  Returns:

    - `mat4x4` Returns self for easy chaining.

- `mat4x4:mulTo(destination, other)`

  Writes result into a separate matrix.

  Parameters:

    1. `destination`: `mat4x4`

    2. `other`: `mat4x4`

  Returns:

    - `mat4x4` Returns destination matrix.

# Module common/math.lua

## Function math.gaussianAdjustment(x, k)
Takes value with even 0…1 distribution and remaps it to recreate a distribution
similar to Gaussian’s one (with k≈0.52, a default value). Lower to make bell more
compact, use a value above 1 to get some sort of inverse distibution.

  Parameters:

  1. `x`: `number` Value to adjust.

  2. `k`: `number` Bell curvature parameter.

  Returns:

  - `number`
## Function math.poissonSamplerSquare(size, tileMode)
Builds a list of points arranged in a square with poisson distribution.

  Parameters:

  1. `size`: `integer` Number of points.

  2. `tileMode`: `boolean?` If set to `true`, resulting points would be tilable without breaking poisson distribution.

  Returns:

  - `vec2`
## Function math.poissonSamplerCircle(size)
Builds a list of points arranged in a circle with poisson distribution.

  Parameters:

  1. `size`: `integer` Number of points.

  Returns:

  - `vec2`
## Function math.randomKey()
Generates a random number in [0, INT32_MAX) range. Can be a good argument for `math.randomseed()`.

  Returns:

  - `integer`
## Function math.seededRandom(seed)
Generates random number based on a seed.

  Parameters:

  1. `seed`: `integer|boolean|string` Seed.

  Returns:

  - `number` Random number from 0 to 1.
## Function math.round(number, decimals)
Rounds number, leaves certain number of decimals.

  Parameters:

  1. `number`: `number`

  2. `decimals`: `number?` Default value: 0 (rounding to a whole number).

  Returns:

  - `integer`
## Function math.clampN(value, min, max)
Clamps a number value between `min` and `max`.

  Parameters:

  1. `value`: `number`

  2. `min`: `number`

  3. `max`: `number`

  Returns:

  - `number`
## Function math.saturateN(value)
Clamps a number value between 0 and 1.

  Parameters:

  1. `value`: `number`

  Returns:

  - `number`
## Function math.clampV(value, min, max)
Clamps a copy of a vector between `min` and `max`. To avoid making copies, use `vec:clamp(min, max)`.

  Parameters:

  1. `value`: `T`

  2. `min`: `any`

  3. `max`: `any`

  Returns:

  - `T`
## Function math.saturateV(value)
Clamps a copy of a vector between 0 and 1. To avoid making copies, use `vec:saturate()`.

  Parameters:

  1. `value`: `T`

  Returns:

  - `T`
## Function math.clamp(x, min, max)
Clamps value between `min` and `max`, returning `min` if `x` is below `min` or `max` if `x` is above `max`. Universal version, so might be slower.
Also, if given a vector or a color, would make a copy of it.

  Parameters:

  1. `x`: `T`

  2. `min`: `T|number`

  3. `max`: `T|number`

  Returns:

  - `T`
## Function math.saturate(x)
Clamps value between 0 and 1, returning 0 if `x` is below 0 or 1 if `x` is above 1. Universal version, so might be slower.
Also, if given a vector or a color, would make a copy of it.

  Parameters:

  1. `x`: `T`

  Returns:

  - `T`
## Function math.sign(x)
Returns a sing of a value, or 0 if value is 0.

  Parameters:

  1. `x`: `number`

  Returns:

  - `integer`
## Function math.lerp(x, y, mix)
Linear interpolation between `x` and `y` using `mix` (x * (1 - mix) + y * mix).

  Parameters:

  1. `x`: `T`

  2. `y`: `T`

  3. `mix`: `number`

  Returns:

  - `T`
## Function math.lerpInvSat(value, min, max)
Returns 0 if value is less than v0, returns 1 if it’s more than v1, linear interpolation in-between.

  Parameters:

  1. `value`: `number`

  2. `min`: `number`

  3. `max`: `number`

  Returns:

  - `number`
## Function math.remap(value, oldA, oldB, newA, newB)
Returns `newA` if `value` equals to `oldA`, `newB` if `value` is `oldB`, applies linear interpolation for other input values. Doesn’t apply clamping.

  Parameters:

  1. `value`: `number`

  2. `oldA`: `number`

  3. `oldB`: `number`

  4. `newA`: `number`

  5. `newB`: `number`

  Returns:

  - `number`
## Function math.smoothstep(x)
Smoothstep operation. More about it in [wiki](https://en.wikipedia.org/wiki/Smoothstep).

  Parameters:

  1. `x`: `number`

  Returns:

  - `number`
## Function math.smootherstep(x)
Like a smoothstep operation, but even smoother.

  Parameters:

  1. `x`: `number`

  Returns:

  - `number`
## Function math.normalize(x)
Creates a copy of a vector and normalizes it. Consider using a method `vec:normalize()` instead when you can change the original vector to save on performanceMeter.

  Parameters:

  1. `x`: `T`

  Returns:

  - `T`
## Function math.cross(x, y)
Creates a copy of a vector and runs a cross product on it. Consider avoiding making a copy with `vec:cross(otherVec)`.

  Parameters:

  1. `x`: `vec3`

  Returns:

  - `vec3`
## Function math.dot(x, y)
Calculates dot product of two vectors.

  Parameters:

  1. `x`: `vec2|vec3|vec4`

  Returns:

  - `number`
## Function math.angle(x, y)
Calculates angle between vectors in radians.

  Parameters:

  1. `x`: `vec2|vec3|vec4`

  Returns:

  - `number` Radians.
## Function math.distance(x, y)
Calculates distance between vectors.

  Parameters:

  1. `x`: `vec2|vec3|vec4`

  Returns:

  - `number`
## Function math.distanceSquared(x, y)
Calculates squared distance between vectors (slightly faster without taking a square root).

  Parameters:

  1. `x`: `vec2|vec3|vec4`

  Returns:

  - `number`
## Function math.project(x, y)
Creates a copy of a vector and projects it onto a different vector. Consider avoiding making a copy with `vec:project(otherVec)`.

  Parameters:

  1. `x`: `T`

  Returns:

  - `T`
## Function math.radians(x)
## Function math.degress(x)
## Function math.isnan(x)
Checks if value is not-a-number.

  Parameters:

  1. `x`: `number`

  Returns:

  - `boolean`
## Function math.isinf(x)
Checks if value is positive or negative infinity.

  Parameters:

  1. `x`: `number`

  Returns:

  - `boolean`
## Function math.isfinite(x)
Checks if value is finite (not infinite or nan).

  Parameters:

  1. `x`: `number`

  Returns:

  - `boolean`
## Function math.isNaN(x)
## Function math.lagMult(lag, dt)

  Parameters:

  1. `lag`: `number`

  2. `dt`: `number`

  Returns:

  - `number`
## Function math.perlin(input, octaves, persistence)
Perlin noise for given input. Returns value within -1…1 range, or outside of it if `octaves` is above 1. If you’re using octaves, make sure `input`
won’t overflow when being multiplied by two multiple times.

Consider using `math.simplex` instead, it might be a better alternative.

  Parameters:

  1. `input`: `number|vec2|vec3`

  2. `octaves`: `integer?` Pass number greater than 1 to generate octave noise instead (sum `octaves` noise functions together increasing input and multiplying amplitude by `persistence` each step). Default value: 1.

  3. `persistence`: `number?` Persistance for octave noise. Used only if `octaves` is above 1. Default value: 0.5.

  Returns:

  - `number`
## Function math.simplex(input, octaves, lacunarity, persistence)
Simplex noise for given input. Returns value within -1…1 range (unlike `math.perlin`, always). If you’re using octaves, make sure `input`
won’t overflow when being multiplied by two multiple times.

  Parameters:

  1. `input`: `number|vec2|vec3`

  2. `octaves`: `integer?` Pass number greater than 1 to generate octave noise instead (sum `octaves` noise functions together increasing input and multiplying amplitude by `persistence` each step). Default value: 1.

  3. `lacunarity`: `number?` Frequency increase for subsequent octaves. Used only if `octaves` is above 1. Default value: 2.

  4. `persistence`: `number?` Persistance for octave noise. Used only if `octaves` is above 1. Usually set to `1 / lacunarity`. Default value: 0.5.

  Returns:

  - `number`
## Function math.convertHDR(input, toLDR)
Roughly convert HDR value to LDR using conversion hints provided by current WeatherFX style. Doesn’t apply nothing like tonemapping or exposure
correction, simply adjusts for a case where WeatherFX style uses small brightness multiplier or linear color space.

Note: shaders have the same function called `convertHDR()`.

  Parameters:

  1. `input`: `T` Value to convert.

  2. `toLDR`: `boolean?` Pass `true` to do the reverse and convert LDR to HDR. Default value: `false`.

  Returns:

  - `T`
## Function math.applyLag(value, target, lag, dt)

  Parameters:

  1. `value`: `T`

  2. `target`: `T`

  3. `lag`: `number`

  4. `dt`: `number`

  Returns:

  - `T`

# Module common/string.lua

## Function string.dump() return nil
Function won’t work: while CSP tries its best to guarantee API compatibility, ABI compatibility is not a priority at all,
and the underlying LuaJIT implementation frequently changes and might even be replaced with something else in the future.

  Returns:

  - `nil`
## Function string.split(self, separator, limit, trimResult, skipEmpty, splitByAnyChar)
Splits string into an array using separator.

  Parameters:

  1. `self`: `string` String to split.

  2. `separator`: `string?` Separator. If empty, string will be split into individual characters. Default value: ` `.

  3. `limit`: `integer?` Limit for pieces of string. Once reached, remaining string is put as a list piece.

  4. `trimResult`: `boolean?` Set to `true` to trim found strings. Default value: `false`.

  5. `skipEmpty`: `boolean?` Set to `false` to keep empty strings. Default value: `true` (for compatibility reasons).

  6. `splitByAnyChar`: `boolean?` Set to `true` to split not by a string `separator`, but by any characters in `separator`.

  Returns:

  - `string`
## Function string.numbers(self, limit)
Splits string into a bunch of numbers (not in an array). Any symbol that isn’t a valid part of number is considered to be a delimiter. Does not create an array
to keep things faster. To make it into an array, simply wrap the call in `{}`.

  Parameters:

  1. `self`: `string` String to split.

  2. `limit`: `integer?` Limit for amount of numbers. Once reached, remaining part is ignored.

  Returns:

  - `...` Numbers
## Function string.pack(self, ...)
Pack things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
Use `a` for half-precision floating point value (two bytes).

  Parameters:

  1. `self`: `string` Format string.

  Returns:

  - `string`
## Function string.packsize(self)
Measure size of packed things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
Use `a` for half-precision floating point value (two bytes).

  Parameters:

  1. `self`: `string` Format string.

  Returns:

  - `integer`
## Function string.unpack(self)
Unpack things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
Use `a` for half-precision floating point value (two bytes).

  Parameters:

  1. `self`: `string` Format string.

  Returns:

  - `...`
## Function string.urlCheck(self, offset)
Checks if string starts with an URL or not. Uses flexible parsing scheme so even URLs not starting with
a scheme could be found.

  Parameters:

  1. `self`: `string` Target string.

  2. `offset`: `integer?` Starting search index, 1-based.

  Returns:

  - `integer`
## Function string.urlNext(self, offset)
Finds next URL in a string. Uses flexible parsing scheme so even URLs not starting with
a scheme could be found.

  Parameters:

  1. `self`: `string` Target string.

  2. `offset`: `integer?` Starting search index, 1-based.

  Returns:

  1. `integer`

  2. `integer`
## Function string.findIgnoreCase(self, needle, index)
Works like string.find with plain mode, but ignores case.

  Parameters:

  1. `self`: `string` String to find `needle` in.

  2. `needle`: `string` String to find.

  3. `index`: `integer?` Starting search index. Default value: `1`.

  Returns:

  - `integer`
## Function string.replace(self, replacee, replacer, limit, ignoreCase)
Searches and replaces all the substrings.

  Parameters:

  1. `self`: `string` String to find `replacee` and replace with `replacer` in.

  2. `replacee`: `string` String to find.

  3. `replacer`: `string?` String to replace. Default value: ``.

  4. `limit`: `integer?` Maximum number of found strings to replace. Default value: `math.huge`.

  5. `ignoreCase`: `boolean?` Option for case-incensitive search. Default value: `false`.

  Returns:

  - `string`
## Function string.codePointToUTF8(codePoint)
Returns UTF8 string for a corresponding code point.

  Parameters:

  1. `codePoint`: `integer`

  Returns:

  - `string`
## Function string.codePointAt(self, start)
Returns unicode codepoint and length in bytes from a point in a string. Throws an error with invalid UTF-8.

  Parameters:

  1. `self`: `string` String to get a codepoint from

  2. `start`: `integer` Index (starts with 1, if below counts from the end).

  Returns:

  1. `integer`

  2. `integer` Symbol length (or `nil` if there is no symbol with given index).
## Function string.nextEmoji(self, start)
Looks for a next emoji in the string. If next emoji is complex, all the symbols will be processed and returned as a single byte sequence. Uses 15th version
with data from Emoji Keyboard/Display Test Data for UTS #51.
Not working properly for CSP versions below v0.2.3-preview50.

  Parameters:

  1. `self`: `string` String to search emojis in.

  2. `start`: `integer` Index (starts with 1, if below counts from the end).

  Returns:

  1. `integer`

  2. `integer`
## Function string.urlEncode(self, plusForSpaces)
Encodes URL argument.

  Parameters:

  1. `self`: `string`

  2. `plusForSpaces`: `boolean?` Use `'+'` for space symbol (works for URLs, but if a regular URL encoding is needed, might be getting in a way). Default value: `true`.

  Returns:

  - `string`
## Function string.startsWith(self, another, offset)
Checks if the beginning of a string matches another string. If string to match is longer than the first one, always returns `false`.

  Parameters:

  1. `self`: `string` String to check the beginning of.

  2. `another`: `string` String to match.

  3. `offset`: `integer?` Optional offset for the matching beginning. Default value: `0`.

  Returns:

  - `boolean`
## Function string.endsWith(self, another, offset)
Checks if the end of a string matches another string. If string to match is longer than the first one, always returns `false`.

  Parameters:

  1. `self`: `string` String to check the end of.

  2. `another`: `string` String to match.

  3. `offset`: `integer?` Optional offset for the matching end. Default value: `0`.

  Returns:

  - `boolean`
## Function string.alphanumCompare(self, another)
Compares string alphanumerically.

  Parameters:

  1. `self`: `string` First string.

  2. `another`: `string` Second string.

  Returns:

  - `integer` Returns positive number if first string is larger than second one, or 0 if strings are equal.
## Function string.versionCompare(self, another)
Compares string as versions (splits by dots and uses alphanumerical comparator for each piece).

  Parameters:

  1. `self`: `string` First version.

  2. `another`: `string` Second version.

  Returns:

  - `integer` Returns positive number if first version is newer than second one, or 0 if versions are equal.
## Function string.trim(self, characters, direction)
Trims string at beginning and end.

  Parameters:

  1. `self`: `string` String to trim.

  2. `characters`: `string?` Characters to remove. Default value: `'\n\r\t '`.

  3. `direction`: `integer?` Direction to trim, 0 for trimming both ends, -1 for trimming beginning only, 1 for trimming the end. Default value: `0`.

  Returns:

  - `string`
## Function string.multiply(self, count)
Repeats string a given number of times (`repeat` is a reserved keyword, so here we are).

  Parameters:

  1. `self`: `string` String to trim.

  2. `count`: `integer` Number of times to repeat the string.

  Returns:

  - `string`
## Function string.pad(self, targetLength, pad, direction)
Pads string with symbols from `pad` until it reaches the desired length.

  Parameters:

  1. `self`: `string` String to trim.

  2. `targetLength`: `integer` Desired string length. If shorter than current length, string will be trimmed from the end.

  3. `pad`: `string?` String to pad with. If empty, no padding will be performed. If has more than one symbol, will be repeated to fill the space. Default value: ` ` (space).

  4. `direction`: `integer?` Direction to pad to, 1 for padding at the end, -1 for padding at the start, 0 for padding from both ends centering string. Default value: `1`.

  Returns:

  - `string`
## Function string.regfind(self, pattern, init, ignoreCase)
Similar to `string.find()`: looks for the first match of `pattern` and returns indices, but uses regular expressions.

Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.

  Parameters:

  1. `self`: `string` String to search in.

  2. `pattern`: `string` Regular expression.

  3. `init`: `integer?` 1-based offset to start searching from. Default value: `1`.

  4. `ignoreCase`: `boolean?` Set to `true` to make search case-insensitive. Default value: `false`.

  Returns:

  1. `integer`

  2. `integer`

  3. `...` Captured elements, if there are any capture groups in the pattern.
## Function string.regmatch(self, pattern, init, ignoreCase)
Similar to `string.match()`: looks for the first match of `pattern` and returns matches, but uses regular expressions.

Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.

  Parameters:

  1. `self`: `string` String to search in.

  2. `pattern`: `string` Regular expression.

  3. `init`: `integer?` 1-based offset to start searching from. Default value: `1`.

  4. `ignoreCase`: `boolean?` Set to `true` to make search case-insensitive. Default value: `false`.

  Returns:

  - `string` Captured elements if there are any capture groups in the pattern, or the whole captured string otherwise.
## Function string.reggmatch(self, pattern, ignoreCase)
Similar to `string.gmatch()`: iterates over matches of `pattern`, but uses regular expressions.

Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.

  Parameters:

  1. `self`: `string` String to search in.

  2. `pattern`: `string` Regular expression.

  3. `ignoreCase`: `boolean?` Set to `true` to make search case-insensitive. Default value: `false`.

  Returns:

  - `fun`
## Function string.reggsub(self, pattern, repl, limit, ignoreCase)
Similar to `string.gsub()`: replaces all entries of `pattern` with `repl`, but uses regular expressions.

Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.

  Parameters:

  1. `self`: `string` String to search in.

  2. `pattern`: `string` Regular expression.

  3. `limit`: `integer?` Limit maximum number of replacements. Default value: `math.huge`.

  4. `ignoreCase`: `boolean?` Set to `true` to make search case-insensitive. Default value: `false`.

  Returns:

  - `string` String with found entries replaced.
## Function string.cspmatch(self, filter, init)
Compares a string against CSP-style filter (using “?” for “any characters”).

  Parameters:

  1. `self`: `string` String to check.

  2. `filter`: `string` Filter to check. Surround with `{…}` to use complex queries, for example, `'{ ABC? & ! ?DEF }'`.

  3. `init`: `integer?` 1-based offset to start searching from. Default value: `1`.

  Returns:

  - `boolean`

# Module common/table.lua

## Function table.chain(table, ...)
Merges tables into one big table. Tables can be arrays or dictionaries, if it’s a dictionary same keys from subsequent tables will overwrite previously set keys.

  Parameters:

  1. `table`: `T`

  Returns:

  - `T`
## Function table.isArray(t)
Checks if table is an array or not. Arrays are tables that only have consecutive numeric keys. If this function returns `true`, it doesn’t mean
underlying LuaJIT structure is exactly a dense array, but it does mean that it could be. For example, `{[2]=2, [1]=1}` is not a dense array from
LuaJIT POV, but semantically it is, and so `table.isArray()` would return `true`.

  Parameters:

  1. `t`: `table|any[]`

  Returns:

  - `boolean`
## Function table.new(arrayElements, mapElements)
Creates a new table with preallocated space for given amount of elements.

  Parameters:

  1. `arrayElements`: `integer` How many elements the table will have as a sequence.

  2. `mapElements`: `integer` How many other elements the table will have.

  Returns:

  - `table`
## Function table.clear(t)
Cleares table without deallocating space using a fast LuaJIT call. Can work
with both array and non-array tables.

  Parameters:

  1. `t`: `table`
## Function table.nkeys(t)
Returns the total number of elements in a given Lua table (i.e. from both the array and hash parts combined).

  Parameters:

  1. `t`: `table`

  Returns:

  - `integer`
## Function table.clone(t, deep)
Clones table using a fast LuaJIT call. Doesn’t clone any vectors or colors inside, but it is fast.

  Parameters:

  1. `t`: `T`

  2. `deep`: `nil|boolean|'full'` Set to `true` for deep cloning. Default value: `false`. Since 0.2.10, set to `'full'` to clone vectors or colors as well.

  Returns:

  - `T`
## Function table.removeItem(t, item)
Removes first item by value, returns true if any item was removed. Can work
with both array and non-array tables.

  Parameters:

  1. `t`: `table<any, T>`

  2. `item`: `T`

  Returns:

  - `boolean`
## Function table.getOrCreate(t, key, callback, callbackData)
Returns an element from table with a given key. If there is no such element, calls callback
and uses its return value to add a new element and return that. Can work
with both array and non-array tables.

  Parameters:

  1. `t`: `table<any, T>`

  2. `key`: `any`

  3. `callback`: `fun(callbackData: TCallbackData): T`

  4. `callbackData`: `TCallbackData?`

  Returns:

  - `T`
## Function table.contains(t, item)
Returns true if table contains an item. Can work with both array and non-array tables.

  Parameters:

  1. `t`: `table<any, T>`

  2. `item`: `T`

  Returns:

  - `boolean`
## Function table.random(t, filteringCallback, filteringCallbackData, randomDevice)
Returns a random item from a table. Optional callback works like a filter. Can work
with both array and non-array tables. Alternatively, optional callback can provide a number
for a weight of an item.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `filteringCallback`: `nil|fun(item: T, key: TKey, callbackData: TCallbackData): boolean`

  3. `filteringCallbackData`: `TCallbackData?`

  4. `randomDevice`: `nil|fun(): number` Optional callback for generating random numbers. Needs to return a value between 0 and 1. If not set, default `math.random` is used.

  Returns:

  - `T`
## Function table.indexOf(t, item)
Returns a key of a given element, or `nil` if there is no such element in a table. Can work
with both array and non-array tables.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `item`: `T`

  Returns:

  - `TKey|nil`
## Function table.same(t1, t2, deep)
Returns true if tables contents are the same.

  Parameters:

  1. `t1`: `table?`

  2. `t2`: `table?`

  3. `deep`: `boolean?` Default value: `true`.

  Returns:

  - `boolean`
## Function table.join(t, itemsJoin, keyValueJoin, toStringCallback, toStringCallbackData)
Joins elements of a table to a string, works with both arrays and non-array tables. Optinal
toStringCallback parameter can be used for a custom item serialization. All parameters but
`t` (for actual table) are optional and can be skipped.

Note: it wouldn’t work as fast as `table.concat`, but it would call a `tostring()` (or custom
serializer callback) for each element.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `itemsJoin`: `string?` Default value: ','.

  3. `keyValueJoin`: `string?` Default value: '='.

  4. `toStringCallback`: `nil|fun(item: T, key: TKey, callbackData: TCallbackData): string`

  5. `toStringCallbackData`: `TCallbackData?`

  Returns:

  - `TKey|nil`
## Function table.slice(t, from, to, step)
Slices array, basically acts like slicing thing in Python.

  Parameters:

  1. `t`: `T[]`

  2. `from`: `integer` Starting index.

  3. `to`: `integer?` Ending index.

  4. `step`: `integer?` Step.

  Returns:

  - `T`
## Function table.reverse(t)
Flips table from back to front, requires an array.

  Parameters:

  1. `t`: `T[]`

  Returns:

  - `T`
## Function table.map(t, callback, callbackData)
Calls callback function for each of table elements, creates a new table containing all the resulting values.
Can work with both array and non-array tables. For non-array tables, new table is going to be an array unless
callback function would return a key as a second return value.

If callback returns two values, second would be used as a key to create a table-like table (not an array-like one).

Note: if callback returns `nil`, value will be skipped, so this function can act as a filtering one too.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `(fun(item: T, index: TKey, callbackData: TCallbackData): TReturnValue, TReturnKey?)|nil` Mapping callback.

  3. `callbackData`: `TCallbackData?`
## Function table.reduce(t, startingValue, callback, callbackData)
Calls callback function for each of table elements, creates a new table containing all the resulting values.
Can work with both array and non-array tables. For non-array tables, new table is going to be an array unless
callback function would return a key as a second return value.

If callback returns two values, second would be used as a key to create a table-like table (not an array-like one).

Note: if callback returns `nil`, value will be skipped, so this function can act as a filtering one too.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `startingValue`: `TData`

  3. `callback`: `fun(data: TData, item: T, index: TKey, callbackData: TCallbackData): TData` Reduction callback.

  4. `callbackData`: `TCallbackData?`

  Returns:

  - `TData`
## Function table.filter(t, callback, callbackData)
Creates a new table from all elements for which filtering callback returns true. Can work with both
array and non-array tables.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `fun(item: T, index: TKey, callbackData: TCallbackData): any` Filtering callback.

  3. `callbackData`: `TCallbackData?`
## Function table.every(t, callback, callbackData)
Returns true if callback returns non-false value for every element of the table. Can work with both
array and non-array tables.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `fun(item: T, index: TKey, callbackData: TCallbackData): boolean`

  3. `callbackData`: `TCallbackData?`

  Returns:

  - `boolean`
## Function table.some(t, callback, callbackData)
Returns true if callback returns non-false value for at least a single element of the table. Can work
with both array and non-array tables.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `fun(item: T, index: TKey, callbackData: TCallbackData): boolean`

  3. `callbackData`: `TCallbackData?`

  Returns:

  - `boolean`
## Function table.count(t, callback, callbackData)
Counts number of elements for which callback returns non-false value. Can work
with both array and non-array tables.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `nil|fun(item: T, index: TKey, callbackData: TCallbackData): boolean` If not set, all elements will be counted.

  3. `callbackData`: `TCallbackData?`

  Returns:

  - `integer`
## Function table.sum(t, callback, callbackData)
Calls callback for each element, returns sum of returned values. Can work
with both array and non-array tables. If callback is missing, sums actual values in table.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `fun(item: T, index: TKey, callbackData: TCallbackData): boolean`

  3. `callbackData`: `TCallbackData?`

  Returns:

  - `integer`
## Function table.findFirst(t, callback, callbackData)
Returns first element and its key for which callback returns a non-false value. Can work
with both array and non-array tables. If nothing is found, returns `nil`.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `fun(item: T, index: TKey, callbackData: TCallbackData): boolean`

  3. `callbackData`: `TCallbackData?`

  Returns:

  - `T`
## Function table.findByProperty(t, key, value)
Returns first element and its key for which a certain property matches the value. If nothing is
found, returns `nil`.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `key`: `string`

  3. `value`: `any`

  Returns:

  - `T`
## Function table.maxEntry(t, callback, callbackData)
Returns an element and its key for which callback would return the highest numerical value. Can work
with both array and non-array tables. If callback is missing, actual table elements will be compared.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `fun(item: T, index: TKey, callbackData: TCallbackData): number`

  3. `callbackData`: `TCallbackData?`

  Returns:

  - `T`
## Function table.minEntry(t, callback, callbackData)
Returns an element and its key for which callback would return the lowest numerical value. Can work
with both array and non-array tables. If callback is missing, actual table elements will be compared.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `fun(item: T, index: TKey, callbackData: TCallbackData): number`

  3. `callbackData`: `TCallbackData?`

  Returns:

  - `T`
## Function table.forEach(t, callback, callbackData)
Runs callback for each item in a table. Can work with both array and non-array tables.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `fun(item: T, key: TKey, callbackData: TCallbackData)`

  3. `callbackData`: `TCallbackData?`

  Returns:

  - `table`
## Function table.distinct(t, callback, callbackData)
Creates a new table with unique elements from original table only. Optionally, a callback
can be used to provide a key which uniqueness will be checked. Can work with both array
and non-array tables.

  Parameters:

  1. `t`: `{[TKey]: T}`

  2. `callback`: `nil|fun(item: T, key: TKey, callbackData: TCallbackData): any`

  3. `callbackData`: `TCallbackData?`
## Function table.findLeftOfIndex(t, testCallback, testCallbackData)
Finds first element for which `testCallback` returns true, returns index of an element before it.
Elements should be ordered in such a way that there would be no more elements returning false to the right
of an element returning true.

If `testCallback` returns true for all elements, would return 0. If `testCallback` returns false for all,
returns index of the latest element.

  Parameters:

  1. `t`: `T[]`

  2. `testCallback`: `fun(item: T, index: integer, callbackData: TCallbackData): boolean`

  3. `testCallbackData`: `nil|TCallbackData`

  Returns:

  - `integer`
## Function table.assign(target, ...)
Similar to JavaScript’s `Object.assign()`, works with tables and arrays, returns first argument (modified).

  Parameters:

  1. `target`: `T`

  2. `...`: `table`

  Returns:

  - `T`
## Function table.flatten(t, maxLevel)
Flattens table similar to JavaScript function with the same name. Requires an array.

  Parameters:

  1. `t`: `any[]`

  2. `maxLevel`: `integer?` Default value: 1.

  Returns:

  - `any`
## Function table.range(endingIndex, startingIndex, step, callback, callbackData)
Creates a new table running in steps from `startingIndex` to `endingIndex`, including `endingIndex`.
If callback returns two values, second value is used as a key.

  Parameters:

  1. `endingIndex`: `integer?`

  2. `startingIndex`: `integer`

  3. `step`: `integer?`

  4. `callback`: `fun(index: integer, callbackData: TCallbackData): T, integer|string?`

  5. `callbackData`: `TCallbackData?`

  Returns:

  - `T`
## Function table.build(iterator, k, v)
Creates a new table from iterator. Supports iterators returning one or two values (if two values are returned, first is considered the key,
if not, values are simply added to a list).

  Parameters:

  1. `iterator`: `fun(...): T`

  Returns:

  - `T`

# Module common/io.lua

## Class io.FileAttributes
Structure containing various file or directory attributes, including various flags and dates. All values are precomputed and ready to be used (there is
no overhead in accessing them once you get the structure).
## Function io.scanDir(directory, mask, callback, callbackData)
Scan directory and call callback function for each of files, passing file name (not full name, but only name of the file) and attributes. If callback function would return
a non-nil value, iteration will stop and value returned by callback would return from this function. This could be used to
find a certain file without going through all files in the directory. Optionally, a mask can be used to pre-filter received files
entries.

If callback function is not provided, it’ll return list of files instead (file names only).

System entries “.” and “..” will not be included in the list of files. Accessing attributes does not add extra cost.

  Parameters:

  1. `directory`: `string` Directory to look for files in. Note: directory is relative to current directory, not to script directory. For AC in general it’s an AC root directory, but do not rely on it, instead use `ac.getFolder(ac.FolderID.Root)`.

  2. `mask`: `string?` Mask in a form of usual “*.*”. Default value: '*'.

  3. `callback`: `fun(fileName: string, fileAttributes: io.FileAttributes, callbackData: TCallbackData): TReturn?` Callback which will be ran for every file in directory fitting mask until it would return a non-nil value.

  4. `callbackData`: `TCallbackData?` Callback data that will be passed to callback as third argument, to avoid creating a capture.

  Returns:

  - `TReturn`

# Module common/os.lua

## Class os.ConsoleProcessResult
## Function os.parseDate(date, format)
Parse date and return a unix timestamp. Uses `std::get_time()` for actual parsing:
<https://en.cppreference.com/w/cpp/io/manip/get_time>.

  Parameters:

  1. `date`: `string` String containing date.

  2. `format`: `string?` Format string. Default value: `'%Y-%m-%dT%H:%M:%S'`.

  Returns:

  - `integer`
## Function os.openFileDialog(params, callback)
Opens regular Windows file opening dialog, calls callback with either an error or a path to a file selected by user
(or nil if selection was cancelled). All parameters in `params` table are optional (the whole table too).

  Parameters:

  1. `params`: `{title: string, defaultFolder: nil|string, folder: string, fileName: string, fileTypes: nil|{` name: string, mask: string }[], addAllFilesFileType: boolean, fileTypeIndex: integer, fileNameLabel: string, okButtonLabel: string, places: string[], flags: os.DialogFlags}|nil|`{defaultFolder = ac.getFolder(ac.FolderID.Root), fileTypes = {{name = 'Images', mask = '*.png;*.jpg;*.jpeg;*.bmp'}}, addAllFilesFileType = true, flags = bit.bor(os.DialogFlags.PathMustExist, os.DialogFlags.FileMustExist)}` "Table with properties:\n- `title` (`string`): Dialog title.\n- `defaultFolder` (`nil|string`): Default folder if there is not a recently used folder value available.\n- `folder` (`string`): Selected folder (unlike `defaultFolder`, overrides recently used folder).\n- `fileName` (`string`): File name that appears in the File name edit box when that dialog box is opened.\n- `fileTypes` (`nil|{ name: string, mask: string }[]`): File types (names and masks).\n- `addAllFilesFileType` (`boolean`): If providing file types, set this to true to automatically add “All Files (*.*)” type at the bottom\n- `fileTypeIndex` (`integer`): File type selected by default (1-based).\n- `fileNameLabel` (`string`): Text of the label next to the file name edit box.\n- `okButtonLabel` (`string`): Text of the Open button.\n- `places` (`string[]`): Additional places to show in the list of locations on the left.\n- `flags` (`os.DialogFlags`): Dialog flags (use `bit.bor()` to combine flags together to avoid errors with adding same flag twice)"

  2. `callback`: `fun(err: string, filename: string)`
## Function os.saveFileDialog(params, callback)
Opens regular Windows file saving dialog, calls callback with either an error or a path to a file selected by user
(or nil if selection was cancelled). All parameters in `params` table are optional (the whole table too).

  Parameters:

  1. `params`: `{title: string, defaultFolder: nil|string, defaultExtension: string, folder: string, fileName: string, saveAsItem: string, fileTypes: nil|{` name: string, mask: string }[], addAllFilesFileType: boolean, fileTypeIndex: integer, fileNameLabel: string, okButtonLabel: string, places: string[], flags: os.DialogFlags}|nil|`{defaultFolder = ac.getFolder(ac.FolderID.Root), fileTypes = {{name = 'Images', mask = '*.png;*.jpg;*.jpeg;*.bmp'}}, addAllFilesFileType = true, flags = bit.bor(os.DialogFlags.PathMustExist, os.DialogFlags.OverwritePrompt, os.DialogFlags.NoReadonlyReturn)}` "Table with properties:\n- `title` (`string`): Dialog title.\n- `defaultFolder` (`nil|string`): Default folder if there is not a recently used folder value available.\n- `defaultExtension` (`string`): Sets the default extension to be added to file names, with a dot in front.\n- `folder` (`string`): Selected folder (unlike `defaultFolder`, overrides recently used folder).\n- `fileName` (`string`): File name that appears in the File name edit box when that dialog box is opened.\n- `saveAsItem` (`string`): Ann item to be used as the initial entry in a Save As dialog.\n- `fileTypes` (`nil|{ name: string, mask: string }[]`): File types (names and masks).\n- `addAllFilesFileType` (`boolean`): If providing file types, set this to true to automatically add “All Files (*.*)” type at the bottom\n- `fileTypeIndex` (`integer`): File type selected by default (1-based).\n- `fileNameLabel` (`string`): Text of the label next to the file name edit box.\n- `okButtonLabel` (`string`): Text of the Save button.\n- `places` (`string[]`): Additional places to show in the list of locations on the left.\n- `flags` (`os.DialogFlags`): Dialog flags (use `bit.bor()` to combine flags together to avoid errors with adding same flag twice)"

  2. `callback`: `fun(err: string, filename: string)`
## Function os.runConsoleProcess(params, callback)
Run a console process in background with given arguments, return exit code and output in callback. Launched process will be tied
to AC process to shut down with AC (works only on Windows 8 and newer).

  Parameters:

  1. `params`: `{filename: string, arguments: string[], rawArguments: boolean, workingDirectory: string, timeout: integer, environment: table, inheritEnvironment: boolean, stdin: string, separateStderr: boolean, terminateWithScript: boolean|'disposable', assignJob: boolean, dataCallback: fun(err: boolean, data: string)}|`{` filename = '', arguments = {} }` "Table with properties:\n- `filename` (`string`): Application filename.\n- `arguments` (`string[]`): Arguments (quotes will be added automatically unless `rawArguments` is set to true).\n- `rawArguments` (`boolean`): Set to `true` to disable any arguments processing and pass them as they are, simply joining them with a space symbol.\n- `workingDirectory` (`string`): Working directory.\n- `timeout` (`integer`): Timeout in milliseconds. If above zero, process will be killed after given time has passed.\n- `environment` (`table`): If set to a table, values from that table will be used as environment variables instead of inheriting ones from AC process.\n- `inheritEnvironment` (`boolean`): Set to `true` to inherit AC environment variables before adding custom ones.\n- `stdin` (`string`): Optional data to pass to a process in stdin pipe.\n- `separateStderr` (`boolean`): Store stderr data in a separate string.\n- `terminateWithScript` (`boolean|'disposable'`): Terminate process if this Lua script were to terminate (for example, during reload). Since 0.2.10, pass `'disposable'` instead to get `ac.Disposable` back, allowing to terminate the process manually.\n- `assignJob` (`boolean`): Set to `false` to stop CSP from tying the process to AC process (doing so ensures child process would shut down with AC closing).\n- `dataCallback` (`fun(err: boolean, data: string)`): If set to a function, data written in stdout and stderr will be passed to the function instead as it arrives."

  2. `callback`: `nil|fun(err: string, data: os.ConsoleProcessResult)`

# Module common/timer.lua

## Function setTimeout(callback, delay, uniqueKey)
Runs callback after certain time. Returns cancellation ID.
Note: all callbacks will be ran before `update()` call,
and they would only ran when script runs. So if your script is executed each frame and AC runs at 60 FPS, smallest interval
would be 0.016 s, and anything lower that you’d set would still act like 0.016 s. Also, intervals would only be called once
per frame.

  Parameters:

  1. `callback`: `fun()`

  2. `delay`: `number?` Delay time in seconds. Default value: 0.

  3. `uniqueKey`: `any?` Unique key: if set, timer wouldn’t be added unless there is no more active timers with such ID.

  Returns:

  - `integer`
## Function setInterval(callback, period, uniqueKey)
Repeteadly runs callback after certain time. Returns cancellation ID.
Note: all callbacks will be ran before `update()` call,
and they would only ran when script runs. So if your script is executed each frame and AC runs at 60 FPS, smallest interval
would be 0.016 s, and anything lower that you’d set would still act like 0.016 s. Also, intervals would only be called once
per frame.

  Parameters:

  1. `callback`: `fun(): function?` Return `clearInterval` (actual function) to clear interval.

  2. `period`: `number?` Period time in seconds. Default value: 0.

  3. `uniqueKey`: `any?` Unique key: if set, timer wouldn’t be added unless there is no more active timers with such ID.

  Returns:

  - `integer`
## Function clearTimeout(cancellationID)
Stops timeout.

  Parameters:

  1. `cancellationID`: `integer` Value earlier retuned by `setTimeout()`. If a non-numerical value is passed (like a `nil`), call is ignored and returns `false`.

  Returns:

  - `boolean` True if timeout with such ID has been found and stopped.
## Function clearInterval(cancellationID)
Stops interval.

  Parameters:

  1. `cancellationID`: `integer` Value earlier retuned by `setInterval()`.

  Returns:

  - `boolean` True if interval with such ID has been found and stopped.

# Module common/ac_enums.lua

## Function physics.Collider.Box(size, offset, look, up, debug)
Box collider.

  Parameters:

  1. `size`: `vec3`

  2. `offset`: `vec3?` Default value: `vec3(0, 0, 0)`.

  3. `look`: `vec3?` Default value: `vec3(0, 0, 1)`.

  4. `up`: `vec3?` Default value: `vec3(0, 1, 0)`.

  5. `debug`: `boolean?` Set to `true` to see an outline. Default value: `false`.

  Returns:

  - `physics.ColliderType`
## Function physics.Collider.Sphere(radius, offset, debug)
Sphere collider.

  Parameters:

  1. `radius`: `number`

  2. `offset`: `vec3?` Default value: `vec3(0, 0, 0)`.

  3. `debug`: `boolean?` Set to `true` to see an outline. Default value: `false`.

  Returns:

  - `physics.ColliderType`
## Function physics.Collider.Capsule(length, radius, offset, look, debug)
Capsule collider (like cylinder, but instead of flat caps it has hemispheres and works a bit faster).

  Parameters:

  1. `length`: `number`

  2. `radius`: `number`

  3. `offset`: `vec3?` Default value: `vec3(0, 0, 0)`.

  4. `look`: `vec3?` Default value: `vec3(0, 0, 1)`.

  5. `debug`: `boolean?` Set to `true` to see an outline. Default value: `false`.

  Returns:

  - `physics.ColliderType`
## Function physics.Collider.Cylinder(length, radius, offset, look, debug)
Cylinder collider (slower than capsule, consider using capsule where appropriate).

  Parameters:

  1. `length`: `number`

  2. `radius`: `number`

  3. `offset`: `vec3?` Default value: `vec3(0, 0, 0)`.

  4. `look`: `vec3?` Default value: `vec3(0, 0, 1)`.

  5. `debug`: `boolean?` Set to `true` to see an outline. Default value: `false`.

  Returns:

  - `physics.ColliderType`

# Module common/ac_extras_ini.lua

## Function ac.INIConfig(format, sections)
A wrapper for data parsed from an INI files, supports different INI formats. Parsing is done on
CSP side, rest is on CSP side. Use `:get()` and `:set()` methods to operate values.

  Parameters:

  1. `format`: `ac.INIFormat`

  2. `sections`: `table`

  Returns:

  - `ac.INIConfig`
## Class ac.INIConfig
A wrapper for data parsed from an INI files, supports different INI formats. Parsing is done on
CSP side, rest is on CSP side. Use `:get()` and `:set()` methods to operate values.

- `ac.INIConfig:get(section, key, defaultValue, offset)`

  Get value from parsed INI file. Note: getting vector values creates them anew, so if you’re going to use a value often, consider
caching it locally.

  Parameters:

    1. `section`: `string` Section name.

    2. `key`: `string` Value key.

    3. `defaultValue`: `T` Defines type of value to return, is returned if value is missing. If not set, list of strings is returned.

    4. `offset`: `integer?` Optional 1-based offset for data parsed in CSP format (in case value contains several items). Default value: 1.

  Returns:

    - `T`

- `ac.INIConfig:tryGetLut(section, key)`

  Attempts to load a 1D-to-1D LUT from an INI file, supports both inline “(|X=Y|…|)” LUTs and separate files next to configs (only
for configs loaded by filename or from car data)

  Returns:

    - `ac.DataLUT11`

- `ac.INIConfig:tryGet2DLut(section, key)`

  Attempts to load a 2D-to-1D LUT from an INI file, supports both inline “(|X,Y=Z|…|)” LUTs and separate files next to configs (only
for configs loaded by filename or from car data)

  Returns:

    - `ac.DataLUT21`

- `ac.INIConfig:iterate(prefix, noPostfixForFirst)`

  Iterates over sections of INI file with a certain prefix. Order matches order of CSP parsing such data.

Example:
```lua
for index, section in iniConfig:iterate('LIGHT') do
  print('Color: '..iniConfig:get(section, 'COLOR', 'red'))
end
```

  Parameters:

    1. `prefix`: `string` Prefix for section names.

    2. `noPostfixForFirst`: `boolean?` Only for default INI format. If set to `true`, first section would not have “_0” postfix.

  Returns:

    - `fun`

- `ac.INIConfig:iterateValues(section, prefix, digitsOnly)`

  Iterates over values of INI section with a certain prefix. Order matches order of CSP parsing such data.

Example:
```lua
for index, key in iniConfig:iterateValues('LIGHT_0', 'POSITION', true) do
  print('Position: '..tostring(iniConfig:get('LIGHT_0', key, vec3())))
end
```

  Parameters:

    1. `prefix`: `string` Prefix for section names.

    2. `digitsOnly`: `boolean?` If set to `true`, would only collect keys consisting of a prefix and a number (useful for configs with extra properties).

  Returns:

    - `fun`

- `ac.INIConfig:mapSection(section, defaults)`

  Takes table with default values and returns a table with values filled from config.

  Parameters:

    1. `section`: `string` Section name.

    2. `defaults`: `T` Table with keys and default values. Keys are the same as INI keys.

  Returns:

    - `T`

- `ac.INIConfig:mapConfig(defaults)`

  Takes table with default values and returns a table with values filled from config.

  Parameters:

    1. `defaults`: `T` Table with section names and sub-tables with keys and default values. Keys are the same as INI keys.

  Returns:

    - `T`

- `ac.INIConfig:set(section, key, value)`

  Set an INI value. Pass `nil` as value to remove it.

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `value`: `string|string[]|number|boolean|nil|vec2|vec3|vec4|rgb|rgbm`

  Returns:

    - `ac.INIConfig` Returns itself for chaining several methods together.

- `ac.INIConfig:setAndSave(section, key, value)`

  Set an INI value and save file immediately using special old Windows function to edit a single INI value. Compatible only with default
INI format. Doesn’t provide major peformance improvements, but might be useful if you prefer to keep original formatting as much as possible
when editing a single value only.

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `value`: `string|string[]|number|boolean|nil|vec2|vec3|vec4|rgb|rgbm`

  Returns:

    - `boolean` Returns `true` if new value is different and config was saved.

- `ac.INIConfig:serialize()`

  Serializes data in INI format using format specified on INIConfig creation. You can also use `tostring()` function.

  Returns:

    - `string`

- `ac.INIConfig:save(filename)`

  Saves contents to a file in INI form.

  Parameters:

    1. `filename`: `string?` Filename. If filename is not set, saves file with the same name as it was loaded. Updates `filename` field.

  Returns:

    - `ac.INIConfig` Returns itself for chaining several methods together.
## Function ac.INIConfig.parse(data, format, includeFolders)
Parse INI config from a string.

  Parameters:

  1. `data`: `string` Serialized INI data.

  2. `format`: `ac.INIFormat?` Format to parse. Default value: `ac.INIFormat.Default`.

  3. `includeFolders`: `('@cars'|'@tracks'|string)[]?` Optional folders to include files from (only for `ac.INIFormat.ExtendedIncludes` format). Use special values `'@cars'` and `'@tracks'` for car or track configs.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.load(filename, format, includeFolders)
Load INI file, optionally with includes.

  Parameters:

  1. `filename`: `string` INI config filename.

  2. `format`: `ac.INIFormat?` Format to parse. Default value: `ac.INIFormat.Default`.

  3. `includeFolders`: `('@cars'|'@tracks'|string)[]?` Optional folders to include files from (only for `ac.INIFormat.ExtendedIncludes` format). If not set, parent folder for config filename is used. Use special values `'@cars'` and `'@tracks'` for car or track configs.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.carData(carIndex, fileName)
Load car data INI file. Supports “data.acd” files as well. Returned files might be tweaked by
things like custom physics virtual tyres. To get original file, use `ac.INIConfig.load()`.

Returned file can’t be saved.

  Parameters:

  1. `carIndex`: `number` 0-based car index.

  2. `fileName`: `string` Car data file name, such as `'tyres.ini'`.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.trackData(fileName)
Load track data INI file. Can be used by track scripts which might not always  have access to those files directly.

Returned file can’t be saved.

  Parameters:

  1. `fileName`: `string` Car data file name, such as `'tyres.ini'`.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.carConfig(carIndex)
Returns CSP config for a car. Might be slow: some of those configs are huge. Make sure to cache the resulting value if you need to reuse it.

Returned file can’t be saved.

  Parameters:

  1. `carIndex`: `number` 0-based car index.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.trackConfig()
Returns CSP config for a track. Might be slow: some of those configs are huge. Make sure to cache the resulting value if you need to reuse it.

Returned file can’t be saved.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.onlineExtras()
Returns config with extra online options, the ones that can be set with Content Manager.

Returned file can’t be saved.

  Returns:

  - `ac.INIConfig|nil` If not an online session, returns `nil`.
## Function ac.INIConfig.raceConfig()
Returns race config (`cfg/race.ini`). Password and online GUID won’t be included.

Returned file can’t be saved.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.videoConfig()
Returns video config (`cfg/video.ini`).

Returned file can’t be saved.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.controlsConfig()
Returns controls config (`cfg/controls.ini`).

Returned file can’t be saved.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.currentSetup()
Returns current setup INI file (either previously loaded or saved). Any changes in actual setup in pits won’t be reflected in the returned
data unless file was saved.

Returned file can be saved. Use `ac.onSetupFile()` to listen to data changes and either read extra data from setup file, or change the contents after file has been saved.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.cspModule(cspModuleID)
Load config of a CSP module by its name.

  Parameters:

  1. `cspModuleID`: `ac.CSPModuleID` Name of a CSP module.

  Returns:

  - `ac.INIConfig`
## Function ac.INIConfig.scriptSettings()
Load config of the current Lua script (“settings.ini” in script directory and settings overriden by user, meant to be customizable with Content Manager).

  Returns:

  - `ac.INIConfig`

# Module common/ac_extras_datalut.lua

## Function ac.DataLUT11()
Creates a new empty 1D-to-1D LUT. Use `ac.DataLUT11:add(input, output)` to fill it with data.

  Returns:

  - `ac.DataLUT11`
## Function ac.DataLUT11.parse(data)
Parse 1D-to-1D LUT from a string in “(|Input1=Output1|Input2=Output2|…|)” format.

  Parameters:

  1. `data`: `string` Serialized LUT data.

  Returns:

  - `ac.DataLUT11`
## Function ac.DataLUT11.load(filename)
Load 1D-to-1D LUT file.

  Parameters:

  1. `filename`: `string` LUT filename.

  Returns:

  - `ac.DataLUT11`
## Function ac.DataLUT11.carData(carIndex, fileName)
Load car data 1D-to-1D LUT file. Supports “data.acd” files as well.

  Parameters:

  1. `carIndex`: `number` 0-based car index.

  2. `fileName`: `string` Car data file name, such as `'power.lut'`.

  Returns:

  - `ac.DataLUT11`
## Function ac.DataLUT21()
Creates a new empty 2D-to-1D LUT. Use `ac.DataLUT21:add(input, output)` to fill it with data.

  Returns:

  - `ac.DataLUT21`
## Function ac.DataLUT21.parse(data)
Parse 2D-to-1D LUT from a string in “(|X1,Y1=Output1|X2,Y2=Output2|…|)” format.

  Parameters:

  1. `data`: `string` Serialized LUT data.

  Returns:

  - `ac.DataLUT21`
## Function ac.DataLUT21.load(filename)
Load 2D-to-1D LUT file.

  Parameters:

  1. `filename`: `string` LUT filename.

  Returns:

  - `ac.DataLUT21`
## Function ac.DataLUT21.carData(carIndex, fileName)
Load car data 2D-to-1D LUT file. Supports “data.acd” files as well.

  Parameters:

  1. `carIndex`: `number` 0-based car index.

  2. `fileName`: `string` Car data file name, such as `'speed_throttle.2dlut'`.

  Returns:

  - `ac.DataLUT21`
## Class ac.DataLUT11
Simple 1D-to-1D lookup table wrapper, helps to deal with all those “.lut“ files in car data.

- `ac.DataLUT11:add(input, output)`

  Add a new value to LUT.

  Parameters:

    1. `input`: `number`

    2. `output`: `number`

  Returns:

    - `ac.DataLUT11` Returns self for easy chaining.

- `ac.DataLUT11:bounds()`

  Returns data boundaries.

  Returns:

    1. `vec2` Minimum input and output.

    2. `vec2` Maximum input and output.

- `ac.DataLUT11:get(input)`

  Computes a LUT value using either linear or cubic interpolation (set field `ac.DataLUT11.useCubicInterpolation` to
`true` to use cubic interpolation).

  Parameters:

    1. `input`: `number`

  Returns:

    - `number`

- `ac.DataLUT11:getPointInput(index)`

  Returns input value of a certain point of a LUT, or `math.nan` if there is no such point.

  Parameters:

    1. `index`: `number` 0-based index.

  Returns:

    - `number`

- `ac.DataLUT11:getPointOutput(index)`

  Returns output value of a certain point of a LUT, or `math.nan` if there is no such point.

  Parameters:

    1. `index`: `number` 0-based index.

  Returns:

    - `number`

- `ac.DataLUT11:serialize(longFormat)`

  Convert LUT into a string, either in a short (inlined, for an INI config) or long (for a separate file) format.

  Parameters:

    1. `longFormat`: `boolean?` Set to `true` to use long format. Default value: `false`.

  Returns:

    - `string`
## Class ac.DataLUT21
Simple 2D-to-1D lookup table wrapper, helps to deal with all those “.2dlut“ files in car data. Tables can miss some values,
such areas will be further interpolated.

- `ac.DataLUT21:bounds()`

  Returns data boundaries.

  Returns:

    1. `vec3` Minimum input (X, Y) and output (Z).

    2. `vec3` Maximum input (X, Y) and output (Z).

- `ac.DataLUT21:add(input, output)`

  Add a new value to a 2D LUT.

  Parameters:

    1. `input`: `vec2`

    2. `output`: `number`

  Returns:

    - `ac.DataLUT21` Returns self for easy chaining.

- `ac.DataLUT21:get(input)`

  Computes a LUT value using either bilinear or bicubic interpolation (set field `ac.DataLUT21.useBicubicInterpolation` to
`true` to use bicubic interpolation).

  Parameters:

    1. `input`: `vec2`

  Returns:

    - `number`

- `ac.DataLUT21:serialize()`

  Convert LUT into a string in a short (inlined, for an INI config) format.

  Returns:

    - `string`

# Module common/ac_extras_connect.lua

## Function ac.connect(layout, keepLive, namespace)
Creates a new shared structure to quickly exchange data between different Lua scripts within a session. Example:
```lua
local sharedData = ac.connect{
  ac.StructItem.key('myChannel'),        -- optional, to avoid collisions
  someString = ac.StructItem.string(24), -- 24 is for capacity
  someInt = ac.StructItem.int(),
  someDouble = ac.StructItem.double(),
  someVec = ac.StructItem.vec3()
}
```

Note: to connect two scripts, both of them chould use `ac.connect()` and pass exactly the same layouts. Also, consider using more
specific names to avoid possible unwanted collisions. For example, instead of using `value = ac.StructItem.int()` which might be
used somewhere else, use `weatherBrightnessValue = ac.StructItem.int()`. Or, simply add `ac.StructItem.key('myUniqueKey')`.

For safety reasons, car scripts can only connect to other car scripts, and track scripts can only connect to other track scripts.

  Parameters:

  1. `layout`: `T` A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.

  2. `keepLive`: `boolean?` Set to true to keep structure even if any references were removed or script was unloaded.

  3. `namespace`: `nil|ac.SharedNamespace` Optional namespace stopping scripts of certain types to access data of scripts with different types. For more details check `ac.SharedNamespace` documentation.

  Returns:

  - `T`
## Function ac.StructItem.combine(layout, compact)
Create a new struct from a given layout. Could be used in calls like `ac.structBytes()` and `ac.fillStructWithBytes()`. Each call defines and creates a new struct, so don’t
call them each frame, I believe LuaJIT doesn’t do garbage collection on struct definitions.

  Parameters:

  1. `layout`: `T`

  2. `compact`: `boolean?`

  Returns:

  1. `T`

  2. `integer` Structure size.

  3. `string` Structure name.

# Module common/ac_struct_item.lua

## Function ac.StructItem.key(key)
Adds a key to a structure to ensure its uniqueness. Consider using something like “yourUsername.yourContentID” or something
like that for a key, so that your data would not interfere with data from Lua scripts written by other developers. Note:
if you’re exchanging data between physics and graphics thread in your car, you might have to append `car.index` to there as
well so that different cars would have either own data things.

  Returns:

  - `nil`
## Function ac.StructItem.explicit(alignment, packing)
Enables explicit ordering for your structures.
By default, CSP will reorder fields in your structures for optimal data packing. Because all scripts written in Lua share the same algorithm,
it’s all fine and good, but if you want for your script to exchange data with other programs, explicit order would work much better.

  Parameters:

  1. `alignment`: `integer?` Optional override for alignment of child structures.

  2. `packing`: `integer?` Optional overrider for packing of fields.

  Returns:

  - `nil`
## Function ac.StructItem.half()

  Returns:

  - `number`
## Function ac.StructItem.float()

  Returns:

  - `number`
## Function ac.StructItem.double()

  Returns:

  - `number`
## Function ac.StructItem.norm8()

  Returns:

  - `number`
## Function ac.StructItem.unorm8()

  Returns:

  - `number`
## Function ac.StructItem.norm16()

  Returns:

  - `number`
## Function ac.StructItem.unorm16()

  Returns:

  - `number`
## Function ac.StructItem.int16()

  Returns:

  - `integer`
## Function ac.StructItem.uint16()

  Returns:

  - `integer`
## Function ac.StructItem.int32()

  Returns:

  - `integer`
## Function ac.StructItem.uint32()

  Returns:

  - `integer`
## Function ac.StructItem.int64()

  Returns:

  - `integer`
## Function ac.StructItem.uint64()

  Returns:

  - `integer`
## Function ac.StructItem.boolean()

  Returns:

  - `boolean`
## Function ac.StructItem.char()
Same as `ac.StructItem.int8()`.

  Returns:

  - `integer`
## Function ac.StructItem.byte()
Same as `ac.StructItem.uint8()`.

  Returns:

  - `integer`
## Function ac.StructItem.int8()

  Returns:

  - `integer`
## Function ac.StructItem.uint8()

  Returns:

  - `integer`
## Function ac.StructItem.vec2()

  Returns:

  - `vec2`
## Function ac.StructItem.vec3()

  Returns:

  - `vec3`
## Function ac.StructItem.vec4()

  Returns:

  - `vec4`
## Function ac.StructItem.rgb()

  Returns:

  - `rgb`
## Function ac.StructItem.rgbm()

  Returns:

  - `rgbm`
## Function ac.StructItem.hsv()

  Returns:

  - `hsv`
## Function ac.StructItem.quat()

  Returns:

  - `quat`
## Function ac.StructItem.array(elementType, size)

  Parameters:

  1. `elementType`: `T`

  2. `size`: `integer`

  Returns:

  - `T`
## Function ac.StructItem.struct(fields)

  Parameters:

  1. `fields`: `T`

  Returns:

  - `T`
## Function ac.StructItem.string(capacity)

  Parameters:

  1. `capacity`: `integer?` Maximum string capacity. Default value: 32.

  Returns:

  - `string`
## Function ac.StructItem.mat3x3()

  Returns:

  - `mat3x3`
## Function ac.StructItem.mat4x4()

  Returns:

  - `mat4x4`
## Function ac.StructItem.transform(compactPosition, compactRotation, rangeFrom, rangeTo)
Matrix packed to 6, 9 or 12 bytes (depending on settings).

Note: to update value you need to use assignment operator (`.field = newValue`), altering matrix of this property with methods like
`:mulSelf()` only changes unpacked value on your side, but not the actual structure value.

  Parameters:

  1. `compactPosition`: `boolean?` If `true`, position is packed into 3 bytes, otherwise it will take 6 bytes. Default value: `false`.

  2. `compactRotation`: `boolean?` If `true`, rotation is packed into 3 bytes, otherwise it will take 6 bytes. Default value: `false`.

  3. `rangeFrom`: `number|vec3?` Minimal expected position. Pass it together with `rangeTo` to encode position data more efficiently.

  4. `rangeTo`: `number|vec3?` Maximum expected position. Pass it together with `rangeFrom` to encode position data more efficiently.

  Returns:

  - `mat4x4`
## Function ac.StructItem.build(layout)
Simply create a new FFI structure with a given layout. Doesn’t connect to anything.

  Parameters:

  1. `layout`: `T` A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.

  Returns:

  - `T`

# Module common/ac_extras_hashspace.lua

## Function ac.HashSpace(cellSize)

  Parameters:

  1. `cellSize`: `number` Should be about twice as large as your largest entity.

  Returns:

  - `ac.HashSpace`

# Module common/ac_extras_numlut.lua

## Function ac.Lut(data, hsvColumns)

  Parameters:

  1. `data`: `string` String with LUT data, in a format similar to AC LUT formats. Please note: rows must be ordered for efficient binary search.

  2. `hsvColumns`: `integer[]` 1-based indices of columns storing HSV data. Such columns, of course, will be interpolated differently (for example, mixing hues 350 and 20 would produce 10).

  Returns:

  - `ac.Lut`
## Function ac.LutJit:new(o, data, hsvRows)
Creates new ac.LuaJit instance. Deprecated and broken, use `ac.Lut` instead.

  Parameters:

  1. `data`: `any`

  2. `hsvRows`: `integer[]`  1-based indices of columns (not rows) storing HSV values in them.

  Returns:

  - `table`

# Module common/ac_extras_onlineevent.lua

## Function ac.OnlineEvent(layout, callback, namespace, udp, params)
Creates a new type of online event to exchange between scripts running on different clients in an online
race. Example:
```lua
local chatMessageEvent = ac.OnlineEvent({
  -- message structure layout:
  message = ac.StructItem.string(50),
  mood = ac.StructItem.float(),
}, function (sender, data)
  -- got a message from other client (or ourselves; in such case `sender.index` would be 0):
  ac.debug('Got message: from', sender and sender.index or -1)
  ac.debug('Got message: text', data.message)
  ac.debug('Got message: mood', data.mood)
end)

-- sending a new message:
chatMessageEvent{ message = 'hello world', mood = 5 }
```

Note: to exchange messages between two scripts, both of them chould use `ac.OnlineEvent()` and pass exactly the same layouts. Also, consider using more
specific names to avoid possible unwanted collisions. For example, instead of using `value = ac.StructItem.int()` which might be
used somewhere else, use `mySpecificValue = ac.StructItem.int()`. Or, simply add `ac.StructItem.key('myUniqueKey')`.

For safety reasons, car scripts can only exchange messages with other car scripts, and track scripts can only exchange messages with other track scripts.
Your own messages will arrive to you as well unless you were to use `target` with ID different from your session ID, you might need to filter out those
messages.

If the server is not a custom AC Server (use `ac.getSim().directMessagingAvailable` to check), but the original implementation, following restrictions apply:
- Each message should be smaller than 175 bytes.
- At least 200 ms should pass between sending messages.
- UDP messages are not available (those require `ac.getSim().directUDPMessagingAvailable` flag).
- Don’t use this system to exchange data too often: it uses chat messages to transfer data, so it’s far from optimal.

  Parameters:

  1. `layout`: `T` A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.

  2. `callback`: `fun(sender: ac.StateCar|nil, message: T)` Callback that will be called when a new message of this type is received. Note: it would be called even if message was sent from this script. Use `sender` to check message origin: if it’s `nil`, message has come from the server, if its `.index` is 0, message has come from this client (and possibly this script).

  3. `namespace`: `nil|ac.SharedNamespace` Optional namespace stopping scripts of certain types to access data of scripts with different types. For more details check `ac.SharedNamespace` documentation.

  4. `udp`: `nil|boolean|{range: number}` Pass `true` to use UDP messages (available for Lua apps and online scripts only). Use `ac.getSim().directUDPMessagingAvailable` to check if you could use `udp` flag before hand. Note: enabling this option means `repeatForNewConnections` parameter will be ignored. Alternatively, pass a table with advanced UDP settings.

  5. `params`: `{processPostponed: boolean?}?` Extra params. Set `processPostponed` to process previously received TCP messages (up to 256, callback will be called in the next frame for all messages from first to last).

  Returns:

  1. `fun`

  2. `fun`

# Module common/ac_extras_connectmmf.lua

## Function ac.readMemoryMappedFile(filename, layout, persist)
Opens shared memory file for reading. Do not attempt to modify any of its contents: doing so pretty much always would result in Assetto Corsa
just straight up crashing.

  Parameters:

  1. `filename`: `string` Shared memory file filename (without “Local\” bit).

  2. `layout`: `T` String for the body of the structure.

  3. `persist`: `boolean?` Keep file alive even after the script stopped or the variable was cleared by garbage collector. Default value: `false`.

  Returns:

  - `T`
## Function ac.writeMemoryMappedFile(filename, layout, persist)
Opens shared memory file for writing. Note: if the file would exist at the moment of opening (for example, created before by a different
Lua script, or by a separate process), it would retain its current state, but if it’s a new file, it’ll be initialized with all zeroes.

  Parameters:

  1. `filename`: `string` Shared memory file filename (without “Local\” bit).

  2. `layout`: `T` String for the body of the structure.

  3. `persist`: `boolean?` Keep file alive even after the script stopped or the variable was cleared by garbage collector. Default value: `false`.

  Returns:

  - `T`
## Function ac.disposeMemoryMappedFile(reference)
Forcefully closes memory mapped file opened either for reading or writing without waiting for GC to pick it up.
function ac.disposeMemoryMappedFile(reference) end

# Module common/ac_general_utils.lua

## Function ac.evaluateLapTime()
Estimates lap time and sector times for main car using AC function originally used by Time Attack mode. Could be
helpful in creating custom time attack modes. Uses “ideal_line.ai” from “track folder/data”, so might not work
well with mods. If that file is missing, returns nil.

# Module common/ac_social.lua

## Function ac.DriverTags(driverName)
Faster way to deal with driver tags. Any request of unsupported fields will return `false` for further extendability.
Scripts with access to I/O can also alter fields.

  Parameters:

  1. `driverName`: `string`

  Returns:

  - `ac.DriverTags`
## Class ac.DriverTags
Faster way to deal with driver tags. Any request of unsupported fields will return `false` for further extendability.
Scripts with access to I/O can also alter fields.
## Function ac.isTaggedAsFriend(driverName)
Checks if a user is tagged as a friend. Uses CSP and CM databases. Deprecated, use `ac.DriverTags` instead.

  Parameters:

  1. `driverName`: `string` Driver name.

  Returns:

  - `boolean`
## Function ac.tagAsFriend(driverName, isFriend)
Tags user as a friend (or removes the tag if `false` is passed). Deprecated, use `ac.DriverTags` instead.

  Parameters:

  1. `driverName`: `string` Driver name.

  2. `isFriend`: `boolean?` Default value: `true`.

# Module common/ac_music.lua

## Class ac.MusicData
Information about currently playing track. Use function `ac.currentlyPlaying()` to get
a reference to it.

To draw album cover, pass `ac.MusicData` as an argument to something like `ui.image()`.
## Function ac.currentlyPlaying()
Syncs information about currently playing music and returns a table with details. Takes data from
Windows 10 Media API, or from other sources configured in Music module of CSP.

  Returns:

  - `ac.MusicData`

# Module common/ac_weatherconditions.lua

## Function ac.TrackConditions(sessionStart, sessionTransfer, randomness, lapGain)
State of the track surface.

  Parameters:

  1. `sessionStart`: `number` From 0 to 100.

  2. `sessionTransfer`: `number` From 0 to 100.

  3. `randomness`: `number`

  4. `lapGain`: `number`

  Returns:

  - `ac.TrackConditions`
## Class ac.TrackConditions
State of the track surface.
## Function ac.TemperatureParams(ambient, road)

  Parameters:

  1. `ambient`: `number` Temperature in C°.

  2. `road`: `number` Temperature in C°.

  Returns:

  - `ac.TemperatureParams`
## Class ac.TemperatureParams
## Function ac.WindParams(direction, speedFrom, speedTo)

  Parameters:

  1. `direction`: `number` Direction in degrees.

  2. `speedFrom`: `number` Speed in km/h.

  3. `speedTo`: `number` Speed in km/h.

  Returns:

  - `ac.WindParams`
## Class ac.WindParams
## Function ac.ConditionsSet()

  Returns:

  - `ac.ConditionsSet`
## Class ac.ConditionsSet

# Module common/ac_state.lua

## Function ac.getCar(index)
Returns reference to a structure with various information about the state of a car. Very cheap to use.
This is a new version with shorter name and 0-based indexing (to match other API functions).

Updates once per graphics frame. You can use it in physics scripts to access things such as tyre radius, but
for anything live there please look for specialized physics-rate updating values.

Note: index starts with 0. Make sure to check result for `nil` if you’re accessing a car that might not be there. First car
with index 0 is always there.

  Parameters:

  1. `index`: `integer` 0-based index.

  Returns:

  - `ac.StateCar`
## Function ac.getCar.ordered(index)
Returns Nth closest to camera car (pass 0 to get an ID of the nearest car). Inactive cars don’t count, so the number of cars
here might be smaller than total number of cars in the race.

  Parameters:

  1. `index`: `integer` 0-based index.

  Returns:

  - `ac.StateCar`
## Function ac.getCar.leaderboard(index)
Returns Nth car in the race leaderboard (uses lap times in practice and qualify sessions). Pass 0 to get the top one.

  Parameters:

  1. `index`: `integer` 0-based index.

  Returns:

  - `ac.StateCar`
## Function ac.getCar.serverSlot(index)
Returns Nth car in server entry list. Pass 0 to get the first one. In offline races returns `nil`.

  Parameters:

  1. `index`: `integer` 0-based index.

  Returns:

  - `ac.StateCar`
## Function ac.iterateCars()
Iterates over all the cars from one with 0th index to the last one. Use in a for-loop. To get a Nth car, use `ac.getCar()`.

Example:
```lua
for i, c in ac.iterateCars() do
  ac.debug(i, car.position)
end
```

  Returns:

  - `fun`
## Function ac.iterateCars.ordered(inverse)
Iterates over active cars (excluding disconnected ones online) from nearest to furthest. Use in a for-loop. To get a Nth car, use `ac.getCar.ordered()`.

Example:
```lua
for i, c in ac.iterateCars.ordered() do
  ac.debug(i, car.position)
end
```

  Parameters:

  1. `inverse`: `boolean?` Set to `true` to iterate in inverse order (available since 0.2.5).

  Returns:

  - `fun`
## Function ac.iterateCars.leaderboard()
Iterates over cars from first to last in the race leaderboard (uses lap times in practice and qualify sessions). Use in a for-loop. To get a Nth car, use `ac.getCar.leaderboard()`.

Example:
```lua
for i, c in ac.iterateCars.leaderboard() do
  ac.debug(i, car.position)
end
```

  Returns:

  - `fun`
## Function ac.iterateCars.serverSlots()
Iterates over cars based on their `sessionID` (index of a session slot). Use in a for-loop. To get a Nth car, use `ac.getCar.serverSlot()`. In offline races
returns an empty iterator.

Example:
```lua
for i, c in ac.iterateCars.leaderboard() do
  ac.debug(i, car.position)
end
```

  Returns:

  - `fun`
## Class ac.StateCar

- `ac.StateCar:skin()`

  Returns:

    - `string`

- `ac.StateCar:tyresName()`

  Returns:

    - `string`

- `ac.StateCar:tyresLongName()`

  Returns:

    - `string`

- `ac.StateCar:id()`

  Returns:

    - `string`

- `ac.StateCar:name()`

  Returns:

    - `string`

- `ac.StateCar:brand()`

  Returns:

    - `string`

- `ac.StateCar:country()`

  Returns:

    - `string`

- `ac.StateCar:driverName()`

  Returns:

    - `string`

- `ac.StateCar:driverNationCode()`

  Returns:

    - `string`

- `ac.StateCar:driverNationality()`

  Returns:

    - `string`

- `ac.StateCar:driverTeam()`

  Returns:

    - `string`

- `ac.StateCar:driverNumber()`

  Returns:

    - `string`

# Module common/ac_storage.lua

## Class ac.StoredValue

- `ac.StoredValue:get()`

  Returns:

    - `string|number|boolean|vec2|vec3|vec4|rgb|rgbm`

- `ac.StoredValue:set(value)`

  Parameters:

    1. `value`: `string|number|boolean|vec2|vec3|vec4|rgb|rgbm`
## Function ac.storage(layout, keyPrefix)
Storage function. Easiest way to use is to pass it a table with default values — it would give you a table back
which would load values on reads and save values on writes. Values have to be either strings, numbers, booleans,
vectors or colors. Example:
```lua
local storedValues = ac.storage{
  someKey = 15,
  someStringValue = 20
}
storedValues.someKey = 20
```
Alternatively, you can use it as a function which would take a key and a default value and return you an
`ac.StoredValue` wrapper with methods `:get()` and `:set(newValue)`:
```lua
local stored = ac.storage('someKey', 15)
stored:get()
stored:set(20)
```
Or, just access it directly in `localStorage` style of JavaScript. Similar to JavaScript, this way you can only store
strings:
```lua
ac.storage.key = 'value'
ac.debug('loaded', ac.storage.key)
```
Data will be saved in “Documents\Assetto Corsa\cfg\extension\state\lua”, in corresponding subfolder. Actual writing
will happen a few seconds after new value was pushed, and only if value was changed, so feel free to use this function
to write things often.

  Parameters:

  1. `layout`: `T`

  2. `keyPrefix`: `string|nil` Optional parameter for adding a prefix to keys.

  Returns:

  - `T`
## Function ac.storageHasKey(storage, key)
Checks if storage table created by `ac.storage(table)` has a certain key or not.

  Parameters:

  1. `storage`: `any`

  2. `key`: `string`

  Returns:

  - `boolean`
## Function ac.storageChanged()
Returns `true` if any storage value has changed since the previous call.

  Returns:

  - `boolean`

# Module common/ac_configs.lua

## Class ac.ConfigProvider

- `ac.ConfigProvider.bool(section, key, defaultValue)`

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `defaultValue`: `boolean|nil`

  Returns:

    - `boolean`

- `ac.ConfigProvider.number(section, key, defaultValue)`

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `defaultValue`: `number`

  Returns:

    - `number`

- `ac.ConfigProvider.string(section, key, defaultValue)`

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `defaultValue`: `string|nil`

  Returns:

    - `string`

- `ac.ConfigProvider.rgb(section, key, defaultValue)`

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `defaultValue`: `rgb|nil`

  Returns:

    - `rgb`

- `ac.ConfigProvider.rgbm(section, key, defaultValue)`

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `defaultValue`: `rgbm|nil`

  Returns:

    - `rgbm`

- `ac.ConfigProvider.vec2(section, key, defaultValue)`

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `defaultValue`: `vec2|nil`

  Returns:

    - `vec2`

- `ac.ConfigProvider.vec3(section, key, defaultValue)`

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `defaultValue`: `vec3|nil`

  Returns:

    - `vec3`

- `ac.ConfigProvider.vec4(section, key, defaultValue)`

  Parameters:

    1. `section`: `string`

    2. `key`: `string`

    3. `defaultValue`: `vec4|nil`

  Returns:

    - `vec4`
## Function ac.getTrackConfig(section, key, defaultValue)
Reads a value from the config of currently loaded track. To use it, you need to specify `defaultValue` value, it would be used to determine
the type of the value you need (and would be returned if value in config is missing).

Alternatively, if called without arguments, returns ac.ConfigProvider which then can be used to access
values in a typed manner. For it, `defaultValue` is optional.

  Parameters:

  1. `section`: `string` Section name in config (the one in square brackets).

  2. `key`: `string` Config key (value before “=” sign).

  3. `defaultValue`: `T` Value that’s returned as a result if value is missing. Also determines the type needed.

  Returns:

  - `T`
## Function ac.getCarConfig(carIndex, section, key, defaultValue)
Reads a value from the config of a car. To use it, you need to specify `defaultValue` value, it would be used to determine
the type of the value you need (and would be returned if value in config is missing).

Alternatively, if called with car index only, returns ac.ConfigProvider which then can be used to access
values in a typed manner. For it, `defaultValue` is optional.

  Parameters:

  1. `carIndex`: `integer` 0-based car index.

  2. `section`: `string` Section name in config (the one in square brackets).

  3. `key`: `string` Config key (value before “=” sign).

  4. `defaultValue`: `T` Value that’s returned as a result if value is missing. Also determines the type needed.

  Returns:

  - `T`

# Module common/ac_reftypes.lua

## Function refbool(value)
Stores a boolean value and can be used as a reference to it.

  Parameters:

  1. `value`: `boolean` Stored value.

  Returns:

  - `refbool`
## Class refbool
Stores a boolean value and can be used as a reference to it.

- `refbool.isrefbool(x)`

  Returns:

    - `boolean`

- `refbool:set(newValue)`

  For easier use with UI controls.

  Parameters:

    1. `newValue`: `boolean|`true`|`false``

  Returns:

    - `refbool`
## Function refnumber(value)
Stores a numerical value and can be used as a reference to it.

  Parameters:

  1. `value`: `number` Stored value.

  Returns:

  - `refnumber`
## Class refnumber
Stores a numerical value and can be used as a reference to it.

- `refnumber.isrefnumber(x)`

  Returns:

    - `boolean`

- `refnumber:set(newValue)`

  For easier use with UI controls.

  Parameters:

    1. `newValue`: `number`

  Returns:

    - `refnumber`

# Module common/ac_dualsense.lua

## Function ac.getDualSenseControllers()
Return table with gamepad indices for keys and 0-based indices of associated cars for values.

  Returns:

  - `table`

# Module common/ac_dualshock.lua

## Function ac.getDualShockControllers()
Return table with gamepad indices for keys and 0-based indices of associated cars for values.

  Returns:

  - `table`

# Module common/ac_web.lua

## Class WebResponse
## Function web.timeouts(resolve, connect, send, receive)
Configures timeouts in milliseconds for the following web requests. If you’re sure in your server, consider lowering timeouts so that
in a case of a missing internet connection it wouldn’t take forever to determine the issue. Parameters will be passed to `WinHttpSetTimeouts()`
function (https://learn.microsoft.com/en-us/windows/win32/api/winhttp/nf-winhttp-winhttpsettimeouts).

  Parameters:

  1. `resolve`: `integer?` Time in milliseconds for DNS resolve, 0 to disable timeout. Default value: 4000 ms.

  2. `connect`: `integer?` Time in milliseconds for establishing connection. Default value: 10000 ms.

  3. `send`: `integer?` Time in milliseconds for sending data. Default value: 30000 ms.

  4. `receive`: `integer?` Time in milliseconds for receiving data. Default value: 30000 ms.
## Function web.get(url, headers, callback)
Sends a GET HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
to one of my API tokens for some time, accidentally sending a request each frame).

  Parameters:

  1. `url`: `string` URL.

  2. `headers`: `table<string, string|number|boolean>?` Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method). Another special key added in 0.2.10 is `[':https-certificate'], see `WebResponse` docs for more info.

  3. `callback`: `fun(err: string, response: WebResponse)`
## Function web.post(url, headers, data, callback)
Sends a POST HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
to one of my API tokens for some time, accidentally sending a request each frame).

  Parameters:

  1. `url`: `string` URL.

  2. `headers`: `table<string, string|number|boolean>?` Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).

  3. `data`: `WebPayload?` Optional data.

  4. `callback`: `fun(err: string, response: WebResponse)`
## Function web.request(method, url, headers, data, callback)
Sends a custom HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
to one of my API tokens for some time, accidentally sending a request each frame).

  Parameters:

  1. `method`: `"'GET'"|"'POST'"|"'PUT'"|"'HEAD'"|"'DELETE'"|"'PATCH'"|"'OPTIONS'"` HTTP method.

  2. `url`: `string` URL.

  3. `headers`: `table<string, string|number|boolean>?` Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).

  4. `data`: `WebPayload?` Optional data.

  5. `callback`: `fun(err: string, response: WebResponse)`
## Function web.socket(url, headers, callback, params)
Open a WebSocket connection.

  Parameters:

  1. `url`: `string` URL.

  2. `headers`: `table<string, string|number|boolean>?` Optional headers.

  3. `callback`: `nil|fun(data: binary)`

  4. `params`: `web.SocketParams?`

  Returns:

  - `web.Socket`

# Module common/ac_physics_unrestricted.lua



# Module common/stringify.lua

## Function stringify(obj, compact, depthLimit)
Serialize Lua value (table, number, string, etc.) in a Lua table format (similar to how `JSON.stringify` in JavaScript
generates a thing with JavaScript syntax). Format seems to be called Luaon. Most of Lua entities are supported, including array-like tables, table
tables and mixed ones. CSP API things, such as vectors or colors, are also supported. For things like threads,
functions or unknown cdata types instead a placeholder object will be created.

Circular references also result in creating similar objects, for example: `t = {1, 2, 3, t}` would result in
`{ 1, 2, 3, { type = 'circular reference' } }`.

If any table in given data would have a `__stringify()` function, it would be called as a method (so first argument
would be the table with `__stringify` itself). If that function would return a string, that string will be used
instead of regular table serialization. The idea is for classes to define a method like this and output a line of code
which could be used to create a new instance like this on deserialization. Note: for such like to use a custom function
like a class constructor, you would either need to register that function with a certain name or provide a table referring
to it on deserialization. That’s because although deserialization uses `load()` function to parse and run data as Lua code,
it wouldn’t allow code to access existing functions by default.

  Parameters:

  1. `obj`: `table|number|string|boolean|nil` Object to serialize.

  2. `compact`: `boolean?` If true, resulting string would not have spaces and line breaks, slightly faster and a lot more compact.

  3. `depthLimit`: `integer?` Limits how deep serialization would go. Default value: 20.

  Returns:

  - `string` String with input data presented in Lua syntax.
## Function stringify.parse(serialized, namespace)
Parse a string with Lua table syntax into a Lua object (table, number, string, vector, etc.), can support custom objects as well.
Only functions from `namespace` can be used (as well as vectors and functions registered earlier with `stringify.register()`),
so if you’re using custom classes, make sure to either register them earlier or pass them in `namespace` table. Alternatively,
you can just pass `_G` as `namespace`, but it might be pretty unsecure, so maybe don’t do it.

Would raise an error if failed to parse or if any of initializers would raise an error.

  Parameters:

  1. `serialized`: `string` Serialized data.

  2. `namespace`: `table|nil` Namespace table. Serialized data would be evaluated as Lua code and would have access to it.

  Returns:

  - `table|number|string|boolean|nil`
## Function stringify.tryParse(serialized, namespace, fallback)
Parse a string with Lua table syntax into a Lua object (table, number, string, vector, etc.), can support custom objects as well.
Only functions from `namespace` can be used (as well as vectors and functions registered earlier with `stringify.register()`),
so if you’re using custom classes, make sure to either register them earlier or pass them in `namespace` table. Alternatively,
you can just pass `_G` as `namespace`, but it might be pretty unsecure, so maybe don’t do it.

Returns fallback value if failed to parse, or if `serialized` is empty or not set, or if any of initializers would raise an error.

  Parameters:

  1. `serialized`: `string?` Serialized data.

  2. `namespace`: `table|nil` Namespace table. Serialized data would be evaluated as Lua code and would have access to it.

  3. `fallback`: `T|nil` Value to return if parsing failed.

  Returns:

  - `T`
## Function stringify.register(name, fn)
Registers a new initializer function with a given name.

  Parameters:

  1. `name`: `string` Name of an initializer (how serialized data would refer to it).

  2. `fn`: `function` Initializer function (returning value for serialized data to use).
## Function stringify.substep(out, ptr, obj, lineBreak, depthLimit)
Serialization substep. Works similar to `stringify()` itself, but instead of returning string simply adds new terms to
`out` table. Use it in custom `__stringify` methods for serializing child items if you need the best performance.

  Parameters:

  1. `out`: `string[]` Output table with words to concatenate later (without any joining string).

  2. `ptr`: `integer` Position within `out` table to write next word into. At the very start, when table is empty, it would be 1.

  3. `obj`: `any` Item to serialize.

  4. `lineBreak`: `string|nil` Line break with some spaces for aligning child items, or `nil` if compact stringify mode is used. One tab is two spaces.

  5. `depthLimit`: `integer` Limits how many steps down serialization can go. If 0 or below, no tables would be serialized.

  Returns:

  - `integer` Updated `ptr` value (if one item was added to `out`, should increase by 1).
## Function stringify.binary(obj)
Different serializer, produces binary data instead of human-readable. Faster and with even more compact output, but not human-readable.

  Parameters:

  1. `obj`: `table|number|string|boolean|nil` Object to serialize.

  Returns:

  - `string` String with input data presented in binary format, so it won’t be readable and will contain zero bytes.
## Function stringify.binary.parse(serialized)
Parses binary data prepared with `stringify.binary()`.

  Parameters:

  1. `serialized`: `string` Serialized data.

  Returns:

  - `table|number|string|boolean|nil`
## Function stringify.binary.tryParse(serialized, fallback)
Tries to parse binary data prepared with `stringify.binary()`.

Returns fallback value if failed to parse, or if `serialized` is empty or not set, or if any of initializers would raise an error.

  Parameters:

  1. `serialized`: `string?` Serialized data.

  2. `fallback`: `T|nil` Value to return if parsing failed.

  Returns:

  - `T`
## Class ClassStringifiable
A small helper to add as a parent class for EmmyLua to work better.

- `ClassStringifiable:__stringify(out, ptr, obj, lineBreak, depthLimit)`

  Serialize instance of class. Can either return a `string`, or construct it into `out` table and return a new position in it. String itself should be a like of
Lua code which would reconstruct the object on deserialization. Don’t forget to either register referred function with `stringify.register()` or provide
a reference to it in `namespace` table with `stringify.parse()`.

Note: to serialize sub-objects, such as constructor arguments, you can use `stringify()` or `stringify.substep()` if you’re using an approach with
manually constructing `out` table. Alternatively for basic types you can use `string.format()`: “%q” would give you a string in Lua format, so you can use it
like so:
```lua
function MyClass:__serialize()
  return string.format('MyClass(%q, %s)', self.stringName, self.numericalCounter)
end
```

  Parameters:

    1. `out`: `string[]` Output table with words to concatenate later (without any joining string).

    2. `ptr`: `integer` Position within `out` table to write next word into. At the very start, when table is empty, it would be 1.

    3. `obj`: `any` Item to serialize.

    4. `lineBreak`: `string|nil` Line break with some spaces for aligning child items, or `nil` if compact stringify mode is used. One tab is two spaces.

    5. `depthLimit`: `integer` Limits how many steps down serialization can go. If 0 or below, no tables would be serialized.

  Returns:

    - `integer` Updated `ptr` value (if one item was added to `out`, should increase by 1).

# Module common/json.lua

## Function JSON.stringify(data)
Serializes a Lua entity (like a table) into a compact JSON.

  Parameters:

  1. `data`: `table|number|string|boolean|nil`

  Returns:

  - `string`
## Function JSON.parse(data)
Parses a compact JSON into a Lua entity. Note: if JSON is damaged, parser won’t throw an error, but
results might be somewhat unpredictable. It’s an intended behaviour: in 99% of cases JSON parser
used to exchange data with, for example, API endpoints, will receive correct data, but some of those
AC JSON files are pretty screwed and often include things like missing commas, comments, etc.

  Parameters:

  1. `data`: `string?`

  Returns:

  - `any`

# Module common/ac_primitive_vec2.d.lua

## Function vec2.new(x, y)
Creates new vector. It’s usually faster to create a new item with `vec2(x, y)` directly, but the way LuaJIT works,
that call only works with two numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Returns:

  - `vec2`
## Function vec2.isvec2(p)
Checks if value is vec2 or not.

  Parameters:

  1. `p`: `any`

  Returns:

  - `boolean`
## Function vec2.tmp()
Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

  - `vec2`
## Function vec2.intersect(p1, p2, p3, p4)
Intersects two line segments, one going from `p1` to `p2` and another going from `p3` to `p4`. Returns intersection point or `nil` if there is no intersection.

  Returns:

  - `vec2`
## Function vec2(x, y)
Two-dimensional vector. All operators are overloaded. Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
```lua
someVec = vec2()
…
someVec = math.normalize(vec1 + vec2) * 10
```
Consider rewriting it like:
```lua
someVec = vec2()
…
someVec:set(vec1):add(vec2):normalize():scale(10)
```

  Parameters:

  1. `x`: `number?`

  2. `y`: `number?`

  Returns:

  - `vec2`
## Class vec2
Two-dimensional vector. All operators are overloaded. Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
```lua
someVec = vec2()
…
someVec = math.normalize(vec1 + vec2) * 10
```
Consider rewriting it like:
```lua
someVec = vec2()
…
someVec:set(vec1):add(vec2):normalize():scale(10)
```

- `vec2.new(x, y)`

  Creates new vector. It’s usually faster to create a new item with `vec2(x, y)` directly, but the way LuaJIT works,
that call only works with two numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Returns:

    - `vec2`

- `vec2.isvec2(p)`

  Checks if value is vec2 or not.

  Parameters:

    1. `p`: `any`

  Returns:

    - `boolean`

- `vec2.tmp()`

  Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

    - `vec2`

- `vec2.intersect(p1, p2, p3, p4)`

  Intersects two line segments, one going from `p1` to `p2` and another going from `p3` to `p4`. Returns intersection point or `nil` if there is no intersection.

  Returns:

    - `vec2`

- `vec2:clone()`

  Makes a copy of a vector.

  Returns:

    - `vec2`

- `vec2:unpack()`

  Unpacks vec2 into two numbers.

  Returns:

    - `number`

- `vec2:table()`

  Turns vec2 into a table with two values.

  Returns:

    - `number`

- `vec2:type()`

  Returns reference to vec2 class.
function vec2:type() end

- `vec2:set(x, y)`

  Parameters:

    1. `x`: `vec2|number`

    2. `y`: `number?`

  Returns:

    - `vec2` Returns itself.

- `vec2:setScaled(vec, scale)`

  Parameters:

    1. `vec`: `vec2`

    2. `scale`: `number`

  Returns:

    - `vec2` Returns itself.

- `vec2:setLerp(value1, value2, mix)`

  Parameters:

    1. `value1`: `vec2`

    2. `value2`: `vec2`

    3. `mix`: `number`

  Returns:

    - `vec2` Returns itself.

- `vec2:copyTo(out)`

  Copies its values to a different vector.

  Parameters:

    1. `out`: `vec2`

  Returns:

    - `vec2` Returns itself.

- `vec2:add(valueToAdd, out)`

  Parameters:

    1. `valueToAdd`: `vec2|number`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:addScaled(valueToAdd, scale, out)`

  Parameters:

    1. `valueToAdd`: `vec2`

    2. `scale`: `number`

    3. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:sub(valueToSubtract, out)`

  Parameters:

    1. `valueToSubtract`: `vec2|number`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:mul(valueToMultiplyBy, out)`

  Parameters:

    1. `valueToMultiplyBy`: `vec2`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:div(valueToDivideBy, out)`

  Parameters:

    1. `valueToDivideBy`: `vec2`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:pow(exponent, out)`

  Parameters:

    1. `exponent`: `vec2|number`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:scale(multiplier, out)`

  Parameters:

    1. `multiplier`: `number`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:min(otherValue, out)`

  Parameters:

    1. `otherValue`: `vec2|number`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:max(otherValue, out)`

  Parameters:

    1. `otherValue`: `vec2|number`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:saturate(out)`

  Parameters:

    1. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:clamp(min, max, out)`

  Parameters:

    1. `min`: `vec2`

    2. `max`: `vec2`

    3. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:length()`

  Returns:

    - `number`

- `vec2:lengthSquared()`

  Returns:

    - `number`

- `vec2:distance(otherVector)`

  Parameters:

    1. `otherVector`: `vec2`

  Returns:

    - `number`

- `vec2:distanceSquared(otherVector)`

  Parameters:

    1. `otherVector`: `vec2`

  Returns:

    - `number`

- `vec2:closerToThan(otherVector, distanceThreshold)`

  Parameters:

    1. `otherVector`: `vec2`

    2. `distanceThreshold`: `number`

  Returns:

    - `boolean`

- `vec2:angle(otherVector)`

  Parameters:

    1. `otherVector`: `vec2`

  Returns:

    - `number` Radians.

- `vec2:dot(otherVector)`

  Parameters:

    1. `otherVector`: `vec2`

  Returns:

    - `number`

- `vec2:normalize(out)`

  Normalizes itself (unless different `out` is provided).

  Parameters:

    1. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:lerp(otherVector, mix, out)`

  Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `vec2`

    2. `mix`: `number`

    3. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

- `vec2:project(otherVector, out)`

  Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `vec2`

    2. `out`: `vec2|nil` Optional destination argument.

  Returns:

    - `vec2` Returns itself or out value.

# Module common/ac_primitive_vec3.d.lua

## Function vec3.new(x, y, z)
Creates new vector. It’s usually faster to create a new item with `vec3(x, y, z)` directly, but the way LuaJIT works,
that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

  1. `x`: `number?`

  2. `y`: `number?`

  3. `z`: `number?`

  Returns:

  - `vec3`
## Function vec3.isvec3(p)
Checks if value is vec3 or not.

  Parameters:

  1. `p`: `any`

  Returns:

  - `boolean`
## Function vec3.tmp()
Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

  - `vec3`
## Function vec3(x, y, z)
Three-dimensional vector. All operators are overloaded.
Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
```lua
someVec = vec3()
…
someVec = math.normalize(vec1 + vec2) * 10
```
Consider rewriting it like:
```lua
someVec = vec3()
…
someVec:set(vec1):add(vec2):normalize():scale(10)
```

  Parameters:

  1. `x`: `number?`

  2. `y`: `number?`

  3. `z`: `number?`

  Returns:

  - `vec3`
## Class vec3
Three-dimensional vector. All operators are overloaded.
Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
```lua
someVec = vec3()
…
someVec = math.normalize(vec1 + vec2) * 10
```
Consider rewriting it like:
```lua
someVec = vec3()
…
someVec:set(vec1):add(vec2):normalize():scale(10)
```

- `vec3.new(x, y, z)`

  Creates new vector. It’s usually faster to create a new item with `vec3(x, y, z)` directly, but the way LuaJIT works,
that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

    1. `x`: `number?`

    2. `y`: `number?`

    3. `z`: `number?`

  Returns:

    - `vec3`

- `vec3.isvec3(p)`

  Checks if value is vec3 or not.

  Parameters:

    1. `p`: `any`

  Returns:

    - `boolean`

- `vec3.tmp()`

  Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

    - `vec3`

- `vec3:clone()`

  Makes a copy of a vector.

  Returns:

    - `vec3`

- `vec3:unpack()`

  Unpacks vec3 into three numbers.

  Returns:

    - `number`

- `vec3:table()`

  Turns vec3 into a table with three values.

  Returns:

    - `number`

- `vec3:type()`

  Returns reference to vec3 class.
function vec3:type() end

- `vec3:set(x, y, z)`

  Parameters:

    1. `x`: `vec3|number`

    2. `y`: `number?`

    3. `z`: `number?`

  Returns:

    - `vec3` Returns itself.

- `vec3:setScaled(vec, scale)`

  Parameters:

    1. `vec`: `vec3`

    2. `scale`: `number`

  Returns:

    - `vec3` Returns itself.

- `vec3:setLerp(value1, value2, mix)`

  Parameters:

    1. `value1`: `vec3`

    2. `value2`: `vec3`

    3. `mix`: `number`

  Returns:

    - `vec3` Returns itself.

- `vec3:setCrossNormalized(value1, value2)`

  Sets itself to a normalized result of cross product of value1 and value2.

  Parameters:

    1. `value1`: `vec3`

    2. `value2`: `vec3`

  Returns:

    - `vec3` Returns itself.

- `vec3:copyTo(out)`

  Copies its values to a different vector.

  Parameters:

    1. `out`: `vec3`

  Returns:

    - `vec3` Returns itself.

- `vec3:add(valueToAdd, out)`

  Parameters:

    1. `valueToAdd`: `vec3|number`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:addScaled(valueToAdd, scale, out)`

  Parameters:

    1. `valueToAdd`: `vec3`

    2. `scale`: `number`

    3. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:sub(valueToSubtract, out)`

  Parameters:

    1. `valueToSubtract`: `vec3|number`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:mul(valueToMultiplyBy, out)`

  Parameters:

    1. `valueToMultiplyBy`: `vec3`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:div(valueToDivideBy, out)`

  Parameters:

    1. `valueToDivideBy`: `vec3`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:pow(exponent, out)`

  Parameters:

    1. `exponent`: `vec3|number`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:scale(multiplier, out)`

  Parameters:

    1. `multiplier`: `number`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:min(otherValue, out)`

  Parameters:

    1. `otherValue`: `vec3|number`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:max(otherValue, out)`

  Parameters:

    1. `otherValue`: `vec3|number`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:saturate(out)`

  Parameters:

    1. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:clamp(min, max, out)`

  Parameters:

    1. `min`: `vec3`

    2. `max`: `vec3`

    3. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:length()`

  Returns:

    - `number`

- `vec3:lengthSquared()`

  Returns:

    - `number`

- `vec3:distance(otherVector)`

  Parameters:

    1. `otherVector`: `vec3`

  Returns:

    - `number`

- `vec3:distanceSquared(otherVector)`

  Parameters:

    1. `otherVector`: `vec3`

  Returns:

    - `number`

- `vec3:closerToThan(otherVector, distanceThreshold)`

  Parameters:

    1. `otherVector`: `vec3`

    2. `distanceThreshold`: `number`

  Returns:

    - `boolean`

- `vec3:angle(otherVector)`

  Parameters:

    1. `otherVector`: `vec3`

  Returns:

    - `number` Radians.

- `vec3:dot(otherVector)`

  Parameters:

    1. `otherVector`: `vec3`

  Returns:

    - `number`

- `vec3:normalize(out)`

  Normalizes itself (unless different `out` is provided).

  Parameters:

    1. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:cross(otherVector, out)`

  Rewrites own values with values of cross product of itself and other vector (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `vec3`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:lerp(otherVector, mix, out)`

  Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `vec3`

    2. `mix`: `number`

    3. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:project(otherVector, out)`

  Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `vec3`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:rotate(quaternion, out)`

  Rewrites own values with values of itself rotated with quaternion (unless different `out` is provided).

  Parameters:

    1. `quaternion`: `quat`

    2. `out`: `vec3|nil` Optional destination argument.

  Returns:

    - `vec3` Returns itself or out value.

- `vec3:distanceToLine(a, b)`

  Returns distance from point to a line. For performance reasons doesn’t do any checks, so be careful with incoming arguments.

  Returns:

    - `number`

- `vec3:distanceToLineSquared(a, b)`

  Returns squared distance from point to a line. For performance reasons doesn’t do any checks, so be careful with incoming arguments.

  Returns:

    - `number`

# Module common/ac_primitive_vec4.d.lua

## Function vec4.new(x, y, z, w)
Creates new vector. It’s usually faster to create a new item with `vec4(x, y, z, w)` directly, but the way LuaJIT works,
that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

  1. `x`: `number?`

  2. `y`: `number?`

  3. `z`: `number?`

  4. `w`: `number?`

  Returns:

  - `vec4`
## Function vec4.isvec4(p)
Checks if value is vec4 or not.

  Parameters:

  1. `p`: `any`

  Returns:

  - `boolean`
## Function vec4.tmp()
Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

  - `vec4`
## Function vec4(x, y, z, w)
Four-dimensional vector. All operators are also overloaded.
Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
```lua
someVec = vec4()
…
someVec = math.normalize(vec1 + vec2) * 10
```
Consider rewriting it like:
```lua
someVec = vec4()
…
someVec:set(vec1):add(vec2):normalize():scale(10)
```

  Parameters:

  1. `x`: `number?`

  2. `y`: `number?`

  3. `z`: `number?`

  4. `w`: `number?`

  Returns:

  - `vec4`
## Class vec4
Four-dimensional vector. All operators are also overloaded.
Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
```lua
someVec = vec4()
…
someVec = math.normalize(vec1 + vec2) * 10
```
Consider rewriting it like:
```lua
someVec = vec4()
…
someVec:set(vec1):add(vec2):normalize():scale(10)
```

- `vec4.new(x, y, z, w)`

  Creates new vector. It’s usually faster to create a new item with `vec4(x, y, z, w)` directly, but the way LuaJIT works,
that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

    1. `x`: `number?`

    2. `y`: `number?`

    3. `z`: `number?`

    4. `w`: `number?`

  Returns:

    - `vec4`

- `vec4.isvec4(p)`

  Checks if value is vec4 or not.

  Parameters:

    1. `p`: `any`

  Returns:

    - `boolean`

- `vec4.tmp()`

  Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

    - `vec4`

- `vec4:clone()`

  Makes a copy of a vector.

  Returns:

    - `vec4`

- `vec4:unpack()`

  Unpacks vec4 into four numbers.

  Returns:

    - `number`

- `vec4:table()`

  Turns vec4 into a table with four values.

  Returns:

    - `number`

- `vec4:type()`

  Returns reference to vec4 class.
function vec4:type() end

- `vec4:set(x, y, z, w)`

  Parameters:

    1. `x`: `vec4|number`

    2. `y`: `number?`

    3. `z`: `number?`

    4. `w`: `number?`

  Returns:

    - `vec4` Returns itself.

- `vec4:setScaled(vec, scale)`

  Parameters:

    1. `vec`: `vec4`

    2. `scale`: `number`

  Returns:

    - `vec4` Returns itself.

- `vec4:setLerp(value1, value2, mix)`

  Parameters:

    1. `value1`: `vec4`

    2. `value2`: `vec4`

    3. `mix`: `number`

  Returns:

    - `vec4` Returns itself.

- `vec4:setCrossNormalized(value1, value2)`

  Sets itself to a normalized result of cross product of value1 and value2.

  Parameters:

    1. `value1`: `vec4`

    2. `value2`: `vec4`

  Returns:

    - `vec4` Returns itself.

- `vec4:copyTo(out)`

  Copies its values to a different vector.

  Parameters:

    1. `out`: `vec4`

  Returns:

    - `vec4` Returns itself.

- `vec4:add(valueToAdd, out)`

  Parameters:

    1. `valueToAdd`: `vec4|number`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:addScaled(valueToAdd, scale, out)`

  Parameters:

    1. `valueToAdd`: `vec4`

    2. `scale`: `number`

    3. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:sub(valueToSubtract, out)`

  Parameters:

    1. `valueToSubtract`: `vec4|number`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:mul(valueToMultiplyBy, out)`

  Parameters:

    1. `valueToMultiplyBy`: `vec4`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:div(valueToDivideBy, out)`

  Parameters:

    1. `valueToDivideBy`: `vec4`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:pow(exponent, out)`

  Parameters:

    1. `exponent`: `vec4|number`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:scale(multiplier, out)`

  Parameters:

    1. `multiplier`: `number`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:min(otherValue, out)`

  Parameters:

    1. `otherValue`: `vec4|number`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:max(otherValue, out)`

  Parameters:

    1. `otherValue`: `vec4|number`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:saturate(out)`

  Parameters:

    1. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:clamp(min, max, out)`

  Parameters:

    1. `min`: `vec4`

    2. `max`: `vec4`

    3. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:length()`

  Returns:

    - `number`

- `vec4:lengthSquared()`

  Returns:

    - `number`

- `vec4:distance(otherVector)`

  Parameters:

    1. `otherVector`: `vec4`

  Returns:

    - `number`

- `vec4:distanceSquared(otherVector)`

  Parameters:

    1. `otherVector`: `vec4`

  Returns:

    - `number`

- `vec4:closerToThan(otherVector, distanceThreshold)`

  Parameters:

    1. `otherVector`: `vec4`

    2. `distanceThreshold`: `number`

  Returns:

    - `boolean`

- `vec4:angle(otherVector)`

  Parameters:

    1. `otherVector`: `vec4`

  Returns:

    - `number` Radians.

- `vec4:dot(otherVector)`

  Parameters:

    1. `otherVector`: `vec4`

  Returns:

    - `number`

- `vec4:normalize(out)`

  Normalizes itself (unless different `out` is provided).

  Parameters:

    1. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:lerp(otherVector, mix, out)`

  Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `vec4`

    2. `mix`: `number`

    3. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

- `vec4:project(otherVector, out)`

  Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `vec4`

    2. `out`: `vec4|nil` Optional destination argument.

  Returns:

    - `vec4` Returns itself or out value.

# Module common/ac_primitive_rgb.d.lua

## Function rgb.new(r, g, b, m)
Creates new instance. It’s usually faster to create a new item with `rgb(r, g, b, mult)` directly, but the way LuaJIT works,
that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

  1. `r`: `number?`

  2. `g`: `number?`

  3. `b`: `number?`

  Returns:

  - `rgb`
## Function rgb.isrgb(p)
Checks if value is rgb or not.

  Parameters:

  1. `p`: `any`

  Returns:

  - `boolean`
## Function rgb.tmp()
Temporary color. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

  - `rgb`
## Function rgb.from0255(r, g, b, a)
Creates color from 0…255 values

  Parameters:

  1. `r`: `number` From 0 to 255

  2. `g`: `number` From 0 to 255

  3. `b`: `number` From 0 to 255

  Returns:

  - `rgb`
## Function rgb(r, g, b)
Three-channel color. All operators are overloaded. White is usually `rgb=1,1,1`.

  Parameters:

  1. `r`: `number?`

  2. `g`: `number?`

  3. `b`: `number?`

  Returns:

  - `rgb`
## Class rgb
Three-channel color. All operators are overloaded. White is usually `rgb=1,1,1`.

- `rgb.new(r, g, b, m)`

  Creates new instance. It’s usually faster to create a new item with `rgb(r, g, b, mult)` directly, but the way LuaJIT works,
that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

    1. `r`: `number?`

    2. `g`: `number?`

    3. `b`: `number?`

  Returns:

    - `rgb`

- `rgb.isrgb(p)`

  Checks if value is rgb or not.

  Parameters:

    1. `p`: `any`

  Returns:

    - `boolean`

- `rgb.tmp()`

  Temporary color. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

    - `rgb`

- `rgb.from0255(r, g, b, a)`

  Creates color from 0…255 values

  Parameters:

    1. `r`: `number` From 0 to 255

    2. `g`: `number` From 0 to 255

    3. `b`: `number` From 0 to 255

  Returns:

    - `rgb`

- `rgb:clone()`

  Makes a copy of a vector.

  Returns:

    - `rgb`

- `rgb:unpack()`

  Unpacks rgb into three numbers.

  Returns:

    - `rgb`

- `rgb:table()`

  Turns rgb into a table with three numbers.

  Returns:

    - `number`

- `rgb:type()`

  Returns reference to rgb class.
function rgb:type() end

- `rgb:set(r, g, b)`

  Parameters:

    1. `r`: `rgb|number`

    2. `g`: `number?`

    3. `b`: `number?`

  Returns:

    - `rgb` Returns itself.

- `rgb:setScaled(x, mult)`

  Parameters:

    1. `x`: `rgb`

    2. `mult`: `number`

  Returns:

    - `rgb` Returns itself.

- `rgb:setLerp(value1, value2, mix)`

  Parameters:

    1. `value1`: `rgb`

    2. `value2`: `rgb`

    3. `mix`: `number`

  Returns:

    - `rgb` Returns itself.

- `rgb:add(valueToAdd, out)`

  Parameters:

    1. `valueToAdd`: `rgb|number`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:addScaled(valueToAdd, scale, out)`

  Parameters:

    1. `valueToAdd`: `rgb`

    2. `scale`: `number`

    3. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:sub(valueToSubtract, out)`

  Parameters:

    1. `valueToSubtract`: `rgb|number`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:mul(valueToMultiplyBy, out)`

  Parameters:

    1. `valueToMultiplyBy`: `rgb`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:div(valueToDivideBy, out)`

  Parameters:

    1. `valueToDivideBy`: `rgb`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:pow(exponent, out)`

  Parameters:

    1. `exponent`: `rgb|number`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:scale(multiplier, out)`

  Parameters:

    1. `multiplier`: `number`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:min(otherValue, out)`

  Parameters:

    1. `otherValue`: `rgb|number`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:max(otherValue, out)`

  Parameters:

    1. `otherValue`: `rgb|number`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:saturate(out)`

  Parameters:

    1. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:clamp(min, max, out)`

  Parameters:

    1. `min`: `rgb`

    2. `max`: `rgb`

    3. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:adjustSaturation(saturation, out)`

  Adjusts saturation using a very simple formula.

  Parameters:

    1. `saturation`: `number`

    2. `out`: `rgb|nil` Optional destination argument.

  Returns:

    - `rgb` Returns itself or out value.

- `rgb:normalize()`

  Makes sure brightest value does not exceed 1.

  Returns:

    - `rgb` Returns itself.

- `rgb:value()`

  Returns brightest value (aka V in HSV).

  Returns:

    - `number`

- `rgb:hue()`

  Returns hue.

  Returns:

    - `number`

- `rgb:saturation()`

  Returns saturation.

  Returns:

    - `number`

- `rgb:luminance()`

  Returns luminance value.

  Returns:

    - `number`

- `rgb:rgbm(mult)`

  Returns rgbm.

  Parameters:

    1. `mult`: `number?` Default value: 1.

  Returns:

    - `rgbm`

- `rgb:hsv(out)`

  Returns HSV color of rgb*mult.

  Parameters:

    1. `out`: `hsv?` If set, assigns result to given `hsv` instead of creating a new one. Added in 0.2.10.

  Returns:

    - `hsv`

- `rgb:vec3()`

  Returns rgb*mult turned to vec3.

  Returns:

    - `vec3`

- `rgb:hex()`

  Returns string with hex representation and leading “#”.

  Returns:

    - `string`

# Module common/ac_primitive_hsv.d.lua

## Function hsv.new(h, s, v)
Creates new instance. It’s usually faster to create a new item with `hsv(h, s, v)`.

  Parameters:

  1. `h`: `number?`

  2. `s`: `number?`

  3. `v`: `number?`

  Returns:

  - `hsv`
## Function hsv.ishsv(p)
Checks if value is hsv or not.

  Parameters:

  1. `p`: `any`

  Returns:

  - `boolean`
## Function hsv.tmp()
Temporary HSV color. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

  - `hsv`
## Function hsv(h, s, v)
HSV color (hue, saturation, value). Equality operator is overloaded.

  Parameters:

  1. `h`: `number?`

  2. `s`: `number?`

  3. `v`: `number?`

  Returns:

  - `hsv`
## Class hsv
HSV color (hue, saturation, value). Equality operator is overloaded.

- `hsv.new(h, s, v)`

  Creates new instance. It’s usually faster to create a new item with `hsv(h, s, v)`.

  Parameters:

    1. `h`: `number?`

    2. `s`: `number?`

    3. `v`: `number?`

  Returns:

    - `hsv`

- `hsv.ishsv(p)`

  Checks if value is hsv or not.

  Parameters:

    1. `p`: `any`

  Returns:

    - `boolean`

- `hsv.tmp()`

  Temporary HSV color. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

    - `hsv`

- `hsv:clone()`

  Makes a copy of a vector.

  Returns:

    - `hsv`

- `hsv:unpack()`

  Unpacks hsv into three numbers.

  Returns:

    - `rgb`

- `hsv:table()`

  Turns hsv into a table with three numbers.

  Returns:

    - `number`

- `hsv:type()`

  Returns reference to hsv class.
function hsv:type() end

- `hsv:set(h, s, v)`

  Parameters:

    1. `h`: `number`

    2. `s`: `number`

    3. `v`: `number`

  Returns:

    - `hsv` Returns itself.

- `hsv:rgb(out)`

  Returns RGB color.

  Parameters:

    1. `out`: `rgb?` If set, assigns result to given `rgb` instead of creating a new one. Added in 0.2.10.

  Returns:

    - `rgb`

# Module common/ac_primitive_rgbm.d.lua

## Function rgbm.new(r, g, b, m)
Creates new instance. It’s usually faster to create a new item with `rgbm(r, g, b, mult)` directly, but the way LuaJIT works,
that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

  1. `r`: `number?`

  2. `g`: `number?`

  3. `b`: `number?`

  4. `m`: `number?` Default value: 1.

  Returns:

  - `rgbm`
## Function rgbm.isrgbm(p)
Checks if value is rgbm or not.

  Parameters:

  1. `p`: `any`

  Returns:

  - `boolean`
## Function rgbm.tmp()
Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

  - `rgbm`
## Function rgbm.from0255(r, g, b, a)
Creates color from 0…255 values

  Parameters:

  1. `r`: `number` From 0 to 255.

  2. `g`: `number` From 0 to 255.

  3. `b`: `number` From 0 to 255.

  4. `a`: `number?` From 0 to 1. Default value: 1.

  Returns:

  - `rgbm`
## Function rgbm(r, g, b, mult)
Four-channel color. Fourth value, `mult`, can be used for alpha, for brightness, anything like that. All operators are also 
overloaded. White is usually `rgb=1,1,1`.

  Parameters:

  1. `r`: `number?`

  2. `g`: `number?`

  3. `b`: `number?`

  4. `mult`: `number?`

  Returns:

  - `rgbm`
## Class rgbm
Four-channel color. Fourth value, `mult`, can be used for alpha, for brightness, anything like that. All operators are also 
overloaded. White is usually `rgb=1,1,1`.

- `rgbm.new(r, g, b, m)`

  Creates new instance. It’s usually faster to create a new item with `rgbm(r, g, b, mult)` directly, but the way LuaJIT works,
that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

    1. `r`: `number?`

    2. `g`: `number?`

    3. `b`: `number?`

    4. `m`: `number?` Default value: 1.

  Returns:

    - `rgbm`

- `rgbm.isrgbm(p)`

  Checks if value is rgbm or not.

  Parameters:

    1. `p`: `any`

  Returns:

    - `boolean`

- `rgbm.tmp()`

  Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

    - `rgbm`

- `rgbm.from0255(r, g, b, a)`

  Creates color from 0…255 values

  Parameters:

    1. `r`: `number` From 0 to 255.

    2. `g`: `number` From 0 to 255.

    3. `b`: `number` From 0 to 255.

    4. `a`: `number?` From 0 to 1. Default value: 1.

  Returns:

    - `rgbm`

- `rgbm:clone()`

  Makes a copy of a vector.

  Returns:

    - `rgbm`

- `rgbm:unpack()`

  Unpacks rgbm into rgb and number.

  Returns:

    - `rgb`

- `rgbm:table()`

  Turns rgbm into a table with four values.

  Returns:

    - `number`

- `rgbm:type()`

  Returns reference to rgbm class.
function rgbm:type() end

- `rgbm:set(rgb, mult)`

  Parameters:

    1. `rgb`: `rgbm|rgb`

    2. `mult`: `number?`

  Returns:

    - `rgbm` Returns itself.

- `rgbm:setLerp(value1, value2, mix)`

  Parameters:

    1. `value1`: `rgbm`

    2. `value2`: `rgbm`

    3. `mix`: `number`

  Returns:

    - `rgbm` Returns itself.

- `rgbm:add(valueToAdd, out)`

  Parameters:

    1. `valueToAdd`: `rgbm|number`

    2. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:addScaled(valueToAdd, scale, out)`

  Parameters:

    1. `valueToAdd`: `rgbm`

    2. `scale`: `number`

    3. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:sub(valueToSubtract, out)`

  Parameters:

    1. `valueToSubtract`: `rgbm|number`

    2. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:mul(valueToMultiplyBy, out)`

  Parameters:

    1. `valueToMultiplyBy`: `rgbm`

    2. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:div(valueToDivideBy, out)`

  Parameters:

    1. `valueToDivideBy`: `rgbm`

    2. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:pow(exponent, out)`

  Parameters:

    1. `exponent`: `rgbm|number`

    2. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:scale(multiplier, out)`

  Parameters:

    1. `multiplier`: `number`

    2. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:min(otherValue, out)`

  Parameters:

    1. `otherValue`: `rgbm|number`

    2. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:max(otherValue, out)`

  Parameters:

    1. `otherValue`: `rgbm|number`

    2. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:saturate(out)`

  Parameters:

    1. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:clamp(min, max, out)`

  Parameters:

    1. `min`: `rgbm`

    2. `max`: `rgbm`

    3. `out`: `rgbm|nil` Optional destination argument.

  Returns:

    - `rgbm` Returns itself or out value.

- `rgbm:normalize()`

  Makes sure brightest value does not exceed 1.

  Returns:

    - `rgbm` Returns itself.

- `rgbm:value()`

  Returns brightest value.

  Returns:

    - `number`

- `rgbm:luminance()`

  Returns luminance value.

  Returns:

    - `number`

- `rgbm:color()`

  Returns color (rgb*mult).

  Returns:

    - `rgb`

- `rgbm:hsv()`

  Returns HSV color of rgb*mult.

  Returns:

    - `hsv`

- `rgbm:vec3()`

  Returns rgb*mult turned to vec3.

  Returns:

    - `vec3`

- `rgbm:vec4()`

  Returns vec4, where X, Y and Z are RGB values and W is mult.

  Returns:

    - `vec4`

- `rgbm:hex()`

  Returns string with hex representation and leading “#”.

  Returns:

    - `string`

# Module common/ac_primitive_quat.d.lua

## Function quat.new(x, y, z, w)
Creates new quaternion. It’s usually faster to create a new item with `quat(x, y, z, w)` directly, but the way LuaJIT works,
that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

  1. `x`: `number?`

  2. `y`: `number?`

  3. `z`: `number?`

  4. `w`: `number?`

  Returns:

  - `quat`
## Function quat.isquat(p)
Checks if value is quat or not.

  Parameters:

  1. `p`: `any`

  Returns:

  - `boolean`
## Function quat.fromAngleAxis(angle, x, y, z)
Creates a new quaternion.

  Parameters:

  1. `angle`: `number` In radians.

  2. `x`: `vec3|number`

  3. `y`: `number?`

  4. `z`: `number?`

  Returns:

  - `quat`
## Function quat.fromDirection(x, y, z)
Creates a new quaternion.

  Parameters:

  1. `x`: `vec3|number`

  2. `y`: `number?`

  3. `z`: `number?`

  Returns:

  - `quat`
## Function quat.between(u, v)
Creates a new quaternion.

  Parameters:

  1. `u`: `quat`

  2. `v`: `quat`

  Returns:

  - `quat`
## Function quat.tmp()
Temporary quaternion. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

  - `quat`
## Function quat(x, y, z, w)
Quaternion. All operators are overloaded.

  Parameters:

  1. `x`: `number?`

  2. `y`: `number?`

  3. `z`: `number?`

  4. `w`: `number?`

  Returns:

  - `quat`
## Class quat
Quaternion. All operators are overloaded.

- `quat.new(x, y, z, w)`

  Creates new quaternion. It’s usually faster to create a new item with `quat(x, y, z, w)` directly, but the way LuaJIT works,
that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
various calls (which also makes it slightly slower).

  Parameters:

    1. `x`: `number?`

    2. `y`: `number?`

    3. `z`: `number?`

    4. `w`: `number?`

  Returns:

    - `quat`

- `quat.isquat(p)`

  Checks if value is quat or not.

  Parameters:

    1. `p`: `any`

  Returns:

    - `boolean`

- `quat.fromAngleAxis(angle, x, y, z)`

  Creates a new quaternion.

  Parameters:

    1. `angle`: `number` In radians.

    2. `x`: `vec3|number`

    3. `y`: `number?`

    4. `z`: `number?`

  Returns:

    - `quat`

- `quat.fromDirection(x, y, z)`

  Creates a new quaternion.

  Parameters:

    1. `x`: `vec3|number`

    2. `y`: `number?`

    3. `z`: `number?`

  Returns:

    - `quat`

- `quat.between(u, v)`

  Creates a new quaternion.

  Parameters:

    1. `u`: `quat`

    2. `v`: `quat`

  Returns:

    - `quat`

- `quat.tmp()`

  Temporary quaternion. For most cases though, it might be better to define those locally and use those. Less chance of collision.

  Returns:

    - `quat`

- `quat:clone()`

  Makes a copy of a quaternion.

  Returns:

    - `quat`

- `quat:unpack()`

  Unpacks quat into four numbers.

  Returns:

    - `number`

- `quat:table()`

  Turns quat into a table with four values.

  Returns:

    - `number`

- `quat:type()`

  Returns reference to quat class.
function quat:type() end

- `quat:set(x, y, z, w)`

  Parameters:

    1. `x`: `quat|number`

    2. `y`: `number?`

    3. `z`: `number?`

    4. `w`: `number?`

  Returns:

    - `quat` Returns itself.

- `quat:setAngleAxis(angle, x, y, z)`

  Parameters:

    1. `angle`: `number` In radians.

    2. `x`: `vec3|number`

    3. `y`: `number?`

    4. `z`: `number?`

  Returns:

    - `quat` Returns itself.

- `quat:getAngleAxis()`

  Returns:

    1. `number` Angle in radians.

    2. `number` Axis, X.

    3. `number` Axis, Y.

    4. `number` Axis, Z.

- `quat:setBetween(u, v)`

  Parameters:

    1. `u`: `quat`

    2. `v`: `quat`

  Returns:

    - `quat` Returns itself.

- `quat:setDirection(x, y, z)`

  Parameters:

    1. `x`: `vec3|number`

    2. `y`: `number?`

    3. `z`: `number?`

  Returns:

    - `quat` Returns itself.

- `quat:add(valueToAdd, out)`

  Parameters:

    1. `valueToAdd`: `quat|number`

    2. `out`: `quat|nil` Optional destination argument.

  Returns:

    - `quat` Returns itself or out value.

- `quat:sub(valueToSubtract, out)`

  Parameters:

    1. `valueToSubtract`: `quat|number`

    2. `out`: `quat|nil` Optional destination argument.

  Returns:

    - `quat` Returns itself or out value.

- `quat:mul(valueToMultiplyBy, out)`

  Parameters:

    1. `valueToMultiplyBy`: `quat`

    2. `out`: `quat|nil` Optional destination argument.

  Returns:

    - `quat` Returns itself or out value.

- `quat:scale(multiplier, out)`

  Parameters:

    1. `multiplier`: `number`

    2. `out`: `quat|nil` Optional destination argument.

  Returns:

    - `quat` Returns itself or out value.

- `quat:length()`

  Returns:

    - `number`

- `quat:normalize(out)`

  Normalizes itself (unless different `out` is provided).

  Parameters:

    1. `out`: `quat|nil` Optional destination argument.

  Returns:

    - `quat` Returns itself or out value.

- `quat:lerp(otherVector, mix, out)`

  Rewrites own values with values of lerp of itself and other quaternion (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `quat`

    2. `mix`: `number`

    3. `out`: `quat|nil` Optional destination argument.

  Returns:

    - `quat` Returns itself or out value.

- `quat:slerp(otherVector, mix, out)`

  Rewrites own values with values of slerp of itself and other quaternion (unless different `out` is provided).

  Parameters:

    1. `otherVector`: `quat`

    2. `mix`: `number`

    3. `out`: `quat|nil` Optional destination argument.

  Returns:

    - `quat` Returns itself or out value.

# Module lib_hashspace.lua

## Class ac.HashSpaceItem

- `ac.HashSpaceItem:id()`

  Returns ID associated with an item.

  Returns:

    - `integer`

- `ac.HashSpaceItem:update(pos)`

  Moves an item to a position.

  Parameters:

    1. `pos`: `vec3`

- `ac.HashSpaceItem:dispose()`

  Removes item from its space.
function HashSpaceItem:dispose() end
## Function ac.HashSpace(cellSize)
Simple structure meant to speed up collision detection by arranging items in a grid using hashmap. Cells are arranged horizontally.

  Parameters:

  1. `cellSize`: `number` Should be about twice as large as your largest entity.

  Returns:

  - `ac.HashSpace`
## Class ac.HashSpace
Simple structure meant to speed up collision detection by arranging items in a grid using hashmap. Cells are arranged horizontally.

- `ac.HashSpace:iterate(pos, callback, callbackData)`

  Iterates items around given position.

  Parameters:

    1. `pos`: `vec3`

    2. `callback`: `fun(id: integer, callbackData: T)`

    3. `callbackData`: `T?`

- `ac.HashSpace:anyAround(pos)`

  Checks if there are any items around given position.

  Parameters:

    1. `pos`: `vec3`

  Returns:

    - `boolean`

- `ac.HashSpace:count(pos)`

  Count amount of items around given position.

  Parameters:

    1. `pos`: `vec3`

  Returns:

    - `integer`

- `ac.HashSpace:rawPointers(pos)`

  Returns raw pointers for given position for manual iteration. Be careful!

  Parameters:

    1. `pos`: `vec3`

  Returns:

    - `any`

- `ac.HashSpace:add()`

  Adds a new dynamic item to the grid. Each item gets a new ID.

  Returns:

    - `ac.HashSpaceItem`

- `ac.HashSpace:addFixed(id, pos)`

  Adds a fixed item to the grid, with predetermined ID. Avoid mixing dynamic and fixed items in the same grid.

  Parameters:

    1. `id`: `integer`

    2. `pos`: `vec3`

# Module lib_numlut.lua

## Class ac.Lut
Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
```lua
local lut = ac.Lut([[
 -100 |  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
  -90 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
  -20 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
]], { 2 })
assert(lut:calculate(-95)[1] == 0.5)
```

- `ac.Lut:calculate(input)`

  Interpolate for a given input, return a newly created table. Note: consider using `:calculateTo()` instead to avoid re-creating tables, it would work much more efficiently.

  Parameters:

    1. `input`: `number`

  Returns:

    - `number`

- `ac.Lut:calculateTo(output, input)`

  Interpolate for a given input, write result to a given table.

  Parameters:

    1. `output`: `number[]`

    2. `input`: `number`

  Returns:

    - `number`

# Module lib_numlut_jit.lua

## Class ac.LutJit
Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
```lua
local lutJit = ac.LutJit:new{ data = {
  { input = -100, output = {  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
  { input =  -90, output = {  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
  { input =  -20, output = {  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
  }, hsvRows = { 2 }}
assert(lutJit:calculate(-95)[1] == 1)
```
Obsolete. Use `ac.Lut` instead, with faster C++ implementation.

- `ac.LutJit:new(o, data, hsvRows)`

  Creates new ac.LuaJit instance. Deprecated, use `ac.Lut` instead.

  Parameters:

    1. `data`: `any`

    2. `hsvRows`: `integer[]`  1-based indices of columns (not rows) storing HSV values in them.

  Returns:

    - `table`

- `ac.LutJit:calculate(input)`

  Computes a new value. Deprecated, use `ac.Lut` instead.

  Parameters:

    1. `input`: `number`

  Returns:

    - `number`

- `ac.LutJit:calculateTo(output, input)`

  Computes a new value to a preexisting HSV value. Deprecated, use `ac.Lut` instead.

  Parameters:

    1. `output`: `number[]`

    2. `input`: `number`

  Returns:

    - `number`
## Function ac.LutJit:new(o, data, hsvRows)
Creates new ac.LuaJit instance. Deprecated, use `ac.Lut` instead.

  Parameters:

  1. `data`: `any`

  2. `hsvRows`: `integer[]`  1-based indices of columns (not rows) storing HSV values in them.

  Returns:

  - `table`
## Function ac.LutJit:calculate(input)
Computes a new value. Deprecated, use `ac.Lut` instead.

  Parameters:

  1. `input`: `number`

  Returns:

  - `number`
## Function ac.LutJit:calculateTo(output, input)
Computes a new value to a preexisting HSV value. Deprecated, use `ac.Lut` instead.

  Parameters:

  1. `output`: `number[]`

  2. `input`: `number`

  Returns:

  - `number`

# Module lib_social.lua

## Function ac.isTaggedAsFriend(driverName)
Checks if a user is tagged as a friend. Uses CSP and CM databases. Deprecated, use `ac.DriverTags` instead.

  Parameters:

  1. `driverName`: `string` Driver name.

  Returns:

  - `boolean`
## Function ac.tagAsFriend(driverName, isFriend)
Tags user as a friend (or removes the tag if `false` is passed). Deprecated, use `ac.DriverTags` instead.

  Parameters:

  1. `driverName`: `string` Driver name.

  2. `isFriend`: `boolean?` Default value: `true`.
## Function web.loadRemoteModel(source, callback)
Loads a ZIP file from a given URL, unpacks first KN5 from it to a cache folder and returns
its filename through a callback. If file is already in cache storage, doesn’t do anything and
simply returns filename to it. After callback is called, that filename could be used to load
KN5 in the scene.

If there is a VAO patch in a ZIP file, it will be extracted next to KN5.

Note: only valid KN5 files and VAO patches are supported. Heavy caching is applied: if model was
downloaded once, it would not be re-downloaded (unlike with remote textures where proper HTTP caching
rules apply). If model was not accessed for a couple of weeks, it’ll be removed.

If you need to download several entities and do something afterwards, it might help to use some
promise Lua library.

Use `web.loadRemoteAssets()` instead.

  Parameters:

  1. `source`: `string|{url: string, headers: table<string, string>}` URL to download, or, since 0.2.10, a table.

  2. `callback`: `fun(err: string, filename: string)`
## Function web.loadRemoteAnimation(source, callback)
Loads a ZIP file from a given URL, unpacks first KsAnim from it to a cache folder and returns
its filename through a callback. If file is already in cache storage, doesn’t do anything and
simply returns filename to it. After callback is called, that filename could be used to animate
objects in the scene. If animation was not accessed for a couple of weeks, it’ll be removed.

If you need to download several entities and do something afterwards, it might help to use some
promise Lua library.

Use `web.loadRemoteAssets()` instead.

  Parameters:

  1. `source`: `string|{url: string, headers: table<string, string>}` URL to download, or, since 0.2.10, a table.

  2. `callback`: `fun(err: string, filename: string)`
## Function web.loadRemoteAssets(source, callback)
Loads a ZIP file from a given URL, unpacks assets from it to a cache folder and returns
path to the folder in a callback. If files are already in cache storage, doesn’t do anything and
simply returns the path. After callback is called, you can use path to the folder to get full paths to those assets.
If assets are not accessed for a couple of weeks, they’ll be removed.

Since 0.2.10, scripts with I/O access are allowed to extract all types of files using this function.

  Parameters:

  1. `source`: `string|{url: string, headers: table<string, string>, crucial: string?}` URL to download, or, since 0.2.10, a table. Field `crucial` acts similar to `crucial` of `io.extractFromZipAsync()`.

  2. `callback`: `fun(err: string, folder: string)`
## Function web.resolveDNS(url, callback)
Resolve hostname, return IPv4 via a callback.

  Parameters:

  1. `url`: `string`

  2. `callback`: `fun(err: string?, response: string?)`
## Function web.encryptKey(key)

  Parameters:

  1. `key`: `string`

  Returns:

  - `string`
## Function ac.writeReplayBlob(key, data)
Writes additional data to replay. Use `ac.readReplayBlob()` to extract data later in replay mode. Data written this way is not tied to frames.
Don’t bother compressing data too much: when writing, data will be compressed automatically.

  Parameters:

  1. `key`: `string` Existing data with the same key will be overwritten.

  2. `data`: `binary?`
## Function ac.readReplayBlob(key)
Reads additional data from replay if recorded with `ac.writeReplayBlob()`.

  Parameters:

  1. `key`: `string`

  Returns:

  - `binary`
## Function ac.ReplayStream(layout, callback, frameDivisor)
Create a new stream for recording data to replays. Write data in returned structure if not in replay mode, read data if in replay mode (use `sim.isReplayActive` to check if you need to write or read the data).
Few important points:
 - Each frame should not exceed 256 bytes to keep replay size appropriate. Limit for car scripts is lower, only 32 bytes.
 - While data will be interpolated between frames during reading, directional vectors won’t be re-normalized.
 - If two different apps would open a stream with the same layout, they’ll share a replay entry. Since 0.2.8, they’ll also share memory block, making `ac.ReplayStream()` act similar to `ac.connect()`.
 - Each opened replay stream will persist through the entire AC session to be saved at the end. Currently, the limit is 320 streams per session (before 0.2.8, the limit was 128).
 - Default values for unitialized frames are zeroes.
 - Before 0.2.8, if game is launched in replay mode and there is no such data in replay, `ac.ReplayStream()` could return `nil`. Now, it’ll return the data, but it’ll be empty.
 - Car scripts (both visual and physics) automatically add car ID and index to the key, ensuring uniqueness. Visual scripts can’t create new streams, but can access streams created by physics scripts, making it an effective way to pass data from physics to render, automatically being recorded in replays.

  Parameters:

  1. `layout`: `T` A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Unlike other similar functions, here you shouldn’t use string, otherwise data blending won’t work.

  2. `callback`: `fun()?` Callback that will be called when replay stops. Use this callback to re-apply data from structure: at the moment of the call it will contain stuff from last recorded frame allowing you to restore the state of a simulation to when replay mode was activated.

  3. `frameDivisor`: `integer?` Set to 2 to skip one out of two frames when recording, or 3 to skip two out of three frames. Default value: `1` (no skipping). Reduces replay size.

  Returns:

  - `T` Might return `nil` if there is game is launched in replay mode and there is no such data stored in the replay.
## Function ac.accessCarPhysics()
For any physics calculations avoid using structures provided by `ac.getCar()` and such: those update with graphics thread, so
 not often enough, plus if graphics thread would experience a freeze that data might get very out of date.

  Returns:

  - `ac.StateCphysCar`
## Function ac.accessCarDamper(index)
Access damper data (for both reading and writing). Note: if you’re overwriting a certain value, make sure it’s not accessible
via setup menu.

  Parameters:

  1. `index`: `integer` 0-based wheel index.

  Returns:

  - `ac.StateCphysDamper`
## Function ac.getCarWheelSurface(index)
Access wheel surface data (for both reading and writing). Note: if you’re overwriting a certain value, make sure it’s not accessible
via setup menu.

  Parameters:

  1. `index`: `integer` 0-based wheel index.

  Returns:

  - `ac.StateCphysSurface`
## Function ac.addForce(position, posLocal, force, forceLocal)
Adds force to a car body.

  Parameters:

  1. `position`: `vec3` Point of force application.

  2. `posLocal`: `boolean|`true`|`false`` If `true`, position is treated like position relative to car coordinates, otherwise as world position.

  3. `force`: `vec3` Force vector in N.

  4. `forceLocal`: `boolean|`true`|`false`` If `true`, force is treated like vector relative to car coordinates, otherwise as world vector.
## Function ac.addHubForce(tyres, position, force)
Adds force to a car wheel.

  Parameters:

  1. `tyres`: `ac.Wheel` 0-based wheel index.

  2. `position`: `vec3` Point of force application.

  3. `force`: `vec3` Force vector in N.
## Function ac.addHubForce2(tyres, position, force, addFeedbackTorque, addSteerTorque)
Adds force to a car wheel (version with working feedback and steer torque).

  Parameters:

  1. `tyres`: `ac.Wheel` 0-based wheel index.

  2. `position`: `vec3` Point of force application.

  3. `force`: `vec3` Force vector in N.

  4. `addFeedbackTorque`: `boolean?` Set to `true` to add torque as feedback torque to the engine (does not have any effect with non-driven wheels). Default value: `false`.

  5. `addSteerTorque`: `number?` Set a non-zero value (a multiplier) if force should translate to FFB as well (does not have any effect with non-steering wheels). Default value: 0.
## Function ac.addTorque(torque, torqueLocal, hubIndex)
Adds torque to a car or hub body.

  Parameters:

  1. `torque`: `vec3` Torque vector in N×m.

  2. `torqueLocal`: `boolean|`true`|`false`` If `true`, torque is treated like vector relative to body coordinates, otherwise as world vector.

  3. `hubIndex`: `integer?` If set to a value from 0 to 3, adds torque to a hub body instead of car body. Added in 0.2.8. Default value: -1.
## Function ac.setColliderOffset(index, offset)
Updates position of a certain box collider.

  Parameters:

  1. `index`: `integer`

  2. `offset`: `vec3`

  Returns:

  - `boolean` Returns `false` if there is no such collider.
## Function ac.resetColliderWears()
Resets wear value all box colliders where it is allowed.
function ac.resetColliderWears() end
## Function ac.getColliderWear(index)
Gets wear value of a certain box collider.

  Parameters:

  1. `index`: `integer`

  Returns:

  - `number`
## Function ac.setWingGain(wingIndex, cdGain, clGain)
Changes CD_GAIN and CL_GAIN of a wing, overriding values set in `aero.ini`.

  Parameters:

  1. `wingIndex`: `integer`

  2. `cdGain`: `number`

  3. `clGain`: `number`
## Function ac.setGearsFinalRatio(finalRatio)
Changes final gear ratio, can be overriden by setup if available.

  Parameters:

  1. `finalRatio`: `number`
## Function ac.setDifferentialCoast(coast)
Changes differential coast value, can be overriden by setup if available.

  Parameters:

  1. `coast`: `number`
## Function ac.setDifferentialPower(power)
Changes differential power value, can be overriden by setup if available.

  Parameters:

  1. `power`: `number`
## Function ac.setDifferentialPreload(value)
Changes differential power value, can be overriden by setup if available.

  Parameters:

  1. `value`: `number`
## Function ac.setAWDCenterDifferentialPreload(value)
Changes AWD center differential power value.

  Parameters:

  1. `value`: `number`
## Function ac.awakeCarPhysics()
Awakes car (it will roll downhill).
function ac.awakeCarPhysics() end
## Function ac.setGearsGrinding(grinding)
Changes remaining engine life.

  Parameters:

  1. `grinding`: `boolean|`true`|`false``
## Function ac.setGearboxTimes(gearUpTime, gearDownTime, autoCutoffTime)
Changes time for gear shifting (alters `[GEARBOX] CHANGE_UP_TIME/CHANGE_DN_TIME/AUTO_CUTOFF_TIME`). Values are in milliseconds.

  Parameters:

  1. `gearUpTime`: `number`

  2. `gearDownTime`: `number`

  3. `autoCutoffTime`: `number`
## Function ac.allowCarDRS(active)
Allows and disallows car DRS. If DRS is already disallowed by track zones or physics API, wouldn’t override it, but allows to add more
 conditions disallowing DRS further. If DRS is already engaged, it’ll be disengaged.

  Parameters:

  1. `active`: `boolean|`true`|`false`` Set to `false` to disallow use of DRS.
## Function ac.overrideGasInput(value)
Overrides gas pedal value passed to engine. Unlike changing `.gas` property of car data, this one doesn’t show up in instruments, UI widgets and such.

  Parameters:

  1. `value`: `number` Pass `math.huge` to disable override.
## Function ac.disableEngineLimiter(disable)
Deactivates engine limiter. Use `ac.overrideGasInput()` to implement custom logic.

  Parameters:

  1. `disable`: `boolean?` Default value: `true`.
## Function ac.setDrivetrainDamageRPMWindow(value)
Changes shifting RPM window simulating gearbox damage.

  Parameters:

  1. `value`: `number`
## Function ac.setRainTreadEfficiencyMultiplier(tyres, value)
Alters tread efficiency at moving water away for unusual cases.

  Parameters:

  1. `tyres`: `ac.Wheel`

  2. `value`: `number`
## Function ac.setAntirollBars(kFront, kRear)
Changes values of antiroll bars.

  Parameters:

  1. `kFront`: `number`

  2. `kRear`: `number`
## Function ac.setFuelConsumption(value)
Changes fuel consumption coefficient.

  Parameters:

  1. `value`: `number`
## Function ac.setEngineRPM(value)
Changes current RPM.

  Parameters:

  1. `value`: `number`
## Function ac.setSteeringFFB(value)
Changes current steering FFB. Be very careful with this function: crazy values might break some wheels or even hurt people
using Direct Drive controllers.

  Parameters:

  1. `value`: `number?` Pass `nil` (or `math.huge`) to disable override. Default value: `nil`.
## Function ac.setSteeringDamping(value)
Changes current steering damping effect. Might not work with some wheels, or be altered by FFB postprocessing script.
Original AC uses damping for low speed effect only. Calling this function will stop that low speed damping effect from working.

  Parameters:

  1. `value`: `number?` Pass `nil` (or `math.huge`) to disable override. Default value: `nil`.
## Function ac.getWheelsInertia()
Returns wheels inertia.

  Returns:

  - `number`
## Function ac.addWheelsFeedbackTorque(tyres, torque)
Adds extra feedback torque from wheels to the engine.

  Parameters:

  1. `tyres`: `ac.Wheel`

  2. `torque`: `number`
## Function ac.setDrivetrainRootVelocity(value)
Changes current drivetrain root speed.

  Parameters:

  1. `value`: `number`
## Function ac.setDrivetrainDriveVelocity(value)
Changes current drivetrain drive speed.

  Parameters:

  1. `value`: `number`
## Function ac.setClutchMaxTorque(value)
Changes max clutch torque.

  Parameters:

  1. `value`: `number`
## Function ac.setEngineLifeLeft(value)
Changes remaining engine life.

  Parameters:

  1. `value`: `number` Value from 0 (broken engine) to 1000 (new one).
## Function ac.setEngineStalling(value)
Enables or disables engine stalling. Engine with stall enabled wouldn’t automatically get extra RPM if engine is below certain
 RPM. Note: if you’re using it for recreating manual engine start up, in the future it might lead to regular manual engine starting fix
 applied to all cars getting disabled for yours.

 Since 0.2.5 with its experiment to enabling stalling for all cars, using this function will stop CSP from handling stalling on its side.

  Parameters:

  1. `value`: `boolean|`true`|`false``
## Function ac.setEngineStarterTorque(torque)
Enables engine stalling and sets this torque as active starter torque (set to 0 to enable stalling without active starter).

  Parameters:

  1. `torque`: `number`
## Function ac.setWaterTemperature(temperature, disableOriginal)
Changes water temperature.

  Parameters:

  1. `temperature`: `number` Temperature in °C.

  2. `disableOriginal`: `boolean?` Set to `true` to completely disable original logic. Default value: `false`.
## Function ac.setTyreInflation(tyres, inflation)
Changes tyre inflation.

  Parameters:

  1. `tyres`: `ac.Wheel`

  2. `inflation`: `number` Set to 0 to blow up a tyre.
## Function ac.setTyreWearMultiplier(tyres, multiplier)
Changes wear multiplier (rate at which tyre wears off, doesn’t alter existing wear).

  Parameters:

  1. `tyres`: `ac.Wheel`

  2. `multiplier`: `number?` Set to 0 to disable further wear accumulation. Default value: 1.
## Function ac.shiftPatchTemperatures(tyres, targetTemperature, transfer)
Changes temperatures of tyre patches getting them closer to `targetTemperature` with `transfer` intensity. Use carefully.

  Parameters:

  1. `tyres`: `ac.Wheel`

  2. `targetTemperature`: `number`

  3. `transfer`: `number`
## Function ac.setTyresBlankets(tyres, blanketActive)
Sets tyre blankets and invalidates current lap. If set, they would keep tyres at optimal temperature until car would reach 10 km/h,
and then they would be removed. If you need to set tyres temperature for a moving car, use `physics.setTyresTemperature()`
(to get optimal tyre temperature, use `ac.getCar(N).wheels[0].tyreOptimumTemperature`.

  Parameters:

  1. `tyres`: `ac.Wheel`

  2. `blanketActive`: `boolean?` True to set tyre blankets, false to remove. Default value: `true`.
## Function ac.getTurboUserWastegate(index)
You can also just use `car.turboWastegates[7]` if you less than 8 turbos.

  Parameters:

  1. `index`: `integer`

  Returns:

  - `number`
## Function ac.setTurboUserWastegate(index, value)
Sets custom value for turbo wastegate (aka user setting).

  Parameters:

  1. `index`: `integer`

  2. `value`: `number`
## Function ac.setTurboMaxBoost(index, value)
Change max turbo boost.

  Parameters:

  1. `index`: `integer`

  2. `value`: `number`
## Function ac.setTurboWastegate(index, wastegate, isAdjustable)
Change turbo wastegate.

  Parameters:

  1. `index`: `integer`

  2. `wastegate`: `number`

  3. `isAdjustable`: `boolean|`true`|`false``
## Function ac.setTurboExtras(index, lagUp, lagDown, referenceRpm, gamma)
Change extra turbo parameters.
 Use `ac.setTurboExtras2()` instead, this one incorrectly handles lag values.

  Parameters:

  1. `index`: `integer`

  2. `lagUp`: `number`

  3. `lagDown`: `number`

  4. `referenceRpm`: `number`

  5. `gamma`: `number`
## Function ac.setTurboExtras2(index, lagUp, lagDown, referenceRpm, gamma)
Change extra turbo parameters. This version handles lag values properly. Available since CSP 0.2.5.

  Parameters:

  1. `index`: `integer`

  2. `lagUp`: `number`

  3. `lagDown`: `number`

  4. `referenceRpm`: `number`

  5. `gamma`: `number`
## Function ac.overrideTurboBoost(index, newBoost, instrumentsBoost)
Overrides turbo boost completely. Note: once used, original turbo logic would no longer apply, all original settings would
 no longer matter (except for adjustable flag).

  Parameters:

  1. `index`: `integer` 0-based index. Pass `-1` to alter final turbo value used by original AC instruments, audio and such.

  2. `newBoost`: `number?` Pass `nil` to revert to original turbo. If negative and no `instrumentsBoost` is provided, negative value is only shown visually and won’t affect physics. Default value: `nil`.

  3. `instrumentsBoost`: `number?` If set, `newBoost` can be negative, and this is the value that will be shown on CSP turbo instruments. Default value: `nil`.
## Function ac.overrideSpecificValue(id, value, tyres)

  Parameters:

  1. `id`: `ac.CarPhysicsValueID`

  2. `value`: `number|boolean`

  3. `tyres`: `ac.Wheel?` Used by per-wheel values, 0-based wheel index. Default value: `ac.Wheel.All`.
## Function ac.overrideTurboBlowOffValve(value)
Overrides turbo BOV value used for audio. Doesn’t affect physics.

  Parameters:

  1. `value`: `number?` Pass `nil` (or `math.huge`) to disable override. Default value: `nil`.
## Function ac.overrideEngineTorque(newTorque)
Overrides engine torque (as in, replaces whole torque curve with a single data point for the entire RPM range). Make sure to
 call each frame if you want torque to depend on RPM and such.

  Parameters:

  1. `newTorque`: `number` Pass not-a-number to revert to original curve.
## Function ac.setExtraTorque(torque)
Set extra torque added to engine. Gets added after all the other logic, including turbos and such.

  Parameters:

  1. `torque`: `number`
## Function ac.addElectricTorque(tyres, torque, overrideExisting)

  Parameters:

  1. `tyres`: `ac.Wheel` 0-based wheel index.

  2. `torque`: `number`

  3. `overrideExisting`: `boolean?` Pass `true` to remove original torque (from components such as ERS). Default value: `false`.
## Function ac.overrideBrakesTorque(tyres, torque, handbrakeTorque, discTemperature)
Overrides brakes. Once called, original braking system will be disabled for entirely of the race, so make sure to keep using
this function and set torque for all four wheels. Disc temperature is optional, but if set it will be used by visual part (eventually).
Key difference betweeen braking and handbrake is that handbrake is not affected by ABS (also keep in mind original AC only applies
handbrake to rear wheels).

If a new braking system from extended physics is enabled, this call will have no effect. Make sure to use inputs from `ac.accessCarPhysics()`
and not from `car` to operate at physics rate.

  Parameters:

  1. `tyres`: `ac.Wheel` 0-based wheel index.

  2. `torque`: `number` Value in Nm. Pass not-a-number to revert to original behaviour (for CSP v0.2.3-preview20 or newer).

  3. `handbrakeTorque`: `number`

  4. `discTemperature`: `number?` Does not affect physics. Default value: 0.
## Function ac.overrideABS(wheelLf, wheelRf, wheelLr, wheelRr)
Overrides ABS. Once called, original ABS system will be disabled (pass `nil` or call without arguments to restore original behavior).
Expected values are within 0…1 range and act as multipliers for braking intensity. ABS only affects brakes and not handbrake.

  Parameters:

  1. `wheelLf`: `number?` Default value: `nil`.

  2. `wheelRf`: `number?` Default value: `nil`.

  3. `wheelLr`: `number?` Default value: `nil`.

  4. `wheelRr`: `number?` Default value: `nil`.
## Function ac.debugSleep(sleepMs)

  Parameters:

  1. `sleepMs`: `integer`
## Function ac.isDebugDrawActive()

  Returns:

  - `boolean`
## Function ac.drawDebugLine(from, to, color)
Draw a line to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.

 Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.

  Parameters:

  1. `from`: `vec3`

  2. `to`: `vec3`

  3. `color`: `rgbm`
## Function ac.drawDebugArrow(from, to, color)
Draw an arrow to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.

 Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.

  Parameters:

  1. `from`: `vec3`

  2. `to`: `vec3`

  3. `color`: `rgbm`
## Function ac.drawDebugSquare(pos, nm, size, color)
Draw a square to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.

 Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.

  Parameters:

  1. `pos`: `vec3`

  2. `nm`: `vec3`

  3. `size`: `number`

  4. `color`: `rgbm`
## Function ac.drawDebugBox(center, size, color)
Draw a box to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.

 Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.

  Parameters:

  1. `center`: `vec3`

  2. `size`: `vec3`

  3. `color`: `rgbm`
## Function ac.drawDebugCross(center, size, color)
Draw a cross to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.

 Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.

  Parameters:

  1. `center`: `vec3`

  2. `size`: `number`

  3. `color`: `rgbm`
## Function ac.drawDebugText(center, text, color)
Draw some text to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.

 Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.

  Parameters:

  1. `center`: `vec3`

  2. `text`: `string`

  3. `color`: `rgbm`
## Function ac.getScriptSetupValue(id)
Returns a reference to a custom script setup item. If there is no item with such ID, returns `nil`. Call once
and reuse returned reference to keep things fast.

  Parameters:

  1. `id`: `string` ID from section in “setup.ini”.

  Returns:

  - `refnumber`
## Function ac.setExtraMass(pos, mass, massBox)
Set extra weight to a certain position of a car. Each time this function is called with a new `pos` value,
new weight will be created (can create up to 4 only). Call is free if the position, weight and mass box doesn’t change.

  Parameters:

  1. `pos`: `vec3` Position in meters relative to car.

  2. `mass`: `number` Mass value in kg.

  3. `massBox`: `vec3?` Inertia box (size of a mass item in meters). Default value: `vec3(1, 1, 1)`.
## Function ac.reportIncompatibleSetup(reason)
Report current setup as incompatible preventing user from start the race. Calling it while car is already driving won’t make a difference.

  Parameters:

  1. `reason`: `string|nil` Please specify what exactly is wrong (not used yet, will be used a bit later. Default value: `nil`.
## Function ac.onSetupValueChange(filter, callback)
Sets a callback which will be called when user changes a setup value matching filter. Doesn’t react to setup values being changed by anything else.

  Parameters:

  1. `filter`: `string` Section name or filter (use “?” for wildcards.

  2. `callback`: `fun(id: string, value: number)`

  Returns:

  - `ac.Disposable`
## Function ac.getSetupValue(id)
Returns a reference to a setup item value. If there is no item with such index, returns `nil`. Call once
and reuse returned reference to keep things fast.

  Parameters:

  1. `id`: `string` ID from section in “setup.ini”.

  Returns:

  - `refnumber`
## Function ac.setScriptSetupValue(id, value)
Changes value of a setup item by its ID. Better to not call this function every frame (or maybe not even call at all
to respect user setup).

  Parameters:

  1. `id`: `string` ID from section in “setup.ini”.

  2. `value`: `number`

  Returns:

  - `boolean` Returns `false` if there is no such item.
## Function ac.getDynamicController(name)
Allows to access a dynamic controller in an INI file. If there is no such controller, returns `nil`.

  Parameters:

  1. `name`: `string` For example, `'ctrl_script.ini'`.

  Returns:

  - `refnumber`
## Function ac.setEngineRPMLimit(newValue, scaleInstruments)
Changes current RPM limit.

  Parameters:

  1. `newValue`: `number`

  2. `scaleInstruments`: `boolean?` Default value: `false`.
## Function ac.disallowExtraSwitch(index, disallow, forceDisable)
Call this function to prevent a certain extra switch from activating. Unlike similar function available to car displays and such,
this one can’t be altered without altering car data and overrides all the checks including extra switch activation API.

  Parameters:

  1. `index`: `integer` 0-based switch index.

  2. `disallow`: `boolean?` Default value: `false`.

  3. `forceDisable`: `boolean?` Set to `true` to forcefully disable the switch. Default value: `false`.
## Function ac.suspensionJointConfigure(wheel, joint, erp, cfm)
Override ERP and CFM for a certain suspension joint. Add `[_AC_LINK_ALTERATION] PRINT_OUT=1` to “suspensions.ini” of
a car with extended physics to see the list of suspension joints in CSP log during loading.

  Parameters:

  1. `wheel`: `integer` 0-based wheel index.

  2. `joint`: `integer` 0-based joint index (within the list of all suspension joints).

  3. `erp`: `number`

  4. `cfm`: `number`

  Returns:

  - `boolean` Returns `false` if there is no such wheel or joint.
## Function ac.getSuspensionJointPointTo(dst, wheel, joint, wheelSize)
Return a connection point for a certain suspension distance joint in world space. Add `[_AC_LINK_ALTERATION] PRINT_OUT=1` to “suspensions.ini” of
a car with extended physics to see the list of suspension joints in CSP log during loading.

  Parameters:

  1. `dst`: `vec3` Pass a reference to `vec3()` to get the value.

  2. `wheel`: `integer` 0-based wheel index.

  3. `joint`: `integer` 0-based joint index (within the list of all suspension joints).

  4. `wheelSize`: `boolean|`true`|`false`` Set to `true` to get position on wheel side (relative to wheel) or `false` to get position on body side (relative to body).

  Returns:

  - `boolean` Returns `false` if there is no such wheel or joint, or if it’s not a distance joint.
## Function ac.suspensionJointReseat(wheel, joint, posBody, posHub)
Change connection points for a certain suspension distance joint. Add `[_AC_LINK_ALTERATION] PRINT_OUT=1` to “suspensions.ini” of
a car with extended physics to see the list of suspension joints in CSP log during loading.

This function changes connection points keeping distance the same, meaning if your connection points moved further away bodies
will be forced closer together to maintain the distance.

If you’re using Suspension Debug App, lines won’t shift as they are still drawn based on original suspension geometry. Instead, you can use
`ac.getSuspensionJointPointTo()` to get coordinates of those points, and `ac.drawDebugLine()` to draw it (use CSP Debug app to activate render of those lines).

  Parameters:

  1. `wheel`: `integer` 0-based wheel index.

  2. `joint`: `integer` 0-based joint index (within the list of all suspension joints).

  3. `posBody`: `vec3` Body connection point, coordinates relative to car body.

  4. `posHub`: `vec3` Hub connection point, coordinates relative to wheel hub.

  Returns:

  - `boolean` Returns `false` if there is no such wheel or joint, or if it’s not a distance joint.
## Function ac.suspensionJointReseatDistance(wheel, joint, distance)
Change distance for a certain suspension distance joint. Add `[_AC_LINK_ALTERATION] PRINT_OUT=1` to “suspensions.ini” of
a car with extended physics to see the list of suspension joints in CSP log during loading.

This function changes distance keeping connection points the same, meaning if your new distance is larger bodies will be moved
further away.

If you’re using Suspension Debug App, lines won’t shift as they are still drawn based on original suspension geometry. Instead, you can use
`ac.getSuspensionJointPointTo()` to get coordinates of those points, and `ac.drawDebugLine()` to draw it (use CSP Debug app to activate render of those lines).

  Parameters:

  1. `wheel`: `integer` 0-based wheel index.

  2. `joint`: `integer` 0-based joint index.

  3. `distance`: `number` Distance in meters.

  Returns:

  - `boolean` Returns `false` if there is no such wheel or joint, or if it’s not a distance joint.
## Function ac.pauseScriptUntil(condition)
Pauses subsequent `update()` calls for the script until a certain condition is met. Can save some CPU time. Disabling
does not stop callbacks or timers. Multiple conditions can be combined with `bit.bor()`. Pausing will be disabled
the next time script activates, so make sure to pause it when you’re done with processing.

  Parameters:

  1. `condition`: `ac.ScriptResumeCondition`
## Function ac.setAILookaheadBase(value)
Changes AI base lookahead value. Use `ac.INIConfig.carData(carIndex, 'ai.ini'):get('LOOKAHEAD', 'BASE', 12)` to
load original value first and go from there (don’t re-read it each frame though, it’ll get expensive).

  Parameters:

  1. `value`: `number` New value.
## Function ac.setAILookaheadGasBrake(value)
Changes AI gas/brake lookahead value. Use `ac.INIConfig.carData(carIndex, 'ai.ini'):get('LOOKAHEAD', 'GAS_BRAKE_LOOKAHEAD', 10)` to
load original value first and go from there (don’t re-read it each frame though, it’ll get expensive).

  Parameters:

  1. `value`: `number` New value.
## Function ac.setAIBrakeHint(value)
Changes AI brake hint value. Use `ac.INIConfig.carData(carIndex, 'ai.ini'):get('PEDALS', 'BRAKE_HINT', 1)` to
load original value first and go from there (don’t re-read it each frame though, it’ll get expensive).

  Parameters:

  1. `value`: `number` New value.
## Function ac.setExtraAIGrip(value)
Changes extra AI grip (120% by default).

  Parameters:

  1. `value`: `number` Set to 1 for normal grip.
## Function ac.setAIPitStopRequest(value)
Controls if AI goes to pits or not.

  Parameters:

  1. `value`: `boolean?` Default value: `true`.
## Function ac.setAIBrakeMistake(time)
Triggers brake mistake causing wheels to lock on braking.

  Parameters:

  1. `time`: `number` Mistake time in seconds.
## Function ac.setAITractionMistake(time, severity)
Triggers traction mistake.

  Parameters:

  1. `time`: `number` Mistake time in seconds.

  2. `severity`: `number` Severity, acts like gas pedal multiplier.
## Function ac.setKERSCharge(value)

  Parameters:

  1. `value`: `number`
## Function ac.setKERSCurrentKJ(value)

  Parameters:

  1. `value`: `number`
## Function ac.overrideTyreSmoke(tyreIndex, intensity, thickness, surfaceHeat)
Changes behaviour of smoke going off a tyre (won’t affect dust or water splashes). Actual movement of smoke might change with CSP updates.

  Parameters:

  1. `tyreIndex`: `integer`

  2. `intensity`: `number` Use `math.nan` to restore original behaviour, or a value from 0 to 1.

  3. `thickness`: `number` A value from 0 to 1.

  4. `surfaceHeat`: `number?` Values above 0 will get entire surface to emit smoke as well. Default value: 0.
## Function ac.setGearLabel(c)
Changes label used to display current gear. Label can be up to four symbols long. If label is 2 characters or less, it’ll be stored in a replay as well
(do any gearboxes have labels longer than that?) Can be useful for creating automatic gearboxes and such: AC widgets will use this label, and other apps can access the label
using `ac.getCar().gearLabel`.

  Parameters:

  1. `c`: `string|nil` If empty or `nil`, resets label to default gear label. Default value: `nil`.
## Function ac.setABS(mode)

  Parameters:

  1. `mode`: `integer`
## Function ac.setTC(mode)

  Parameters:

  1. `mode`: `integer`
## Function ac.isTurboWastegateAdjustable(turboIndex)

  Parameters:

  1. `turboIndex`: `integer`

  Returns:

  - `boolean`
## Function ac.setBrakeBias(balance)

  Parameters:

  1. `balance`: `number`
## Function ac.setEngineBrakeSetting(settingIndex)

  Parameters:

  1. `settingIndex`: `integer`
## Function ac.setDRS(state)

  Parameters:

  1. `state`: `boolean|`true`|`false``
## Function ac.setKERS(state)

  Parameters:

  1. `state`: `boolean|`true`|`false``
## Function ac.setMGUHCharging(charging)

  Parameters:

  1. `charging`: `boolean|`true`|`false``
## Function ac.setMGUKDelivery(level)

  Parameters:

  1. `level`: `integer`
## Function ac.setMGUKRecovery(level)

  Parameters:

  1. `level`: `integer`
## Function ac.setHeadlights(active)

  Parameters:

  1. `active`: `boolean|`true`|`false``
## Function ac.flashLights()
Activates flashing lights for a bit.
function ac.flashLights() end
## Function ac.setWiperMode(wiperMode)
Sets index of current wiper speed. To get current speed or number of available speeds, check `ac.StateCar`.

  Parameters:

  1. `wiperMode`: `integer` Wiper mode index from 0 (disabled) to `ac.StateCar.wiperModes` (excluding).
## Function ac.setHighBeams(active)
Toggles high beams on and off. Note: the way lights work, this only changes if high beams are working with low beams or if low beams are alone (and,
in reality, they actually switch a low-beam flag used to switch headlights into low-beam mode). To flash high beams without low beams,
use `ac.flashLights()`.

  Parameters:

  1. `active`: `boolean|`true`|`false``
## Function ac.setDaytimeLights(active)

  Parameters:

  1. `active`: `boolean|`true`|`false``
## Function ac.setBrakingLightsThreshold(threshold)

  Parameters:

  1. `threshold`: `number?` Default value: 0.01.
## Function ac.setTurningLights(mode)

  Parameters:

  1. `mode`: `ac.TurningLights`
## Function ac.setExtraSwitch(index, value)
Changes the state of an extra switch. Note: if switch is in hold mode, it’ll reset to its disabled state after a few frames.
 This function ignores availability checks (but wouldn’t work if the switch has been disabled from car custom physics script).

  Parameters:

  1. `index`: `integer` 0-based index.

  2. `value`: `boolean|`true`|`false``

  Returns:

  - `boolean`
## Function ac.isExtraSwitchAvailable(index, availableToCarControl)
Checks if an extra switch is available.

  Parameters:

  1. `index`: `integer` 0-based index.

  2. `availableToCarControl`: `boolean?` Car control scripts can toggle a switch even if it’s not available to user with switch flags unless switch has been disabled by car physics script. Set this parameter to `false` to check if user can toggle the state with a hotkey, or leave it as `true` if you need to verify if the switch hasn’t been disabled by physics. Default value: `true`.

  Returns:

  - `boolean`
## Function physics.allowed()
Returns `true` if script can affect physics engine. If not, only `physics.raycastTrack()` is available.

  Returns:

  - `boolean`
## Function physics.raycastTrack(pos, dir, length, point, normal)
Casts a ray from given position in a certain direction to check if it hits any physics surfaces. Returns distance to a hit,
or -1 if there wasn’t any. Optionally can return contact point and normal too, if vectors in their place are passed.

Note: smaller rays are faster to cast. Also, rays going straight down are slightly faster as well.

  Parameters:

  1. `pos`: `vec3`

  2. `dir`: `vec3`

  3. `length`: `number`

  4. `point`: `vec3|nil` Default value: `nil`.

  5. `normal`: `vec3|nil` Default value: `nil`.

  Returns:

  - `number`
## Class ac.StateCphysWheel
## Class ac.StateCphysCar
## Class ac.StateCphysDamper
Holds state of an AC damper available for both reading and writing.
## Class ac.StateCphysSurface
Holds state of an AC track surface available for reading only.
## Function ac.overrideCarState(key, value, index)
Override a rendering thread value. Doesn’t affect actual physics (unless your physics script uses data from `ac.getCar()`, which might
be a bad idea to begin with).

  Parameters:

  1. `key`: `'steer'|'gas'|'brake'|'clutch'|'handbrake'|'gear'|'rpm'|'limiter'|'limiterActive'|'turbo'|'drivetrain'|'fuel'|'bodyworkVolume'|'wheelAngularSpeed'|'wheelSlipAngle'|'wheelSlipRatio'|'wheelTyreSlip'|'wheelNDSlip'|'wheelLoad'|'wheelLoadedRadius'|'wheelLiveRadius'|'wheelFlexOffsetX'|'wheelFlexOffsetZ'|'wheelFlexTwist'`

  2. `value`: `number|boolean` For `limiterActive`, pass boolean. Other types expect numbers. Pass `nil` to cancel out overriding.

  3. `index`: `ac.Wheel?` For `wheel…` values, this value specifies affected wheels.
## Class ScriptData
Note: joypad assist script runs from physics thread, so update rate is much higher. Please keep it in mind and keep
code as fast as possible.

# Module common/ac_extras_binaryinput.lua

## Function ac.ControlButton(id, defaults)

  Parameters:

  1. `id`: `string` Name of a section in “controls.ini”. If you are adding a new input, use something like “your.namespace/Nice Name” (without square brackets or colons) to ensure there won’t be collisions and it would integrate nicely.

  2. `defaults`: `{keyboard: nil|{key: ui.KeyIndex?, ctrl: boolean?, shift: boolean?, alt: boolean?}, gamepad: nil|ac.GamepadButton, period: nil|number, hold: nil|boolean}?` Default settings if user has not configured input yet. Parameter `period` can be used to create buttons which would keep reporting as pressed (or call `:onDown()`) while held, can be configured in “controls.ini” as “REPEAT_PERIOD”; by default repeating is disable. Set parameter `hold` to a boolean value and control widget will get a “hold” switch. Buttons configured in “hold” mode return `true` on `:pressed()` when both pressed and released, as well as trigger `:onPressed()` when released too. Note: if `ac.ControlButton()` is called multiple times within a race session, only defaults from the first run will be taken into account (but if subsequent calls will have a “hold” value, button editing widget will still get a “hold” switch).

  Returns:

  - `ac.ControlButton`
## Class ac.ControlButton
A good way to listen to user pressing buttons configured in AC control settings. Handles everything for you automatically, and if you’re working
on a Lua app has a `:control()` method drawing a button showing current binding and allowing to change it in-game.

Could be used for original AC button bindings, new bindings added by CSP, or even for creating custom bindings. For that, make sure to pass a
reliably unique ID when creating a control button, maybe even prefixed by your app name.

Note: inputs for car scripts (both display and physics ones) would work only if the car is currently controlled by the user and not in a replay.
When possible, consider binding to car state instead. If your script runs at lower rate than graphics thread (skipping frames), either use `:down()`
or, better yet, sign to events, `:pressed()` call might return `false`.

- `ac.ControlButton:configured()`

  Button is configured.

  Returns:

    - `boolean`

- `ac.ControlButton:disabled()`

  Button is disabled.

  Returns:

    - `boolean`

- `ac.ControlButton:holdMode()`

  Button is using hold mode.

  Returns:

    - `boolean`

- `ac.ControlButton:pressed()`

  Button was just pressed. For buttons in hold mode returns `true` on both press and release.

  Returns:

    - `boolean`

- `ac.ControlButton:released()`

  Button was just released. For buttons in hold mode returns `true` on both press and release.

  Returns:

    - `boolean`

- `ac.ControlButton:down()`

  Button is held down. For buttons in hold mode works similar to `:pressed()`.

  Returns:

    - `boolean`

- `ac.ControlButton:onPressed(callback)`

  Sets a callback to be called when the button is pressed. For buttons in hold mode calls callback on both presses and releases. If button is held down
when this method is called, callback will be called the next frame.

  Parameters:

    1. `callback`: `fun()`

  Returns:

    - `ac.Disposable`

- `ac.ControlButton:onReleased(callback)`

  Sets a callback to be called when the button is released. For buttons in hold mode calls callback shortly after both presses and releases.

  Parameters:

    1. `callback`: `fun()`

  Returns:

    - `ac.Disposable`

- `ac.ControlButton:setAlwaysActive(value)`

  Always active buttons work even if AC is paused or in, for example, pits menu.

  Parameters:

    1. `value`: `boolean?` Default value: `true`.

  Returns:

    - `ac.ControlButton`

- `ac.ControlButton:setDisabled(value)`

  Disabled buttons ignore presses but remember their settings.

  Parameters:

    1. `value`: `boolean?` Default value: `true`.

  Returns:

    - `ac.ControlButton`

# Module common/ac_car_control_physics.lua

## Class ac.CarExtraSwitchParams
A helper structure to simulate some inputs for controlling the car.
## Function ac.accessExtraSwitchParams(index)

  Parameters:

  1. `index`: `integer` 0-based switch index.

  Returns:

  - `ac.CarExtraSwitchParams`

# Module common/ac_physics_raycast.lua

