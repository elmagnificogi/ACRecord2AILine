---@meta
---@diagnostic disable: lowercase-global

---@alias ac.DebugCollectMode
---| `ac.DebugCollectMode.Average` @Value: 0.
---| `ac.DebugCollectMode.Minimum` @Value: 1.
---| `ac.DebugCollectMode.Maximum` @Value: 2.
ac.DebugCollectMode = {
  Average = 0, ---@type ac.DebugCollectMode #Value: 0.
  Minimum = 1, ---@type ac.DebugCollectMode #Value: 1.
  Maximum = 2, ---@type ac.DebugCollectMode #Value: 2.
}

---@alias ac.INIFormat
---| `ac.INIFormat.Default` @AC format: no quotes, “[” in value begins a new section, etc.
---| `ac.INIFormat.DefaultAcd` @AC format, but also with support for reading files from `data.acd` (makes difference only for `ac.INIConfig.load()`).
---| `ac.INIFormat.Extended` @Quotes are allowed, comma-separated value turns into multiple values (for vectors and lists), repeated keys replace previous values.
---| `ac.INIFormat.ExtendedIncludes` @Same as CSP, but also with support for INIpp expressions and includes.
ac.INIFormat = {
  Default = 0, ---@type ac.INIFormat #AC format: no quotes, “[” in value begins a new section, etc.
  DefaultAcd = 1, ---@type ac.INIFormat #AC format, but also with support for reading files from `data.acd` (makes difference only for `ac.INIConfig.load()`).
  Extended = 10, ---@type ac.INIFormat #Quotes are allowed, comma-separated value turns into multiple values (for vectors and lists), repeated keys replace previous values.
  ExtendedIncludes = 11, ---@type ac.INIFormat #Same as CSP, but also with support for INIpp expressions and includes.
}

---@alias ac.LightType
---| `ac.LightType.Regular` @Value: 1.
---| `ac.LightType.Line` @Value: 2.
ac.LightType = {
  Regular = 1, ---@type ac.LightType #Value: 1.
  Line = 2, ---@type ac.LightType #Value: 2.
}

---@alias ac.IncludeType
---| `ac.IncludeType.None` @Value: 0.
---| `ac.IncludeType.Car` @Value: 1.
---| `ac.IncludeType.Track` @Value: 2.
ac.IncludeType = {
  None = 0, ---@type ac.IncludeType #Value: 0.
  Car = 1, ---@type ac.IncludeType #Value: 1.
  Track = 2, ---@type ac.IncludeType #Value: 2.
}

---@alias ac.FogAlgorithm
---| `ac.FogAlgorithm.Original` @Value: 0.
---| `ac.FogAlgorithm.New` @Value: 1.
ac.FogAlgorithm = {
  Original = 0, ---@type ac.FogAlgorithm #Value: 0.
  New = 1, ---@type ac.FogAlgorithm #Value: 1.
}

---@alias ac.SurfaceType
---| `ac.SurfaceType.Grass` @Value: 0.
---| `ac.SurfaceType.Dirt` @Value: 1.
---| `ac.SurfaceType.Snow` @-Could also be ice.
---| `ac.SurfaceType.Default` @Value: 255.
ac.SurfaceType = {
  Grass = 0, ---@type ac.SurfaceType #Value: 0.
  Dirt = 1, ---@type ac.SurfaceType #Value: 1.
  Snow = 2, ---@type ac.SurfaceType #-Could also be ice.
  Default = 255, ---@type ac.SurfaceType #Value: 255.
}

---@alias ac.SurfaceExtendedType
---| `ac.SurfaceExtendedType.Base` @Value: 0.
---| `ac.SurfaceExtendedType.ExtraTurf` @Value: 1.
---| `ac.SurfaceExtendedType.Grass` @Value: 2.
---| `ac.SurfaceExtendedType.Gravel` @Value: 3.
---| `ac.SurfaceExtendedType.Kerb` @Value: 4.
---| `ac.SurfaceExtendedType.Old` @Value: 5.
---| `ac.SurfaceExtendedType.Sand` @Value: 6.
---| `ac.SurfaceExtendedType.Ice` @Value: 7.
---| `ac.SurfaceExtendedType.Snow` @Value: 8.
ac.SurfaceExtendedType = {
  Base = 0, ---@type ac.SurfaceExtendedType #Value: 0.
  ExtraTurf = 1, ---@type ac.SurfaceExtendedType #Value: 1.
  Grass = 2, ---@type ac.SurfaceExtendedType #Value: 2.
  Gravel = 3, ---@type ac.SurfaceExtendedType #Value: 3.
  Kerb = 4, ---@type ac.SurfaceExtendedType #Value: 4.
  Old = 5, ---@type ac.SurfaceExtendedType #Value: 5.
  Sand = 6, ---@type ac.SurfaceExtendedType #Value: 6.
  Ice = 7, ---@type ac.SurfaceExtendedType #Value: 7.
  Snow = 8, ---@type ac.SurfaceExtendedType #Value: 8.
}

---@alias ac.ShadowsState
---| `ac.ShadowsState.Off` @Value: 0.
---| `ac.ShadowsState.On` @Value: 1.
---| `ac.ShadowsState.EverythingShadowed` @Value: 2.
ac.ShadowsState = {
  Off = 0, ---@type ac.ShadowsState #Value: 0.
  On = 1, ---@type ac.ShadowsState #Value: 1.
  EverythingShadowed = 2, ---@type ac.ShadowsState #Value: 2.
}

---@alias ac.TextureState
---| `ac.TextureState.Empty` @Value: 0.
---| `ac.TextureState.Loading` @Value: 1.
---| `ac.TextureState.Failed` @Value: 2.
---| `ac.TextureState.Ready` @Value: 3.
ac.TextureState = {
  Empty = 0, ---@type ac.TextureState #Value: 0.
  Loading = 1, ---@type ac.TextureState #Value: 1.
  Failed = 2, ---@type ac.TextureState #Value: 2.
  Ready = 3, ---@type ac.TextureState #Value: 3.
}

---@alias ac.CameraMode
---| `ac.CameraMode.Cockpit` @First person view.
---| `ac.CameraMode.Car` @F6 camera.
---| `ac.CameraMode.Drivable` @Chase/bonnet/bumper/dash cameras.
---| `ac.CameraMode.Track` @Replay camera.
---| `ac.CameraMode.Helicopter` @Moving replay camera.
---| `ac.CameraMode.OnBoardFree` @F5 camera.
---| `ac.CameraMode.Free` @F7 camera.
---| `ac.CameraMode.Deprecated` @Value: 7.
---| `ac.CameraMode.ImageGeneratorCamera` @Value: 8.
---| `ac.CameraMode.Start` @Starting camera.
ac.CameraMode = {
  Cockpit = 0, ---@type ac.CameraMode #First person view.
  Car = 1, ---@type ac.CameraMode #F6 camera.
  Drivable = 2, ---@type ac.CameraMode #Chase/bonnet/bumper/dash cameras.
  Track = 3, ---@type ac.CameraMode #Replay camera.
  Helicopter = 4, ---@type ac.CameraMode #Moving replay camera.
  OnBoardFree = 5, ---@type ac.CameraMode #F5 camera.
  Free = 6, ---@type ac.CameraMode #F7 camera.
  Deprecated = 7, ---@type ac.CameraMode #Value: 7.
  ImageGeneratorCamera = 8, ---@type ac.CameraMode #Value: 8.
  Start = 9, ---@type ac.CameraMode #Starting camera.
}

---@alias ac.DrivableCamera
---| `ac.DrivableCamera.Chase` @Value: 0.
---| `ac.DrivableCamera.Chase2` @Value: 1.
---| `ac.DrivableCamera.Bonnet` @Value: 2.
---| `ac.DrivableCamera.Bumper` @Value: 3.
---| `ac.DrivableCamera.Dash` @Value: 4.
ac.DrivableCamera = {
  Chase = 0, ---@type ac.DrivableCamera #Value: 0.
  Chase2 = 1, ---@type ac.DrivableCamera #Value: 1.
  Bonnet = 2, ---@type ac.DrivableCamera #Value: 2.
  Bumper = 3, ---@type ac.DrivableCamera #Value: 3.
  Dash = 4, ---@type ac.DrivableCamera #Value: 4.
}

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

---@alias ac.MirrorPieceRole
---| `ac.MirrorPieceRole.None` @Value: 0.
---| `ac.MirrorPieceRole.Top` @Value: 1.
---| `ac.MirrorPieceRole.Left` @Value: 2.
---| `ac.MirrorPieceRole.Right` @Value: 4.
ac.MirrorPieceRole = {
  None = 0, ---@type ac.MirrorPieceRole #Value: 0.
  Top = 1, ---@type ac.MirrorPieceRole #Value: 1.
  Left = 2, ---@type ac.MirrorPieceRole #Value: 2.
  Right = 4, ---@type ac.MirrorPieceRole #Value: 4.
}

---@alias ac.MirrorPieceFlip
---| `ac.MirrorPieceFlip.None` @Value: 0.
---| `ac.MirrorPieceFlip.Horizontal` @Value: 1.
---| `ac.MirrorPieceFlip.Vertical` @Value: 2.
---| `ac.MirrorPieceFlip.Both` @Value: 3.
ac.MirrorPieceFlip = {
  None = 0, ---@type ac.MirrorPieceFlip #Value: 0.
  Horizontal = 1, ---@type ac.MirrorPieceFlip #Value: 1.
  Vertical = 2, ---@type ac.MirrorPieceFlip #Value: 2.
  Both = 3, ---@type ac.MirrorPieceFlip #Value: 3.
}

---@alias ac.MirrorMonitorType
---| `ac.MirrorMonitorType.TN` @Oldschool displays with a lot of color distortion.
---| `ac.MirrorMonitorType.VA` @Medium tier, less color distortion.
---| `ac.MirrorMonitorType.IPS` @Almost no color distortion.
ac.MirrorMonitorType = {
  TN = 0, ---@type ac.MirrorMonitorType #Oldschool displays with a lot of color distortion.
  VA = 2, ---@type ac.MirrorMonitorType #Medium tier, less color distortion.
  IPS = 1, ---@type ac.MirrorMonitorType #Almost no color distortion.
}

---@alias ac.WeatherType
---| `ac.WeatherType.LightThunderstorm` @Value: 0.
---| `ac.WeatherType.Thunderstorm` @Value: 1.
---| `ac.WeatherType.HeavyThunderstorm` @Value: 2.
---| `ac.WeatherType.LightDrizzle` @Value: 3.
---| `ac.WeatherType.Drizzle` @Value: 4.
---| `ac.WeatherType.HeavyDrizzle` @Value: 5.
---| `ac.WeatherType.LightRain` @Value: 6.
---| `ac.WeatherType.Rain` @Value: 7.
---| `ac.WeatherType.HeavyRain` @Value: 8.
---| `ac.WeatherType.LightSnow` @Value: 9.
---| `ac.WeatherType.Snow` @Value: 10.
---| `ac.WeatherType.HeavySnow` @Value: 11.
---| `ac.WeatherType.LightSleet` @Value: 12.
---| `ac.WeatherType.Sleet` @Value: 13.
---| `ac.WeatherType.HeavySleet` @Value: 14.
---| `ac.WeatherType.Clear` @Value: 15.
---| `ac.WeatherType.FewClouds` @Value: 16.
---| `ac.WeatherType.ScatteredClouds` @Value: 17.
---| `ac.WeatherType.BrokenClouds` @Value: 18.
---| `ac.WeatherType.OvercastClouds` @Value: 19.
---| `ac.WeatherType.Fog` @Value: 20.
---| `ac.WeatherType.Mist` @Value: 21.
---| `ac.WeatherType.Smoke` @Value: 22.
---| `ac.WeatherType.Haze` @Value: 23.
---| `ac.WeatherType.Sand` @Value: 24.
---| `ac.WeatherType.Dust` @Value: 25.
---| `ac.WeatherType.Squalls` @Value: 26.
---| `ac.WeatherType.Tornado` @Value: 27.
---| `ac.WeatherType.Hurricane` @Value: 28.
---| `ac.WeatherType.Cold` @Value: 29.
---| `ac.WeatherType.Hot` @Value: 30.
---| `ac.WeatherType.Windy` @Value: 31.
---| `ac.WeatherType.Hail` @Value: 32.
ac.WeatherType = {
  LightThunderstorm = 0, ---@type ac.WeatherType #Value: 0.
  Thunderstorm = 1, ---@type ac.WeatherType #Value: 1.
  HeavyThunderstorm = 2, ---@type ac.WeatherType #Value: 2.
  LightDrizzle = 3, ---@type ac.WeatherType #Value: 3.
  Drizzle = 4, ---@type ac.WeatherType #Value: 4.
  HeavyDrizzle = 5, ---@type ac.WeatherType #Value: 5.
  LightRain = 6, ---@type ac.WeatherType #Value: 6.
  Rain = 7, ---@type ac.WeatherType #Value: 7.
  HeavyRain = 8, ---@type ac.WeatherType #Value: 8.
  LightSnow = 9, ---@type ac.WeatherType #Value: 9.
  Snow = 10, ---@type ac.WeatherType #Value: 10.
  HeavySnow = 11, ---@type ac.WeatherType #Value: 11.
  LightSleet = 12, ---@type ac.WeatherType #Value: 12.
  Sleet = 13, ---@type ac.WeatherType #Value: 13.
  HeavySleet = 14, ---@type ac.WeatherType #Value: 14.
  Clear = 15, ---@type ac.WeatherType #Value: 15.
  FewClouds = 16, ---@type ac.WeatherType #Value: 16.
  ScatteredClouds = 17, ---@type ac.WeatherType #Value: 17.
  BrokenClouds = 18, ---@type ac.WeatherType #Value: 18.
  OvercastClouds = 19, ---@type ac.WeatherType #Value: 19.
  Fog = 20, ---@type ac.WeatherType #Value: 20.
  Mist = 21, ---@type ac.WeatherType #Value: 21.
  Smoke = 22, ---@type ac.WeatherType #Value: 22.
  Haze = 23, ---@type ac.WeatherType #Value: 23.
  Sand = 24, ---@type ac.WeatherType #Value: 24.
  Dust = 25, ---@type ac.WeatherType #Value: 25.
  Squalls = 26, ---@type ac.WeatherType #Value: 26.
  Tornado = 27, ---@type ac.WeatherType #Value: 27.
  Hurricane = 28, ---@type ac.WeatherType #Value: 28.
  Cold = 29, ---@type ac.WeatherType #Value: 29.
  Hot = 30, ---@type ac.WeatherType #Value: 30.
  Windy = 31, ---@type ac.WeatherType #Value: 31.
  Hail = 32, ---@type ac.WeatherType #Value: 32.
}

---@alias ac.TonemapFunction
---| `ac.TonemapFunction.Linear` @Simple linear mapping.
---| `ac.TonemapFunction.LinearClamped` @Linear mapping (LDR clamp).
---| `ac.TonemapFunction.Sensitometric` @Simple simulation of response of film, CCD, etc., recommended.
---| `ac.TonemapFunction.Reinhard` @Reinhard.
---| `ac.TonemapFunction.ReinhardLum` @Saturation retention type Reinhard tone map function.
---| `ac.TonemapFunction.Log` @Tone map function for the logarithmic space.
---| `ac.TonemapFunction.LogLum` @Saturation retention type logarithmic space tone map function.
---| `ac.TonemapFunction.ACES` @ACES.
---| `ac.TonemapFunction.Uchimura` @GT-like by Uchimura.
---| `ac.TonemapFunction.RomBinDaHouse` @Tonemapping by RomBinDaHouse.
---| `ac.TonemapFunction.Lottes` @Tonemapping by Lottes.
---| `ac.TonemapFunction.Uncharted` @Tonemapping used in Uncharted.
---| `ac.TonemapFunction.Unreal` @Tonemapping commonly used in UE.
---| `ac.TonemapFunction.Filmic` @Filmic tonemapping.
---| `ac.TonemapFunction.ReinhardWp` @White-preserving Reinhard.
---| `ac.TonemapFunction.Juicy` @Experimental, better preserving saturation.
---| `ac.TonemapFunction.AgX` @Might be the best one, based on https://iolite-engine.com/blog_posts/minimal_agx_implementation.
ac.TonemapFunction = {
  Linear = 0, ---@type ac.TonemapFunction #Simple linear mapping.
  LinearClamped = 1, ---@type ac.TonemapFunction #Linear mapping (LDR clamp).
  Sensitometric = 2, ---@type ac.TonemapFunction #Simple simulation of response of film, CCD, etc., recommended.
  Reinhard = 3, ---@type ac.TonemapFunction #Reinhard.
  ReinhardLum = 4, ---@type ac.TonemapFunction #Saturation retention type Reinhard tone map function.
  Log = 5, ---@type ac.TonemapFunction #Tone map function for the logarithmic space.
  LogLum = 6, ---@type ac.TonemapFunction #Saturation retention type logarithmic space tone map function.
  ACES = 7, ---@type ac.TonemapFunction #ACES.
  Uchimura = 8, ---@type ac.TonemapFunction #GT-like by Uchimura.
  RomBinDaHouse = 9, ---@type ac.TonemapFunction #Tonemapping by RomBinDaHouse.
  Lottes = 10, ---@type ac.TonemapFunction #Tonemapping by Lottes.
  Uncharted = 11, ---@type ac.TonemapFunction #Tonemapping used in Uncharted.
  Unreal = 12, ---@type ac.TonemapFunction #Tonemapping commonly used in UE.
  Filmic = 13, ---@type ac.TonemapFunction #Filmic tonemapping.
  ReinhardWp = 14, ---@type ac.TonemapFunction #White-preserving Reinhard.
  Juicy = 15, ---@type ac.TonemapFunction #Experimental, better preserving saturation.
  AgX = 16, ---@type ac.TonemapFunction #Might be the best one, based on https://iolite-engine.com/blog_posts/minimal_agx_implementation.
}

---@alias ac.FolderID
---| `ac.FolderID.AppData` @…/AppData.
---| `ac.FolderID.Documents` @…/Documents.
---| `ac.FolderID.Root` @…/SteamApps/common/assettocorsa.
---| `ac.FolderID.Cfg` @…/Documents/Assetto Corsa/cfg.
---| `ac.FolderID.Logs` @…/Documents/Assetto Corsa/logs.
---| `ac.FolderID.Screenshots` @…/Documents/Assetto Corsa/screens.
---| `ac.FolderID.Replays` @…/Documents/Assetto Corsa/replay.
---| `ac.FolderID.ReplaysTemp` @…/Documents/Assetto Corsa/replay/temp.
---| `ac.FolderID.UserSetups` @…/Documents/Assetto Corsa/setups.
---| `ac.FolderID.PPFilters` @…/SteamApps/common/assettocorsa/system/cfg/ppfilters.
---| `ac.FolderID.ContentCars` @…/SteamApps/common/assettocorsa/content/cars.
---| `ac.FolderID.ContentDrivers` @…/SteamApps/common/assettocorsa/content/drivers.
---| `ac.FolderID.ContentTracks` @…/SteamApps/common/assettocorsa/content/tracks.
---| `ac.FolderID.ExtRoot` @…/SteamApps/common/assettocorsa/extension.
---| `ac.FolderID.ExtCfgSys` @…/SteamApps/common/assettocorsa/extension/config.
---| `ac.FolderID.ExtCfgUser` @…/Documents/Assetto Corsa/cfg/extension.
---| `ac.FolderID.ExtTextures` @…/SteamApps/common/assettocorsa/extension/textures.
---| `ac.FolderID.ACApps` @…/SteamApps/common/assettocorsa/apps.
---| `ac.FolderID.ACAppsLua` @…/SteamApps/common/assettocorsa/apps/lua.
---| `ac.FolderID.ACAppsPython` @…/SteamApps/common/assettocorsa/apps/python.
---| `ac.FolderID.ExtCfgState` @…/Documents/Assetto Corsa/cfg/extension/state (changing configs there does not trigger any live reloads).
---| `ac.FolderID.ContentFonts` @…/SteamApps/common/assettocorsa/content/fonts.
---| `ac.FolderID.RaceResults` @…/Documents/Assetto Corsa/out.
---| `ac.FolderID.AppDataLocal` @…/AppData/Local.
---| `ac.FolderID.ExtFonts` @…/SteamApps/common/assettocorsa/extension/fonts.
---| `ac.FolderID.ACDocuments` @…/Documents/Assetto Corsa.
---| `ac.FolderID.ExtLua` @…/SteamApps/common/assettocorsa/extension/lua.
---| `ac.FolderID.ExtCache` @…/SteamApps/common/assettocorsa/cache.
---| `ac.FolderID.AppDataTemp` @…/AppData/Local/Temp.
---| `ac.FolderID.ExtInternal` @…/SteamApps/common/assettocorsa/extension/internal.
---| `ac.FolderID.ScriptOrigin` @Main script directory.
---| `ac.FolderID.ScriptConfig` @…/Documents/Assetto Corsa/cfg/extension/state/lua/<mode>/<script ID>.
---| `ac.FolderID.CurrentTrack` @…/SteamApps/common/assettocorsa/content/tracks/<track ID>.
---| `ac.FolderID.CurrentTrackLayout` @…/SteamApps/common/assettocorsa/content/tracks/<track ID>/<layout ID> (or the same as CurrentTrack if no layout is selected).
---| `ac.FolderID.CurrentTrackLayoutUI` @…/SteamApps/common/assettocorsa/content/tracks/<track ID>/ui/<layout ID> (or just …/ui if no layout is selected).
ac.FolderID = {
  AppData = 0, ---@type ac.FolderID #…/AppData.
  Documents = 1, ---@type ac.FolderID #…/Documents.
  Root = 4, ---@type ac.FolderID #…/SteamApps/common/assettocorsa.
  Cfg = 5, ---@type ac.FolderID #…/Documents/Assetto Corsa/cfg.
  Logs = 7, ---@type ac.FolderID #…/Documents/Assetto Corsa/logs.
  Screenshots = 8, ---@type ac.FolderID #…/Documents/Assetto Corsa/screens.
  Replays = 9, ---@type ac.FolderID #…/Documents/Assetto Corsa/replay.
  ReplaysTemp = 10, ---@type ac.FolderID #…/Documents/Assetto Corsa/replay/temp.
  UserSetups = 11, ---@type ac.FolderID #…/Documents/Assetto Corsa/setups.
  PPFilters = 12, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/system/cfg/ppfilters.
  ContentCars = 13, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/cars.
  ContentDrivers = 14, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/drivers.
  ContentTracks = 15, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/tracks.
  ExtRoot = 16, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension.
  ExtCfgSys = 17, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/config.
  ExtCfgUser = 18, ---@type ac.FolderID #…/Documents/Assetto Corsa/cfg/extension.
  ExtTextures = 21, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/textures.
  ACApps = 23, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/apps.
  ACAppsLua = 1029, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/apps/lua.
  ACAppsPython = 24, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/apps/python.
  ExtCfgState = 25, ---@type ac.FolderID #…/Documents/Assetto Corsa/cfg/extension/state (changing configs there does not trigger any live reloads).
  ContentFonts = 26, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/fonts.
  RaceResults = 27, ---@type ac.FolderID #…/Documents/Assetto Corsa/out.
  AppDataLocal = 28, ---@type ac.FolderID #…/AppData/Local.
  ExtFonts = 29, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/fonts.
  ACDocuments = 31, ---@type ac.FolderID #…/Documents/Assetto Corsa.
  ExtLua = 32, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/lua.
  ExtCache = 33, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/cache.
  AppDataTemp = 34, ---@type ac.FolderID #…/AppData/Local/Temp.
  ExtInternal = 35, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/internal.
  ScriptOrigin = 1024, ---@type ac.FolderID #Main script directory.
  ScriptConfig = 1025, ---@type ac.FolderID #…/Documents/Assetto Corsa/cfg/extension/state/lua/<mode>/<script ID>.
  CurrentTrack = 1026, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/tracks/<track ID>.
  CurrentTrackLayout = 1027, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/tracks/<track ID>/<layout ID> (or the same as CurrentTrack if no layout is selected).
  CurrentTrackLayoutUI = 1028, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/tracks/<track ID>/ui/<layout ID> (or just …/ui if no layout is selected).
}

---@alias ac.HolidayType
---| `ac.HolidayType.None` @Value: 0.
---| `ac.HolidayType.Generic` @Value: 13.
---| `ac.HolidayType.NewYear` @Value: 1.
---| `ac.HolidayType.Christmas` @Value: 2.
---| `ac.HolidayType.VictoryDay` @Value: 3.
---| `ac.HolidayType.IndependenceDay` @Value: 4.
---| `ac.HolidayType.Halloween` @Value: 5.
---| `ac.HolidayType.JapanFestival` @Value: 6.
---| `ac.HolidayType.ChineseNewYear` @Value: 7.
---| `ac.HolidayType.EidAlAdha` @Value: 8.
---| `ac.HolidayType.GuyFawkesNight` @Value: 9.
---| `ac.HolidayType.StIstvanCelebration` @Value: 10.
---| `ac.HolidayType.CanadaDay` @Value: 11.
---| `ac.HolidayType.VictoriaDay` @Value: 12.
ac.HolidayType = {
  None = 0, ---@type ac.HolidayType #Value: 0.
  Generic = 13, ---@type ac.HolidayType #Value: 13.
  NewYear = 1, ---@type ac.HolidayType #Value: 1.
  Christmas = 2, ---@type ac.HolidayType #Value: 2.
  VictoryDay = 3, ---@type ac.HolidayType #Value: 3.
  IndependenceDay = 4, ---@type ac.HolidayType #Value: 4.
  Halloween = 5, ---@type ac.HolidayType #Value: 5.
  JapanFestival = 6, ---@type ac.HolidayType #Value: 6.
  ChineseNewYear = 7, ---@type ac.HolidayType #Value: 7.
  EidAlAdha = 8, ---@type ac.HolidayType #Value: 8.
  GuyFawkesNight = 9, ---@type ac.HolidayType #Value: 9.
  StIstvanCelebration = 10, ---@type ac.HolidayType #Value: 10.
  CanadaDay = 11, ---@type ac.HolidayType #Value: 11.
  VictoriaDay = 12, ---@type ac.HolidayType #Value: 12.
}

---@alias ac.SkyRegion
---| `ac.SkyRegion.None` @Value: 0.
---| `ac.SkyRegion.Sun` @Value: 1.
---| `ac.SkyRegion.Opposite` @Value: 2.
---| `ac.SkyRegion.All` @Value: 3.
ac.SkyRegion = {
  None = 0, ---@type ac.SkyRegion #Value: 0.
  Sun = 1, ---@type ac.SkyRegion #Value: 1.
  Opposite = 2, ---@type ac.SkyRegion #Value: 2.
  All = 3, ---@type ac.SkyRegion #Value: 3.
}

---@alias ac.SkyFeature
---| `ac.SkyFeature.Sun` @Value: 0.
---| `ac.SkyFeature.Moon` @Value: 1.
---| `ac.SkyFeature.Mercury` @Value: 101.
---| `ac.SkyFeature.Venus` @Value: 102.
---| `ac.SkyFeature.Mars` @Value: 103.
---| `ac.SkyFeature.Jupiter` @Value: 104.
---| `ac.SkyFeature.Saturn` @Value: 105.
---| `ac.SkyFeature.ISS` @Value: 200.
ac.SkyFeature = {
  Sun = 0, ---@type ac.SkyFeature #Value: 0.
  Moon = 1, ---@type ac.SkyFeature #Value: 1.
  Mercury = 101, ---@type ac.SkyFeature #Value: 101.
  Venus = 102, ---@type ac.SkyFeature #Value: 102.
  Mars = 103, ---@type ac.SkyFeature #Value: 103.
  Jupiter = 104, ---@type ac.SkyFeature #Value: 104.
  Saturn = 105, ---@type ac.SkyFeature #Value: 105.
  ISS = 200, ---@type ac.SkyFeature #Value: 200.
}

---This enum is used by car state.
---@alias ac.UserInputMode
---| `ac.UserInputMode.Wheel` @Value: 0.
---| `ac.UserInputMode.Gamepad` @Value: 1.
---| `ac.UserInputMode.Keyboard` @Value: 2.
ac.UserInputMode = {
  Wheel = 0, ---@type ac.UserInputMode #Value: 0.
  Gamepad = 1, ---@type ac.UserInputMode #Value: 1.
  Keyboard = 2, ---@type ac.UserInputMode #Value: 2.
}

---@alias ac.AudioChannel
---| `ac.AudioChannel.Main` @Value: 'main'.
---| `ac.AudioChannel.Rain` @Value: 'rain'.
---| `ac.AudioChannel.Weather` @Value: 'weather'.
---| `ac.AudioChannel.Track` @Value: 'track'.
---| `ac.AudioChannel.Wipers` @Value: 'wipers'.
---| `ac.AudioChannel.CarComponents` @Value: 'carComponents'.
---| `ac.AudioChannel.Wind` @Value: 'wind'.
---| `ac.AudioChannel.Tyres` @Value: 'tyres'.
---| `ac.AudioChannel.Surfaces` @Value: 'surfaces'.
---| `ac.AudioChannel.Dirt` @Value: 'dirt'.
---| `ac.AudioChannel.Engine` @Value: 'engine'.
---| `ac.AudioChannel.Transmission` @Value: 'transmission'.
---| `ac.AudioChannel.Opponents` @Value: 'opponents'.
ac.AudioChannel = {
  Main = 'main', ---@type ac.AudioChannel #Value: 'main'.
  Rain = 'rain', ---@type ac.AudioChannel #Value: 'rain'.
  Weather = 'weather', ---@type ac.AudioChannel #Value: 'weather'.
  Track = 'track', ---@type ac.AudioChannel #Value: 'track'.
  Wipers = 'wipers', ---@type ac.AudioChannel #Value: 'wipers'.
  CarComponents = 'carComponents', ---@type ac.AudioChannel #Value: 'carComponents'.
  Wind = 'wind', ---@type ac.AudioChannel #Value: 'wind'.
  Tyres = 'tyres', ---@type ac.AudioChannel #Value: 'tyres'.
  Surfaces = 'surfaces', ---@type ac.AudioChannel #Value: 'surfaces'.
  Dirt = 'dirt', ---@type ac.AudioChannel #Value: 'dirt'.
  Engine = 'engine', ---@type ac.AudioChannel #Value: 'engine'.
  Transmission = 'transmission', ---@type ac.AudioChannel #Value: 'transmission'.
  Opponents = 'opponents', ---@type ac.AudioChannel #Value: 'opponents'.
}

---@alias ac.SpawnSet
---| `ac.SpawnSet.Start` @Value: 'START'.
---| `ac.SpawnSet.Pits` @Value: 'PIT'.
---| `ac.SpawnSet.HotlapStart` @Value: 'HOTLAP_START'.
---| `ac.SpawnSet.TimeAttack` @Careful: most tracks might not have that spawn set.
ac.SpawnSet = {
  Start = 'START', ---@type ac.SpawnSet #Value: 'START'.
  Pits = 'PIT', ---@type ac.SpawnSet #Value: 'PIT'.
  HotlapStart = 'HOTLAP_START', ---@type ac.SpawnSet #Value: 'HOTLAP_START'.
  TimeAttack = 'TIME_ATTACK', ---@type ac.SpawnSet #Careful: most tracks might not have that spawn set.
}

---At the moment, most of those flag types are never shown, but more flags will be added later. Also, physics-altering scripts---(like, for example, server scripts) can override flag type and use any flag from this list (and apply their own rules and---penalties when needed)
---@alias ac.FlagType
---| `ac.FlagType.None` @No flag, works.
---| `ac.FlagType.Start` @Works in race, practice or hotlap modes.
---| `ac.FlagType.Caution` @Yellow flag, works.
---| `ac.FlagType.Slippery` @Does not work yet.
---| `ac.FlagType.PitLaneClosed` @Does not work yet.
---| `ac.FlagType.Stop` @Black flag, works.
---| `ac.FlagType.SlowVehicle` @Does not work yet.
---| `ac.FlagType.Ambulance` @Does not work yet.
---| `ac.FlagType.ReturnToPits` @Penalty flag, works.
---| `ac.FlagType.MechanicalFailure` @Does not work yet.
---| `ac.FlagType.Unsportsmanlike` @Does not work yet.
---| `ac.FlagType.StopCancel` @Does not work yet.
---| `ac.FlagType.FasterCar` @Blue flag, works.
---| `ac.FlagType.Finished` @Checkered flag, works.
---| `ac.FlagType.OneLapLeft` @White flag, works.
---| `ac.FlagType.SessionSuspended` @Does not work yet.
---| `ac.FlagType.Code60` @Does not work yet.
ac.FlagType = {
  None = 0, ---@type ac.FlagType #No flag, works.
  Start = 1, ---@type ac.FlagType #Works in race, practice or hotlap modes.
  Caution = 2, ---@type ac.FlagType #Yellow flag, works.
  Slippery = 3, ---@type ac.FlagType #Does not work yet.
  PitLaneClosed = 4, ---@type ac.FlagType #Does not work yet.
  Stop = 5, ---@type ac.FlagType #Black flag, works.
  SlowVehicle = 6, ---@type ac.FlagType #Does not work yet.
  Ambulance = 7, ---@type ac.FlagType #Does not work yet.
  ReturnToPits = 8, ---@type ac.FlagType #Penalty flag, works.
  MechanicalFailure = 9, ---@type ac.FlagType #Does not work yet.
  Unsportsmanlike = 10, ---@type ac.FlagType #Does not work yet.
  StopCancel = 11, ---@type ac.FlagType #Does not work yet.
  FasterCar = 12, ---@type ac.FlagType #Blue flag, works.
  Finished = 13, ---@type ac.FlagType #Checkered flag, works.
  OneLapLeft = 14, ---@type ac.FlagType #White flag, works.
  SessionSuspended = 15, ---@type ac.FlagType #Does not work yet.
  Code60 = 16, ---@type ac.FlagType #Does not work yet.
}

---This enum is used by physics scripts only. For the one for car state, use `ac.UserInputMode`.
---@alias ac.InputMethod
---| `ac.InputMethod.Unknown` @Value: 0.
---| `ac.InputMethod.Wheel` @Value: 1.
---| `ac.InputMethod.Gamepad` @Value: 2.
---| `ac.InputMethod.Keyboard` @Value: 3.
---| `ac.InputMethod.AI` @Value: 4.
ac.InputMethod = {
  Unknown = 0, ---@type ac.InputMethod #Value: 0.
  Wheel = 1, ---@type ac.InputMethod #Value: 1.
  Gamepad = 2, ---@type ac.InputMethod #Value: 2.
  Keyboard = 3, ---@type ac.InputMethod #Value: 3.
  AI = 4, ---@type ac.InputMethod #Value: 4.
}

---@alias ac.PenaltyType
---| `ac.PenaltyType.None` @No penalty.
---| `ac.PenaltyType.MandatoryPits` @Parameter: how many laps are left to do mandatory pits.
---| `ac.PenaltyType.TeleportToPits` @Parameter: how many seconds to wait in pits with locked controls.
---| `ac.PenaltyType.SlowDown` @Requires to cut gas for number of seconds in parameter (warning: works only with some race configurations, for example, “Disable gas cut penalty” should not be active in server rules settings).
---| `ac.PenaltyType.BlackFlag` @Adds black flag, no parameter.
---| `ac.PenaltyType.ReleaseBlackFlag` @Removes previously set black flag, no parameter.
ac.PenaltyType = {
  None = 0, ---@type ac.PenaltyType #No penalty.
  MandatoryPits = 1, ---@type ac.PenaltyType #Parameter: how many laps are left to do mandatory pits.
  TeleportToPits = 2, ---@type ac.PenaltyType #Parameter: how many seconds to wait in pits with locked controls.
  SlowDown = 3, ---@type ac.PenaltyType #Requires to cut gas for number of seconds in parameter (warning: works only with some race configurations, for example, “Disable gas cut penalty” should not be active in server rules settings).
  BlackFlag = 4, ---@type ac.PenaltyType #Adds black flag, no parameter.
  ReleaseBlackFlag = 5, ---@type ac.PenaltyType #Removes previously set black flag, no parameter.
}

---@alias ac.ImageFormat
---| `ac.ImageFormat.BMP` @Value: 0.
---| `ac.ImageFormat.JPG` @Value: 1.
---| `ac.ImageFormat.PNG` @Value: 2.
---| `ac.ImageFormat.DDS` @Value: 5.
---| `ac.ImageFormat.ZippedDDS` @DDS in a ZIP file, if used for saving canvas, actual saving happens in a different thread (so, it’s both fast and compact).
ac.ImageFormat = {
  BMP = 0, ---@type ac.ImageFormat #Value: 0.
  JPG = 1, ---@type ac.ImageFormat #Value: 1.
  PNG = 2, ---@type ac.ImageFormat #Value: 2.
  DDS = 5, ---@type ac.ImageFormat #Value: 5.
  ZippedDDS = 6, ---@type ac.ImageFormat #DDS in a ZIP file, if used for saving canvas, actual saving happens in a different thread (so, it’s both fast and compact).
}

---Key indices, pretty much mirrors all those “VK_…” key tables.
---@alias ac.KeyIndex
---| `ac.KeyIndex.LeftButton` @Value: 1.
---| `ac.KeyIndex.RightButton` @Value: 2.
---| `ac.KeyIndex.MiddleButton` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.XButton1` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.XButton2` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.Tab` @Value: 9.
---| `ac.KeyIndex.Return` @Value: 13.
---| `ac.KeyIndex.Shift` @Value: 16.
---| `ac.KeyIndex.Control` @Value: 17.
---| `ac.KeyIndex.Menu` @Aka Alt button.
---| `ac.KeyIndex.Escape` @Value: 27.
---| `ac.KeyIndex.Accept` @Value: 30.
---| `ac.KeyIndex.Space` @Value: 32.
---| `ac.KeyIndex.End` @Value: 35.
---| `ac.KeyIndex.Home` @Value: 36.
---| `ac.KeyIndex.Left` @Arrow ←.
---| `ac.KeyIndex.Up` @Arrow ↑.
---| `ac.KeyIndex.Right` @Arrow →.
---| `ac.KeyIndex.Down` @Arrow ↓.
---| `ac.KeyIndex.Insert` @Value: 45.
---| `ac.KeyIndex.Delete` @Value: 46.
---| `ac.KeyIndex.LeftWin` @Value: 91.
---| `ac.KeyIndex.RightWin` @Value: 92.
---| `ac.KeyIndex.NumPad0` @Value: 96.
---| `ac.KeyIndex.NumPad1` @Value: 97.
---| `ac.KeyIndex.NumPad2` @Value: 98.
---| `ac.KeyIndex.NumPad3` @Value: 99.
---| `ac.KeyIndex.NumPad4` @Value: 100.
---| `ac.KeyIndex.NumPad5` @Value: 101.
---| `ac.KeyIndex.NumPad6` @Value: 102.
---| `ac.KeyIndex.NumPad7` @Value: 103.
---| `ac.KeyIndex.NumPad8` @Value: 104.
---| `ac.KeyIndex.NumPad9` @Value: 105.
---| `ac.KeyIndex.Multiply` @Value: 106.
---| `ac.KeyIndex.Add` @Value: 107.
---| `ac.KeyIndex.Separator` @Value: 108.
---| `ac.KeyIndex.Subtract` @Value: 109.
---| `ac.KeyIndex.Decimal` @Value: 110.
---| `ac.KeyIndex.Divide` @Value: 111.
---| `ac.KeyIndex.F1` @Value: 112.
---| `ac.KeyIndex.F2` @Value: 113.
---| `ac.KeyIndex.F3` @Value: 114.
---| `ac.KeyIndex.F4` @Value: 115.
---| `ac.KeyIndex.F5` @Value: 116.
---| `ac.KeyIndex.F6` @Value: 117.
---| `ac.KeyIndex.F7` @Value: 118.
---| `ac.KeyIndex.F8` @Value: 119.
---| `ac.KeyIndex.F9` @Value: 120.
---| `ac.KeyIndex.F10` @Value: 121.
---| `ac.KeyIndex.F11` @Value: 122.
---| `ac.KeyIndex.F12` @Value: 123.
---| `ac.KeyIndex.NumLock` @Value: 144.
---| `ac.KeyIndex.Scroll` @Value: 145.
---| `ac.KeyIndex.OemNecEqual` @“.
---| `ac.KeyIndex.LeftShift` @Value: 160.
---| `ac.KeyIndex.RightShift` @Value: 161.
---| `ac.KeyIndex.LeftControl` @Value: 162.
---| `ac.KeyIndex.RightControl` @Value: 163.
---| `ac.KeyIndex.LeftMenu` @Aka left Alt button.
---| `ac.KeyIndex.RightMenu` @Aka right Alt button.
---| `ac.KeyIndex.Oem1` @“;:” for US.
---| `ac.KeyIndex.SquareOpenBracket` @Value: 219.
---| `ac.KeyIndex.SquareCloseBracket` @Value: 221.
---| `ac.KeyIndex.D0` @Digit 0.
---| `ac.KeyIndex.D1` @Digit 1.
---| `ac.KeyIndex.D2` @Digit 2.
---| `ac.KeyIndex.D3` @Digit 3.
---| `ac.KeyIndex.D4` @Digit 4.
---| `ac.KeyIndex.D5` @Digit 5.
---| `ac.KeyIndex.D6` @Digit 6.
---| `ac.KeyIndex.D7` @Digit 7.
---| `ac.KeyIndex.D8` @Digit 8.
---| `ac.KeyIndex.D9` @Digit 9.
---| `ac.KeyIndex.A` @Letter A.
---| `ac.KeyIndex.B` @Letter B.
---| `ac.KeyIndex.C` @Letter C.
---| `ac.KeyIndex.D` @Letter D.
---| `ac.KeyIndex.E` @Letter E.
---| `ac.KeyIndex.F` @Letter F.
---| `ac.KeyIndex.G` @Letter G.
---| `ac.KeyIndex.H` @Letter H.
---| `ac.KeyIndex.I` @Letter I.
---| `ac.KeyIndex.J` @Letter J.
---| `ac.KeyIndex.K` @Letter K.
---| `ac.KeyIndex.L` @Letter L.
---| `ac.KeyIndex.M` @Letter M.
---| `ac.KeyIndex.N` @Letter N.
---| `ac.KeyIndex.O` @Letter O.
---| `ac.KeyIndex.P` @Letter P.
---| `ac.KeyIndex.Q` @Letter Q.
---| `ac.KeyIndex.R` @Letter R.
---| `ac.KeyIndex.S` @Letter S.
---| `ac.KeyIndex.T` @Letter T.
---| `ac.KeyIndex.U` @Letter U.
---| `ac.KeyIndex.V` @Letter V.
---| `ac.KeyIndex.W` @Letter W.
---| `ac.KeyIndex.X` @Letter X.
---| `ac.KeyIndex.Y` @Letter Y.
---| `ac.KeyIndex.Z` @Letter Z.
ac.KeyIndex = {
  LeftButton = 1, ---@type ac.KeyIndex #Value: 1.
  RightButton = 2, ---@type ac.KeyIndex #Value: 2.
  Cancel = 3, ---@type ac.KeyIndex #Value: 3.
  MiddleButton = 4, ---@type ac.KeyIndex #Not contiguous with LeftButton and RightButton.
  XButton1 = 5, ---@type ac.KeyIndex #Not contiguous with LeftButton and RightButton.
  XButton2 = 6, ---@type ac.KeyIndex #Not contiguous with LeftButton and RightButton.
  Back = 8, ---@type ac.KeyIndex #Value: 8.
  Tab = 9, ---@type ac.KeyIndex #Value: 9.
  Clear = 12, ---@type ac.KeyIndex #Value: 12.
  Return = 13, ---@type ac.KeyIndex #Value: 13.
  Shift = 16, ---@type ac.KeyIndex #Value: 16.
  Control = 17, ---@type ac.KeyIndex #Value: 17.
  Menu = 18, ---@type ac.KeyIndex #Aka Alt button.
  Pause = 19, ---@type ac.KeyIndex #Value: 19.
  Capital = 20, ---@type ac.KeyIndex #Value: 20.
  Kana = 21, ---@type ac.KeyIndex #Value: 21.
  Hangeul = 21, ---@type ac.KeyIndex #Old name - should be here for compatibility.
  Hangul = 21, ---@type ac.KeyIndex #Value: 21.
  Junja = 23, ---@type ac.KeyIndex #Value: 23.
  Final = 24, ---@type ac.KeyIndex #Value: 24.
  Hanja = 25, ---@type ac.KeyIndex #Value: 25.
  Kanji = 25, ---@type ac.KeyIndex #Value: 25.
  Escape = 27, ---@type ac.KeyIndex #Value: 27.
  Convert = 28, ---@type ac.KeyIndex #Value: 28.
  NonConvert = 29, ---@type ac.KeyIndex #Value: 29.
  Accept = 30, ---@type ac.KeyIndex #Value: 30.
  ModeChange = 31, ---@type ac.KeyIndex #Value: 31.
  Space = 32, ---@type ac.KeyIndex #Value: 32.
  PageUp = 33, ---@type ac.KeyIndex #Value: 33.
  PageDown = 34, ---@type ac.KeyIndex #Value: 34.
  End = 35, ---@type ac.KeyIndex #Value: 35.
  Home = 36, ---@type ac.KeyIndex #Value: 36.
  Left = 37, ---@type ac.KeyIndex #Arrow ←.
  Up = 38, ---@type ac.KeyIndex #Arrow ↑.
  Right = 39, ---@type ac.KeyIndex #Arrow →.
  Down = 40, ---@type ac.KeyIndex #Arrow ↓.
  Select = 41, ---@type ac.KeyIndex #Value: 41.
  Print = 42, ---@type ac.KeyIndex #Value: 42.
  Execute = 43, ---@type ac.KeyIndex #Value: 43.
  Snapshot = 44, ---@type ac.KeyIndex #Value: 44.
  Insert = 45, ---@type ac.KeyIndex #Value: 45.
  Delete = 46, ---@type ac.KeyIndex #Value: 46.
  Help = 47, ---@type ac.KeyIndex #Value: 47.
  LeftWin = 91, ---@type ac.KeyIndex #Value: 91.
  RightWin = 92, ---@type ac.KeyIndex #Value: 92.
  Apps = 93, ---@type ac.KeyIndex #Value: 93.
  Sleep = 95, ---@type ac.KeyIndex #Value: 95.
  NumPad0 = 96, ---@type ac.KeyIndex #Value: 96.
  NumPad1 = 97, ---@type ac.KeyIndex #Value: 97.
  NumPad2 = 98, ---@type ac.KeyIndex #Value: 98.
  NumPad3 = 99, ---@type ac.KeyIndex #Value: 99.
  NumPad4 = 100, ---@type ac.KeyIndex #Value: 100.
  NumPad5 = 101, ---@type ac.KeyIndex #Value: 101.
  NumPad6 = 102, ---@type ac.KeyIndex #Value: 102.
  NumPad7 = 103, ---@type ac.KeyIndex #Value: 103.
  NumPad8 = 104, ---@type ac.KeyIndex #Value: 104.
  NumPad9 = 105, ---@type ac.KeyIndex #Value: 105.
  Multiply = 106, ---@type ac.KeyIndex #Value: 106.
  Add = 107, ---@type ac.KeyIndex #Value: 107.
  Separator = 108, ---@type ac.KeyIndex #Value: 108.
  Subtract = 109, ---@type ac.KeyIndex #Value: 109.
  Decimal = 110, ---@type ac.KeyIndex #Value: 110.
  Divide = 111, ---@type ac.KeyIndex #Value: 111.
  F1 = 112, ---@type ac.KeyIndex #Value: 112.
  F2 = 113, ---@type ac.KeyIndex #Value: 113.
  F3 = 114, ---@type ac.KeyIndex #Value: 114.
  F4 = 115, ---@type ac.KeyIndex #Value: 115.
  F5 = 116, ---@type ac.KeyIndex #Value: 116.
  F6 = 117, ---@type ac.KeyIndex #Value: 117.
  F7 = 118, ---@type ac.KeyIndex #Value: 118.
  F8 = 119, ---@type ac.KeyIndex #Value: 119.
  F9 = 120, ---@type ac.KeyIndex #Value: 120.
  F10 = 121, ---@type ac.KeyIndex #Value: 121.
  F11 = 122, ---@type ac.KeyIndex #Value: 122.
  F12 = 123, ---@type ac.KeyIndex #Value: 123.
  F13 = 124, ---@type ac.KeyIndex #Value: 124.
  F14 = 125, ---@type ac.KeyIndex #Value: 125.
  F15 = 126, ---@type ac.KeyIndex #Value: 126.
  F16 = 127, ---@type ac.KeyIndex #Value: 127.
  F17 = 128, ---@type ac.KeyIndex #Value: 128.
  F18 = 129, ---@type ac.KeyIndex #Value: 129.
  F19 = 130, ---@type ac.KeyIndex #Value: 130.
  F20 = 131, ---@type ac.KeyIndex #Value: 131.
  F21 = 132, ---@type ac.KeyIndex #Value: 132.
  F22 = 133, ---@type ac.KeyIndex #Value: 133.
  F23 = 134, ---@type ac.KeyIndex #Value: 134.
  F24 = 135, ---@type ac.KeyIndex #Value: 135.
  NavigationView = 136, ---@type ac.KeyIndex #Reserved.
  NavigationMenu = 137, ---@type ac.KeyIndex #Reserved.
  NavigationUp = 138, ---@type ac.KeyIndex #Reserved.
  NavigationDown = 139, ---@type ac.KeyIndex #Reserved.
  NavigationLeft = 140, ---@type ac.KeyIndex #Reserved.
  NavigationRight = 141, ---@type ac.KeyIndex #Reserved.
  NavigationAccept = 142, ---@type ac.KeyIndex #Reserved.
  NavigationCancel = 143, ---@type ac.KeyIndex #Reserved.
  NumLock = 144, ---@type ac.KeyIndex #Value: 144.
  Scroll = 145, ---@type ac.KeyIndex #Value: 145.
  OemNecEqual = 146, ---@type ac.KeyIndex #“.
  OemFjJisho = 146, ---@type ac.KeyIndex #“Dictionary” key.
  OemFjMasshou = 147, ---@type ac.KeyIndex #“Unregister word” key.
  OemFjTouroku = 148, ---@type ac.KeyIndex #“Register word” key.
  OemFjLoya = 149, ---@type ac.KeyIndex #“Left OYAYUBI” key.
  OemFjRoya = 150, ---@type ac.KeyIndex #“Right OYAYUBI” key.
  LeftShift = 160, ---@type ac.KeyIndex #Value: 160.
  RightShift = 161, ---@type ac.KeyIndex #Value: 161.
  LeftControl = 162, ---@type ac.KeyIndex #Value: 162.
  RightControl = 163, ---@type ac.KeyIndex #Value: 163.
  LeftMenu = 164, ---@type ac.KeyIndex #Aka left Alt button.
  RightMenu = 165, ---@type ac.KeyIndex #Aka right Alt button.
  BrowserBack = 166, ---@type ac.KeyIndex #Value: 166.
  BrowserForward = 167, ---@type ac.KeyIndex #Value: 167.
  BrowserRefresh = 168, ---@type ac.KeyIndex #Value: 168.
  BrowserStop = 169, ---@type ac.KeyIndex #Value: 169.
  BrowserSearch = 170, ---@type ac.KeyIndex #Value: 170.
  BrowserFavorites = 171, ---@type ac.KeyIndex #Value: 171.
  BrowserHome = 172, ---@type ac.KeyIndex #Value: 172.
  VolumeMute = 173, ---@type ac.KeyIndex #Value: 173.
  VolumeDown = 174, ---@type ac.KeyIndex #Value: 174.
  VolumeUp = 175, ---@type ac.KeyIndex #Value: 175.
  MediaNextTrack = 176, ---@type ac.KeyIndex #Value: 176.
  MediaPrevTrack = 177, ---@type ac.KeyIndex #Value: 177.
  MediaStop = 178, ---@type ac.KeyIndex #Value: 178.
  MediaPlayPause = 179, ---@type ac.KeyIndex #Value: 179.
  LaunchMail = 180, ---@type ac.KeyIndex #Value: 180.
  LaunchMediaSelect = 181, ---@type ac.KeyIndex #Value: 181.
  LaunchApp1 = 182, ---@type ac.KeyIndex #Value: 182.
  LaunchApp2 = 183, ---@type ac.KeyIndex #Value: 183.
  Oem1 = 186, ---@type ac.KeyIndex #“;:” for US.
  OemPlus = 187, ---@type ac.KeyIndex #“+” any country.
  OemComma = 188, ---@type ac.KeyIndex #“,” any country.
  OemMinus = 189, ---@type ac.KeyIndex #“-” any country.
  OemPeriod = 190, ---@type ac.KeyIndex #“.” any country.
  Oem2 = 191, ---@type ac.KeyIndex #“/?” for US.
  Oem3 = 192, ---@type ac.KeyIndex #“`~” for US.
  GamepadA = 195, ---@type ac.KeyIndex #Reserved.
  GamepadB = 196, ---@type ac.KeyIndex #Reserved.
  GamepadX = 197, ---@type ac.KeyIndex #Reserved.
  GamepadY = 198, ---@type ac.KeyIndex #Reserved.
  GamepadRightShoulder = 199, ---@type ac.KeyIndex #Reserved.
  GamepadLeftShoulder = 200, ---@type ac.KeyIndex #Reserved.
  GamepadLeftTrigger = 201, ---@type ac.KeyIndex #Reserved.
  GamepadRightTrigger = 202, ---@type ac.KeyIndex #Reserved.
  GamepadDpadUp = 203, ---@type ac.KeyIndex #Reserved.
  GamepadDpadDown = 204, ---@type ac.KeyIndex #Reserved.
  GamepadDpadLeft = 205, ---@type ac.KeyIndex #Reserved.
  GamepadDpadRight = 206, ---@type ac.KeyIndex #Reserved.
  GamepadMenu = 207, ---@type ac.KeyIndex #Reserved.
  GamepadView = 208, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickButton = 209, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickButton = 210, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickUp = 211, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickDown = 212, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickRight = 213, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickLeft = 214, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickUp = 215, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickDown = 216, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickRight = 217, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickLeft = 218, ---@type ac.KeyIndex #Reserved.
  SquareOpenBracket = 219, ---@type ac.KeyIndex #Value: 219.
  SquareCloseBracket = 221, ---@type ac.KeyIndex #Value: 221.
  D0 = 48, ---@type ac.KeyIndex #Digit 0.
  D1 = 49, ---@type ac.KeyIndex #Digit 1.
  D2 = 50, ---@type ac.KeyIndex #Digit 2.
  D3 = 51, ---@type ac.KeyIndex #Digit 3.
  D4 = 52, ---@type ac.KeyIndex #Digit 4.
  D5 = 53, ---@type ac.KeyIndex #Digit 5.
  D6 = 54, ---@type ac.KeyIndex #Digit 6.
  D7 = 55, ---@type ac.KeyIndex #Digit 7.
  D8 = 56, ---@type ac.KeyIndex #Digit 8.
  D9 = 57, ---@type ac.KeyIndex #Digit 9.
  A = 65, ---@type ac.KeyIndex #Letter A.
  B = 66, ---@type ac.KeyIndex #Letter B.
  C = 67, ---@type ac.KeyIndex #Letter C.
  D = 68, ---@type ac.KeyIndex #Letter D.
  E = 69, ---@type ac.KeyIndex #Letter E.
  F = 70, ---@type ac.KeyIndex #Letter F.
  G = 71, ---@type ac.KeyIndex #Letter G.
  H = 72, ---@type ac.KeyIndex #Letter H.
  I = 73, ---@type ac.KeyIndex #Letter I.
  J = 74, ---@type ac.KeyIndex #Letter J.
  K = 75, ---@type ac.KeyIndex #Letter K.
  L = 76, ---@type ac.KeyIndex #Letter L.
  M = 77, ---@type ac.KeyIndex #Letter M.
  N = 78, ---@type ac.KeyIndex #Letter N.
  O = 79, ---@type ac.KeyIndex #Letter O.
  P = 80, ---@type ac.KeyIndex #Letter P.
  Q = 81, ---@type ac.KeyIndex #Letter Q.
  R = 82, ---@type ac.KeyIndex #Letter R.
  S = 83, ---@type ac.KeyIndex #Letter S.
  T = 84, ---@type ac.KeyIndex #Letter T.
  U = 85, ---@type ac.KeyIndex #Letter U.
  V = 86, ---@type ac.KeyIndex #Letter V.
  W = 87, ---@type ac.KeyIndex #Letter W.
  X = 88, ---@type ac.KeyIndex #Letter X.
  Y = 89, ---@type ac.KeyIndex #Letter Y.
  Z = 90, ---@type ac.KeyIndex #Letter Z.
}

---More types might be added later, or at least a `CustomMode` type.
---@alias ac.SessionType
---| `ac.SessionType.Undefined` @Value: 0.
---| `ac.SessionType.Practice` @Value: 1.
---| `ac.SessionType.Qualify` @Value: 2.
---| `ac.SessionType.Race` @Value: 3.
---| `ac.SessionType.Hotlap` @Value: 4.
---| `ac.SessionType.TimeAttack` @Value: 5.
---| `ac.SessionType.Drift` @Value: 6.
---| `ac.SessionType.Drag` @Value: 7.
ac.SessionType = {
  Undefined = 0, ---@type ac.SessionType #Value: 0.
  Practice = 1, ---@type ac.SessionType #Value: 1.
  Qualify = 2, ---@type ac.SessionType #Value: 2.
  Race = 3, ---@type ac.SessionType #Value: 3.
  Hotlap = 4, ---@type ac.SessionType #Value: 4.
  TimeAttack = 5, ---@type ac.SessionType #Value: 5.
  Drift = 6, ---@type ac.SessionType #Value: 6.
  Drag = 7, ---@type ac.SessionType #Value: 7.
}

---@alias ac.SharedNamespace
---| `ac.SharedNamespace.Global` @Value: ''.
---| `ac.SharedNamespace.CarDisplay` @Value: 'car_scriptable_display'.
---| `ac.SharedNamespace.CarScript` @Value: 'car_script'.
---| `ac.SharedNamespace.TrackDisplay` @Value: 'track_scriptable_display'.
---| `ac.SharedNamespace.TrackScript` @Value: 'track_script'.
---| `ac.SharedNamespace.ServerScript` @Value: 'server_script'.
---| `ac.SharedNamespace.Shared` @Value: 'shared'.
ac.SharedNamespace = {
  Global = '', ---@type ac.SharedNamespace #Value: ''.
  CarDisplay = 'car_scriptable_display', ---@type ac.SharedNamespace #Value: 'car_scriptable_display'.
  CarScript = 'car_script', ---@type ac.SharedNamespace #Value: 'car_script'.
  TrackDisplay = 'track_scriptable_display', ---@type ac.SharedNamespace #Value: 'track_scriptable_display'.
  TrackScript = 'track_script', ---@type ac.SharedNamespace #Value: 'track_script'.
  ServerScript = 'server_script', ---@type ac.SharedNamespace #Value: 'server_script'.
  Shared = 'shared', ---@type ac.SharedNamespace #Value: 'shared'.
}

---@alias ac.CompressionType
---| `ac.CompressionType.LZ4` @Fastest compression, great for use in real-time applications. Does not take `level` into account.
---| `ac.CompressionType.Deflate` @Deflate compression.
---| `ac.CompressionType.Zlib` @Zlib compression (deflate with zlib wrapper).
---| `ac.CompressionType.Gzip` @Gzip compression (deflate with gzip wrapper).
ac.CompressionType = {
  LZ4 = 0, ---@type ac.CompressionType #Fastest compression, great for use in real-time applications. Does not take `level` into account.
  Deflate = 1, ---@type ac.CompressionType #Deflate compression.
  Zlib = 2, ---@type ac.CompressionType #Zlib compression (deflate with zlib wrapper).
  Gzip = 3, ---@type ac.CompressionType #Gzip compression (deflate with gzip wrapper).
}

---@alias ac.NationCode
---| `ac.NationCode.Aruba` @Aruba.
---| `ac.NationCode.Afghanistan` @Afghanistan.
---| `ac.NationCode.Angola` @Angola.
---| `ac.NationCode.Anguilla` @Anguilla.
---| `ac.NationCode.Albania` @Albania.
---| `ac.NationCode.Andorra` @Andorra.
---| `ac.NationCode.United` @United.
---| `ac.NationCode.Argentina` @Argentina.
---| `ac.NationCode.Armenia` @Armenia.
---| `ac.NationCode.American` @American.
---| `ac.NationCode.Antarctica` @Antarctica.
---| `ac.NationCode.Antigua` @Antigua.
---| `ac.NationCode.Australia` @Australia.
---| `ac.NationCode.Austria` @Austria.
---| `ac.NationCode.Azerbaijan` @Azerbaijan.
---| `ac.NationCode.Burundi` @Burundi.
---| `ac.NationCode.Belgium` @Belgium.
---| `ac.NationCode.Benin` @Benin.
---| `ac.NationCode.Burkina` @Burkina.
---| `ac.NationCode.Bangladesh` @Bangladesh.
---| `ac.NationCode.Bulgaria` @Bulgaria.
---| `ac.NationCode.Bahrain` @Bahrain.
---| `ac.NationCode.Bahamas` @Bahamas.
---| `ac.NationCode.Bosnia` @Bosnia.
---| `ac.NationCode.Belarus` @Belarus.
---| `ac.NationCode.Belize` @Belize.
---| `ac.NationCode.Bermuda` @Bermuda.
---| `ac.NationCode.Bolivia` @Bolivia.
---| `ac.NationCode.Brazil` @Brazil.
---| `ac.NationCode.Barbados` @Barbados.
---| `ac.NationCode.Brunei` @Brunei.
---| `ac.NationCode.Bhutan` @Bhutan.
---| `ac.NationCode.Botswana` @Botswana.
---| `ac.NationCode.Central` @Central.
---| `ac.NationCode.Canada` @Canada.
---| `ac.NationCode.Cocos` @Cocos.
---| `ac.NationCode.Switzerland` @Switzerland.
---| `ac.NationCode.Chile` @Chile.
---| `ac.NationCode.China` @China.
---| `ac.NationCode.Cote` @Côte.
---| `ac.NationCode.Cameroon` @Cameroon.
---| `ac.NationCode.Congo` @Congo.
---| `ac.NationCode.Cook` @Cook.
---| `ac.NationCode.Colombia` @Colombia.
---| `ac.NationCode.Comoros` @Comoros.
---| `ac.NationCode.Cape` @Cape.
---| `ac.NationCode.Costa` @Costa.
---| `ac.NationCode.Cuba` @Cuba.
---| `ac.NationCode.Cayman` @Cayman.
---| `ac.NationCode.Cyprus` @Cyprus.
---| `ac.NationCode.Czech` @Czech.
---| `ac.NationCode.Germany` @Germany.
---| `ac.NationCode.Djibouti` @Djibouti.
---| `ac.NationCode.Dominica` @Dominica.
---| `ac.NationCode.Denmark` @Denmark.
---| `ac.NationCode.Dominican` @Dominican.
---| `ac.NationCode.Algeria` @Algeria.
---| `ac.NationCode.Ecuador` @Ecuador.
---| `ac.NationCode.Egypt` @Egypt.
---| `ac.NationCode.England` @England.
---| `ac.NationCode.Eritrea` @Eritrea.
---| `ac.NationCode.Western` @Western.
---| `ac.NationCode.Spain` @Spain.
---| `ac.NationCode.Estonia` @Estonia.
---| `ac.NationCode.Ethiopia` @Ethiopia.
---| `ac.NationCode.Finland` @Finland.
---| `ac.NationCode.Fiji` @Fiji.
---| `ac.NationCode.France` @France.
---| `ac.NationCode.Faroe` @Faroe.
---| `ac.NationCode.Micronesia` @Micronesia.
---| `ac.NationCode.Gabon` @Gabon.
---| `ac.NationCode.Great` @Great.
---| `ac.NationCode.Georgia` @Georgia.
---| `ac.NationCode.Guernsey` @Guernsey.
---| `ac.NationCode.Ghana` @Ghana.
---| `ac.NationCode.Gibraltar` @Gibraltar.
---| `ac.NationCode.Guinea` @Guinea.
---| `ac.NationCode.Gambia` @Gambia.
---| `ac.NationCode.Equatorial` @Equatorial.
---| `ac.NationCode.Greece` @Greece.
---| `ac.NationCode.Grenada` @Grenada.
---| `ac.NationCode.Greenland` @Greenland.
---| `ac.NationCode.Guatemala` @Guatemala.
---| `ac.NationCode.Guam` @Guam.
---| `ac.NationCode.Guyana` @Guyana.
---| `ac.NationCode.Hong` @Hong.
---| `ac.NationCode.Honduras` @Honduras.
---| `ac.NationCode.Croatia` @Croatia.
---| `ac.NationCode.Haiti` @Haiti.
---| `ac.NationCode.Hungary` @Hungary.
---| `ac.NationCode.Indonesia` @Indonesia.
---| `ac.NationCode.Isle` @Isle.
---| `ac.NationCode.India` @India.
---| `ac.NationCode.Ireland` @Ireland.
---| `ac.NationCode.Iran` @Iran.
---| `ac.NationCode.Iraq` @Iraq.
---| `ac.NationCode.Iceland` @Iceland.
---| `ac.NationCode.Israel` @Israel.
---| `ac.NationCode.Italy` @Italy.
---| `ac.NationCode.Jamaica` @Jamaica.
---| `ac.NationCode.Jersey` @Jersey.
---| `ac.NationCode.Jordan` @Jordan.
---| `ac.NationCode.Japan` @Japan.
---| `ac.NationCode.Kazakhstan` @Kazakhstan.
---| `ac.NationCode.Kenya` @Kenya.
---| `ac.NationCode.Kyrgyzstan` @Kyrgyzstan.
---| `ac.NationCode.Cambodia` @Cambodia.
---| `ac.NationCode.Kiribati` @Kiribati.
---| `ac.NationCode.Saint` @Saint.
---| `ac.NationCode.South` @South.
---| `ac.NationCode.Kuwait` @Kuwait.
---| `ac.NationCode.Laos` @Laos.
---| `ac.NationCode.Lebanon` @Lebanon.
---| `ac.NationCode.Liberia` @Liberia.
---| `ac.NationCode.Liechtenstein` @Liechtenstein.
---| `ac.NationCode.Sri` @Sri.
---| `ac.NationCode.Lesotho` @Lesotho.
---| `ac.NationCode.Lithuania` @Lithuania.
---| `ac.NationCode.Luxembourg` @Luxembourg.
---| `ac.NationCode.Latvia` @Latvia.
---| `ac.NationCode.Macau` @Macau.
---| `ac.NationCode.Morocco` @Morocco.
---| `ac.NationCode.Monaco` @Monaco.
---| `ac.NationCode.Moldova` @Moldova.
---| `ac.NationCode.Madagascar` @Madagascar.
---| `ac.NationCode.Maldives` @Maldives.
---| `ac.NationCode.Mexico` @Mexico.
---| `ac.NationCode.Marshall` @Marshall.
---| `ac.NationCode.Macedonia` @Macedonia.
---| `ac.NationCode.Mali` @Mali.
---| `ac.NationCode.Malta` @Malta.
---| `ac.NationCode.Myanmar` @Myanmar.
---| `ac.NationCode.Montenegro` @Montenegro.
---| `ac.NationCode.Mongolia` @Mongolia.
---| `ac.NationCode.Mozambique` @Mozambique.
---| `ac.NationCode.Mauritania` @Mauritania.
---| `ac.NationCode.Montserrat` @Montserrat.
---| `ac.NationCode.Martinique` @Martinique.
---| `ac.NationCode.Mauritius` @Mauritius.
---| `ac.NationCode.Malawi` @Malawi.
---| `ac.NationCode.Malaysia` @Malaysia.
---| `ac.NationCode.Namibia` @Namibia.
---| `ac.NationCode.New` @New.
---| `ac.NationCode.Niger` @Niger.
---| `ac.NationCode.Nigeria` @Nigeria.
---| `ac.NationCode.Nicaragua` @Nicaragua.
---| `ac.NationCode.Northern` @Northern.
---| `ac.NationCode.Netherlands` @Netherlands.
---| `ac.NationCode.Norway` @Norway.
---| `ac.NationCode.Nepal` @Nepal.
---| `ac.NationCode.Nauru` @Nauru.
---| `ac.NationCode.Oman` @Oman.
---| `ac.NationCode.Pakistan` @Pakistan.
---| `ac.NationCode.Panama` @Panama.
---| `ac.NationCode.Peru` @Peru.
---| `ac.NationCode.Philippines` @Philippines.
---| `ac.NationCode.Palau` @Palau.
---| `ac.NationCode.Papua` @Papua.
---| `ac.NationCode.Poland` @Poland.
---| `ac.NationCode.Puerto` @Puerto.
---| `ac.NationCode.Portugal` @Portugal.
---| `ac.NationCode.Paraguay` @Paraguay.
---| `ac.NationCode.French` @French.
---| `ac.NationCode.Qatar` @Qatar.
---| `ac.NationCode.Romania` @Romania.
---| `ac.NationCode.Russia` @Russia.
---| `ac.NationCode.Rwanda` @Rwanda.
---| `ac.NationCode.Saudi` @Saudi.
---| `ac.NationCode.Scotland` @Scotland.
---| `ac.NationCode.Sudan` @Sudan.
---| `ac.NationCode.Senegal` @Senegal.
---| `ac.NationCode.Singapore` @Singapore.
---| `ac.NationCode.Solomon` @Solomon.
---| `ac.NationCode.Sierra` @Sierra.
---| `ac.NationCode.El` @El.
---| `ac.NationCode.San` @San.
---| `ac.NationCode.Somalia` @Somalia.
---| `ac.NationCode.Serbia` @Serbia.
---| `ac.NationCode.Sao` @Sao.
---| `ac.NationCode.Suriname` @Suriname.
---| `ac.NationCode.Slovakia` @Slovakia.
---| `ac.NationCode.Slovenia` @Slovenia.
---| `ac.NationCode.Sweden` @Sweden.
---| `ac.NationCode.Swaziland` @Swaziland.
---| `ac.NationCode.Seychelles` @Seychelles.
---| `ac.NationCode.Syria` @Syria.
---| `ac.NationCode.Turks` @Turks.
---| `ac.NationCode.Chad` @Chad.
---| `ac.NationCode.Togo` @Togo.
---| `ac.NationCode.Thailand` @Thailand.
---| `ac.NationCode.Tajikistan` @Tajikistan.
---| `ac.NationCode.Turkmenistan` @Turkmenistan.
---| `ac.NationCode.Timor` @Timor.
---| `ac.NationCode.Tonga` @Tonga.
---| `ac.NationCode.Trinidad` @Trinidad.
---| `ac.NationCode.Tunisia` @Tunisia.
---| `ac.NationCode.Turkey` @Turkey.
---| `ac.NationCode.Tuvalu` @Tuvalu.
---| `ac.NationCode.Taiwan` @Taiwan.
---| `ac.NationCode.Tanzania` @Tanzania.
---| `ac.NationCode.Uganda` @Uganda.
---| `ac.NationCode.Ukraine` @Ukraine.
---| `ac.NationCode.Uruguay` @Uruguay.
---| `ac.NationCode.USA` @USA.
---| `ac.NationCode.Uzbekistan` @Uzbekistan.
---| `ac.NationCode.Venezuela` @Venezuela.
---| `ac.NationCode.British` @British.
---| `ac.NationCode.Virgin` @Virgin.
---| `ac.NationCode.Vietnam` @Vietnam.
---| `ac.NationCode.Vanuatu` @Vanuatu.
---| `ac.NationCode.Wales` @Wales.
---| `ac.NationCode.Samoa` @Samoa.
---| `ac.NationCode.Yemen` @Yemen.
---| `ac.NationCode.Zambia` @Zambia.
---| `ac.NationCode.Zimbabwe` @Zimbabwe.
ac.NationCode = {
  Aruba = 'ABW', ---@type ac.NationCode #Aruba.
  Afghanistan = 'AFG', ---@type ac.NationCode #Afghanistan.
  Angola = 'AGO', ---@type ac.NationCode #Angola.
  Anguilla = 'AIA', ---@type ac.NationCode #Anguilla.
  Albania = 'ALB', ---@type ac.NationCode #Albania.
  Andorra = 'AND', ---@type ac.NationCode #Andorra.
  United = 'ARE', ---@type ac.NationCode #United.
  Argentina = 'ARG', ---@type ac.NationCode #Argentina.
  Armenia = 'ARM', ---@type ac.NationCode #Armenia.
  American = 'ASM', ---@type ac.NationCode #American.
  Antarctica = 'ATA', ---@type ac.NationCode #Antarctica.
  Antigua = 'ATG', ---@type ac.NationCode #Antigua.
  Australia = 'AUS', ---@type ac.NationCode #Australia.
  Austria = 'AUT', ---@type ac.NationCode #Austria.
  Azerbaijan = 'AZE', ---@type ac.NationCode #Azerbaijan.
  Burundi = 'BDI', ---@type ac.NationCode #Burundi.
  Belgium = 'BEL', ---@type ac.NationCode #Belgium.
  Benin = 'BEN', ---@type ac.NationCode #Benin.
  Burkina = 'BFA', ---@type ac.NationCode #Burkina.
  Bangladesh = 'BGD', ---@type ac.NationCode #Bangladesh.
  Bulgaria = 'BGR', ---@type ac.NationCode #Bulgaria.
  Bahrain = 'BHR', ---@type ac.NationCode #Bahrain.
  Bahamas = 'BHS', ---@type ac.NationCode #Bahamas.
  Bosnia = 'BIH', ---@type ac.NationCode #Bosnia.
  Belarus = 'BLR', ---@type ac.NationCode #Belarus.
  Belize = 'BLZ', ---@type ac.NationCode #Belize.
  Bermuda = 'BMU', ---@type ac.NationCode #Bermuda.
  Bolivia = 'BOL', ---@type ac.NationCode #Bolivia.
  Brazil = 'BRA', ---@type ac.NationCode #Brazil.
  Barbados = 'BRB', ---@type ac.NationCode #Barbados.
  Brunei = 'BRN', ---@type ac.NationCode #Brunei.
  Bhutan = 'BTN', ---@type ac.NationCode #Bhutan.
  Botswana = 'BWA', ---@type ac.NationCode #Botswana.
  Central = 'CAF', ---@type ac.NationCode #Central.
  Canada = 'CAN', ---@type ac.NationCode #Canada.
  Cocos = 'CCK', ---@type ac.NationCode #Cocos.
  Switzerland = 'CHE', ---@type ac.NationCode #Switzerland.
  Chile = 'CHL', ---@type ac.NationCode #Chile.
  China = 'CHN', ---@type ac.NationCode #China.
  Cote = 'CIV', ---@type ac.NationCode #Côte.
  Cameroon = 'CMR', ---@type ac.NationCode #Cameroon.
  Congo = 'COG', ---@type ac.NationCode #Congo.
  Cook = 'COK', ---@type ac.NationCode #Cook.
  Colombia = 'COL', ---@type ac.NationCode #Colombia.
  Comoros = 'COM', ---@type ac.NationCode #Comoros.
  Cape = 'CPV', ---@type ac.NationCode #Cape.
  Costa = 'CRI', ---@type ac.NationCode #Costa.
  Cuba = 'CUB', ---@type ac.NationCode #Cuba.
  Cayman = 'CYM', ---@type ac.NationCode #Cayman.
  Cyprus = 'CYP', ---@type ac.NationCode #Cyprus.
  Czech = 'CZE', ---@type ac.NationCode #Czech.
  Germany = 'DEU', ---@type ac.NationCode #Germany.
  Djibouti = 'DJI', ---@type ac.NationCode #Djibouti.
  Dominica = 'DMA', ---@type ac.NationCode #Dominica.
  Denmark = 'DNK', ---@type ac.NationCode #Denmark.
  Dominican = 'DOM', ---@type ac.NationCode #Dominican.
  Algeria = 'DZA', ---@type ac.NationCode #Algeria.
  Ecuador = 'ECU', ---@type ac.NationCode #Ecuador.
  Egypt = 'EGY', ---@type ac.NationCode #Egypt.
  England = 'ENG', ---@type ac.NationCode #England.
  Eritrea = 'ERI', ---@type ac.NationCode #Eritrea.
  Western = 'ESH', ---@type ac.NationCode #Western.
  Spain = 'ESP', ---@type ac.NationCode #Spain.
  Estonia = 'EST', ---@type ac.NationCode #Estonia.
  Ethiopia = 'ETH', ---@type ac.NationCode #Ethiopia.
  Finland = 'FIN', ---@type ac.NationCode #Finland.
  Fiji = 'FJI', ---@type ac.NationCode #Fiji.
  France = 'FRA', ---@type ac.NationCode #France.
  Faroe = 'FRO', ---@type ac.NationCode #Faroe.
  Micronesia = 'FSM', ---@type ac.NationCode #Micronesia.
  Gabon = 'GAB', ---@type ac.NationCode #Gabon.
  Great = 'GBR', ---@type ac.NationCode #Great.
  Georgia = 'GEO', ---@type ac.NationCode #Georgia.
  Guernsey = 'GGY', ---@type ac.NationCode #Guernsey.
  Ghana = 'GHA', ---@type ac.NationCode #Ghana.
  Gibraltar = 'GIB', ---@type ac.NationCode #Gibraltar.
  Guinea = 'GNB', ---@type ac.NationCode #Guinea.
  Gambia = 'GMB', ---@type ac.NationCode #Gambia.
  Equatorial = 'GNQ', ---@type ac.NationCode #Equatorial.
  Greece = 'GRC', ---@type ac.NationCode #Greece.
  Grenada = 'GRD', ---@type ac.NationCode #Grenada.
  Greenland = 'GRL', ---@type ac.NationCode #Greenland.
  Guatemala = 'GTM', ---@type ac.NationCode #Guatemala.
  Guam = 'GUM', ---@type ac.NationCode #Guam.
  Guyana = 'GUY', ---@type ac.NationCode #Guyana.
  Hong = 'HKG', ---@type ac.NationCode #Hong.
  Honduras = 'HND', ---@type ac.NationCode #Honduras.
  Croatia = 'HRV', ---@type ac.NationCode #Croatia.
  Haiti = 'HTI', ---@type ac.NationCode #Haiti.
  Hungary = 'HUN', ---@type ac.NationCode #Hungary.
  Indonesia = 'IDN', ---@type ac.NationCode #Indonesia.
  Isle = 'IMN', ---@type ac.NationCode #Isle.
  India = 'IND', ---@type ac.NationCode #India.
  Ireland = 'IRL', ---@type ac.NationCode #Ireland.
  Iran = 'IRN', ---@type ac.NationCode #Iran.
  Iraq = 'IRQ', ---@type ac.NationCode #Iraq.
  Iceland = 'ISL', ---@type ac.NationCode #Iceland.
  Israel = 'ISR', ---@type ac.NationCode #Israel.
  Italy = 'ITA', ---@type ac.NationCode #Italy.
  Jamaica = 'JAM', ---@type ac.NationCode #Jamaica.
  Jersey = 'JEY', ---@type ac.NationCode #Jersey.
  Jordan = 'JOR', ---@type ac.NationCode #Jordan.
  Japan = 'JPN', ---@type ac.NationCode #Japan.
  Kazakhstan = 'KAZ', ---@type ac.NationCode #Kazakhstan.
  Kenya = 'KEN', ---@type ac.NationCode #Kenya.
  Kyrgyzstan = 'KGZ', ---@type ac.NationCode #Kyrgyzstan.
  Cambodia = 'KHM', ---@type ac.NationCode #Cambodia.
  Kiribati = 'KIR', ---@type ac.NationCode #Kiribati.
  Saint = 'VCT', ---@type ac.NationCode #Saint.
  South = 'ZAF', ---@type ac.NationCode #South.
  Kuwait = 'KWT', ---@type ac.NationCode #Kuwait.
  Laos = 'LAO', ---@type ac.NationCode #Laos.
  Lebanon = 'LBN', ---@type ac.NationCode #Lebanon.
  Liberia = 'LBR', ---@type ac.NationCode #Liberia.
  Liechtenstein = 'LIE', ---@type ac.NationCode #Liechtenstein.
  Sri = 'LKA', ---@type ac.NationCode #Sri.
  Lesotho = 'LSO', ---@type ac.NationCode #Lesotho.
  Lithuania = 'LTU', ---@type ac.NationCode #Lithuania.
  Luxembourg = 'LUX', ---@type ac.NationCode #Luxembourg.
  Latvia = 'LVA', ---@type ac.NationCode #Latvia.
  Macau = 'MAC', ---@type ac.NationCode #Macau.
  Morocco = 'MAR', ---@type ac.NationCode #Morocco.
  Monaco = 'MCO', ---@type ac.NationCode #Monaco.
  Moldova = 'MDA', ---@type ac.NationCode #Moldova.
  Madagascar = 'MDG', ---@type ac.NationCode #Madagascar.
  Maldives = 'MDV', ---@type ac.NationCode #Maldives.
  Mexico = 'MEX', ---@type ac.NationCode #Mexico.
  Marshall = 'MHL', ---@type ac.NationCode #Marshall.
  Macedonia = 'MKD', ---@type ac.NationCode #Macedonia.
  Mali = 'MLI', ---@type ac.NationCode #Mali.
  Malta = 'MLT', ---@type ac.NationCode #Malta.
  Myanmar = 'MMR', ---@type ac.NationCode #Myanmar.
  Montenegro = 'MNE', ---@type ac.NationCode #Montenegro.
  Mongolia = 'MNG', ---@type ac.NationCode #Mongolia.
  Mozambique = 'MOZ', ---@type ac.NationCode #Mozambique.
  Mauritania = 'MRT', ---@type ac.NationCode #Mauritania.
  Montserrat = 'MSR', ---@type ac.NationCode #Montserrat.
  Martinique = 'MTQ', ---@type ac.NationCode #Martinique.
  Mauritius = 'MUS', ---@type ac.NationCode #Mauritius.
  Malawi = 'MWI', ---@type ac.NationCode #Malawi.
  Malaysia = 'MYS', ---@type ac.NationCode #Malaysia.
  Namibia = 'NAM', ---@type ac.NationCode #Namibia.
  New = 'NZL', ---@type ac.NationCode #New.
  Niger = 'NER', ---@type ac.NationCode #Niger.
  Nigeria = 'NGA', ---@type ac.NationCode #Nigeria.
  Nicaragua = 'NIC', ---@type ac.NationCode #Nicaragua.
  Northern = 'NIR', ---@type ac.NationCode #Northern.
  Netherlands = 'NLD', ---@type ac.NationCode #Netherlands.
  Norway = 'NOR', ---@type ac.NationCode #Norway.
  Nepal = 'NPL', ---@type ac.NationCode #Nepal.
  Nauru = 'NRU', ---@type ac.NationCode #Nauru.
  Oman = 'OMN', ---@type ac.NationCode #Oman.
  Pakistan = 'PAK', ---@type ac.NationCode #Pakistan.
  Panama = 'PAN', ---@type ac.NationCode #Panama.
  Peru = 'PER', ---@type ac.NationCode #Peru.
  Philippines = 'PHL', ---@type ac.NationCode #Philippines.
  Palau = 'PLW', ---@type ac.NationCode #Palau.
  Papua = 'PNG', ---@type ac.NationCode #Papua.
  Poland = 'POL', ---@type ac.NationCode #Poland.
  Puerto = 'PRI', ---@type ac.NationCode #Puerto.
  Portugal = 'PRT', ---@type ac.NationCode #Portugal.
  Paraguay = 'PRY', ---@type ac.NationCode #Paraguay.
  French = 'PYF', ---@type ac.NationCode #French.
  Qatar = 'QAT', ---@type ac.NationCode #Qatar.
  Romania = 'ROU', ---@type ac.NationCode #Romania.
  Russia = 'RUS', ---@type ac.NationCode #Russia.
  Rwanda = 'RWA', ---@type ac.NationCode #Rwanda.
  Saudi = 'SAU', ---@type ac.NationCode #Saudi.
  Scotland = 'SCT', ---@type ac.NationCode #Scotland.
  Sudan = 'SDN', ---@type ac.NationCode #Sudan.
  Senegal = 'SEN', ---@type ac.NationCode #Senegal.
  Singapore = 'SGP', ---@type ac.NationCode #Singapore.
  Solomon = 'SLB', ---@type ac.NationCode #Solomon.
  Sierra = 'SLE', ---@type ac.NationCode #Sierra.
  El = 'SLV', ---@type ac.NationCode #El.
  San = 'SMR', ---@type ac.NationCode #San.
  Somalia = 'SOM', ---@type ac.NationCode #Somalia.
  Serbia = 'SRB', ---@type ac.NationCode #Serbia.
  Sao = 'STP', ---@type ac.NationCode #Sao.
  Suriname = 'SUR', ---@type ac.NationCode #Suriname.
  Slovakia = 'SVK', ---@type ac.NationCode #Slovakia.
  Slovenia = 'SVN', ---@type ac.NationCode #Slovenia.
  Sweden = 'SWE', ---@type ac.NationCode #Sweden.
  Swaziland = 'SWZ', ---@type ac.NationCode #Swaziland.
  Seychelles = 'SYC', ---@type ac.NationCode #Seychelles.
  Syria = 'SYR', ---@type ac.NationCode #Syria.
  Turks = 'TCA', ---@type ac.NationCode #Turks.
  Chad = 'TCD', ---@type ac.NationCode #Chad.
  Togo = 'TGO', ---@type ac.NationCode #Togo.
  Thailand = 'THA', ---@type ac.NationCode #Thailand.
  Tajikistan = 'TJK', ---@type ac.NationCode #Tajikistan.
  Turkmenistan = 'TKM', ---@type ac.NationCode #Turkmenistan.
  Timor = 'TLS', ---@type ac.NationCode #Timor.
  Tonga = 'TON', ---@type ac.NationCode #Tonga.
  Trinidad = 'TTO', ---@type ac.NationCode #Trinidad.
  Tunisia = 'TUN', ---@type ac.NationCode #Tunisia.
  Turkey = 'TUR', ---@type ac.NationCode #Turkey.
  Tuvalu = 'TUV', ---@type ac.NationCode #Tuvalu.
  Taiwan = 'TWN', ---@type ac.NationCode #Taiwan.
  Tanzania = 'TZA', ---@type ac.NationCode #Tanzania.
  Uganda = 'UGA', ---@type ac.NationCode #Uganda.
  Ukraine = 'UKR', ---@type ac.NationCode #Ukraine.
  Uruguay = 'URY', ---@type ac.NationCode #Uruguay.
  USA = 'USA', ---@type ac.NationCode #USA.
  Uzbekistan = 'UZB', ---@type ac.NationCode #Uzbekistan.
  Venezuela = 'VEN', ---@type ac.NationCode #Venezuela.
  British = 'VGB', ---@type ac.NationCode #British.
  Virgin = 'VIR', ---@type ac.NationCode #Virgin.
  Vietnam = 'VNM', ---@type ac.NationCode #Vietnam.
  Vanuatu = 'VUT', ---@type ac.NationCode #Vanuatu.
  Wales = 'WLS', ---@type ac.NationCode #Wales.
  Samoa = 'WSM', ---@type ac.NationCode #Samoa.
  Yemen = 'YEM', ---@type ac.NationCode #Yemen.
  Zambia = 'ZMB', ---@type ac.NationCode #Zambia.
  Zimbabwe = 'ZWE', ---@type ac.NationCode #Zimbabwe.
}

---@alias ac.CSPModuleID
---| `ac.CSPModuleID.BrakeDiscFX` @Brake Disc FX.
---| `ac.CSPModuleID.CarInstruments` @Car instruments.
---| `ac.CSPModuleID.ChaserCamera` @Chaser Camera.
---| `ac.CSPModuleID.ChatShortcuts` @Chat shortcuts.
---| `ac.CSPModuleID.ColorfulShadowing` @Colorful shadowing.
---| `ac.CSPModuleID.CustomRenderingModes` @Mode tweaks: custom render modes.
---| `ac.CSPModuleID.DXGITweaks` @DXGI.
---| `ac.CSPModuleID.ExtraFX` @Extra FX.
---| `ac.CSPModuleID.FakeShadowsFX` @Fake Shadows FX.
---| `ac.CSPModuleID.FFBTweaks` @FFB Tweaks.
---| `ac.CSPModuleID.FreerCamera` @Freer Camera.
---| `ac.CSPModuleID.G27Lights` @Logitech G27/29.
---| `ac.CSPModuleID.GamepadFX` @Gamepad FX.
---| `ac.CSPModuleID.General` @General Patch settings.
---| `ac.CSPModuleID.GraphicsAdjustments` @Graphics adjustments.
---| `ac.CSPModuleID.GrassFX` @Grass FX.
---| `ac.CSPModuleID.GUI` @GUI.
---| `ac.CSPModuleID.LightingFX` @Lighting FX.
---| `ac.CSPModuleID.LuaTools` @Lua_tools.
---| `ac.CSPModuleID.MumblePlugin` @Mumble_plugin.
---| `ac.CSPModuleID.Music` @Music.
---| `ac.CSPModuleID.NeckFX` @Neck FX.
---| `ac.CSPModuleID.NewBehaviour` @New AI behavior.
---| `ac.CSPModuleID.NiceScreenshots` @Nice Screenshots.
---| `ac.CSPModuleID.ParticlesFX` @Particles FX.
---| `ac.CSPModuleID.RainFX` @Rain FX.
---| `ac.CSPModuleID.ReflectionsFX` @Reflections FX.
---| `ac.CSPModuleID.ShadowedWheels` @Shadowed wheels.
---| `ac.CSPModuleID.SkidmarksFX` @Skidmarks FX.
---| `ac.CSPModuleID.SmallTweaks` @Small tweaks.
---| `ac.CSPModuleID.SmartMirror` @Smart Mirror.
---| `ac.CSPModuleID.SmartShadows` @Smart Shadows.
---| `ac.CSPModuleID.Spectating` @Spectating.
---| `ac.CSPModuleID.Splashscreen` @New loading screen.
---| `ac.CSPModuleID.SurfacesFX` @Surfaces FX.
---| `ac.CSPModuleID.Taskbar` @Taskbar.
---| `ac.CSPModuleID.TrackAdjustments` @Track adjustments.
---| `ac.CSPModuleID.TripleCustom` @Mode tweaks: Triple.
---| `ac.CSPModuleID.TyresFX` @Tyres FX.
---| `ac.CSPModuleID.VRTweaks` @Mode tweaks: VR.
---| `ac.CSPModuleID.WalkingOut` @Walking_out.
---| `ac.CSPModuleID.WeatherFX` @Weather FX.
---| `ac.CSPModuleID.WindscreenFX` @Windscreen FX.
---| `ac.CSPModuleID.Yebisest` @Yebisest.
ac.CSPModuleID = {
  BrakeDiscFX = 'brakedisc_fx', ---@type ac.CSPModuleID #Brake Disc FX.
  CarInstruments = 'car_instruments', ---@type ac.CSPModuleID #Car instruments.
  ChaserCamera = 'chaser_camera', ---@type ac.CSPModuleID #Chaser Camera.
  ChatShortcuts = 'chat_shortcuts', ---@type ac.CSPModuleID #Chat shortcuts.
  ColorfulShadowing = 'colorful_shadowing', ---@type ac.CSPModuleID #Colorful shadowing.
  CustomRenderingModes = 'custom_rendering_modes', ---@type ac.CSPModuleID #Mode tweaks: custom render modes.
  DXGITweaks = 'dxgi_tweaks', ---@type ac.CSPModuleID #DXGI.
  ExtraFX = 'extra_fx', ---@type ac.CSPModuleID #Extra FX.
  FakeShadowsFX = 'fake_shadows_fx', ---@type ac.CSPModuleID #Fake Shadows FX.
  FFBTweaks = 'ffb_tweaks', ---@type ac.CSPModuleID #FFB Tweaks.
  FreerCamera = 'freer_camera', ---@type ac.CSPModuleID #Freer Camera.
  G27Lights = 'g27_lights', ---@type ac.CSPModuleID #Logitech G27/29.
  GamepadFX = 'gamepad_fx', ---@type ac.CSPModuleID #Gamepad FX.
  General = 'general', ---@type ac.CSPModuleID #General Patch settings.
  GraphicsAdjustments = 'graphics_adjustments', ---@type ac.CSPModuleID #Graphics adjustments.
  GrassFX = 'grass_fx', ---@type ac.CSPModuleID #Grass FX.
  GUI = 'gui', ---@type ac.CSPModuleID #GUI.
  LightingFX = 'lighting_fx', ---@type ac.CSPModuleID #Lighting FX.
  LuaTools = 'lua_tools', ---@type ac.CSPModuleID #Lua_tools.
  MumblePlugin = 'mumble_plugin', ---@type ac.CSPModuleID #Mumble_plugin.
  Music = 'music', ---@type ac.CSPModuleID #Music.
  NeckFX = 'neck', ---@type ac.CSPModuleID #Neck FX.
  NewBehaviour = 'new_behaviour', ---@type ac.CSPModuleID #New AI behavior.
  NiceScreenshots = 'nice_screenshots', ---@type ac.CSPModuleID #Nice Screenshots.
  ParticlesFX = 'particles_fx', ---@type ac.CSPModuleID #Particles FX.
  RainFX = 'rain_fx', ---@type ac.CSPModuleID #Rain FX.
  ReflectionsFX = 'reflections_fx', ---@type ac.CSPModuleID #Reflections FX.
  ShadowedWheels = 'shadowed_wheels', ---@type ac.CSPModuleID #Shadowed wheels.
  SkidmarksFX = 'skidmarks_fx', ---@type ac.CSPModuleID #Skidmarks FX.
  SmallTweaks = 'small_tweaks', ---@type ac.CSPModuleID #Small tweaks.
  SmartMirror = 'smart_mirror', ---@type ac.CSPModuleID #Smart Mirror.
  SmartShadows = 'smart_shadows', ---@type ac.CSPModuleID #Smart Shadows.
  Spectating = 'spectating', ---@type ac.CSPModuleID #Spectating.
  Splashscreen = 'splashscreen', ---@type ac.CSPModuleID #New loading screen.
  SurfacesFX = 'surfaces_fx', ---@type ac.CSPModuleID #Surfaces FX.
  Taskbar = 'taskbar', ---@type ac.CSPModuleID #Taskbar.
  TrackAdjustments = 'track_adjustments', ---@type ac.CSPModuleID #Track adjustments.
  TripleCustom = 'triple_custom', ---@type ac.CSPModuleID #Mode tweaks: Triple.
  TyresFX = 'tyres_fx', ---@type ac.CSPModuleID #Tyres FX.
  VRTweaks = 'vr_tweaks', ---@type ac.CSPModuleID #Mode tweaks: VR.
  WalkingOut = 'walking_out', ---@type ac.CSPModuleID #Walking_out.
  WeatherFX = 'weather_fx', ---@type ac.CSPModuleID #Weather FX.
  WindscreenFX = 'windscreen_fx', ---@type ac.CSPModuleID #Windscreen FX.
  Yebisest = 'yebisest', ---@type ac.CSPModuleID #Yebisest.
}

---@alias ac.ObjectClass
---| `ac.ObjectClass.Any` @Return any scene object. If returned as result from `:class()`, means that there is no object with such index.
---| `ac.ObjectClass.Node` @Regular children-holding objects.
---| `ac.ObjectClass.Model` @Track objects.
---| `ac.ObjectClass.CarNodeSorter` @An object holding cars.
---| `ac.ObjectClass.NodeBoundingSphere` @A wrapper for each car, skipping rendering if whole thing is not in frustum.
---| `ac.ObjectClass.IdealLine` @Ideal line.
---| `ac.ObjectClass.ParticleSystem` @Particle systems (don’t do much with ParticlesFX active).
---| `ac.ObjectClass.StaticParticleSystem` @Usually used for spectators.
---| `ac.ObjectClass.DisplayNode` @Display nodes for car dashboards.
---| `ac.ObjectClass.TextNode` @3D text nodes for car dashboards.
---| `ac.ObjectClass.CSPNode` @CSP nodes, for example fake shadow nodes.
---| `ac.ObjectClass.Renderable` @Refers to meshes and skinned meshes together.
---| `ac.ObjectClass.Mesh` @Regular meshes.
---| `ac.ObjectClass.SkinnedMesh` @Skinned meshes.
---| `ac.ObjectClass.SkidmarkBuffer` @Objects with skidmarks (don’t do much with SkidmarksFX active).
ac.ObjectClass = {
  Any = 0, ---@type ac.ObjectClass #Return any scene object. If returned as result from `:class()`, means that there is no object with such index.
  Node = 1, ---@type ac.ObjectClass #Regular children-holding objects.
  Model = 2, ---@type ac.ObjectClass #Track objects.
  CarNodeSorter = 3, ---@type ac.ObjectClass #An object holding cars.
  NodeBoundingSphere = 4, ---@type ac.ObjectClass #A wrapper for each car, skipping rendering if whole thing is not in frustum.
  IdealLine = 7, ---@type ac.ObjectClass #Ideal line.
  ParticleSystem = 8, ---@type ac.ObjectClass #Particle systems (don’t do much with ParticlesFX active).
  StaticParticleSystem = 9, ---@type ac.ObjectClass #Usually used for spectators.
  DisplayNode = 10, ---@type ac.ObjectClass #Display nodes for car dashboards.
  TextNode = 11, ---@type ac.ObjectClass #3D text nodes for car dashboards.
  CSPNode = 12, ---@type ac.ObjectClass #CSP nodes, for example fake shadow nodes.
  Renderable = 13, ---@type ac.ObjectClass #Refers to meshes and skinned meshes together.
  Mesh = 15, ---@type ac.ObjectClass #Regular meshes.
  SkinnedMesh = 16, ---@type ac.ObjectClass #Skinned meshes.
  SkidmarkBuffer = 17, ---@type ac.ObjectClass #Objects with skidmarks (don’t do much with SkidmarksFX active).
}

---@alias ac.GamepadButton
---| `ac.GamepadButton.DPadUp` @Value: 0x1.
---| `ac.GamepadButton.DPadDown` @Value: 0x2.
---| `ac.GamepadButton.DPadLeft` @Value: 0x4.
---| `ac.GamepadButton.DPadRight` @Value: 0x8.
---| `ac.GamepadButton.Start` @Value: 0x10.
---| `ac.GamepadButton.Back` @Value: 0x20.
---| `ac.GamepadButton.LeftThumb` @Value: 0x40.
---| `ac.GamepadButton.RightThumb` @Value: 0x80.
---| `ac.GamepadButton.LeftShoulder` @Value: 0x100.
---| `ac.GamepadButton.RightShoulder` @Value: 0x200.
---| `ac.GamepadButton.L2` @Only for DualShock and Nintendo (ZL) gamepads.
---| `ac.GamepadButton.R2` @Only for DualShock and Nintendo (ZR) gamepads.
---| `ac.GamepadButton.A` @Value: 0x1000.
---| `ac.GamepadButton.B` @Value: 0x2000.
---| `ac.GamepadButton.X` @Value: 0x4000.
---| `ac.GamepadButton.Y` @Value: 0x8000.
---| `ac.GamepadButton.PlayStation` @Only for DualShock, DualSense and Nintendo (Home button) gamepads.
---| `ac.GamepadButton.Microphone` @Only for DualSense and Nintendo (SL button) gamepads.
---| `ac.GamepadButton.Pad` @Only for DualShock, DualSense and Nintendo (Capture button) gamepads.
---| `ac.GamepadButton.Extra` @Only for Nintendo (SR button) gamepads.
ac.GamepadButton = {
  DPadUp = 0x1, ---@type ac.GamepadButton #Value: 0x1.
  DPadDown = 0x2, ---@type ac.GamepadButton #Value: 0x2.
  DPadLeft = 0x4, ---@type ac.GamepadButton #Value: 0x4.
  DPadRight = 0x8, ---@type ac.GamepadButton #Value: 0x8.
  Start = 0x10, ---@type ac.GamepadButton #Value: 0x10.
  Back = 0x20, ---@type ac.GamepadButton #Value: 0x20.
  LeftThumb = 0x40, ---@type ac.GamepadButton #Value: 0x40.
  RightThumb = 0x80, ---@type ac.GamepadButton #Value: 0x80.
  LeftShoulder = 0x100, ---@type ac.GamepadButton #Value: 0x100.
  RightShoulder = 0x200, ---@type ac.GamepadButton #Value: 0x200.
  L2 = 0x400, ---@type ac.GamepadButton #Only for DualShock and Nintendo (ZL) gamepads.
  R2 = 0x800, ---@type ac.GamepadButton #Only for DualShock and Nintendo (ZR) gamepads.
  A = 0x1000, ---@type ac.GamepadButton #Value: 0x1000.
  B = 0x2000, ---@type ac.GamepadButton #Value: 0x2000.
  X = 0x4000, ---@type ac.GamepadButton #Value: 0x4000.
  Y = 0x8000, ---@type ac.GamepadButton #Value: 0x8000.
  PlayStation = 0x10000, ---@type ac.GamepadButton #Only for DualShock, DualSense and Nintendo (Home button) gamepads.
  Microphone = 0x20000, ---@type ac.GamepadButton #Only for DualSense and Nintendo (SL button) gamepads.
  Pad = 0x40000, ---@type ac.GamepadButton #Only for DualShock, DualSense and Nintendo (Capture button) gamepads.
  Extra = 0x80000, ---@type ac.GamepadButton #Only for Nintendo (SR button) gamepads.
}

---@alias ac.GamepadAxis
---| `ac.GamepadAxis.LeftTrigger` @Value: 0.
---| `ac.GamepadAxis.RightTrigger` @Value: 1.
---| `ac.GamepadAxis.LeftThumbX` @Value: 2.
---| `ac.GamepadAxis.LeftThumbY` @Value: 3.
---| `ac.GamepadAxis.RightThumbX` @Value: 4.
---| `ac.GamepadAxis.RightThumbY` @Value: 5.
ac.GamepadAxis = {
  LeftTrigger = 0, ---@type ac.GamepadAxis #Value: 0.
  RightTrigger = 1, ---@type ac.GamepadAxis #Value: 1.
  LeftThumbX = 2, ---@type ac.GamepadAxis #Value: 2.
  LeftThumbY = 3, ---@type ac.GamepadAxis #Value: 3.
  RightThumbX = 4, ---@type ac.GamepadAxis #Value: 4.
  RightThumbY = 5, ---@type ac.GamepadAxis #Value: 5.
}

---@alias ac.GamepadType
---| `ac.GamepadType.None` @No gamepad in that slot.
---| `ac.GamepadType.XBox` @Regular XBox gamepad.
---| `ac.GamepadType.DualSense` @DualSense gamepad.
---| `ac.GamepadType.DualShock` @DualShock gamepad (can also be one of Nintendo gamepads; use `ac.getDualShock(…).type` to check).
ac.GamepadType = {
  None = 0, ---@type ac.GamepadType #No gamepad in that slot.
  XBox = 1, ---@type ac.GamepadType #Regular XBox gamepad.
  DualSense = 2, ---@type ac.GamepadType #DualSense gamepad.
  DualShock = 3, ---@type ac.GamepadType #DualShock gamepad (can also be one of Nintendo gamepads; use `ac.getDualShock(…).type` to check).
}

---Due to compatibility issues DualShock and Nintendo devices are combined in an alternative API area separately from DualSense.
---@alias ac.GamepadDualShockType
---| `ac.GamepadDualShockType.JoyConLeft` @Left Joy-Con.
---| `ac.GamepadDualShockType.JoyConRight` @Right Joy-Con.
---| `ac.GamepadDualShockType.SwitchPro` @Switch Pro Controller.
---| `ac.GamepadDualShockType.DualShock` @DualShock 4.
---| `ac.GamepadDualShockType.DualSense` @DualSense (can appear here if controller is configured to launch in DualShock mode in CM controls settings).
ac.GamepadDualShockType = {
  JoyConLeft = 1, ---@type ac.GamepadDualShockType #Left Joy-Con.
  JoyConRight = 2, ---@type ac.GamepadDualShockType #Right Joy-Con.
  SwitchPro = 3, ---@type ac.GamepadDualShockType #Switch Pro Controller.
  DualShock = 4, ---@type ac.GamepadDualShockType #DualShock 4.
  DualSense = 5, ---@type ac.GamepadDualShockType #DualSense (can appear here if controller is configured to launch in DualShock mode in CM controls settings).
}

---@alias os.DialogFlags
---| `os.DialogFlags.None` @Value: 0.
---| `os.DialogFlags.OverwritePrompt` @When saving a file, prompt before overwriting an existing file of the same name. This is a default value for the Save dialog.
---| `os.DialogFlags.StrictFileTypes` @In the Save dialog, only allow the user to choose a file that has one of the file name extensions specified through IFileDialog::SetFileTypes.
---| `os.DialogFlags.NoChangeDir` @Don't change the current working directory.
---| `os.DialogFlags.PickFolders` @Present an Open dialog that offers a choice of folders rather than files.
---| `os.DialogFlags.ForceFileSystem` @Ensures that returned items are file system items (SFGAO_FILESYSTEM). Note that this does not apply to items returned by IFileDialog::GetCurrentSelection.
---| `os.DialogFlags.AllNonStorageItems` @Enables the user to choose any item in the Shell namespace, not just those with SFGAO_STREAM or SFAGO_FILESYSTEM attributes. This flag cannot be combined with FOS_FORCEFILESYSTEM.
---| `os.DialogFlags.NoValidate` @Do not check for situations that would prevent an application from opening the selected file, such as sharing violations or access denied errors.
---| `os.DialogFlags.AllowMultiselect` @Enables the user to select multiple items in the open dialog. Note that when this flag is set, the IFileOpenDialog interface must be used to retrieve those items.
---| `os.DialogFlags.PathMustExist` @The item returned must be in an existing folder. This is a default value.
---| `os.DialogFlags.FileMustExist` @The item returned must exist. This is a default value for the Open dialog.
---| `os.DialogFlags.CreatePrompt` @Prompt for creation if the item returned in the save dialog does not exist. Note that this does not actually create the item.
---| `os.DialogFlags.ShareAware` @In the case of a sharing violation when an application is opening a file, call the application back through OnShareViolation for guidance. This flag is overridden by FOS_NOVALIDATE.
---| `os.DialogFlags.NoReadonlyReturn` @Do not return read-only items. This is a default value for the Save dialog.
---| `os.DialogFlags.NoTestFileCreate` @Do not test whether creation of the item as specified in the Save dialog will be successful. If this flag is not set, the calling application must handle errors, such as denial of access, discovered when the item is created.
---| `os.DialogFlags.HideMRUPlaces` @Hide the list of places from which the user has recently opened or saved items. This value is not supported as of Windows 7.
---| `os.DialogFlags.HidePinnedPlaces` @Hide items shown by default in the view's navigation pane. This flag is often used in conjunction with the IFileDialog::AddPlace method, to hide standard locations and replace them with custom locations.\n\nWindows 7 and later. Hide all of the standard namespace locations (such as Favorites, Libraries, Computer, and Network) shown in the navigation pane.\n\nWindows Vista. Hide the contents of the Favorite Links tree in the navigation pane. Note that the category itself is still displayed, but shown as empty.
---| `os.DialogFlags.NoDereferenceLinks` @Shortcuts should not be treated as their target items. This allows an application to open a .lnk file rather than what that file is a shortcut to.
---| `os.DialogFlags.OkButtonNeedsInteraction` @The OK button will be disabled until the user navigates the view or edits the filename (if applicable). Note: Disabling of the OK button does not prevent the dialog from being submitted by the Enter key.
---| `os.DialogFlags.DontAddToRecent` @Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
---| `os.DialogFlags.ForceShowHidden` @Include hidden and system items.
---| `os.DialogFlags.DefaultNoMiniMode` @Indicates to the Save As dialog box that it should open in expanded mode. Expanded mode is the mode that is set and unset by clicking the button in the lower-left corner of the Save As dialog box that switches between Browse Folders and Hide Folders when clicked. This value is not supported as of Windows 7.
---| `os.DialogFlags.ForcePreviewPaneOn` @Indicates to the Open dialog box that the preview pane should always be displayed.
---| `os.DialogFlags.SupportStreamableItems` @Indicates that the caller is opening a file as a stream (BHID_Stream), so there is no need to download that file.
os.DialogFlags = {
  None = 0, ---@type os.DialogFlags #Value: 0.
  OverwritePrompt = 2, ---@type os.DialogFlags #When saving a file, prompt before overwriting an existing file of the same name. This is a default value for the Save dialog.
  StrictFileTypes = 4, ---@type os.DialogFlags #In the Save dialog, only allow the user to choose a file that has one of the file name extensions specified through IFileDialog::SetFileTypes.
  NoChangeDir = 8, ---@type os.DialogFlags #Don't change the current working directory.
  PickFolders = 32, ---@type os.DialogFlags #Present an Open dialog that offers a choice of folders rather than files.
  ForceFileSystem = 64, ---@type os.DialogFlags #Ensures that returned items are file system items (SFGAO_FILESYSTEM). Note that this does not apply to items returned by IFileDialog::GetCurrentSelection.
  AllNonStorageItems = 128, ---@type os.DialogFlags #Enables the user to choose any item in the Shell namespace, not just those with SFGAO_STREAM or SFAGO_FILESYSTEM attributes. This flag cannot be combined with FOS_FORCEFILESYSTEM.
  NoValidate = 256, ---@type os.DialogFlags #Do not check for situations that would prevent an application from opening the selected file, such as sharing violations or access denied errors.
  AllowMultiselect = 512, ---@type os.DialogFlags #Enables the user to select multiple items in the open dialog. Note that when this flag is set, the IFileOpenDialog interface must be used to retrieve those items.
  PathMustExist = 2048, ---@type os.DialogFlags #The item returned must be in an existing folder. This is a default value.
  FileMustExist = 4096, ---@type os.DialogFlags #The item returned must exist. This is a default value for the Open dialog.
  CreatePrompt = 8192, ---@type os.DialogFlags #Prompt for creation if the item returned in the save dialog does not exist. Note that this does not actually create the item.
  ShareAware = 16384, ---@type os.DialogFlags #In the case of a sharing violation when an application is opening a file, call the application back through OnShareViolation for guidance. This flag is overridden by FOS_NOVALIDATE.
  NoReadonlyReturn = 32768, ---@type os.DialogFlags #Do not return read-only items. This is a default value for the Save dialog.
  NoTestFileCreate = 65536, ---@type os.DialogFlags #Do not test whether creation of the item as specified in the Save dialog will be successful. If this flag is not set, the calling application must handle errors, such as denial of access, discovered when the item is created.
  HideMRUPlaces = 131072, ---@type os.DialogFlags #Hide the list of places from which the user has recently opened or saved items. This value is not supported as of Windows 7.
  HidePinnedPlaces = 262144, ---@type os.DialogFlags #Hide items shown by default in the view's navigation pane. This flag is often used in conjunction with the IFileDialog::AddPlace method, to hide standard locations and replace them with custom locations.\n\nWindows 7 and later. Hide all of the standard namespace locations (such as Favorites, Libraries, Computer, and Network) shown in the navigation pane.\n\nWindows Vista. Hide the contents of the Favorite Links tree in the navigation pane. Note that the category itself is still displayed, but shown as empty.
  NoDereferenceLinks = 1048576, ---@type os.DialogFlags #Shortcuts should not be treated as their target items. This allows an application to open a .lnk file rather than what that file is a shortcut to.
  OkButtonNeedsInteraction = 2097152, ---@type os.DialogFlags #The OK button will be disabled until the user navigates the view or edits the filename (if applicable). Note: Disabling of the OK button does not prevent the dialog from being submitted by the Enter key.
  DontAddToRecent = 33554432, ---@type os.DialogFlags #Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
  ForceShowHidden = 268435456, ---@type os.DialogFlags #Include hidden and system items.
  DefaultNoMiniMode = 536870912, ---@type os.DialogFlags #Indicates to the Save As dialog box that it should open in expanded mode. Expanded mode is the mode that is set and unset by clicking the button in the lower-left corner of the Save As dialog box that switches between Browse Folders and Hide Folders when clicked. This value is not supported as of Windows 7.
  ForcePreviewPaneOn = 1073741824, ---@type os.DialogFlags #Indicates to the Open dialog box that the preview pane should always be displayed.
  SupportStreamableItems = 2147483648, ---@type os.DialogFlags #Indicates that the caller is opening a file as a stream (BHID_Stream), so there is no need to download that file.
}

---@alias ac.TurningLights
---| `ac.TurningLights.None` @Value: 0.
---| `ac.TurningLights.Left` @Value: 1.
---| `ac.TurningLights.Right` @Value: 2.
---| `ac.TurningLights.Hazards` @Value: 3.
ac.TurningLights = {
  None = 0, ---@type ac.TurningLights #Value: 0.
  Left = 1, ---@type ac.TurningLights #Value: 1.
  Right = 2, ---@type ac.TurningLights #Value: 2.
  Hazards = 3, ---@type ac.TurningLights #Value: 3.
}

---@alias ac.CarAudioEventID
---| `ac.CarAudioEventID.EngineExt` @Value: 0.
---| `ac.CarAudioEventID.EngineInt` @Value: 1.
---| `ac.CarAudioEventID.GearExt` @Value: 2.
---| `ac.CarAudioEventID.GearInt` @Value: 3.
---| `ac.CarAudioEventID.Bodywork` @Value: 4.
---| `ac.CarAudioEventID.Wind` @Value: 5.
---| `ac.CarAudioEventID.Dirt` @Value: 6.
---| `ac.CarAudioEventID.Downshift` @Value: 7.
---| `ac.CarAudioEventID.Horn` @Value: 8.
---| `ac.CarAudioEventID.GearGrind` @Value: 9.
---| `ac.CarAudioEventID.BackfireExt` @Value: 10.
---| `ac.CarAudioEventID.BackfireInt` @Value: 11.
---| `ac.CarAudioEventID.TractionControlExt` @Value: 12.
---| `ac.CarAudioEventID.TractionControlInt` @Value: 13.
---| `ac.CarAudioEventID.Transmission` @Value: 14.
---| `ac.CarAudioEventID.Limiter` @Value: 15.
---| `ac.CarAudioEventID.Turbo` @Value: 16.
---| `ac.CarAudioEventID.WheelLF` @Add 0-based index to this value for Nth wheel.
---| `ac.CarAudioEventID.WheelRF` @Value: 21.
---| `ac.CarAudioEventID.WheelLR` @Value: 22.
---| `ac.CarAudioEventID.WheelRR` @Value: 23.
---| `ac.CarAudioEventID.SkidIntLF` @Add 0-based index to this value for Nth wheel.
---| `ac.CarAudioEventID.SkidIntRF` @Value: 31.
---| `ac.CarAudioEventID.SkidIntLR` @Value: 32.
---| `ac.CarAudioEventID.SkidIntRR` @Value: 33.
---| `ac.CarAudioEventID.SkidExtLF` @Add 0-based index to this value for Nth wheel.
---| `ac.CarAudioEventID.SkidExtRF` @Value: 41.
---| `ac.CarAudioEventID.SkidExtLR` @Value: 42.
---| `ac.CarAudioEventID.SkidExtRR` @Value: 43.
ac.CarAudioEventID = {
  EngineExt = 0, ---@type ac.CarAudioEventID #Value: 0.
  EngineInt = 1, ---@type ac.CarAudioEventID #Value: 1.
  GearExt = 2, ---@type ac.CarAudioEventID #Value: 2.
  GearInt = 3, ---@type ac.CarAudioEventID #Value: 3.
  Bodywork = 4, ---@type ac.CarAudioEventID #Value: 4.
  Wind = 5, ---@type ac.CarAudioEventID #Value: 5.
  Dirt = 6, ---@type ac.CarAudioEventID #Value: 6.
  Downshift = 7, ---@type ac.CarAudioEventID #Value: 7.
  Horn = 8, ---@type ac.CarAudioEventID #Value: 8.
  GearGrind = 9, ---@type ac.CarAudioEventID #Value: 9.
  BackfireExt = 10, ---@type ac.CarAudioEventID #Value: 10.
  BackfireInt = 11, ---@type ac.CarAudioEventID #Value: 11.
  TractionControlExt = 12, ---@type ac.CarAudioEventID #Value: 12.
  TractionControlInt = 13, ---@type ac.CarAudioEventID #Value: 13.
  Transmission = 14, ---@type ac.CarAudioEventID #Value: 14.
  Limiter = 15, ---@type ac.CarAudioEventID #Value: 15.
  Turbo = 16, ---@type ac.CarAudioEventID #Value: 16.
  WheelLF = 20, ---@type ac.CarAudioEventID #Add 0-based index to this value for Nth wheel.
  WheelRF = 21, ---@type ac.CarAudioEventID #Value: 21.
  WheelLR = 22, ---@type ac.CarAudioEventID #Value: 22.
  WheelRR = 23, ---@type ac.CarAudioEventID #Value: 23.
  SkidIntLF = 30, ---@type ac.CarAudioEventID #Add 0-based index to this value for Nth wheel.
  SkidIntRF = 31, ---@type ac.CarAudioEventID #Value: 31.
  SkidIntLR = 32, ---@type ac.CarAudioEventID #Value: 32.
  SkidIntRR = 33, ---@type ac.CarAudioEventID #Value: 33.
  SkidExtLF = 40, ---@type ac.CarAudioEventID #Add 0-based index to this value for Nth wheel.
  SkidExtRF = 41, ---@type ac.CarAudioEventID #Value: 41.
  SkidExtLR = 42, ---@type ac.CarAudioEventID #Value: 42.
  SkidExtRR = 43, ---@type ac.CarAudioEventID #Value: 43.
}

---Flags specifying when to start calling the `update()` next time. Different conditions be combined with `bit.bor()`.---If your script only needs to, for example, reset a certain thing when car resets, don’t forget to call---`ac.pauseScriptUntil()` again once you’re done.------Other functions (such as `script.reset()` for car physics script), callbacks, timers or event listeners will still be---called. You can cancel out pause by calling `ac.pauseScriptUntil(ac.ScriptResumeCondition.NoPause)` from there.------Currently only available to car scripts, both display/extension and physics (since the major performance issue with Lua---is mostly when there are dozens or hundreds of cars all running even some lightweight Lua scripts, which is admittedly---a rare case).
---@alias ac.ScriptResumeCondition
---| `ac.ScriptResumeCondition.Resume` @Disable pause, keep calling `update()` as usual.
---| `ac.ScriptResumeCondition.None` @Do not resume script ever.
---| `ac.ScriptResumeCondition.Pitlane` @Resume script once car arrives in pitlane.
---| `ac.ScriptResumeCondition.Pits` @Resume script when car gets in pits.
---| `ac.ScriptResumeCondition.Reset` @Pause until car resets.
---| `ac.ScriptResumeCondition.Extra` @Pause until extra switch is used.
---| `ac.ScriptResumeCondition.MeshInteraction` @Pause until there is a change mesh could have been touched.
---| `ac.ScriptResumeCondition.Collision` @Pause until car had a contact with something (added in CSP 0.2.8, won’t work for remote cars for now).
ac.ScriptResumeCondition = {
  Resume = -1, ---@type ac.ScriptResumeCondition #Disable pause, keep calling `update()` as usual.
  None = 0x0, ---@type ac.ScriptResumeCondition #Do not resume script ever.
  Pitlane = 0x1, ---@type ac.ScriptResumeCondition #Resume script once car arrives in pitlane.
  Pits = 0x2, ---@type ac.ScriptResumeCondition #Resume script when car gets in pits.
  Reset = 0x4, ---@type ac.ScriptResumeCondition #Pause until car resets.
  Extra = 0x8, ---@type ac.ScriptResumeCondition #Pause until extra switch is used.
  MeshInteraction = 0x10, ---@type ac.ScriptResumeCondition #Pause until there is a change mesh could have been touched.
  Collision = 0x20, ---@type ac.ScriptResumeCondition #Pause until car had a contact with something (added in CSP 0.2.8, won’t work for remote cars for now).
}

---Key indices, pretty much mirrors all those “VK_…” key tables.
---@alias ui.KeyIndex
---| `ui.KeyIndex.LeftButton` @Value: 1.
---| `ui.KeyIndex.RightButton` @Value: 2.
---| `ui.KeyIndex.MiddleButton` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.XButton1` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.XButton2` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.Tab` @Value: 9.
---| `ui.KeyIndex.Return` @Value: 13.
---| `ui.KeyIndex.Shift` @Value: 16.
---| `ui.KeyIndex.Control` @Value: 17.
---| `ui.KeyIndex.Menu` @Aka Alt button.
---| `ui.KeyIndex.Escape` @Value: 27.
---| `ui.KeyIndex.Accept` @Value: 30.
---| `ui.KeyIndex.Space` @Value: 32.
---| `ui.KeyIndex.End` @Value: 35.
---| `ui.KeyIndex.Home` @Value: 36.
---| `ui.KeyIndex.Left` @Arrow ←.
---| `ui.KeyIndex.Up` @Arrow ↑.
---| `ui.KeyIndex.Right` @Arrow →.
---| `ui.KeyIndex.Down` @Arrow ↓.
---| `ui.KeyIndex.Insert` @Value: 45.
---| `ui.KeyIndex.Delete` @Value: 46.
---| `ui.KeyIndex.LeftWin` @Value: 91.
---| `ui.KeyIndex.RightWin` @Value: 92.
---| `ui.KeyIndex.NumPad0` @Value: 96.
---| `ui.KeyIndex.NumPad1` @Value: 97.
---| `ui.KeyIndex.NumPad2` @Value: 98.
---| `ui.KeyIndex.NumPad3` @Value: 99.
---| `ui.KeyIndex.NumPad4` @Value: 100.
---| `ui.KeyIndex.NumPad5` @Value: 101.
---| `ui.KeyIndex.NumPad6` @Value: 102.
---| `ui.KeyIndex.NumPad7` @Value: 103.
---| `ui.KeyIndex.NumPad8` @Value: 104.
---| `ui.KeyIndex.NumPad9` @Value: 105.
---| `ui.KeyIndex.Multiply` @Value: 106.
---| `ui.KeyIndex.Add` @Value: 107.
---| `ui.KeyIndex.Separator` @Value: 108.
---| `ui.KeyIndex.Subtract` @Value: 109.
---| `ui.KeyIndex.Decimal` @Value: 110.
---| `ui.KeyIndex.Divide` @Value: 111.
---| `ui.KeyIndex.F1` @Value: 112.
---| `ui.KeyIndex.F2` @Value: 113.
---| `ui.KeyIndex.F3` @Value: 114.
---| `ui.KeyIndex.F4` @Value: 115.
---| `ui.KeyIndex.F5` @Value: 116.
---| `ui.KeyIndex.F6` @Value: 117.
---| `ui.KeyIndex.F7` @Value: 118.
---| `ui.KeyIndex.F8` @Value: 119.
---| `ui.KeyIndex.F9` @Value: 120.
---| `ui.KeyIndex.F10` @Value: 121.
---| `ui.KeyIndex.F11` @Value: 122.
---| `ui.KeyIndex.F12` @Value: 123.
---| `ui.KeyIndex.NumLock` @Value: 144.
---| `ui.KeyIndex.Scroll` @Value: 145.
---| `ui.KeyIndex.OemNecEqual` @“.
---| `ui.KeyIndex.LeftShift` @Value: 160.
---| `ui.KeyIndex.RightShift` @Value: 161.
---| `ui.KeyIndex.LeftControl` @Value: 162.
---| `ui.KeyIndex.RightControl` @Value: 163.
---| `ui.KeyIndex.LeftMenu` @Aka left Alt button.
---| `ui.KeyIndex.RightMenu` @Aka right Alt button.
---| `ui.KeyIndex.Oem1` @“;:” for US.
---| `ui.KeyIndex.SquareOpenBracket` @Value: 219.
---| `ui.KeyIndex.SquareCloseBracket` @Value: 221.
---| `ui.KeyIndex.D0` @Digit 0.
---| `ui.KeyIndex.D1` @Digit 1.
---| `ui.KeyIndex.D2` @Digit 2.
---| `ui.KeyIndex.D3` @Digit 3.
---| `ui.KeyIndex.D4` @Digit 4.
---| `ui.KeyIndex.D5` @Digit 5.
---| `ui.KeyIndex.D6` @Digit 6.
---| `ui.KeyIndex.D7` @Digit 7.
---| `ui.KeyIndex.D8` @Digit 8.
---| `ui.KeyIndex.D9` @Digit 9.
---| `ui.KeyIndex.A` @Letter A.
---| `ui.KeyIndex.B` @Letter B.
---| `ui.KeyIndex.C` @Letter C.
---| `ui.KeyIndex.D` @Letter D.
---| `ui.KeyIndex.E` @Letter E.
---| `ui.KeyIndex.F` @Letter F.
---| `ui.KeyIndex.G` @Letter G.
---| `ui.KeyIndex.H` @Letter H.
---| `ui.KeyIndex.I` @Letter I.
---| `ui.KeyIndex.J` @Letter J.
---| `ui.KeyIndex.K` @Letter K.
---| `ui.KeyIndex.L` @Letter L.
---| `ui.KeyIndex.M` @Letter M.
---| `ui.KeyIndex.N` @Letter N.
---| `ui.KeyIndex.O` @Letter O.
---| `ui.KeyIndex.P` @Letter P.
---| `ui.KeyIndex.Q` @Letter Q.
---| `ui.KeyIndex.R` @Letter R.
---| `ui.KeyIndex.S` @Letter S.
---| `ui.KeyIndex.T` @Letter T.
---| `ui.KeyIndex.U` @Letter U.
---| `ui.KeyIndex.V` @Letter V.
---| `ui.KeyIndex.W` @Letter W.
---| `ui.KeyIndex.X` @Letter X.
---| `ui.KeyIndex.Y` @Letter Y.
---| `ui.KeyIndex.Z` @Letter Z.
ui.KeyIndex = {
  LeftButton = 1, ---@type ui.KeyIndex #Value: 1.
  RightButton = 2, ---@type ui.KeyIndex #Value: 2.
  Cancel = 3, ---@type ui.KeyIndex #Value: 3.
  MiddleButton = 4, ---@type ui.KeyIndex #Not contiguous with LeftButton and RightButton.
  XButton1 = 5, ---@type ui.KeyIndex #Not contiguous with LeftButton and RightButton.
  XButton2 = 6, ---@type ui.KeyIndex #Not contiguous with LeftButton and RightButton.
  Back = 8, ---@type ui.KeyIndex #Value: 8.
  Tab = 9, ---@type ui.KeyIndex #Value: 9.
  Clear = 12, ---@type ui.KeyIndex #Value: 12.
  Return = 13, ---@type ui.KeyIndex #Value: 13.
  Shift = 16, ---@type ui.KeyIndex #Value: 16.
  Control = 17, ---@type ui.KeyIndex #Value: 17.
  Menu = 18, ---@type ui.KeyIndex #Aka Alt button.
  Pause = 19, ---@type ui.KeyIndex #Value: 19.
  Capital = 20, ---@type ui.KeyIndex #Value: 20.
  Kana = 21, ---@type ui.KeyIndex #Value: 21.
  Hangeul = 21, ---@type ui.KeyIndex #Old name - should be here for compatibility.
  Hangul = 21, ---@type ui.KeyIndex #Value: 21.
  Junja = 23, ---@type ui.KeyIndex #Value: 23.
  Final = 24, ---@type ui.KeyIndex #Value: 24.
  Hanja = 25, ---@type ui.KeyIndex #Value: 25.
  Kanji = 25, ---@type ui.KeyIndex #Value: 25.
  Escape = 27, ---@type ui.KeyIndex #Value: 27.
  Convert = 28, ---@type ui.KeyIndex #Value: 28.
  NonConvert = 29, ---@type ui.KeyIndex #Value: 29.
  Accept = 30, ---@type ui.KeyIndex #Value: 30.
  ModeChange = 31, ---@type ui.KeyIndex #Value: 31.
  Space = 32, ---@type ui.KeyIndex #Value: 32.
  Prior = 33, ---@type ui.KeyIndex #Value: 33.
  Next = 34, ---@type ui.KeyIndex #Value: 34.
  End = 35, ---@type ui.KeyIndex #Value: 35.
  Home = 36, ---@type ui.KeyIndex #Value: 36.
  Left = 37, ---@type ui.KeyIndex #Arrow ←.
  Up = 38, ---@type ui.KeyIndex #Arrow ↑.
  Right = 39, ---@type ui.KeyIndex #Arrow →.
  Down = 40, ---@type ui.KeyIndex #Arrow ↓.
  Select = 41, ---@type ui.KeyIndex #Value: 41.
  Print = 42, ---@type ui.KeyIndex #Value: 42.
  Execute = 43, ---@type ui.KeyIndex #Value: 43.
  Snapshot = 44, ---@type ui.KeyIndex #Value: 44.
  Insert = 45, ---@type ui.KeyIndex #Value: 45.
  Delete = 46, ---@type ui.KeyIndex #Value: 46.
  Help = 47, ---@type ui.KeyIndex #Value: 47.
  LeftWin = 91, ---@type ui.KeyIndex #Value: 91.
  RightWin = 92, ---@type ui.KeyIndex #Value: 92.
  Apps = 93, ---@type ui.KeyIndex #Value: 93.
  Sleep = 95, ---@type ui.KeyIndex #Value: 95.
  NumPad0 = 96, ---@type ui.KeyIndex #Value: 96.
  NumPad1 = 97, ---@type ui.KeyIndex #Value: 97.
  NumPad2 = 98, ---@type ui.KeyIndex #Value: 98.
  NumPad3 = 99, ---@type ui.KeyIndex #Value: 99.
  NumPad4 = 100, ---@type ui.KeyIndex #Value: 100.
  NumPad5 = 101, ---@type ui.KeyIndex #Value: 101.
  NumPad6 = 102, ---@type ui.KeyIndex #Value: 102.
  NumPad7 = 103, ---@type ui.KeyIndex #Value: 103.
  NumPad8 = 104, ---@type ui.KeyIndex #Value: 104.
  NumPad9 = 105, ---@type ui.KeyIndex #Value: 105.
  Multiply = 106, ---@type ui.KeyIndex #Value: 106.
  Add = 107, ---@type ui.KeyIndex #Value: 107.
  Separator = 108, ---@type ui.KeyIndex #Value: 108.
  Subtract = 109, ---@type ui.KeyIndex #Value: 109.
  Decimal = 110, ---@type ui.KeyIndex #Value: 110.
  Divide = 111, ---@type ui.KeyIndex #Value: 111.
  F1 = 112, ---@type ui.KeyIndex #Value: 112.
  F2 = 113, ---@type ui.KeyIndex #Value: 113.
  F3 = 114, ---@type ui.KeyIndex #Value: 114.
  F4 = 115, ---@type ui.KeyIndex #Value: 115.
  F5 = 116, ---@type ui.KeyIndex #Value: 116.
  F6 = 117, ---@type ui.KeyIndex #Value: 117.
  F7 = 118, ---@type ui.KeyIndex #Value: 118.
  F8 = 119, ---@type ui.KeyIndex #Value: 119.
  F9 = 120, ---@type ui.KeyIndex #Value: 120.
  F10 = 121, ---@type ui.KeyIndex #Value: 121.
  F11 = 122, ---@type ui.KeyIndex #Value: 122.
  F12 = 123, ---@type ui.KeyIndex #Value: 123.
  F13 = 124, ---@type ui.KeyIndex #Value: 124.
  F14 = 125, ---@type ui.KeyIndex #Value: 125.
  F15 = 126, ---@type ui.KeyIndex #Value: 126.
  F16 = 127, ---@type ui.KeyIndex #Value: 127.
  F17 = 128, ---@type ui.KeyIndex #Value: 128.
  F18 = 129, ---@type ui.KeyIndex #Value: 129.
  F19 = 130, ---@type ui.KeyIndex #Value: 130.
  F20 = 131, ---@type ui.KeyIndex #Value: 131.
  F21 = 132, ---@type ui.KeyIndex #Value: 132.
  F22 = 133, ---@type ui.KeyIndex #Value: 133.
  F23 = 134, ---@type ui.KeyIndex #Value: 134.
  F24 = 135, ---@type ui.KeyIndex #Value: 135.
  NavigationView = 136, ---@type ui.KeyIndex #Reserved.
  NavigationMenu = 137, ---@type ui.KeyIndex #Reserved.
  NavigationUp = 138, ---@type ui.KeyIndex #Reserved.
  NavigationDown = 139, ---@type ui.KeyIndex #Reserved.
  NavigationLeft = 140, ---@type ui.KeyIndex #Reserved.
  NavigationRight = 141, ---@type ui.KeyIndex #Reserved.
  NavigationAccept = 142, ---@type ui.KeyIndex #Reserved.
  NavigationCancel = 143, ---@type ui.KeyIndex #Reserved.
  NumLock = 144, ---@type ui.KeyIndex #Value: 144.
  Scroll = 145, ---@type ui.KeyIndex #Value: 145.
  OemNecEqual = 146, ---@type ui.KeyIndex #“.
  OemFjJisho = 146, ---@type ui.KeyIndex #“Dictionary” key.
  OemFjMasshou = 147, ---@type ui.KeyIndex #“Unregister word” key.
  OemFjTouroku = 148, ---@type ui.KeyIndex #“Register word” key.
  OemFjLoya = 149, ---@type ui.KeyIndex #“Left OYAYUBI” key.
  OemFjRoya = 150, ---@type ui.KeyIndex #“Right OYAYUBI” key.
  LeftShift = 160, ---@type ui.KeyIndex #Value: 160.
  RightShift = 161, ---@type ui.KeyIndex #Value: 161.
  LeftControl = 162, ---@type ui.KeyIndex #Value: 162.
  RightControl = 163, ---@type ui.KeyIndex #Value: 163.
  LeftMenu = 164, ---@type ui.KeyIndex #Aka left Alt button.
  RightMenu = 165, ---@type ui.KeyIndex #Aka right Alt button.
  BrowserBack = 166, ---@type ui.KeyIndex #Value: 166.
  BrowserForward = 167, ---@type ui.KeyIndex #Value: 167.
  BrowserRefresh = 168, ---@type ui.KeyIndex #Value: 168.
  BrowserStop = 169, ---@type ui.KeyIndex #Value: 169.
  BrowserSearch = 170, ---@type ui.KeyIndex #Value: 170.
  BrowserFavorites = 171, ---@type ui.KeyIndex #Value: 171.
  BrowserHome = 172, ---@type ui.KeyIndex #Value: 172.
  VolumeMute = 173, ---@type ui.KeyIndex #Value: 173.
  VolumeDown = 174, ---@type ui.KeyIndex #Value: 174.
  VolumeUp = 175, ---@type ui.KeyIndex #Value: 175.
  MediaNextTrack = 176, ---@type ui.KeyIndex #Value: 176.
  MediaPrevTrack = 177, ---@type ui.KeyIndex #Value: 177.
  MediaStop = 178, ---@type ui.KeyIndex #Value: 178.
  MediaPlayPause = 179, ---@type ui.KeyIndex #Value: 179.
  LaunchMail = 180, ---@type ui.KeyIndex #Value: 180.
  LaunchMediaSelect = 181, ---@type ui.KeyIndex #Value: 181.
  LaunchApp1 = 182, ---@type ui.KeyIndex #Value: 182.
  LaunchApp2 = 183, ---@type ui.KeyIndex #Value: 183.
  Oem1 = 186, ---@type ui.KeyIndex #“;:” for US.
  OemPlus = 187, ---@type ui.KeyIndex #“+” any country.
  OemComma = 188, ---@type ui.KeyIndex #“,” any country.
  OemMinus = 189, ---@type ui.KeyIndex #“-” any country.
  OemPeriod = 190, ---@type ui.KeyIndex #“.” any country.
  Oem2 = 191, ---@type ui.KeyIndex #“/?” for US.
  Oem3 = 192, ---@type ui.KeyIndex #“`~” for US.
  GamepadA = 195, ---@type ui.KeyIndex #Reserved.
  GamepadB = 196, ---@type ui.KeyIndex #Reserved.
  GamepadX = 197, ---@type ui.KeyIndex #Reserved.
  GamepadY = 198, ---@type ui.KeyIndex #Reserved.
  GamepadRightShoulder = 199, ---@type ui.KeyIndex #Reserved.
  GamepadLeftShoulder = 200, ---@type ui.KeyIndex #Reserved.
  GamepadLeftTrigger = 201, ---@type ui.KeyIndex #Reserved.
  GamepadRightTrigger = 202, ---@type ui.KeyIndex #Reserved.
  GamepadDpadUp = 203, ---@type ui.KeyIndex #Reserved.
  GamepadDpadDown = 204, ---@type ui.KeyIndex #Reserved.
  GamepadDpadLeft = 205, ---@type ui.KeyIndex #Reserved.
  GamepadDpadRight = 206, ---@type ui.KeyIndex #Reserved.
  GamepadMenu = 207, ---@type ui.KeyIndex #Reserved.
  GamepadView = 208, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickButton = 209, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickButton = 210, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickUp = 211, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickDown = 212, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickRight = 213, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickLeft = 214, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickUp = 215, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickDown = 216, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickRight = 217, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickLeft = 218, ---@type ui.KeyIndex #Reserved.
  SquareOpenBracket = 219, ---@type ui.KeyIndex #Value: 219.
  SquareCloseBracket = 221, ---@type ui.KeyIndex #Value: 221.
  D0 = 48, ---@type ui.KeyIndex #Digit 0.
  D1 = 49, ---@type ui.KeyIndex #Digit 1.
  D2 = 50, ---@type ui.KeyIndex #Digit 2.
  D3 = 51, ---@type ui.KeyIndex #Digit 3.
  D4 = 52, ---@type ui.KeyIndex #Digit 4.
  D5 = 53, ---@type ui.KeyIndex #Digit 5.
  D6 = 54, ---@type ui.KeyIndex #Digit 6.
  D7 = 55, ---@type ui.KeyIndex #Digit 7.
  D8 = 56, ---@type ui.KeyIndex #Digit 8.
  D9 = 57, ---@type ui.KeyIndex #Digit 9.
  A = 65, ---@type ui.KeyIndex #Letter A.
  B = 66, ---@type ui.KeyIndex #Letter B.
  C = 67, ---@type ui.KeyIndex #Letter C.
  D = 68, ---@type ui.KeyIndex #Letter D.
  E = 69, ---@type ui.KeyIndex #Letter E.
  F = 70, ---@type ui.KeyIndex #Letter F.
  G = 71, ---@type ui.KeyIndex #Letter G.
  H = 72, ---@type ui.KeyIndex #Letter H.
  I = 73, ---@type ui.KeyIndex #Letter I.
  J = 74, ---@type ui.KeyIndex #Letter J.
  K = 75, ---@type ui.KeyIndex #Letter K.
  L = 76, ---@type ui.KeyIndex #Letter L.
  M = 77, ---@type ui.KeyIndex #Letter M.
  N = 78, ---@type ui.KeyIndex #Letter N.
  O = 79, ---@type ui.KeyIndex #Letter O.
  P = 80, ---@type ui.KeyIndex #Letter P.
  Q = 81, ---@type ui.KeyIndex #Letter Q.
  R = 82, ---@type ui.KeyIndex #Letter R.
  S = 83, ---@type ui.KeyIndex #Letter S.
  T = 84, ---@type ui.KeyIndex #Letter T.
  U = 85, ---@type ui.KeyIndex #Letter U.
  V = 86, ---@type ui.KeyIndex #Letter V.
  W = 87, ---@type ui.KeyIndex #Letter W.
  X = 88, ---@type ui.KeyIndex #Letter X.
  Y = 89, ---@type ui.KeyIndex #Letter Y.
  Z = 90, ---@type ui.KeyIndex #Letter Z.
}

---@alias ac.VAODebugMode
---| `ac.VAODebugMode.Active` @Value: 1.
---| `ac.VAODebugMode.Inactive` @Value: 3.
---| `ac.VAODebugMode.VAOOnly` @Value: 4.
---| `ac.VAODebugMode.ShowNormals` @Value: 5.
ac.VAODebugMode = {
  Active = 1, ---@type ac.VAODebugMode #Value: 1.
  Inactive = 3, ---@type ac.VAODebugMode #Value: 3.
  VAOOnly = 4, ---@type ac.VAODebugMode #Value: 4.
  ShowNormals = 5, ---@type ac.VAODebugMode #Value: 5.
}

--[[ common/common.lua ]]

---Path to a folder with currently running script.
---@type string
__dirname = nil

---A filename, either absolute or relative. If relative, will be resolved against AC root folder. Use `os.setCurrentFolder()` to change current folder.
---@alias path string

---Could be either a string, a number or a boolean value (will be converted into string).
---String can store any binary data including zero bytes. Could also be an FFI struct and it will
---be processed as its binary form.
---@alias binary string|number|boolean

---Could be either a string, a number, a boolean value or a table (without circular references or any non-serializable
---items). Will be serialized here and deserialized in a different script. String can store any binary data including zero bytes.
---@alias serializable string|number|boolean|table|nil

---Main CSP namespace.
ac = {}

---FFI-accelerated list, acts like a regular list (consequent items, size and capacity, automatically growing, etc.)
---Doesn’t store nil values to act more like a Lua table.
---
---Few notes:
---• Use `:get()` and `:set()` to access elements instead of square brakets;
---• Indices are 1-based;
---• For fastest access to individual elements use `.raw` field: it’s a raw pointer, so use 0-based indices there and
---make sure not to access things outside of list size.
---
---For slightly better performance it might be benefitial to preallocate memory with `list:reserve(expectedSizeOrABitMore)`.
---@class ac.GenericList
---@field raw any @Raw pointer for fastest unchecked access with 0-based indices. Use very carefully!
local _ac_genericList = {}

---Return an element at given index.
---@param index integer @1-based index.
---@return any
function _ac_genericList:get(index) end

---Sets an element at given index.
---@param index integer @1-based index.
---@param value any 
function _ac_genericList:set(index, value) end

---Number of items in the list.
---@return integer
function _ac_genericList:size() end

---Size of list in bytes (not capacity, for that use `list:capacityBytes()`).
---@return integer
function _ac_genericList:sizeBytes() end

---Checks if list is empty.
---@return boolean
function _ac_genericList:isEmpty() end

---Capacity of the list.
---@return integer
function _ac_genericList:capacity() end

---Size of list in bytes (capacity).
---@return integer
function _ac_genericList:capacityBytes() end

---Makes sure list can fit `newSize` of elements without reallocating memory.
---@param newSize integer
---@return integer
function _ac_genericList:reserve(newSize) end

---If capacity is greater than current size, reallocates a smaller bit of memory and moves data there.
function _ac_genericList:shrinkToFit() end

---Removes all elements.
function _ac_genericList:clear() end

---Creates a new list with the same contents as the existing one.
---@return ac.GenericList
function _ac_genericList:clone() end
---Custom FFI namespace. Be very careful around here.
---@class ffilibex
---@field C nil @Avoid using functions directly.
ffi = {}

---@param def     string
---@param params? any
function ffi.cdef(def, params, ...) end

---@param ct  ffi.ct*
---@param obj any
---@return boolean
---@nodiscard
function ffi.istype(ct, obj) end

---@param ptr  any
---@param len? integer
---@return string
function ffi.string(ptr, len) end

---@param ct      ffi.ct*
---@param params? any
---@return ffi.ctype*
---@nodiscard
function ffi.typeof(ct, params, ...) end

---@param ct   ffi.ct*
---@param init any
---@return ffi.cdata*
---@nodiscard
function ffi.cast(ct, init) end

---@param ct        ffi.ct*
---@param metatable table
---@return ffi.ctype*
function ffi.metatype(ct, metatable) end

---@param cdata     ffi.cdata*
---@param finalizer? function
---@return ffi.cdata*
function ffi.gc(cdata, finalizer) end

---@param destination any
---@param data any|string
---@param size integer?
function ffi.copy(destination, data, size) end

---Namespace only available for background workers. Use `ac.startBackgroundWorker()` to start a background worker.
worker = {}

---Input data passed to a worker during launch.
---@type nil|boolean|number|string|table
worker.input = nil

---Input data passed to a worker during launch.
---@type nil|boolean|number|string|table
worker.input = nil

---Available only in background worker scripts. Sleep function pauses execution for a certain time. 
---Before unpaused, any callbacks (such as `setTimeout()`, `setInterval()` and
---other custom enqueued callbacks) will be called. This is the only way for those callbacks to fire in a background worker. Note:
---if parent thread is closed, `worker.sleep()` won’t return back and instead script will be unloaded, this way worker can be reloaded
---as well.
---
---If your worker does a lot of async operations, consider using `worker.wait()` instead, setting resulting value with `worker.result`.
---Or maybe not even use anything at all: for basic (non-repeating) callbacks, timers and intervals script will continue running until
---all the postponed actions are complete (updating once every 100 ms).
---@param time number @Time in seconds to pause worker by.
function worker.sleep(time) end

---Wait for `worker.result` value to be set. Stops the worker once `worker.result` value has been provided (or any `error()` has been raised).
---Works the best if your worker uses a lot of async operations. 
---@param time number? @Time in seconds for timeout. Default value: 60. Feel free to pass something like `math.huge` if you don’t need timeout for some reason.
function worker.wait(time) end

---Resulting value used when using `worker.wait()`.
---@type nil|boolean|number|string|table
worker.result = nil

--[[ common/class.lua ]]

---@alias ClassDefinition {__name: string}
---@alias ClassMixin {included: fun(classDefinition: ClassDefinition)}

---A base class. Note: all classes are inheriting from this one even if they’re not using
---`ClassBase` as a parent class explicitly.
ClassBase = {}

---Checks if object is an instance of a class created by `class()` function.
---@param obj any|nil @Any table, vector, nil, anything.
---@return boolean @True if type of `obj` is `ClassBase` or any class inheriting from it.
function ClassBase.isInstanceOf(obj) end

---Checks if ClassBase is a subsclass of a class created by `class()` function. It wouldn’t be, function is here just for
---keeping things even.
---@param classDefinition ClassDefinition @Class created by `class()` function.
---@return boolean @Always false.
function ClassBase:isSubclassOf(classDefinition) end

---Creates a new class. Pretty much the same as calling `class()` (all classes are inheriting from `ClassBase` anyway).
---@return ClassDefinition @New class definition
function ClassBase:subclass(...) end

---Adds a mixin to all subsequently created classes. Use it early in case you want to add a method or some data to all of your objects.
---If `mixin` has a property `included`, it would be called each time new class is created with a reference to the newly created class.
---@param mixin ClassMixin
function ClassBase:include(mixin) end

---Define this function and it would be called each time a new class without a parent (or `ClassBase` for parent) is created.
---@param classDefinition ClassDefinition
function ClassBase:subclassed(classDefinition) end

---A base class for objects with pooling. Note: all classes created with `class.Pool` flag are inheriting from this one even if they’re not using
---`ClassPool` as a parent class explicitly.
ClassPool = {}

---Checks if object is an instance of a class with pooling active.
---@param obj any|nil @Any table, vector, nil, anything.
---@return boolean @True if type of `obj` is `ClassPool` or any class inheriting from it.
function ClassPool.isInstanceOf(obj) end

---Checks if ClassPool is a subsclass of a class created by `class()` function. It wouldn’t be unless you’re passing `ClassBase`, function is here just for
---keeping things even.
---@param classDefinition ClassBase @Class created by `class()` function.
---@return boolean @True if you’ve passed ClassBase here.
function ClassPool:isSubclassOf(classDefinition) end

---Creates a new class with pooling. Pretty much the same as calling `class(class.Pool, ...)` (all classes with `class.Pool` are 
---inheriting from `ClassPool` anyway).
---@return ClassDefinition @New class definition
function ClassPool:subclass(...) end

---Adds a mixin to subsequently created classes with pooling. Use it early in case you want to add a method or some data to all of your objects that use pooling.
---If `mixin` has a property `included`, it would be called each time new class with pooling is created with a reference to the newly created class.
---@param mixin ClassMixin
function ClassPool:include(mixin) end

---Define this function and it would be called each time a new pooling class without a parent (or `ClassPool` for parent) is created.
---@param classDefinition ClassDefinition
function ClassPool:subclassed(classDefinition) end

---A base class. Note: all classes are inheriting from this one even if they’re not using
---`ClassBase` as a parent class explicitly. You might still want to put it in EmmyDoc comment to get hints for functions like `YourClass.isInstanceOf()`.
---@class ClassBase
local _classBase = {}

---Checks if object is an instance of this class. Can be used either as `obj:isInstanceOf(YourClass)` or, as a safer alternative,
---`YourClass.isInstanceOf(obj)` — this one would work even if `obj` is nil, a number, a vector, anything like that. And in all of those
---cases, of course, it would return `false`.
---@param classDefinition ClassDefinition @Used with `obj:isInstanceOf(YourClass)` variant.
---@return boolean @True if argument is an instance of this class.
---@overload fun(): boolean
function _classBase:isInstanceOf(classDefinition) end

---Class method. Checks if class itself is a child class of a different class (or a child of a child, etc). 
---Can be used as `YourClass:isInstanceOf(YourOtherClass)`.
---@param classDefinition ClassDefinition @Class created by `class()` function.
---@return boolean @True if this class is a child of another class (or a child of a child, etc).
function _classBase:isSubclassOf(classDefinition) end

---Class method. Includes mixin, adding new methods to a preexising class. If mixin has a property `included`, it will be called
---with an argument referencing a class mixin is being added to. Can be used as `YourClass:include({ newMethod = function(self, arg) end })`.
---@param mixin ClassMixin @Any mixin.
function _classBase:include(mixin) end

---Class method. Creates a new child class.
---@return ClassDefinition @New class definition
function _classBase:subclass(...) end

---Class method. Called when a new child class is created using this class as a parent one. Redefine this function for
---your class if you need some advanced processing, like adding new methods to a child class.
---@param classDefinition ClassDefinition @New class definition
function _classBase:subclassed(classDefinition) end

---A base class for objects with pooling. Doesn’t add anything, but you can add it as a parent class
---so that `recycled()` would be documented.
---@class ClassPool : ClassBase
local _classPool = {}

---Called when object is about to get recycled.
---@return boolean @Return false if this object should not be recycled and instead destroyed as usual.
function _classPool:recycled() end

---Create a new class. Example:
---
---```
---local MyClass = class('MyClass')        -- class declaration
---
---function MyClass:initialize(arg1, arg2) -- constructor
---  self.myField = arg1 + arg2            -- field
---end
---
---function MyClass:doMyThing()            -- method
---  print(self.myField)
---end
---
---local instance = MyClass(1, 2)          -- creating instance of a class
---instance:doMyThing()                    -- calling a method
---```
---
---Whole thing is very similar to [middleclass](https://github.com/kikito/middleclass), but it’s a different
---implementation that should be somewhat faster. Main differences:
---
---1. Class name is stored in `YourClass.__name` instead of `YourClass.name`.
---
---2. There is no `.static` subtable, all static fields and methods are instead stored in main class
---   table and thus are available as instance fields and methods as well (that’s why `YourClass.name` was
---   renamed to `YourClass.__name`, to avoid possible confusion with a common field name). It’s a bit
---   messier, especially with class methods such as `:subclass()`, but it has some advantages as well:
---   objects creation is faster, and it’s more EmmyLua-friendly (both of which is what it’s all about).
---
---3. Overloaded `__tostring`, `__len` and `__call` are inherited, but not other operators.
---
---4. Method `YourClass.allocate()` works differently here and is used to create a simple table which will be
---   passed to `setmetatable()`. This can help with performance if objects are created often.
---
---Everything else should work the same, including inheritance and mixins. As for performance, some simple
---tests show up to 30% faster objects creation and 40% less memory used for objects with two fields when
---using `YourClass.allocate()` method instead of `YourClass:initialize()` (that alone gives about 15% increase in speed
---when creating an object with two fields):
---
---```
---function YourClass.allocate(arg1, arg2)  -- notice . instead of :
---  return { myField = arg1 + arg2 }     -- also notice, methods are not available at this stage
---end
---```
---
---Other differences (new features rather than something breaking compatibility) and important notes:
---
---1. Function `class()` takes string for class name, another class to act like a parent,
---   allocate and initialize functions and flags. Everything is optional and can go in any order (with one caveat:
---   allocate function should go before initialize function unless you’re using `class.Pool`). Generally there is no
---   benefit in passing allocate and initialize functions here though.
---
---2. With flag `class.NoInitialize` constructor would not look for `YourClass:initialize()` method to call at all,
---   instead using only `YourClass.allocate()`. Might speed things up a bit further.
---
---3. If you’re creating new instances really often, there is a `class.Pool` flag. It would disable the use of
---   `YourClass.allocate()`, but instead allow to reuse unused objects by using `class.recycle(object)`. Recycled objects
---   would end up in a pool of objects to be reused next time an instance would need to be created. Of course, it
---   introduces a whole new type of errors (imagine storing a reference to a recycled item somewhere not knowing it was
---   recycled and now represents something else entirely), so please be careful.
---
---   Note 1: Method `class.recycle()` can be used with nils or non-recycle, no need to have extra checks before calling it.
--- 
---   Note 2: Instances of child classes won’t end up in parent class pool. For such arrangements, consider adding pooling
---           flag to all of child classes where appropriate.
---
---4. Before recycling, method `YourClass:recycled()` will be called. Good time to recycle any inner elements. Also,
---   return `false` from it and object would not be recycled at all.
---
---5. To check type, `YourClass.isInstanceOf(item)` can also be used. Notice that it’s a static method, no “:” here.
---
---All classes are considered children classes of `ClassBase`, that one is mostly for EmmyLua to pick up methods like 
---`YourClass.isInstanceOf(object)`. If you’re creating your own class and want to use such methods, just add `: ClassBase`
---to its EmmyLua annotation. And objects with pooling are children of `ClassPool` which is a child of `ClassBase`. Note: 
---to speed things up, those classes aren’t fully real, but you can access them and their methods and even call things like
---`ClassBase:include()`. Please read documentation for those functions before using them though, just to check.
---@param name string @Class name.
---@param parentClass ClassBase @Parent class.
---@param flags nil|integer|`class.NoInitialize`|`class.Pool`|`class.Minimal` @Flags.
---@overload fun(name: string, flags: nil|integer|`class.NoInitialize`|`class.Pool`|`class.Minimal`)  @Regular parent-less class with some flags
---@overload fun(name: string, allocateFn: function|`function() return {} end, class.NoInitialize`)    @Inline allocate function for slightly faster creation
---@overload fun(name: string, initializeFn: `function (self) end, class.Pool`)               @With pooling for best memory reuse
---@overload fun(allocateFn: `function() return {} end, class.NoInitialize + class.Minimal`)  @Most minimal version
---@return ClassDefinition @New class definition
function class(name, parentClass, flags) end

class = {}

---Skip initialization function completely. Might slightly speed up object creation.
class.NoInitialize = 1

---Reuse recycled objects instead of creating new ones. Disables `.allocate()` and switches to `:initialize()`,
---but performance gain from not having to allocate new tables is worth it. Don’t forget to recycle unused elements
---with `class.recycle(item)`.
class.Pool = 2

---Minimal version of a class, skips creation of all static methods and default to-string operators.
---
---To use with either pooling or no-initialize setup, pass two flags separated by a comma, or just sum them together
---(would work only if values are powers of two and you’re not summing together the same flag twice). Or, use
---`bit.bor(flag1, flag2)`, courtesy of LuaJIT and its BitOp extension.
class.Minimal = 4

---Recycle an item to its pool, to speed up creation and reduce work for GC. Requires class to be created with
---`class.Pool` flag.
---
---This method has protection from double recycling, recycling nils or non-recycleable items, so don’t worry about it.
---@param item ClassPool|nil
function class.recycle(item) end

---A trick to get `class()` to work with EmmyLua annotations nicely. Call `class.emmy(YourClass, YourClass.initialize)`
---or `class.emmy(YourClass, YourClass.allocate)` (whatever you’re using) and it would give you a constructor function.
---Then, use it for local reference or as a return value from module. For best results add annotations to function you’re
---passing here, such as return value or argument types.
---
---In reality is simply returns the class back and ignores second argument, but because of this definition EmmyLua thinks
---it got the constructor.
---@generic T1
---@generic T2
---@param classFn T1
---@param constructorFn T2
---@return T1|T2
function class.emmy(classFn, constructorFn) return constructorFn end

---@return string?
function ac.getPatchVersion() end

---Increments with every CSP build.
---@return integer
function ac.getPatchVersionCode() end

---Load and parse INIpp configuration file (supports includes and such), return it as JSON. Deprecated, use `ac.INIConfig.load()` instead.
---@deprecated
---@param iniFilename string
---@param includeDirs string|nil @Newline separated path to folders to search for included files in. Default value: `nil`.
---@return string?
function ac.loadINIppFile(iniFilename, includeDirs) end

---Returns name of MGUK delivery program. If there is no such car or program, returns `nil`.
---@param carIndex integer @0-based car index.
---@param programIndex integer? @0-based program index (if negative, name of currently selected program will be returned. Default value: -1.
---@return string?
function ac.getMGUKDeliveryName(carIndex, programIndex) end

---Get short name of a tyre set, either currently selected or with certain index. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param compoundIndex integer? @0-based tyre set index, if set to -1, short name of currently selected tyre set will be returned. Default value: -1.
---@return string?
function ac.getTyresName(carIndex, compoundIndex) end

---Get 0-based index of a tyres set with a given short name, or -1 if there is no such tyres set (or such car).
---@param carIndex integer @0-based car index.
---@param tyresShortName string @Short tyres set name (usually a couple of symbols long).
---@return integer
function ac.getTyresIndex(carIndex, tyresShortName) end

---Returns long name of a tyre set with certain index. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param compoundIndex integer? @0-based tyre set index, if set to -1, short name of currently selected tyre set will be returned. Default value: -1.
---@param includePostfix boolean? @Set to `false` to skip short name postfix. Default value: `true`.
---@return string?
function ac.getTyresLongName(carIndex, compoundIndex, includePostfix) end

---Get car ID (name of its folder) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarID(carIndex) end

---Get car name (from its JSON file) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param includeYearPostfix boolean? @Set to `true` to add a year postfix. Default value: `false`.
---@return string?
function ac.getCarName(carIndex, includeYearPostfix) end

---Get selected skin ID of (name of skin’s folder) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarSkinID(carIndex) end

---Get name of a manufacturer of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarBrand(carIndex) end

---Get name of manufactoring country of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarCountry(carIndex) end

---Refers to AI spline.
---@return boolean
function ac.hasTrackSpline() end

---Finds nearest point on track AI spline (fast_lane) and returns its normalized position. If there is no track spline, returns -1.
---@param v vec3
---@return number
function ac.worldCoordinateToTrackProgress(v) end

---Returns distance from AI spline to left and right track boundaries.
---@param v number @Lap progress from 0 to 1.
---@return vec2 @X for left side, Y for right side.
function ac.getTrackAISplineSides(v) end

---@param v number
---@param linear boolean? @Use linear interpolation. Default value: `false`.
---@return vec3
function ac.trackProgressToWorldCoordinate(v, linear) end

---@param v number
---@param r vec3
---@param linear boolean? @Use linear interpolation. Default value: `false`.
function ac.trackProgressToWorldCoordinateTo(v, r, linear) end

---Converts world coordinates into track coordinates. Track coordinates:
--- - X for normalized position (0 — right in the middle, -1 — left side of the track, 1 — right size);
--- - Y for height above track in meters;
--- - Z for track progress.
---@param v vec3
---@return vec3
function ac.worldCoordinateToTrack(v) end

---Converts track coordinates into world coordinates. Track coordinates:
--- - X for normalized position (0 — right in the middle, -1 — left side of the track, 1 — right size);
--- - Y for height above track in meters;
--- - Z for track progress.
---@param v vec3
---@return vec3
function ac.trackCoordinateToWorld(v) end

---Returns track world coordinates in degrees.
---@param worldPos vec3|nil @Added in 0.2.8. If set, function returns coordinates of this point instead. Default value: `nil`.
---@return vec2 @X for latitude, Y for longitude.
function ac.getTrackCoordinatesDeg(worldPos) end

---Returns timezone offset for the track in seconds.
---@param time number? @If set, returns timezone for given timestamp (DST might differ). Default value: `nil`.
---@return vec2 @X for base offset, Y for summer time offset.
function ac.getTrackTimezoneBaseDst(time) end

---Name of a sector.
---@param trackProgress number @Track position from 0 to 1.
---@return string
function ac.getTrackSectorName(trackProgress) end

---Returns directory of the script.
---@return string
function ac.dirname() end

---If `fileName` is not an absolute path, looks for a file in script directory, then relative to CSP folder,
---then relative to AC root folder. If anything is found, returns an absolute path to found file, otherwise
---returns input parameter. If such a filename is not allowed, or `fileName` is `nil`, returns an empty string.
---@param fileName string @File name relative to script folder, or CSP folder, or AC root folder.
---@return path
function ac.findFile(fileName) end

---Returns full path to one of known folders. Some folders might not exist, make sure to create them before writing.
---@param folderID ac.FolderID|string @Could also be a system GUID in “{XX…}” form.
---@return string @Returns empty string if there is no match.
function ac.getFolder(folderID) end

---Turns time in milliseconds into common lap time presentation, like 00:00.123. If minutes exceed 60,
---hours will also be added, but only if `allow_hours` is `true` (default is `false`).
---@param time number @Time in milliseconds.
---@param allowHours boolean? @Set to `true` to add hours as well. If `false` (default value), instead it would produce 99:99.999. If `true`, milliseconds will use two digits instead of three. Default value: `false`.
---@return string
function ac.lapTimeToString(time, allowHours) end

---Returns country name based on nation code (three symbols for country ID).
---@param nationCode ac.NationCode
---@return string
function ac.getCountryName(nationCode) end

---Can be used to access files in “data.acd” and, for example, read car specs.
---@param filename string
---@return string
function ac.readDataFile(filename) end

---Parse INIpp configuration file, return it as JSON. Deprecated, use `ac.INIConfig.parse()` instead.
---@deprecated
---@param iniData string
---@return string
function ac.parseINIppFile(iniData) end

---Use `ac.getTrackID()` instead.
---@deprecated
---@return string
function ac.getTrackId() end

---Returns track ID (name of its folder).
---@return string
function ac.getTrackID() end

---Returns track layout ID (name of layout folder, without name of track folder), or empty string if there is no layout.
---@return string
function ac.getTrackLayout() end

---Returns full track ID (name of track folder and layout folder joined by some string, or just name of track folder if there is no layout).
---@param separator string? @Default value: '-'.
---@return string
function ac.getTrackFullID(separator) end

---Returns track name (as set in its JSON file).
---@return string
function ac.getTrackName() end

---Given name, returns a path like …/assettocorsa/content/tracks/[track ID]/data/[name], taking into account layout as well.
---@param fileName string
---@return string
function ac.getTrackDataFilename(fileName) end

---Get car tags. If there is no such car, returns `nil`. @nodiscard
---@param carIndex integer @0-based car index.
---@return string[]|nil
function ac.getCarTags(carIndex) end

---A key unique for each individual PC (uses serial numbers of processor and motherboard).
---Use `ac.uniqueMachineKeyAsync()` instead.
---@deprecated
---@return string
function ac.uniqueMachineKey() end

---A key unique for each individual PC (uses serial numbers of processor and motherboard). Asynchronous version. Returned value is in binary,
---use something like `ac.encodeBase64()` to encode data in readable format.
---@param callback fun(err: string?, response: string?)
function ac.uniqueMachineKeyAsync(callback) end

---Returns ordered list of data file names (not full paths, just the names) of a certain car. Works for both packed and unpacked cars. If failed,
---returns empty list. @nodiscard
---@param carIndex integer? @0-based car index.
---@return string[]
function ac.getCarDataFiles(carIndex) end

---Returns list of car colliders. @nodiscard
---@param carIndex integer? @0-based car index.
---@param actualColliders boolean? @Set to `true` to draw actual physics colliders (might differ due to some physics alterations). Default value: `false`.
---@return {position: vec3, size: vec3}[]
function ac.getCarColliders(carIndex, actualColliders) end

---Returns squared distance to main camera. In splitscreen mode, returns smallest distance between to cameras. In the future, might be altered by
---more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.
---@param pos vec3
---@return number
function ac.distanceToRenderSquared(pos) end

---Returns distance to main camera. In splitscreen mode, returns smallest distance between to cameras. In the future, might be altered by
---more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.
---@param pos vec3
---@return number
function ac.distanceToRender(pos) end

---Returns `true` if position is closer to main camera than the threshold. In splitscreen mode, considers secondary camera. In the future, might be altered by
---more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.
---@param pos vec3
---@param distance number
---@return boolean
function ac.closerToRenderThan(pos, distance) end

---Encodes float into FP16 format and returns it as uint16.
---@param v number
---@return integer
function ac.encodeHalf(v) end

---Encodes two floats from a vector into FP16 format and returns it as uint32.
---@param v number|vec2
---@return integer
function ac.encodeHalf2(v) end

---Decodes float from FP16 format (represented as uint16) and returns a regular number.
---@param v integer
---@return number
function ac.decodeHalf(v) end

---Decodes two floats from FP16 format (represented as uint32) and returns a vector.
---@param v integer
---@return vec2
function ac.decodeHalf2(v) end

---Computes SHA-256 checksum for given binary data. Very secure, but might be slow with large amounts of data. Data string can contain zero bytes.
---@param data binary
---@return string?
function ac.checksumSHA256(data) end

---Computes 64-bit xxHash checksum for given binary data. Very fast, not that great for encryption purposes.
---Use `bit.tohex()` to turn result into a hex representation. Data string can contain zero bytes.
---@param data binary
---@return integer
function ac.checksumXXH(data) end

---Compresses data. First byte of resulting data is compression type, next four are uncompressed data size, rest is compressed data
---itself. If data is failed to compress, returns `nil`. Data string can contain zero bytes.
---@param data binary
---@param type ac.CompressionType
---@param level integer? @Higher level means better, but slower compression. Maximum value: 12. Default value: 9.
---@return string?
function ac.compress(data, type, level) end

---Decompresses data. First byte of input data is compression type, next four are uncompressed data size. If data is damaged, returns `nil`.
---Data string can contain zero bytes.
---@param data binary
---@return string?
function ac.decompress(data) end

---Encodes data in base64 format. Data string can contain zero bytes.
---@param data binary
---@param trimResult boolean? @If `true`, ending “=” will be trimmed. Default value: `false`.
---@return string?
function ac.encodeBase64(data, trimResult) end

---Decodes data from base64 format (ending “=” are not needed).
---@param data string
---@return string?
function ac.decodeBase64(data) end

---Converts string from UTF-8 to UTF-16 format (two symbols per character). All strings Lua operates with regularly are consired UTF-8. UTF-16 strings
---can’t be used in any CSP API unless documentation states that function can take strings containing zeroes.
---@param data string
---@return string?
function ac.utf8To16(data) end

---Converts string from UTF-16 (two symbols per character) to common Lua UTF-8. All strings Lua operates with regularly are consired UTF-8. UTF-16 strings
---can’t be used in any CSP API unless documentation states that function can take strings containing zeroes. Data string can contain zero bytes.
---@param data binary
---@return string?
function ac.utf16To8(data) end

---Given an FFI struct, returns bytes with its content. Resulting string may contain zeroes.
---@param data binary
---@return string?
function ac.structBytes(data) end

function ac.memoryBarrier() end

---Simple helper to measure time and analyze performance. Call `ac.perfBegin('someKey')` to start counting time and
--- `ac.perfEnd('someKey')` to stop. Measured time will be shown in Lua App Debug app in CSP (moving average across all
--- perfBegin/perfEnd calls). Note: keys on perfBegin() and perfEnd() should match.
---@param value string
function ac.perfBegin(value) end

---Simple helper to measure time and analyze performance. Call `ac.perfBegin('someKey')` to start counting time and
--- `ac.perfEnd('someKey')` to stop. Measured time will be shown in Lua App Debug app in CSP (moving average across all
--- perfBegin/perfEnd calls). Note: keys on perfBegin() and perfEnd() should match.
---@param value string
function ac.perfEnd(value) end

---Unlike `ac.perfBegin('someKey')/ac.perfEnd('someKey')`, `ac.perfFrameBegin(0)/ac.perfFrameEnd(0)` will accumulate time
--- between calls as frame progresses and then use the whole sum for moving average. This makes it suitable for measuring
--- how much time in a frame repeatedly ran bit of code takes. To keep performance as high as possible (considering that
--- it could be ran in a loop), it uses integer keys instead of strings.
---@param value integer
function ac.perfFrameBegin(value) end

---Unlike `ac.perfBegin('someKey')/ac.perfEnd('someKey')`, `ac.perfFrameBegin(0)/ac.perfFrameEnd(0)` will accumulate time
--- between calls as frame progresses and then use the whole sum for moving average. This makes it suitable for measuring
--- how much time in a frame repeatedly ran bit of code takes. To keep performance as high as possible (considering that
--- it could be ran in a loop), it uses integer keys instead of strings.
---@param value integer
function ac.perfFrameEnd(value) end

---@return vec3
function ac.getCameraPosition() end

---@return vec3
function ac.getCameraUp() end

---@return vec3
function ac.getCameraSide() end

---@return vec3
function ac.getCameraForward() end

---This vector is pointing backwards! Only kept for compatibility. For proper one, use `ac.getCameraForward()`.
---@deprecated
---@return vec3
function ac.getCameraDirection() end

---Value in degrees.
---@return number
function ac.getCameraFOV() end

---@param r vec3 @Destination.
function ac.getCameraPositionTo(r) end

---@param r vec3 @Destination.
function ac.getCameraUpTo(r) end

---@param r vec3 @Destination.
function ac.getCameraSideTo(r) end

---@param r vec3 @Destination.
function ac.getCameraForwardTo(r) end

---@param r vec3 @Destination.
function ac.getCameraDirectionTo(r) end

---Returns camera position in car coordinates system.
---@return vec3
function ac.getCameraPositionRelativeToCar() end

---Returns compass angle for given directory.
---@param dir vec3
---@return number @Angle from 0 to 360 (0/360 for north, 90 for east, etc.)
function ac.getCompassAngle(dir) end

---Value in degrees.
---@return number
function ac.getSunAngle() end

---Value in degrees.
---@return number
function ac.getSunPitchAngle() end

---Value in degrees.
---@return number
function ac.getSunHeadingAngle() end

---Returns true if camera is focused on interior (interior audio is playing).
---@return boolean
function ac.isInteriorView() end

---@return boolean
function ac.isInReplayMode() end

---@param filename string
---@param outputFilename string
function ac.compressTexture(filename, outputFilename) end

---Returns precalculated sound speed in m/s taking into account humidity, altitude, pressure, etc.
---@return number
function ac.getSoundSpeedMs() end

---Returns air pressure in kPa.
---@param p vec3
---@return number
function ac.getAirPressure(p) end

---Returns air humidity in 0…1 range. Currently doesn’t use position parameter, but it might change later.
---@param p vec3
---@return number
function ac.getAirHumidity(p) end

---Returns string with last error thrown by this script, or `nil` if there wasn’t an error. Use it in case you would want to set some nicer error reporting.
---@return string?
function ac.getLastError() end

---Returns audio volume for given channel, value from 0 to 1. If channel is not recognized, returns `fallbackValue` if specified, unless (since 0.2.4) you specify key in a
---`'your.namespace/Readable name'` format: this will register a new volume level and show it in Audio Volume app for sessions where value was
---accessed or set.
---@param audioChannelKey ac.AudioChannel
---@param carIndex integer? @If set and a Kunos car-related channel (`'dirt'`, `'engine'`, `'opponents'`, `'surfaces'`, `'transmission'`, `'tyres'`, `'wind'`) is used, returns a car-specific multiplier (1 by default). Default value: -1.
---@param fallbackValue number? @Default value: -1.
---@return number @Value from 0 to 1, or -1 if there is no such channel.
function ac.getAudioVolume(audioChannelKey, carIndex, fallbackValue) end

---Returns name of output audio device.
---@return string
function ac.getAudioOutputDevice() end

---Consider using `ac.getCar(carIndex).speedKmh` instead.
---@param carIndex integer @0-based car index.
---@return number
function ac.getCarSpeedKmh(carIndex) end

---Returns 'R', 'N', number of engaged gear or value set by `ac.setGearLabel()` if used (for implementing automatic gearboxes).
---If your code is displaying current gear, this might be a preferable choice.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarGearLabel(carIndex) end

---Returns approximate Y coordinate of ground, calculated by using depth from reflection cubemap. Does not have a performance impact (that value
--- will be calculated anyway for CSP to run.
---@return number
function ac.getGroundYApproximation() end

---Returns current delta time associated with UI (so values are non-zero if sim or replay are paused).
---@return number @Seconds.
function ac.getDeltaT() end

---Returns current delta time associated with simulation (so values are zero if sim or replay are paused).
---@return number @Seconds.
function ac.getGameDeltaT() end

---Returns delta time for current script. If script only runs every N frames (like car display scripts by default),
---this value will be greater than regular `dt` from simulation state.
---@return number
function ac.getScriptDeltaT() end

---Returns current time multiplier.
---@return number
function ac.getConditionsTimeScale() end

---Returns name of current PP filter with “.ini”.
---@return string?
function ac.getPpFilter() end

---Value is in m/s.
---@return vec3
function ac.getWindVelocity() end

---Value is in m/s.
---@param r vec3 @Destination.
function ac.getWindVelocityTo(r) end

---@return boolean
function ac.isWeatherFxActive() end

---Distance and turn angle (in degrees) for the upcoming turn. If failed to compute, both would be -1. If car is facing wrong way, turn angle is either
---180° or -180° depending on where steering wheel of a car is.
---@param carIndex integer? @Default value: 0.
---@return vec2
function ac.getTrackUpcomingTurn(carIndex) end

---Get full driver name of a driver of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverName(carIndex) end

---Get three character nation code of a driver of a certain car. Nation code is a three-letter uppercase country identifier. If nationality is not set, a value from JSON
---is returned. If it’s missing there, a fallback “ITA” is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverNationCode(carIndex) end

---Get full nationality of a driver of a certain car. Usually, it’s a full country name. If nationality is not set, a value from JSON
---is returned. If it’s missing there, a fallback “Italy” is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverNationality(carIndex) end

---Get name of a team of a driver of a certain car. Team names can be configured in entry list online. If nationality is not set, a value from JSON
---is returned. If it’s missing there, an empty string is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverTeam(carIndex) end

---Get number of a driver of a certain car. If number is set in skin JSON, it will be returned, otherwise it’s a unique 1-based number.
---If there is no car with such index, 0 is returned.
---@param carIndex integer @0-based car index.
---@return integer
function ac.getDriverNumber(carIndex) end

---Returns `true` if a certain driver is using custom icon. Use `'carN::special::driver'` as image filename to draw it (when not custom,
---will give you a livery icon or a fallback dark image).
---@param carIndex integer @0-based car index.
---@return boolean
function ac.isCustomIconSet(carIndex) end

---Get session name for a session with given index. Use `ac.getSim()` to check number of sessions and more information about them.
---If there is no such session, returns `nil`.
---@param sessionIndex integer
---@return string?
function ac.getSessionName(sessionIndex) end

---Is keyboard button being held.
---@param keyIndex ui.KeyIndex
---@return boolean
function ac.isKeyDown(keyIndex) end

---Is keyboard button just moved from not held to held in the last graphics frame (or, for physics scripts since 0.2.7, physics frame).
---Still, if you’re working on car physics script, consider using `ac.ControlButton()` instead for better customization. If your script is skipping frames
---(such as car display scripts), this might not work as expected, as the frame the button has changed the state in could be skipped.
---@param keyIndex ui.KeyIndex
---@return boolean
function ac.isKeyPressed(keyIndex) end

---Is keyboard button just moved from held to not held in the last graphics frame (or, for physics scripts since 0.2.7, physics frame).
---If you’re working on car physics script, consider using `ac.ControlButton()` instead for better customization. If your script is skipping frames
---(such as car display scripts), this might not work as expected, as the frame the button has changed the state in could be skipped.
---@param keyIndex ui.KeyIndex
---@return boolean
function ac.isKeyReleased(keyIndex) end

---Can be called from anywhere. Checks if given point is within main camera frustum (or several, in triple screen mode) or not. For checking if something
---is within current camera instead, try `render.isVisible()`.
---@param pos vec3
---@param radius number
---@param gSpace boolean? @Pass `false` if your coordinates are in world-space rather than with origin shift applied (in most cases, you need to use `false`, this argument is added for backwards compatibility. Default value: `true`.
---@param includeFarPlane boolean? @Pass `false` to ignore far plane. Default value: `true`.
---@return boolean @Checks visibility with frustum culling.
function ac.isVisibleInMainCamera(pos, radius, gSpace, includeFarPlane) end

---Returns steering input from -1 to 1.
---@return number
function ac.getControllerSteerValue() end

---Is gas input pressed (pedal, gamepad axis, keyboard button but not mouse button).
---@return boolean
function ac.isControllerGasPressed() end

---Is gear up input pressed (pedal, gamepad button, keyboard button).
---@return boolean
function ac.isControllerGearUpPressed() end

---Is gear down input pressed (pedal, gamepad button, keyboard button).
---@return boolean
function ac.isControllerGearDownPressed() end

---Get session spawn set (`'START'`, `'PIT'`, `'HOTLAP_START'`, `'TIME_ATTACK'`, etc.) for a session with given index. Use `ac.getSim()`
---to check number of sessions and more information about them. If there is no such session, returns `nil`.
---@param sessionIndex integer
---@return string?
function ac.getSessionSpawnSet(sessionIndex) end

---Forces driver head to be visible even with cockpit camera.
---@param carIndex integer
---@param force boolean? @Default value: `true`.
function ac.forceVisibleHeadNodes(carIndex, force) end

---Checks if a certain gamepad button is pressed.
---@param gamepadIndex integer @0-based index, from 0 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param gamepadButtonID ac.GamepadButton
---@return boolean
function ac.isGamepadButtonPressed(gamepadIndex, gamepadButtonID) end

---Returns value of a certain gamepad axis.
---@param gamepadIndex integer @0-based index, from 0 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param gamepadAxisID ac.GamepadAxis
---@return number
function ac.getGamepadAxisValue(gamepadIndex, gamepadAxisID) end

---Returns number of DirectInput devices (ignore misleading name).
---@return integer
function ac.getJoystickCount() end

---Returns name of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.
---@param joystick integer @0-based index.
---@return string?
function ac.getJoystickName(joystick) end

---Returns instance GUID of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.
---@param joystick integer @0-based index.
---@return string?
function ac.getJoystickInstanceGUID(joystick) end

---Returns product GUID of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.
---@param joystick integer @0-based index.
---@return string?
function ac.getJoystickProductGUID(joystick) end

---Returns index of a DirectInput device by its instance GUID, or `nil` if there is no such device (ignore misleading name).
---@param guid string
---@return integer?
function ac.getJoystickIndexByInstanceGUID(guid) end

---While this function returns accurate number of device axis, consider using 8 instead if you need to iterate over them.
---Actual axis can be somewhere within those 8. For example, if device has a single axis, it could be that you need to access
---axis at index seven to get its value (rest will be zeroes).
---@param joystick integer
---@return integer
function ac.getJoystickAxisCount(joystick) end

---Returns number of buttons of a DirectInput device (ignore misleading name).
---@param joystick integer
---@return integer
function ac.getJoystickButtonsCount(joystick) end

---Returns number of D-pads (aka POVs) of a DirectInput device (ignore misleading name).
---@param joystick integer
---@return integer
function ac.getJoystickDpadsCount(joystick) end

---Checks if a button of a DirectInput device is currently held down (ignore misleading name).
---@param joystick integer
---@param button integer
---@return boolean
function ac.isJoystickButtonPressed(joystick, button) end

---Returns axis value of a DirectInput device (ignore misleading name).
---@param joystick integer
---@param axis integer
---@return number
function ac.getJoystickAxisValue(joystick, axis) end

---Use `ac.getJoystickAxisValue()` instead.
---@deprecated
---@param joystick integer
---@param axis integer
---@return number
function ac.isJoystickAxisValue(joystick, axis) end

---Returns D-pad (aka POV) value of a DirectInput device (ignore misleading name).
---@param joystick integer
---@param dpad integer
---@return integer @If D-pad is not moved, -1, or a value from 0 to 36000 storing the angle (0: up, 9000: right).
function ac.getJoystickDpadValue(joystick, dpad) end

---Use `ac.getJoystickDpadValue()` instead.
---@deprecated
---@param joystick integer
---@param dpad integer
---@return integer
function ac.isJoystickDpadValue(joystick, dpad) end

---Checks current stylus/pen/mouse using RealTimeStylus API (compatible with Windows Ink). Should support things like Wacom tables (if drivers are installed
---and Windows Ink compatibility in options is not disabled).
---
---Note: the moment its called, CSP initializes RealTimeStylus API to monitor pen state until game closes. With that, CSP will also use that data
---for mouse (or pen) pointer interaction with UI in general, especially for IMGUI apps.
---[There is a weird issue in Windows 10](https://answers.microsoft.com/en-us/windows/forum/all/windows-pen-tablet-click-and-drag-lag/9e4cac7d-69a0-4651-87e8-7689ce0d1027)
---where it doesn’t register short click-and-drag events properly expecting a touchscreen gesture. Using RealTimeStylus API for UI in general solves that.
---@return number @Pen pressure from 0 to 1 (if mouse is used, pressure is 1).
function ac.getPenPressure() end

---Returns name of the current online server, or `nil` if it’s not available.
---@return string?
function ac.getServerName() end

---Returns IP address of the current online server, or `nil` if it’s not available.
---@return string?
function ac.getServerIP() end

---Returns HTTP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortHTTP() end

---Returns TCP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortTCP() end

---Returns UDP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortUDP() end

---Returns index of a car with a driver with a certain name, or -1 if there is no such car.
---@param driverName string
---@return integer
function ac.getCarByDriverName(driverName) end

---Returns leaderboard car position, same as Python function with the same name. Does not work online. For an alternative solution,
---get position calculated by CSP via `ac.getCar(N).racePosition`
---@param carIndex integer @0-based car index.
---@return integer @Returns -1 if couldn’t calculate the value.
function ac.getCarLeaderboardPosition(carIndex) end

---Returns real time car position, same as Python function with the same name. Does not work online. For an alternative solution,
---get position calculated by CSP via `ac.getCar(N).racePosition`.
---@param carIndex integer @0-based car index.
---@return integer @Returns -1 if couldn’t calculate the value.
function ac.getCarRealTimeLeaderboardPosition(carIndex) end

---How much of moon area is currently lit up.
---@return number
function ac.getMoonFraction() end

---@return number
function ac.getAltitude() end

---Get direction to a sky feature in world-space (corrected for track heading). If feature is not available, returns a zero vector.
---@param skyFeature ac.SkyFeature
---@param distance number|refnumber|nil @Default value: `nil`.
---@param time number? @If set, it’ll compute direction for the given time instead of the current time. Default value: `nil`.
---@return vec3
function ac.getSkyFeatureDirection(skyFeature, distance, time) end

---Get direction to a star in the sky in world-space (corrected for track heading). If feature is not available, returns a zero vector.
---@param declRad number
---@param rightAscRad number
---@return vec3
function ac.getSkyStarDirection(declRad, rightAscRad) end

---Call this function if your script caused car shape to change and CSP would refresh interior masking, car heightmap and more.
---@param carIndex integer? @Default value: 0.
function ac.refreshCarShape(carIndex) end

---Call this function if your script caused car color to change and CSP would refresh color map for bounced light and more.
---@param carIndex integer? @Default value: 0.
function ac.refreshCarColor(carIndex) end

---Updates state of high-res driver model. Use it before moving driver nodes manually for extra animations: if called,
--- next model update possibly overwriting your custom positioning will be skipped. Also, model update will be enforced
--- so you can blend your custom state.
---
--- Since 0.1.80-preview397, does not apply if HR driver model is currently hidden unless second argument is `true` (in which
--- case it’ll activate driver model for a few frames).
---@param carIndex integer? @For car scripts, always applied to associated car instead. Default value: -1.
---@param forceVisible boolean? @Set to `true` to forcefully switch to HR model for a few frames. Default value: `false`.
function ac.updateDriverModel(carIndex, forceVisible) end

---@param ret mat4x4
---@param carIndex integer
---@return boolean
function ac.getDriverHeadTransformTo(ret, carIndex) end

---Block system messages based on a given regular expression.
---@param regex string @Any message with title or description containing this regex will be discarded.
---@return ac.Disposable
function ac.blockSystemMessages(regex) end

---Sets a callback which will be called when car crosses a certain point on a track. Won’t be triggered if car is in pitlane or recently jumped.
---Time is relative to the same point as `ac.SimState.time`. Tracking happens on physics thread and is interpolated based on car position, so it
---should be precise more than within 3 ms steps.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param progress number @Track progress from 0 to 1.
---@param callback fun(carIndex: integer, timeMs: number)
---@return ac.Disposable
function ac.onTrackPointCrossed(carIndex, progress, callback) end

---Sets a callback which will be called when a new session starts (or restarts). Doesn’t get triggered at the start of the race (Lua scripts load when
---the first session is already up and running to ensure the overall state of the sim is complete)!
---@param callback fun(sessionIndex: integer, restarted: boolean)
---@return ac.Disposable
function ac.onSessionStart(callback) end

---Sets a callback which will be called when AC resolution changes. Happens when window size changes, or when making a screenshot.
---Note: some scripts, such as WeatherFX style or post-processing script, reload completely when resolution changes, but if they’d call
---this function at any point, they would no longer reload. Instead CSP assumes they can handle resolution changes on their side.
---@param callback fun(newSize: vec2, makingScreenshot: boolean)
---@return ac.Disposable
function ac.onResolutionChange(callback) end

---Sets a callback which will be called when selected tyres change for some car. For car scripts to track changes in their own car, use `car.index` as first argument.
--- Note: for physics scripts this even might come a few frames late, but it shouldn’t be a major issue since tyres changes only happen when car is stationary anyway.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer, setIndex: integer, shortName: string, longName: string)
---@return ac.Disposable
function ac.onTyresSetChange(carIndex, callback) end

---Sets a callback which will be called when new user connects the server and their car appears (doesn’t do anything outside of online race).
---@param callback fun(connectedCarIndex: integer, connectedSessionID: integer)
---@return ac.Disposable
function ac.onClientConnected(callback) end

---Sets a callback which will be called when a user disconnects (doesn’t do anything outside of online race).
---@param callback fun(connectedCarIndex: integer, connectedSessionID: integer)
---@return ac.Disposable
function ac.onClientDisconnected(callback) end

---Sets a callback which will be called when control settings change live.
---@param callback fun()
---@return ac.Disposable
function ac.onControlSettingsChanged(callback) end

---Sets a callback which will be called when triple screen configuration changes.
---@param callback fun()
---@return ac.Disposable
function ac.onTripleConfigurationChanged(callback) end

---Returns `true` if a Lua app with given ID is loaded and currently active (not countring background services).
---@param appID string
---@return boolean
function ac.isLuaAppRunning(appID) end

---Returns an estimate of optimal braking amount based on current grip level, or -1 if it can’t be computed for a given car.
---@param carIndex integer
---@return number
function ac.getCarOptimalBrakingAmount(carIndex) end

---Returns an estimate of maximum speed for a given gear in km/h, -1 if it can’t be computed for a given car, or 0 if there is no such gear. Returns negative
---speed for the reverse gear.
---@param carIndex integer
---@param gearIndex integer @Gear index, 1 for first gear (same as `ac.getCar().gear`).
---@return number @Returns speed in km/h.
function ac.getCarMaxSpeedWithGear(carIndex, gearIndex) end

---Changes location of script storage. Scripts without I/O access will have “shared-” appended to their relative path and can’t use “.” or slashes in it
---to ensure configs are contained within the directory. Note: before 0.2.4 calls to this function by scripts without I/O access would have no effect.
---@param relativePath string @Path relative to directory with Lua configs. If empty, call won’t have an effect.*/.
---@param prefix string|nil @Optional prefix. Default value: `nil`.
function ac.storageSetPath(relativePath, prefix) end

---Broadcasts a shared event. With shared events, different Lua scripts can exchange messages and data. Make sure to come up with
---a unique name for your events to avoid collisions with other scripts and Lua apps.
---
---Callbacks will be called next time the script is updating.
---
---Note: if your scripts need to exchange data frequently, consider using `ac.connect()` instead, as it allows to establish a typed connection
---with much less overhead.
---@param key string
---@param data serializable
---@return integer @Returns number of listeners to the event with given key.
function ac.broadcastSharedEvent(key, data) end

---Subscribes to a shared event. With shared events, different Lua scripts can exchange messages and data. Make sure to come up with
---a unique name for your events to avoid collisions with other scripts and Lua apps.
---
---Callback will be called next time this script is updating.
---@param key string
---@param callback fun(data: string|number|boolean|nil, senderName: string, senderType: string, senderID: integer)
---@param processPostponed boolean? @Set to `true` to process previously broadcasted and yet non-processed events (up to 40). Default value: `false`.
---@return ac.Disposable
function ac.onSharedEvent(key, callback, processPostponed) end

---@param callback fun(senderName: string, senderType: string, senderID: integer)
---@return ac.Disposable
function ac.onLuaScriptDisposal(callback) end

---@param hand integer @0 for left, 1 for right.
---@param busy boolean|`true`|`false` @Busy hand doesn’t have visual marks and doesn’t interact with UI and car elements.
function ac.setVRHandBusy(hand, busy) end

---@param hand integer @0 for left, 1 for right.
---@param frequency number
---@param amplitude number
---@param duration number? @Duration in seconds. Default value: 0.01.
function ac.setVRHandVibration(hand, frequency, amplitude, duration) end

---@param cspModuleID ac.CSPModuleID
---@return boolean
function ac.isModuleActive(cspModuleID) end

---@return number, number
function ac.getPerformanceCPUAndGPUTime() end

---Returns index of a car in front of other car (within 100 m), or -1 if there is no such car. Broken, not sure why is it even here, kept for compatibility.
---@deprecated.
---@param carMainIndex integer
---@param distance number|refnumber|nil @Default value: `nil`.
---@return integer
function ac.getCarIndexInFront(carMainIndex, distance) end

---Calculates time gap between two cars in seconds. In race sessions uses total driven distance and main car speed, in other sessions simply
---compares best lap times. If main car is ahead of comparing-to car (in front of, or has better lap time for non-race sessions), value will
---be negative.
---
---In the future implementation might change for something more precise.
---@param carMainIndex integer @0-based index.
---@param carComparingToIndex integer @0-based index.
---@return number
function ac.getGapBetweenCars(carMainIndex, carComparingToIndex) end

---Returns audio peak level for the system, for left and right channels. Careful: AC audio is also included, but
---it still might be used to fake some audio visualization.
---@param output boolean? @Set to `false` to monitor peak from a microphone. Note: it would only work if there are other processes actually listening to audio. Default value: `true`.
---@return vec2
function ac.mediaCurrentPeak(output) end

---Stores value in session shared Lua/Python storage. This is not a long-term storage, more of a way for different scripts to exchange data.
---Note: if you need to exchange a lot of data between Lua scripts, consider using ac.connect instead.
---
---Data string can contain zeroes.
---@param key string @Unique key. If starting with “.”, value won’t be shown in Lua Debug app and will be considered temporary and unimportant.
---@param value string|number|nil @Value to store. If not number or `nil`, will be converted into a string.
function ac.store(key, value) end

---Reads value from session shared Lua/Python storage. This is not a long-term storage, more of a way for different scripts to exchange data.
---Note: if you need to exchange data between Lua scripts, use `ac.connect()` instead. And if despite that you need to exchange data between
---car scripts, make sure to add car index to the key.
---@param key string @Unique key. If starting with “.”, value won’t be shown in Lua Debug app and will be considered temporary and unimportant.
---@return string|number|nil
function ac.load(key) end

---Set texture key to load encoded textures.
---@param key string? @Key to decode subsequently loading textures.
function ac.setTextureKey(key) end

---Encode texture. To load texture later, first call `ac.setTextureKey()`.
---@param filename string @Input filename.
---@param outputFilename string @Should be inside of AC folder.
---@param key string?
---@param applyLz4Compression boolean?
---@return boolean @Returns `false` if file operations failed.
function ac.encodeTexture(filename, outputFilename, key, applyLz4Compression) end

---Sets a callback which will be called when album cover changes.
---@param callback fun(hasCover: boolean)
---@return ac.Disposable
function ac.onAlbumCoverUpdate(callback) end

---Switches to the next track in currently active music player (by simulating media key press).
function ac.mediaNextTrack() end

---Switches to the previous track in currently active music player (by simulating media key press).
function ac.mediaPreviousTrack() end

---Pauses or unpauses current track in currently active music player (by simulating media key press).
function ac.mediaPlayPause() end

---Returns player’s car setup state.
---@return 'legal'|'illegal'|'validating', string? @Returns car setup state and optional reason for setup to be illegal (might be set by car physics script).
function ac.getCarSetupState() end

---Prints message to AC console.
---@param message string?
---@param withoutPrefix boolean? @Default value: `false`.
function ac.console(message, withoutPrefix) end

---Returns `false` if tyres with this short name are illegal in this race. Note: if all of car tyres are illegal, all of them will be legal.
---@param name string
---@return boolean
function ac.areTyresLegal(name) end

---Show message using AC system messages UI. Pass empty `title` and `description` to hide currently shown message, if any.
---
--- Types:
--- - Default: regular message shown on top in white text.
--- - 'illegal': message about an illegal violation. Can be used to warn driver about a crucial mistake, such as lap time
---being invalidated, or wear plank wear exceeding allowed limit. Doesn’t apply any penalties on its own.
---@param title string
---@param description string
---@param type nil|'illegal' @Optional message type.
---@param time number? @Time to show message for in seconds. Default value: 5.
function ac.setMessage(title, description, type, time) end

---Listen to messages, including the ones shown by `ac.setMessage()` and `ac.setIllegalMessage()`.
---@param callback fun(title: string, description: string, type: nil|'illegal', time: number)
---@return ac.Disposable
function ac.onMessage(callback) end

---Use `ac.setMessage()` instead.
---@deprecated
---@param title string
---@param description string
function ac.setSystemMessage(title, description) end

---Return the number of unread chat messages, or 0 in an offline race.
---@return integer
function ac.getUnreadChatMessages() end

---Return distances to the nearest left and right cars in meters within 20 meters, or `nil` if there are no cars nearby or blind spot detection is not available for this car.
---@param carIndex integer @0-based car index.
---@return number?, number?
function ac.getCarBlindSpot(carIndex) end

---Sets given text to the clipboard.
---@param text string
---@return boolean @Returns `false` if failed.
function ac.setClipboardText(text) end

---Sets a callback which will be called when a car teleports somewhere or its state gets reset.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer)
---@return ac.Disposable
function ac.onCarJumped(carIndex, callback) end

---Sets a callback which will be called when a car’s color changes.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer)
---@return ac.Disposable
function ac.onCarColorChanged(carIndex, callback) end

---Sets a callback which will be called when a car completes a lap. Should work for remote cars as well.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer, lapTime: integer, valid: boolean, cuts: integer, lapCount: integer)
---@return ac.Disposable
function ac.onLapCompleted(carIndex, callback) end

---Sets a callback which will be called when a car collides with a wall or another car. Note: collisions in AC are usually lasting a few frames,
---but this callback will only be called once when collision starts (or when index of a car this car collided with has changed). Use
---`ac.getCar().collisionDepth` and similar to analyze the collision in detail. Works in replays as well.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer)
---@return ac.Disposable
function ac.onCarCollision(carIndex, callback) end

---Sets a callback which will be called when config for certain CSP module has changed.
---@param cspModuleID ac.CSPModuleID @ID of a module to monitor.
---@param callback fun() @Callback function.
---@return ac.Disposable
function ac.onCSPConfigChanged(cspModuleID, callback) end

---Sets a callback which will be called when a new screenshot is made.
---@param callback fun()
---@return ac.Disposable
function ac.onScreenshot(callback) end

---Sets a callback which will be called when a command opening a certain section in main menu has been called. More types of pages might be added later.
---@param callback fun(section: 'info'|'setup'|'telemetry'|'time')
---@return ac.Disposable
function ac.onOpenMainMenu(callback) end

---Sets a callback which will be called when list of setups changes.
---@param callback fun()
---@return ac.Disposable
function ac.onSetupsListRefresh(callback) end

---Sets a callback which will be called when setup is loaded or saved. Use `ac.INIConfig.currentSetup()` to load the setup.
---@param callback fun(operation: 'load'|'save', filename: string) @Callback function.
---@return ac.Disposable
function ac.onSetupFile(callback) end

---Works even if collisions are disabled, actually checks collider state live. Invokes ODE OPCODE computation, so don’t use too much.
---@param car0 integer @0-based car index.
---@param car1 integer @0-based car index.
---@return boolean
function ac.areCarsColliding(car0, car1) end

---Check collisions between two shapes. Note: if you want to do something like check a car against a million of powerups on a track, consider doing
---some prefiltering to speed things up. For example, `ac.HashSpace()` can hugely improve performance for such case.
---@param shape1 integer|physics.ColliderType @First entry to check intersection with, either `physics.ColliderType` or a car index.
---@param transform1 mat4x4? @Optional transform for the first entry. If not set, identity for shapes and car transform for cars.
---@param shape2 integer|physics.ColliderType @Second entry to check intersection with.
---@param transform2 mat4x4? @Optional transform for the second entry.
---@return boolean
function ac.areShapesColliding(shape1, transform1, shape2, transform2) end

---Stops functions like `ac.log()` from logging things into CSP log file, in case you need to log a lot. With it, you
--- can use Lua Debug app to see latest log entries.
---@param value boolean? @Default value: `true`.
function ac.setLogSilent(value) end

---Removes `ac.debug()` entries matching filter.
---@param filter string? @Default value: `?`.
function ac.clearDebug(filter) end

---Gets file attributes.
---@param filename path
---@return io.FileAttributes
function io.getAttributes(filename) end

---Reads file content into a string, if such file exists, otherwise returns fallback data or `nil`.
---@param filename path
---@param fallbackData string|nil @Data to return if file could not be read.
---@return string|nil @Returns `nil` if file couldn’t be read and there is no fallback data.
function io.load(filename, fallbackData) end

---Reads file content into a string, if such file exists, otherwise returns fallback data or `nil`. Asynchronous version.
---@param filename path
---@param callback fun(err: string?, response: string?)
function io.loadAsync(filename, callback) end

---Checks if file or directory exists. If you need to know specifically if a file or directory exists, use `io.dirExists(filename)` or `io.fileExists(filename)`.
---@param filename path
---@return boolean
function io.exists(filename) end

---Checks if directory exists. If there is a file in its place, it would return `false`.
---@param filename path
---@return boolean
function io.dirExists(filename) end

---Checks if file exists. If there is a directory in its place, it would return `false`.
---@param filename path
---@return boolean
function io.fileExists(filename) end

---Calculates file size in bytes. Returns -1 if there was an error.
---@param filename path
---@return integer
function io.fileSize(filename) end

---Returns creation time as number of seconds since 1970, or -1 if there was an error.
---@param filename path
---@return integer
function io.creationTime(filename) end

---Returns last access time as number of seconds since 1970, or -1 if there was an error.
---@param filename path
---@return integer
function io.lastAccessTime(filename) end

---Returns last write time as number of seconds since 1970, or -1 if there was an error.
---@param filename path
---@return integer
function io.lastWriteTime(filename) end

---Returns parent path for given filename.
---@param filename string
---@param level integer? @Default value: 1.
---@return string
function io.getParentPath(filename, level) end

---Returns file name path for given filename.
---@param filename string
---@param noExtension boolean? @Default value: `false`.
---@return string
function io.getFileName(filename, noExtension) end

---Checks if file name is acceptable, returns `true` if there are no prohibited symbols in it (unlike `io.isFileNameAcceptable()`, does not allow slashes).
---@param fileName string
---@return boolean
function io.isFileNameAcceptable(fileName) end

---Checks if full file name is acceptable, returns `true` if there are no prohibited symbols in it (unlike `io.isFileNameAcceptable()`, does allow slashes).
---@param filename string
---@return boolean
function io.isFilePathAcceptable(filename) end

---Given an absolute or a relative path, find an actual absolute path. If script doesn’t have I/O access to such file, returns `nil`.
---@param filename path
---@return string|nil
function io.findFile(filename) end

---Loads file from an archive as a string. Archive would remain open for some time to speed up consequent reads. If failed, returns `nil`. Alternatively,
---you can pass ZIP data instead.
---@param zipFilename path
---@param entryFilename string
---@return string
function io.loadFromZip(zipFilename, entryFilename) end

---Computes SHA-256 checksum of a given file, returns result in a callback.
---@param filename path
---@param callback fun(err: string, checksum: string)
function io.checksumSHA256(filename, callback) end

---Returns list of entry names from a ZIP-file.
---@param zipFilename binary?
---@return string[]
function io.scanZip(zipFilename) end

---Returns time in seconds from script start (with high precision).
---@return number @Seconds.
function os.preciseClock() end

---Sets a callback which will be called when CSP itself or a CSP Lua script tries to open an URL. Return `true` if you’re handling URL, so the event would be stopped.
---@param mask string @Regular expression to check URLs against of.
---@param callback fun(url: string): boolean
---@param priority integer? @Smaller values mean script would be the last to get URL (if other scripts wouldn’t intercept it). Default value: 0.
---@return ac.Disposable
function os.onURL(mask, callback, priority) end

---Changes current directory. Any argument `path`, when parsed and found not to be absolute, will be resolved against current directory.
---By default, uses AC root folder. Any change only applies to the current script only. Current path resets when script is reloaded.
---
---Changes behavior of images and assets lookup as well (by default it scans script folder, CSP folder and then root folder looking for a file,
---which might cause some issues and negatively affect performance).
---
--- For scripts without I/O access, only folders script can read from can be used here.
---
--- Note: as of 0.2.6, some API functions might still use AC root folder. This will be fixed in the future, please do not rely on this behavior!
---@param filename path
---@return string
function os.setCurrentFolder(filename) end

---Returns formatted date. Same as `os.date()`, but returned value does not include system timezome.
---@param format string
---@param timestamp integer
---@return string
function os.dateGlobal(format, timestamp) end

---Show a popup message using good old MessageBox. Please do not use it for debugging, instead consider using `ac.log()` and `ac.debug('key', 'value')`
---with in-game Lua Debug App.
---Note: do not rely on this function, most likely it might be removed in the future as obstructing.
---@param msg string
---@param type integer? @Type of MessageBox according to WinAPI. Default value: 0.
---@return integer
function os.showMessage(msg, type) end

---Opens URL in default system browser.
---@param url string
---@param invokeListeners boolean? @Default value: `true`.
function os.openURL(url, invokeListeners) end

---@return number
function ac.getRealTrackHeadingAngle() end

---@return number
function ac.getTimeZoneOffset() end

---@return number
function ac.getTimeZoneDstOffset() end

---@return number
function ac.getTimeZoneBaseOffset() end

---Returns original weather conditions without any filtering or sanity checks. For a faster and more filtered data check `ac.getSim().weatherConditions`.
---@return ac.ConditionsSet
function ac.getConditionsSet() end

---Returns original weather conditions without any filtering or sanity checks. For a faster and more filtered data check `ac.getSim().weatherConditions`.
---@param r ac.ConditionsSet
function ac.getConditionsSetTo(r) end

---Returns floading point number of seconds since 1970/01/01 that can be used for driving track animations in such a way that if time multiplier is set to
---0 or above 1, things would still happen at normal speed, although out of sync with the clock. Ensures to keep things online as well. Currently might not
---work that well with replays, futher updates will improve some edge cases.
---
---Note: if time is still being estimated, returns 0, be sure to check for that case.
---@return number
function ac.getTrackDateTime() end

---Use `ac.getSim()` instead
---@deprecated
---@return ac.StateSim
function ac.getSimState() end

---Use `ac.getUI()` instead
---@deprecated
---@return ac.StateUi
function ac.getUiState() end

---Use `ac.getCar()` instead. Here, index starts with 1! With `ac.getCar()` index starts with 0, to match the rest of API functions
---@param index integer @1-based index.
---@return ac.StateCar?
function ac.getCarState(index) end

---Returns reference to a structure with various information about the state of Assetto Corsa. Very cheap to use.
--- This is a new version with shorter name. Updates once per graphics frame.
---@return ac.StateSim
function ac.getSim() end

---Returns reference to a structure with various information about certain session. Very cheap to use. Note: not all data
--- might be available online.
---@param index integer @0-based index.
---@return ac.StateSession?
function ac.getSession(index) end

---Returns reference to a structure with various information about the state of the UI. Very cheap to use.
---This is a new version with shorter name. Updates once per graphics frame.
---
---Note: this information is about AC UI, not about, for example, a dynamic track texture you might be updating.
---@return ac.StateUi
function ac.getUI() end

---Returns data regarding current triple screen configuration. If AC is not launched in triple screen mode, returns `nil` instead.
---@return ac.StateTriple?
function ac.getTripleConfiguration() end

---Returns reference to a structure with VR-related values, like hands and head positions. Very cheap to use.
---
---Note: currently, accurate values are available with Oculus only.
---@return ac.StateVR?
function ac.getVR() end

---Returns reference to a structure with TrackIR-related values. Very cheap to use.
---@return ac.StateTrackir?
function ac.getTrackIR() end

---Returns additional details on physics state of a car. Not available in replays or for remote cars.
---
---Updates once a frame at graphics rate. If you’re writing a physics script, consider using something else if you need
---to access current state, this thing might be a few physics frames late.
---
---Note: index starts with 0. Make sure to check result for `nil` if you’re accessing a car that might not be there. First car
---with index 0 is always there.
---@param index integer @0-based index.
---@return ac.StateCarPhysics?
function ac.getCarPhysics(index) end

---Returns extras of PS5 DualSense gamepad, such as accelerometer, gyroscope or battery state. Accelerometer and gyroscope values might be different from values reported by `ac.getDualShock()` for different controllers in the same orientation.
---Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.
---@param gamepadIndex integer @0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@return ac.StateDualsense?
function ac.getDualSense(gamepadIndex) end

---Returns a structure with state of PS5 DualSense LEDs, change it to alter its state. Changes remain for some time, keep calling it for continuos adjustments.
---Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.
---@param gamepadIndex integer @0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param priority number? @If multiple scripts try to set LEDs at the same time, the call with highest priority will be applied. Default value: 0.
---@param holdFor number? @Time to keep the changes for in seconds. Default value: 0.5.
---@return ac.StateDualsenseOutput? @Returns `nil` if there is no applicable controller, make sure to check for it.
function ac.setDualSense(gamepadIndex, priority, holdFor) end

---Returns extras of PS4 DualShock gamepad (or Nintendo gamepads), such as accelerometer, gyroscope or battery state. Accelerometer and gyroscope values might be different from values reported by `ac.getDualSense()` for different controllers in the same orientation.
---Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.
---@param gamepadIndex integer @0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@return ac.StateDualshock?
function ac.getDualShock(gamepadIndex) end

---Returns a structure with state of PS4 DualShock (or Nintendo) LEDs, change it to alter its state. Changes remain for some time, keep calling it for continuos adjustments.
---Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.
---@param gamepadIndex integer @0-based index, from 4 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param priority number? @If multiple scripts try to set LEDs at the same time, the call with highest priority will be applied. Default value: 0.
---@param holdFor number? @Time to keep the changes for in seconds. Default value: 0.5.
---@return ac.StateDualshockOutput? @Returns `nil` if there is no applicable controller, make sure to check for it.
function ac.setDualShock(gamepadIndex, priority, holdFor) end

---Returns a structure with state of Xbox One gamepad, change it to alter its state. Changes remain for some time, keep calling it for continuos adjustments.
---Note: if you’re writing a car script, first argument will be ignored and instead the effect would be applied to gamepad controlling the car if possible.
---@param gamepadIndex integer @0-based index, from 0 to 3.
---@param priority number? @If multiple scripts try to set LEDs at the same time, the call with highest priority will be applied. Default value: 0.
---@param holdFor number? @Time to keep the changes for in seconds. Default value: 0.5.
---@return ac.StateXboxOutput? @Returns `nil` if there is no applicable controller, make sure to check for it.
function ac.setXbox(gamepadIndex, priority, holdFor) end

---Returns velocity (in world coordinates) of a car point. If there is no such car or physics currently available, returns vector with zeroes.
---@param carIndex integer @0-based car index.
---@param position vec3 @Point of force application.
---@param posLocal boolean|`true`|`false` @If `true`, position is treated like position relative to car coordinates, otherwise as world position.
---@return vec3
function physics.getPointVelocity(carIndex, position, posLocal) end

---@param carIndex integer @0-based car index.
---@param corner integer @0-based wheel index.
---@return number
function physics.getExtendedSuspensionTravel(carIndex, corner) end

---@param carIndex integer @0-based car index.
---@param corner integer @0-based wheel index.
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
---@field isBlown boolean
---@field isHot boolean
---@field isSpecialSurface boolean @Do not play skids audio if this value is `true`.
---@field surfaceType ac.SurfaceType @Basic type hint used for visuals.
---@field surfaceExtendedType ac.SurfaceExtendedType @Extended type hint, more types will be added later.

---@class ac.StateCar : ClassBase
---@field mass number @Car mass in kg.
---@field graphicsOffset vec3 @Graphics offset from car.ini
---@field graphicsPitchRotation number @Graphics pitch rotation in radians from car.ini
---@field graphicsToPhysicsTransform mat4x4 @Graphics-to-physics transform based on graphics offset and pitch rotation from car.ini
---@field physicsToGraphicsTransform mat4x4 @Physics-to-graphics transform based on graphics offset and pitch rotation from car.ini
---@field steerLock number @Maximum steering wheel angle in degrees.
---@field maxFuel number @Maximum amount of fuel in liters.
---@field exposureOutside number @Outboard exposure from car.ini
---@field exposureInside number @Onboard exposure from car.ini
---@field shakeMultiplier number @SHAKE_MUL value from car.ini
---@field headlightsColor rgb
---@field customCarColor rgb @Custom car color selected online, or `math.nan` if color is the default one
---@field aabbCenter vec3 @Center of AABB (calculated from LOD D or collider mesh).
---@field aabbSize vec3 @Size of AABB in meters (calculated from LOD D or collider mesh).
---@field index integer @0-based (0 for first car).
---@field gearCount integer @Excluding neutral and reverse. Physics-only (see `ac.CarState.physicsAvailable`)
---@field turboCount integer @Physics-only (see `ac.CarState.physicsAvailable`)
---@field tractionType integer @0 for rwd, 1 for fwd, 2 for awd, 3 for new awd, -1 for N/A. Physics-only (see `ac.CarState.physicsAvailable`)
---@field enginePosition integer @0 for unspecified, 1 for front, 2 for rear, 3 for mid. Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakesBiasLimitDown number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakesBiasLimitUp number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakesBiasStep number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field maxRelativePlankWear number @From 0 to 1. Physics-only (see `ac.CarState.physicsAvailable`), 0 if not available.
---@field year integer @Manufactoring year.
---@field hShifter boolean @True if car has H-shifter in its physics data.
---@field adjustableTurbo boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakesCockpitBias boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field extendedPhysics boolean @True if extended car physics is active.
---@field isRacingCar boolean @True for racing cars (cars with class different from “road” or “street”).
---@field isRallyCar boolean @Car counts as a rally car if it has a corresponding tag or “rally” in its name.
---@field isDriftCar boolean @Car counts as a drift car if it has a corresponding tag or “drift” in its name.
---@field isOpenWheeler boolean @Check is based on car tags.
---@field isEngineDiesel boolean @Check is based on car tags.
---@field isKunosCar boolean @True if car is standard, from Kunos.
---@field prefersImperialUnits boolean @True for cars from UK or USA.
---@field headlightsAreHeadlights boolean @If set to `false`, headlights do something else (like change display mode).
---@field hasLowBeams boolean @If set to `false`, low beams are not present (as in, headlights operate in a single mode).
---@field isLeftHandDrive boolean @If set to `true`, steering wheel is on the left side.
---@field sirenHorn boolean @If set to `true`, horn is working in siren mode (press to toggle).
---@field hasFlashingLights boolean
---@field hasCockpitSwitchForUserSpeedLimiter boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field hasHornAudioEvent boolean
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
---@field rpm number @Engine RPM.
---@field rpmLimiter number @RPM limiter threshold, if exists.
---@field rpmMinimum number @Minimum RPM (or -1 if physics not available).
---@field speedKmh number @Current speed in km/h.
---@field speedMs number @Current speed in m/s.
---@field turboBoost number @Turboboost value, from 0 and upwards.
---@field drivetrainSpeed number @Speed delivered to wheels.
---@field waterTemperature number @Approximation of water temperature in °C done by original AC.
---@field minHeight number @Minimum allowed ride height in meters.
---@field restrictor number @Restrictor.
---@field ballast number @Ballast in kg.
---@field ping integer @Ping in ms (or -1 if not available).
---@field cgHeight number
---@field wheelsOutside integer @Number of wheels outside of allowed area.
---@field engineLifeLeft number @Engine life left (1000 for new engine, breaks at 0).
---@field dirt number @Body dirt level from 0 to 1.
---@field damage number[] @Damage values from 0 to maximum collision speed in km/h for four different zones (fifth one is not really used). 5 items, starts with 0.
---@field gearboxDamage number @Gearbox damage (0 for new gearbox, 1 for non-functional).
---@field nodeIndex integer @Car index if 0 is nearest to camera, 1 is second nearest and so on.
---@field visibleIndex integer @Car index if 0 is nearest to camera and visible in main camera, 1 is second nearest visible and so on. Cars outside of main camera would have 255 here.
---@field activeLOD integer @0-based index of visible LOD.
---@field distanceToCamera number @Distance to camera in meters.
---@field splinePosition number @Position of car along the track, 0 for starting line, 1 for finishing line.
---@field driftPoints number @Drift points (calculated in any racing mode).
---@field driftInstantPoints number @Drift instant points (calculated in any racing mode).
---@field driftComboCounter integer @Drift combo counter (calculated in any racing mode).
---@field collisionDepth number @How deep is current collision, in meters (generally it’s better to use change of car speed to estimate collision intensity though, depth is much less predictable).
---@field collisionPosition vec3 @Coordinates of current collision in car space.
---@field collidedWith integer @0 for track, non-zero for cars.
---@field lapCutsCount integer @Number of lap cuts in current lap. Physics-only (see `ac.CarState.physicsAvailable`)
---@field lastLapCutsCount integer @Number of lap cuts in last lap.
---@field aiLevel number @AI level from 0 to 1 (or -1 if there is no AI).
---@field aiAggression number @AI aggression from 0 to 1 (or -1 if there is no AI). Note: aggression level set in a launcher will be multiplied by 0.95, so 100% aggression will show up as 0.95 here.
---@field aiRainTyres number @`True` if currently AI is using rain tyres.
---@field currentSplits integer[] @Time for different splits of current lap, in milliseconds. Items start with 0. To get number of elements, use `#state.currentSplits`.
---@field lastSplits integer[] @Time for different splits of last lap, in milliseconds. Items start with 0. To get number of elements, use `#state.lastSplits`.
---@field bestSplits integer[] @Best splits times (and not splits of best lap), in milliseconds, unlike other split lists, this one is populated with zeroes for sectors without time from the start. Items start with 0. To get number of elements, use `#state.bestSplits`.
---@field bestLapSplits integer[] @Splits times of best lap (not necessarily best split times in itself), in milliseconds. Items start with 0. To get number of elements, use `#state.bestLapSplits`.
---@field wheels ac.StateWheel[] @4 items, starts with 0.
---@field extrapolatedMovement boolean @If set to false and you’re adding objects moving close to cars, use ac.CarState.timestamp to estimate dt in such a way that it would match car physics time
---@field isActive boolean @True if car is currently active (changes to `false` for disconnected cars if server does not have them visible).
---@field isConnected boolean @True if car is currently connected (cars can be disconnected online), or if car is not a remote one.
---@field isRemote boolean @True if car is controlled by another player online.
---@field isAIControlled boolean @True if car is controlled by AI (or that autopilot thing).
---@field isUserControlled boolean @True if car is controlled by user (controls could be disabled completely).
---@field isLapValid boolean @True if current lap is valid. Physics-only (see `ac.CarState.physicsAvailable`)
---@field isLastLapValid boolean @True if last lap is valid.
---@field isCameraOnBoard boolean @True if camera is inside this car.
---@field isInPitlane boolean @True if car is in pits area.
---@field isInPit boolean @True if car is parked in its pit stop place.
---@field isRetired boolean
---@field isEngineLimiterOn boolean
---@field isGearGrinding boolean
---@field hasTurningLights boolean @There could be other components linked to turn signals state, but this variable is about emissives tied to turn signals.
---@field headlightsActive boolean
---@field brakeLightsActive boolean
---@field flashingLightsActive boolean
---@field hornActive boolean
---@field focused boolean
---@field focusedOnInterior boolean
---@field useInternalAudio boolean @If `true`, `…_int` variants of audio events are used.
---@field isHidingLabels boolean @If you’re drawing a map, don’t show cars with this flag on (those would be disconnected cars or, for example, cars acting like traffic). Flag can change during the race
---@field isDriftBonusOn boolean @Drift bonus flag (calculated in any racing mode).
---@field isDriftValid boolean @Is drift valid (calculated in any racing mode).
---@field isRaceFinished boolean @Car has finished the race. Since 0.2.8, non-race sessions are never marked as finished.
---@field isDriverVisible boolean @Driver can be hidden by apps or Lua scripts too.
---@field isDriverDoorOpen boolean
---@field isDriverSeatbeltOn boolean @Same as `SEATBELT` input.
---@field hazardLights boolean
---@field turningLeftLights boolean
---@field turningRightLights boolean
---@field turningLeftOnly boolean
---@field turningRightOnly boolean
---@field lowBeams boolean @`true` if low beams switch is currently active (doesn’t depend on the state of headlights, just on the switch state).
---@field highBeams boolean @`true` if high beams are currently active (either with headlights active, or with high beams flashing).
---@field extraA boolean
---@field extraB boolean
---@field extraC boolean
---@field extraD boolean
---@field extraE boolean
---@field extraF boolean
---@field extraG boolean
---@field extraH boolean
---@field extraI boolean
---@field extraJ boolean
---@field extraK boolean
---@field extraL boolean
---@field extraM boolean
---@field extraN boolean
---@field extraO boolean
---@field extraP boolean
---@field extraQ boolean
---@field extraR boolean
---@field extraS boolean
---@field extraT boolean
---@field kersCharging boolean
---@field turningLightsActivePhase boolean
---@field anyFlamesActive boolean @`true` if any of car flames are currently shown.
---@field justJumped boolean @Changes to `true` for a single frame when car jumps.
---@field resetCounter integer @Increases by 1 each time a car resets.
---@field kersCharge number
---@field kersInput number
---@field kersCurrentKJ number
---@field kersMaxKJ number
---@field kersLoad number
---@field distanceDrivenTotalKm number
---@field distanceDrivenSessionKm number
---@field poweredWheelsSpeed number @Can be used for speedometers if they’re not using GPS and instead use powered wheels, value in km/h.
---@field batteryVoltage number
---@field oilPressure number
---@field oilTemperature number
---@field exhaustTemperature number
---@field wiperModes integer @Number of wiper modes, no less than 1 (wipers disabled state counts like a 0th mode, all cars would have that).
---@field wiperMode integer @Stores previous active mode when wipers are disabled, but still have a loop to complete.
---@field wiperSelectedMode integer @Actual selected mode.
---@field wiperSpeed number
---@field wiperProgress number
---@field bodyWetness number @How wet is car exterior, approximation from 0 to 1 (actual wetness is in 2D map).
---@field compass number @Angle of where car is heading, from 0 to 360 (0/360 for north, 90 for east, etc.)
---@field lapTimeMs integer @Time of current lap in milliseconds.
---@field bestLapTimeMs integer @Time of best lap of this session in milliseconds.
---@field previousLapTimeMs integer @Time of last lap in milliseconds.
---@field lapCount integer @Number of completed laps in this session (within connection online), including spoiled laps.
---@field currentSector integer @0-based index of current track split.
---@field previousSectorTime integer @Time of previous split in milliseconds, or 0 if it’s a first split.
---@field racePosition integer @Position of a car in the race, 1 for first, 2 for second, etc.
---@field drivenInRace number @Distance driven in current race in meters (can be used for estimating race position, based on number of completed laps and current lap progress, in practice or qualify session resets each lap).
---@field estimatedLapTimeMs integer @Based on best lap and performance meter (delta of this lap time vs best lap time).
---@field performanceMeter number @Performance meter comparing this lap with best, seconds.
---@field performanceMeterSpeedDifferenceMs number @In AC performance app, there is that red/green bar, it shows this value.
---@field sessionLapCount integer
---@field compoundIndex integer @Index of currently selected tyre compounds.
---@field sessionID integer @Index of a car in an online race (differs from regular car index: sessionID is an index in entry list, but car.index of your car is always zero)
---@field physicsAvailable boolean @Cars in replays, or remote cars online do not have regular physics component running, so some data will be missing. Such fields are marked as physics-only in comments.
---@field speedLimiterInAction boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field absInAction boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field tractionControlInAction boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field hasUserBrakeBias boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field hasCockpitMGUHMode boolean
---@field hasCockpitERSDelivery boolean
---@field hasCockpitERSRecovery boolean
---@field drsPresent boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field drsAvailable boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field drsActive boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field kersPresent boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field kersHasButtonOverride boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field kersButtonPressed boolean @Physics-only (see `ac.CarState.physicsAvailable`)
---@field mguhChargingBatteries boolean
---@field manualPitsSpeedLimiterEnabled boolean @Returns `true` if manual pits speed limiter is currently active. Physics-only (see `ac.CarState.physicsAvailable`)
---@field userSpeedLimiterEnabled boolean @Returns `true` if custom physics speed limiter is currently active. Not the same as pit limiter (or manually operated speed limiter). Physics-only (see `ac.CarState.physicsAvailable`)
---@field autoShift boolean @Returns `true` if automatic shifting is active. Physics-only (see `ac.CarState.physicsAvailable`)
---@field autoClutch boolean @Returns `true` if auto-clutch is active. Physics-only (see `ac.CarState.physicsAvailable`)
---@field mgukDelivery integer @Starts with 0.
---@field mgukDeliveryCount integer
---@field mgukRecovery integer @From 0 to 10 (for 100%).
---@field tractionControlMode integer @0 for disabled TC. Physics-only (see `ac.CarState.physicsAvailable`)
---@field absMode integer @0 for disabled ABS. Physics-only (see `ac.CarState.physicsAvailable`)
---@field engineBrakeSettingsCount integer
---@field currentEngineBrakeSetting integer
---@field fuelPerLap number @Uses original AC fuel estimation. Zero until value is available. Physics-only (see `ac.CarState.physicsAvailable`)
---@field differentialPreload number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field differentialCoast number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field differentialPower number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field awdFrontShare number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field awdCenterLock number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field drivetrainTorque number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field drivetrainPower number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field brakeBias number @Physics-only (see `ac.CarState.physicsAvailable`)
---@field speedLimiter number @Returns pit limiter speed in km/h (80 by default unless session specified different settings) or 0 if no limit is currently active. Physics-only (see `ac.CarState.physicsAvailable`)
---@field turboBoosts number[] @Values per each turbo, up to 8 (if there are less turbos in a car, rest are zeroes). Physics-only (see `ac.CarState.physicsAvailable`) 8 items, starts with 0.
---@field turboWastegates number[] @Values per each turbo, up to 8 (if there are less turbos in a car, rest are zeroes). Physics-only (see `ac.CarState.physicsAvailable`) 8 items, starts with 0.
---@field tractionControl2 number
---@field fuelMap integer @Current fuel map preset.
---@field steerTorque number
---@field ffbSteerAssist number @Value of `STEER_ASSIST` from car.ini. Physics-only (see `ac.CarState.physicsAvailable`)
---@field ffbBase number @Value of `FFMULT` from car.ini. Physics-only (see `ac.CarState.physicsAvailable`)
---@field ffbFinal number
---@field ffbPure number
---@field ffbMultiplier number @For 100% FFB multiplier, this value is set to 1.
---@field aeroLiftFront number @Aero lift coefficient in front.
---@field aeroLiftRear number @Aero lift coefficient in rear.
---@field aeroDrag number @Aero drag coefficient.
---@field caster number @Caster angle in degrees.
---@field rideHeight number[] @0 for front, 1 for rear. 2 items, starts with 0.
---@field p2pStatus integer
---@field p2pActivations integer
---@field altitude number @Altitude in meters above sea level.
---@field ambientOcclusion number @Ambient occlusion value computed from prebaked data from track’s VAO patch. 0 for car fully shadowed (in a tunnel), 1 for car outside. Affected by WeatherFX adjustments.
---@field rawAmbientOcclusion number @Ambient occlusion value computed from prebaked data from track’s VAO patch. 0 for car fully shadowed (in a tunnel), 1 for car outside. Not affected by WeatherFX adjustments.
---@field carCamerasCount integer @Number of F6 cameras.
---@field currentPenaltyType ac.PenaltyType @Current penalty type (set only for user car).
---@field currentPenaltyParameter integer @Parameter of current penalty (role depends on penalty type).
---@field extraIconsCount integer @Extra driver icons set with `ui.UserIconsLayer()`. To draw, use `carN::special::driver::X` texture name.

---@class ac.StateLeaderboardEntry : ClassBase
---@field car ac.StateCar
---@field totalTimeMs integer
---@field bestLapTimeMs integer
---@field laps integer
---@field raceMode boolean
---@field blackFlagged boolean
---@field hasCompletedLastLap boolean

---@class ac.StateSession : ClassBase
---@field type ac.SessionType
---@field laps integer
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
---@field isFullscreen boolean @A value from AC video settings, does not change live.
---@field isVSyncActive boolean @A value from AC video settings, does not change live.
---@field isPostProcessingActive boolean @True if YEBIS post-processing is active.
---@field isVRMode boolean @True if AC was launched with either Oculus or OpenVR mode (not necessarily successfully connected).
---@field isOculusMode boolean @True if AC was launched with Oculus mode (not necessarily successfully connected).
---@field isOpenVRMode boolean @True if AC was launched with OpenVR mode (not necessarily successfully connected).
---@field isTripleMode boolean @True if AC was launched in triple screen mode.
---@field isCustomVideoMode boolean @True if AC was launched with custom screen mode (fisheye, 360°, splitscreen).
---@field isVRConnected boolean @True if AC runs in either Oculus or OpenVR mode and initialization went successfully.
---@field staticReflections boolean @True if reflection cubemap does not update live and uses custom cubemap.kn5 instead of track model
---@field directMessagingAvailable boolean @True if it’s an online race and server supports TCP exchange of extra data between clients (allows to send online events more frequently).
---@field directUDPMessagingAvailable boolean @True if it’s an online race and server supports UDP exchange of extra data between clients (allows to send UDP online events).
---@field allowTyreBlankets boolean
---@field isReplayOnlyMode boolean @True if AC is ran in replay mode, without any racing.
---@field isOnlineRace boolean @True if it’s an online race.
---@field isShowroomMode boolean @True if AC has been launched in showroom mode.
---@field isPreviewsGenerationMode boolean @True if AC has been launched to generate previews.
---@field freeCameraAllowed boolean @Can be changed in AC video settings.
---@field isPitsSpeedLimiterForced boolean @By default `true`, but servers or offline races can alter session settings and disable this thing.
---@field customAISplinesAllowed boolean @Switches to `false` if `physics.setAISpline()` is not allowed in this session
---@field isFSRActive boolean
---@field isTripleFSRActive boolean
---@field isLinearColorSpaceActive boolean
---@field allowedTyresOut integer
---@field resultScreenTime number @Results screen time in seconds (available online, -1 offline).
---@field raceOverTime number @Race over time in seconds (available online, -1 offline).
---@field mechanicalDamageRate number @In 0…1 range.
---@field tyreConsumptionRate number @In 0…1 range.
---@field fuelConsumptionRate number @In 0…1 range.
---@field gravity number @Negative value (pointing down), -9.81 in pretty much all cases (custom gravity might be enabled though)
---@field inputMode ac.UserInputMode @Input mode selected by user.
---@field windowHandle integer @Main window handle.
---@field currentVAOMode ac.VAODebugMode
---@field neutralSunTrajectoryTimestamp integer @Timestamp for sun trajectory used with seasons disabled.
---@field isMakingScreenshot boolean @If `true`, currently AC is doing an accumulation screenshot. You won’t be able to move camera, grabbed camera will be paused, replay position seeking and more will be postponed, but ideally just don’t do things that could mess up a screenshot in this mode.
---@field time number @Time in milliseconds counting from the start of Assetto Corsa.
---@field gameTime number @Time in seconds counting from the start of Assetto Corsa (same as .time, but divided by 1000, kept for compatibility)
---@field systemTime integer @System timestamp (time in seconds), pretty much the same as os.time()
---@field frame integer @Index of a current render frame.
---@field cameraPosition vec3
---@field cameraPositionDelta vec3 @How much camera has moved since the previous render step.
---@field cameraLook vec3 @Points forward (there was some confusion with older API).
---@field cameraUp vec3
---@field cameraSide vec3
---@field cameraFOV number @Returns current camera FOV in degrees. In VR, always returns 90°
---@field cameraClipNear number @Distance to near clipping plane in meters.
---@field cameraClipFar number @Distance to far clipping plane in meters.
---@field cameraDOFFactor number
---@field cameraDOFFocus number
---@field cameraExposure number
---@field exposureMultiplier number @One controllable by Page Up/Page Down.
---@field carsCount integer @No less than 1: at least a single car would always be present.
---@field closelyFocusedCar integer @0-based index, or -1 if there is no focused car (for example, with track camera or with free camera far from other cars).
---@field focusedCar integer @0-based index, or -1 if there is no focused car, unlike `.closelyFocusedCar` returns index of a car with track camera as well
---@field dt number @Delta time in seconds, 0 when paused, affected by replay slow motion and fast forwarding.
---@field isPaused boolean @If `true`, AC is currently paused.
---@field isInMainMenu boolean @If `true`, main menu is currently active.
---@field isLookingAtSessionResults boolean @If `true`, session results are being shown.
---@field needsDPad boolean @If `true`, D-pad buttons are not used by their main bindings, but instead used by things like Quick Pits menu.
---@field isLive boolean @If `true`, simulation is currently running (not paused and not in replay mode).
---@field isFreeCameraOutside boolean @Set to `true` if camera is either free or orbit (F7/F5) and not inside an interior.
---@field isReplayActive boolean @True in replays (with CSP tweaks, replays might be active online too).
---@field isFocusedOnInterior boolean @True if camera is currently inside a car.
---@field isTripleScreenAvailable boolean @True if current camera allows for triple screen view.
---@field controlsWithShifter boolean @True if current control scheme is using H-shifter.
---@field isVirtualMirrorActive boolean
---@field hideSteeringWheel boolean @True if hiding steering wheel option is active.
---@field hideArmsInCockpit boolean @True if hiding arms in cockpit option is active.
---@field isVirtualMirrorForced boolean
---@field isWindowForeground boolean @True if AC window is currently active (focused and in front of other windows).
---@field isWeatherFXActive boolean
---@field isVAOPatchLoaded boolean
---@field orbitOnboardCamera boolean @True if F5 camera acts as an orbit camera.
---@field cameraJumped boolean @True if camera has just suddenly moved.
---@field isMouseSteeringActive boolean @True if mouse steering is currently active.
---@field ambientLightingMultiplier number
---@field ambientTemperature number @Air temperature.
---@field roadTemperature number @Road temperature.
---@field lightSuggestion number @If WeatherFX style thinks it’s a good time to turn on headlights, this value will increase to 1, otherwise 0.
---@field roadGrip number @Current track grip from 0 to 1.
---@field windSpeedKmh number @Current wind speed in km/h ,might change live.
---@field windVelocityKmh vec2 @Wind velocity relative to game space.
---@field windDirectionDeg number @Wind direction in real world space (taking track heading angle into account).
---@field rainIntensity number
---@field rainWetness number
---@field rainWater number
---@field bestLapTimeMs integer @Time of best lap (global), or 0 if not set.
---@field timeTotalSeconds number @Number of seconds from midnight, not rounded.
---@field timeHours integer @Number of hours from midnight, rounded down.
---@field timeMinutes integer @Number of minutes in current hour, rounded down.
---@field timeSeconds integer @Number of seconds in current minute, rounded down.
---@field timeMultiplier number @Time multiplier set in race conditions. Online, it’s either 0 with basic conditions, averaged with WeatherFX conditions, or averaged based on timestamps sent by the live conditions plugin (in that case, it might even be negative)
---@field timestamp integer @Timestamp for in-game time (whole number seconds since 01/01/1970 within current timezone, not in UTC0).
---@field dayOfYear integer @Returns number of current day in the year, from 1 to 366.
---@field raceFlagType ac.FlagType
---@field raceFlagCause integer @0-based index of a car that triggered blue or yellow flag, or -1.
---@field isSessionStarted boolean
---@field isSessionFinished boolean
---@field raceSessionType ac.SessionType @Type of current session.
---@field timeToSessionStart number @Time to session start in milliseconds, or -1 if not available.
---@field sessionTimeLeft number @Remaining session time in milliseconds.
---@field currentSessionIndex integer @0-based index of current session (`.sessions` store more details about each session)
---@field sessionsCount integer
---@field leaderLapCount integer @Not available in replays yet (returns 0).
---@field trackLengthM number @Track length in meters, as defined by AI spline.
---@field speedLimitKmh number @Speed limit in pits in this session (80 in most cases, but session tweaks might alter the value).
---@field fps number @Current number of frames per second.
---@field fpsCapped number
---@field physicsLate number
---@field cpuOccupancy integer
---@field cpuTime number
---@field firstPersonCameraFOV number @Current value for first person camera FOV in degrees. Global value, applying for all cars.
---@field cameraMode ac.CameraMode
---@field driveableCameraMode ac.DrivableCamera
---@field carCameraIndex integer @0-based index of currently active car camera (if `.cameraMode` is set to `ac.CameraMode.Car`). To find out how many ofd those cameras there are, use `ac.getCar(sim.focusedCar).carCamerasCount`
---@field trackCamerasSetsCount integer
---@field trackCamerasSet integer @0-based index of currently active track cameras set.
---@field audioMasterVolume number
---@field whiteReferencePoint number @Brightness of objects that would look white on-screen, such as UI in VR or driver name tags. You can also use it as a divider to adjust brightness of virtual mirrors (if you are not using postprocessing for virtual mirrors).
---@field specialEvent boolean @One of those archievment challenges is active.
---@field isTimedRace boolean
---@field penaltiesEnabled boolean
---@field fixedSetup boolean
---@field leaderLastLap boolean
---@field timeRaceEnded boolean
---@field timeRaceLastLap boolean
---@field timeRaceAdditionalLap boolean
---@field idealLineShown boolean
---@field damageDisplayerShown boolean
---@field driverNamesShown boolean
---@field isAdmin boolean @Changes to true if user signs up as admin using that new chat app.
---@field sentAdminCommand boolean @Changes to true once user sends a command starting with “/admin”.
---@field pitsSpeedLimit number @Maximum speed allowed in pits in km/h. Regular value is 80, but servers might change it
---@field pitWindowStartTime number @If non-zero, start of mandatory pit time window (to get current time, use `.time`)
---@field pitWindowEndTime number @If non-zero, end of mandatory pit time window (to get current time, use `.time`)
---@field replayFrameMs number @Time of each replay frame in milliseconds.
---@field timeSinceLastUDPPacket number @Time since last UDP packet in seconds. Returns -1 outside of online session (change in CSP 0.2.7).
---@field replayFrames integer @Number of recorded replay frames.
---@field replayCurrentFrame integer @0-based index of current replay frame.
---@field replayPlaybackRate number @0-based index of current replay frame.
---@field weatherType ac.WeatherType @Current weather type, set by WeatherFX controller or guessed from weather name.
---@field weatherSkyOcclusion number @Estimates sky occlusion based on current weather type.
---@field baseAltitude number @Altitude in meters above sea level associated with Y=0 level.
---@field currentQuickPitPreset integer @0-based index of selected Quick Pits menu preset.
---@field connectedCars integer @Number of currently connected cars.
---@field randomSeed integer @Synced between clients online.
---@field equinoxSunTrajectory boolean @True if sun moves as if current date is 20th of March rather than the actual date (used with seasons disabled).
---@field explicitDateSet boolean @True if explicit date is set (usually activates seasons if their behavior is set to default “automatic”).
---@field lapSplits number[] @Normalized positions of track splits. Items start with 0. To get number of elements, use `#state.lapSplits`.
---@field handshakeServerTime number @Server time of the handshake, in milliseconds.
---@field currentServerTime number @Current server time (synced on all clients), in milliseconds. Resets to 0 when new race session (P/Q/R) starts. 0 in offline races.
---@field currentSessionTime number @Current session time (synced on all clients), in milliseconds. Resets to 0 when new race session (P/Q/R) starts. Not 0 in online sessions. Might be negative before a session start.
---@field skyColor rgb @Sky color.
---@field horizonColor rgb @Horizon color.
---@field fogColor rgb @Fog color.
---@field lightColor rgb @Light (sun or moon) color.
---@field lightDirection vec3 @Light (sun or moon) direction.
---@field originShift vec3 @Graphics space offset it meters (always zeroes if “Origin shift” option is disabled).
---@field weatherConditions ac.ConditionsSet @Weather conditions after a sanity check filter.

---@class ac.StateUi : ClassBase
---@field uiScale number @UI scale. Usually scripts shouldn’t worry about it, but just in case
---@field useImperialUnits boolean @If `true`, user would prefer to see imperial units in UI.
---@field accentColor rgbm @Theme-defined accent color.
---@field windowSize vec2 @Size of AC UI window (affected by UI scale).
---@field mousePos vec2 @Mouse position within an AC UI window (affected by UI scale).
---@field dt number @Time between frames in seconds (not affected by pausing or replay speed modifier).
---@field mouseWheel number @Mouse wheel Vertical: 1 unit scrolls about 5 lines text.
---@field isMouseLeftKeyClicked boolean @Left mouse button was just pressed.
---@field isMouseMiddleKeyClicked boolean @Middle mouse button was just pressed.
---@field isMouseRightKeyClicked boolean @Right mouse button was just pressed.
---@field isMouseLeftKeyDoubleClicked boolean @Left mouse button was just double clicked.
---@field isMouseMiddleKeyDoubleClicked boolean @Middle mouse button was just double clicked.
---@field isMouseRightKeyDoubleClicked boolean @Right mouse button was just double clicked.
---@field isMouseLeftKeyDown boolean @Left mouse button is currently held.
---@field isMouseMiddleKeyDown boolean @Middle mouse button is currently held.
---@field isMouseRightKeyDown boolean @Right mouse button is currently held.
---@field ctrlDown boolean @Keyboard modifier pressed: Control.
---@field shiftDown boolean @Keyboard modifier pressed: Shift.
---@field altDown boolean @Keyboard modifier pressed: Alt.
---@field superDown boolean @Keyboard modifier pressed: Cmd/Super/Windows.
---@field wantCaptureMouse boolean @If your script is listening to mouse events, you might need to disable this functionality if this value is `true` — it means mouse is currently captured by some IMGUI element (for example, dragging happens).
---@field wantCaptureKeyboard boolean @If your script is listening to keyboard events, you might need to disable this functionality if this value is `true` — it means keyboard is currently captured by some IMGUI element (for example, user enters text in a text box).
---@field vrController boolean @If true, mouse is currenly controlled by VR controller, so its precision might be lower.
---@field appsHidden boolean @True if apps are hidden by Ctrl+H hotkey, with a GUI module setting, by a Lua script getting exclusive access over it.
---@field uiHidden boolean @True if UI is hidden with a GUI module setting or by a Lua script getting exclusive access over it.
---@field framerate number @UI framerate estimation, in frame per second. Solely for convenience. Rolling average estimation based on IO.DeltaTime over 120 frames
---@field metricsRenderVertices integer @Vertices output during last call to Render().
---@field metricsRenderIndices integer @Indices output during last call to Render() = number of triangles * 3.
---@field metricsRenderWindows integer @Number of visible windows.
---@field metricsActiveWindows integer @Number of active windows.
---@field metricsRenderCommands integer @Number of draw calls.
---@field mouseDelta vec2 @Mouse delta. Note that this is zero if either current or previous position are invalid (-FLT_MAX,-FLT_MAX), so a disappearing/reappearing mouse won't have a huge delta.
---@field currentDesktop integer @Current desktop, from 0 to 3.

---@class ac.StateTripleItem : ClassBase
---@field left vec2
---@field right vec2
---@field height number
---@field xFrom number
---@field xTo number
---@field xWidth number

---@class ac.StateTriple : ClassBase
---@field screens ac.StateTripleItem[] @3 items, starts with 0.

---@class ac.StateVRHand : ClassBase
---@field transform mat4x4
---@field triggerIndex number
---@field triggerHand number
---@field thumbstick vec2
---@field active boolean
---@field thumbUp boolean
---@field indexPointing boolean
---@field busy boolean @Set to true if hand is already going something, like grabbing an object. If so, don’t do any more grabbing (and don’t forget to call `ac.setVRHandBusy()` when you do)
---@field openVRButtons integer @OpenVR-specific buttons.
---@field openVRTouches integer @OpenVR-specific touches.
---@field openVRAxis vec2[] @OpenVR-specific touches. 5 items, starts with 0.

---@class ac.StateVR : ClassBase
---@field headTransform mat4x4
---@field headActive boolean
---@field oculusButtons integer @Oculus-specific buttons.
---@field oculusTouches integer @Oculus-specific touches.
---@field activeHand integer @Index of a hand that is actively moving, or -1.
---@field hands ac.StateVRHand[] @2 items, starts with 0.

---@class ac.StateTrackir : ClassBase
---@field position vec3
---@field rotation vec3

---@class ac.StateDualsenseTouch : ClassBase
---@field delta vec2
---@field pos vec2
---@field id integer
---@field down boolean

---@class ac.StateDualsense : ClassBase
---@field accelerometer vec3
---@field gyroscope vec3
---@field battery number
---@field touches ac.StateDualsenseTouch[] @2 items, starts with 0.
---@field batteryCharging boolean
---@field batteryFullyCharged boolean
---@field headphonesConnected boolean
---@field connected boolean

---@class ac.StateDualsenseOutput : ClassBase
---@field lightBar rgbm
---@field microphoneLED integer @0 for disabled, 1 for enabled, 2 for flashing.
---@field playerLEDsBrightness integer @0 for max, 1 for medium, 2 for low.
---@field disableLEDs boolean
---@field playerLEDsFade boolean
---@field playerLEDs boolean[] @5 items, starts with 0.

---@class ac.StateDualshockTouch : ClassBase
---@field delta vec2
---@field pos vec2
---@field id integer
---@field down boolean

---@class ac.StateDualshock : ClassBase
---@field type ac.GamepadDualShockType
---@field deviceColor rgbm @Only for Nintendo devices.
---@field accelerometer vec3
---@field gyroscope vec3
---@field battery number @Might not provide accurate values for some devices.
---@field batteryCharging boolean @Might not provide accurate values for some devices.
---@field batteryFullyCharged boolean @Might not provide accurate values for some devices.
---@field usbConnected boolean @Might not provide accurate values for some devices.
---@field touches ac.StateDualshockTouch[] @2 items, starts with 0.
---@field connected boolean

---@class ac.StateDualshockOutput : ClassBase
---@field lightBar rgbm
---@field playerNumber integer @Player number.

---@class ac.StateXboxOutput : ClassBase
---@field triggerLeft number @Left trigger vibration.
---@field triggerRight number @Right trigger vibration.

---UI namespace for creating custom widgets or drawing dynamic textures using IMGUI. You can use it to draw things on textures and such, not just for UI.
ui = {}

--[[ common/debug.lua ]]

---Displays value in Lua Debug app, great for tracking state of your values live.
---@param key string
---@param value any?
---@overload fun(key: string, value: number, min: number?, max: number?, collect: integer?, collectMode: ac.DebugCollectMode?) @Variant with fixed range for a graph in Lua Debug app. Set `collect` to a value above 1 if you need Lua Debug App to combine a few values so that graph would move slower. Parameter `collectMode` can specify the way in which values will be combined.
function ac.debug(key, value) end

--[[ common/debug.lua ]]

---Prints a message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.log(...) end

---Prints a warning message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.warn(...) end

---Prints an error message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.error(...) end

---For compatibility, acts similar to `ac.log()`.
function print(...) end

--[[ common/common_base.lua ]]

---Disposable thing is something set which you can then un-set. Just call `ac.Disposable` returned
---from a function to cancel out whatever happened there. For example, unsubscribe from an event.
---@alias ac.Disposable fun()

---Calls a function in a safe way, catching errors. If any errors were to occur, `catch` would be
---called with an error message as an argument. In either case (with and without error), if provided,
---`finally` will be called.
---
---Does not raise errors unless errors were thrown by `catch` or `finally`. Before CSP 0.2.5, if `catch`
---throws an error, `finally` wouldn’t be called (fixed in 0.2.5).
---@generic T
---@param fn fun(): T?
---@param catch fun(err: string)|nil @If not set, error won’t propagate anyway.
---@param finally fun()|nil
---@return T|nil
function try(fn, catch, finally) end

---Calls a function and then calls `dispose` function. Note: `dispose` function will be called even if
---there would be an error in `fn` function. But error would not be contained and will propagate.
---
---Any error thrown by `fn()` will be raised and not captured, but `dispose()` will be called either way.
---@generic T
---@param fn fun(): T?
---@param dispose fun()? @CSPs before 0.2.5 require non-nil argument.
---@return T|nil
function using(fn, dispose) end

---Resolves relative path to a Lua module (relative to Lua file you’re running this function from)
---so it would be ready to be passed to `require()` function.
---
---Note: performance might be a problem if you are calling it too much, consider caching the result.
---@param path string
---@return string
---@nodiscard
function package.relative(path) end

---Resolves relative path to a file (relative to Lua file you’re running this function from)
---so it would be ready to be passed to `io` functions (returns full path).
---
---Note: performance might be a problem if you are calling it too much, consider caching the result.
---@param path string
---@return string
---@nodiscard
function io.relative(path) end

---Given an FFI struct and a string of data, fills struct with that data. Works only if size of struct matches size of data. Data string can contain zeroes.
---@generic T
---@param destination T @FFI struct (type should be “cdata”).
---@param data binary @String with binary data.
---@return T
function ac.fillStructWithBytes(destination, data) end

---Fills a string of an FFI struct with data up to a certain size. Make sure to not overfill the data.
---@param src string @String to copy.
---@param dst string @A `const char[N]` field of a struct.
---@param size integer @Size of `const char[N]` field (N).
function ac.stringToFFIStruct(src, dst, size) end

--[[ common/common.lua ]]

---Adds a callback which might be called when script is unloading. Use it for some state reversion, but
---don’t rely on it too much. For example, if Assetto Corsa would crash or just close rapidly, it would not
---be called. It should be called when scripts reload though.
---@generic T
---@param callback fun(item: T)
---@param item T? @Optional parameter. If provided, will be passed to callback on release, but stored with a weak reference, so it could still be GCed before that (in that case, callback won’t be called at all).
---@return fun() @Call to disable callback.
function ac.onRelease(callback, item) end

---For easy import of scripts from subdirectories. Provide it a name of a directory relative
---to main script folder and it would add that directory to paths it searches for.
---@param dir string
function package.add(dir) end

---Sets a callback which will be called when server welcome message and extended config arrive.
---@param callback fun(message: string, config: ac.INIConfig) @Callback function.
---@return ac.Disposable
function ac.onOnlineWelcome(callback) end

--[[ common/const.lua ]]

---Does nothing, but with preprocessing optimizations inlines value as constant.
---@generic T
---@param value T
---@return T
function const(value) end

--[[ common/ac_matrices.lua ]]

---Creates a new neutral matrix.
---@return mat3x3
function mat3x3.identity() end

---@param row1 vec3? 
---@param row2 vec3? 
---@param row3 vec3? 
---@return mat3x3
function mat3x3(row1, row2, row3) end

---@class mat3x3
---@field row1 vec3
---@field row2 vec3
---@field row3 vec3
local mat3x3 = nil

---@param value mat3x3
---@return mat3x3
function mat3x3:set(value) end

---@return mat3x3
function mat3x3:clone() end

---Creates a new neutral matrix.
---@return mat4x4
function mat4x4.identity() end

---Creates a translation matrix.
---@param offset vec3
---@return mat4x4
function mat4x4.translation(offset) end

---Creates a rotation matrix.
---@param angle number @Angle in radians.
---@param axis vec3
---@return mat4x4
function mat4x4.rotation(angle, axis) end

---Creates a rotation matrix from Euler angles in radians.
---@param head number
---@param pitch number
---@param roll number
---@return mat4x4
function mat4x4.euler(head, pitch, roll) end

---Creates a scaling matrix.
---@param scale vec3
---@return mat4x4
function mat4x4.scaling(scale) end

---Creates a look-at matrix from position and directional vectors. Ensures all vectors are properly normalized.
---@param position vec3
---@param look vec3
---@param up vec3? @Default value: `vec3(0, 1, 0)`.
---@return mat4x4
function mat4x4.look(position, look, up) end

---Creates a perspective matrix.
---@param fovY number @Vertical view angle in radians.
---@param aspect number @Aspect ratio.
---@param zNear number @Near clipping plane.
---@param zFar number @Far clipping plane.
---@return mat4x4
function mat4x4.perspective(fovY, aspect, zNear, zFar) end

---Creates an orthogonal matrix. Might act unexpected with Z values, shifting by range should help.
---@param extentMin vec3
---@param extentMax vec3
---@return mat4x4
function mat4x4.ortho(extentMin, extentMax) end

---@param row1 vec4? 
---@param row2 vec4? 
---@param row3 vec4? 
---@param row4 vec4? 
---@return mat4x4
function mat4x4(row1, row2, row3, row4) end

---@class mat4x4
---@field row1 vec4
---@field row2 vec4
---@field row3 vec4
---@field row4 vec4
---@field position vec3
---@field look vec3
---@field side vec3
---@field up vec3
local mat4x4 = nil

---@param value mat4x4
---@return mat4x4
function mat4x4:set(value) end

---@param destination vec3
---@param vec vec3
---@return vec3
function mat4x4:transformVectorTo(destination, vec) end

---@param vec vec3
---@return vec3
function mat4x4:transformVector(vec) end

---@param destination vec4
---@param vec vec4
---@return vec4
function mat4x4:transformTo(destination, vec) end

---@param vec vec4
---@return vec4
function mat4x4:transform(vec) end

---@param destination vec3
---@param vec vec3
---@return vec3
function mat4x4:transformPointTo(destination, vec) end

---@param vec vec3
---@return vec3
function mat4x4:transformPoint(vec) end

---@return mat4x4
function mat4x4:clone() end

---Creates a new matrix.
---@return mat4x4
function mat4x4:inverse() end

---Modifies current matrix.
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:inverseSelf() end

---Creates a new matrix.
---@return mat4x4
function mat4x4:normalize() end

---Modifies current matrix.
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:normalizeSelf() end

---Creates a new matrix.
---@return mat4x4
function mat4x4:transpose() end

---Modifies current matrix.
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:transposeSelf() end

---Note: unlike vector’s `:mul()`, this one creates a new matrix!
---@param other mat4x4
---@return mat4x4
function mat4x4:mul(other) end

---Modifies current matrix.
---@param other mat4x4
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:mulSelf(other) end

---Writes result into a separate matrix.
---@param destination mat4x4
---@param other mat4x4
---@return mat4x4 @Returns destination matrix.
function mat4x4:mulTo(destination, other) end

--[[ common/math.lua ]]

---Takes value with even 0…1 distribution and remaps it to recreate a distribution
---similar to Gaussian’s one (with k≈0.52, a default value). Lower to make bell more
---compact, use a value above 1 to get some sort of inverse distibution.
---@param x number @Value to adjust.
---@param k number @Bell curvature parameter.
---@return number
---@nodiscard
function math.gaussianAdjustment(x, k) end

---Builds a list of points arranged in a square with poisson distribution.
---@param size integer @Number of points.
---@param tileMode boolean? @If set to `true`, resulting points would be tilable without breaking poisson distribution.
---@return vec2[]
---@nodiscard
function math.poissonSamplerSquare(size, tileMode) end

---Builds a list of points arranged in a circle with poisson distribution.
---@param size integer @Number of points.
---@return vec2[]
---@nodiscard
function math.poissonSamplerCircle(size) end

---Generates a random number in [0, INT32_MAX) range. Can be a good argument for `math.randomseed()`.
---@return integer
---@nodiscard
function math.randomKey() end

---Generates random number based on a seed.
---@param seed integer|boolean|string @Seed.
---@return number @Random number from 0 to 1.
---@nodiscard
function math.seededRandom(seed) end

---Rounds number, leaves certain number of decimals.
---@param number number
---@param decimals number? @Default value: 0 (rounding to a whole number).
---@return integer
---@nodiscard
function math.round(number, decimals) end

---Clamps a number value between `min` and `max`.
---@param value number
---@param min number
---@param max number
---@return number
---@nodiscard
function math.clampN(value, min, max) end

---Clamps a number value between 0 and 1.
---@param value number
---@return number
---@nodiscard
function math.saturateN(value) end

---Clamps a copy of a vector between `min` and `max`. To avoid making copies, use `vec:clamp(min, max)`.
---@generic T
---@param value T
---@param min any
---@param max any
---@return T
---@nodiscard
function math.clampV(value, min, max) end

---Clamps a copy of a vector between 0 and 1. To avoid making copies, use `vec:saturate()`.
---@generic T
---@param value T
---@return T
---@nodiscard
function math.saturateV(value) end

---Clamps value between `min` and `max`, returning `min` if `x` is below `min` or `max` if `x` is above `max`. Universal version, so might be slower.
---Also, if given a vector or a color, would make a copy of it.
---@generic T
---@param x T
---@param min T|number
---@param max T|number
---@return T
---@nodiscard
function math.clamp(x, min, max) end

---Clamps value between 0 and 1, returning 0 if `x` is below 0 or 1 if `x` is above 1. Universal version, so might be slower.
---Also, if given a vector or a color, would make a copy of it.
---@generic T
---@param x T
---@return T
---@nodiscard
function math.saturate(x) end

---Returns a sing of a value, or 0 if value is 0.
---@param x number
---@return integer
---@nodiscard
function math.sign(x) end

---Linear interpolation between `x` and `y` using `mix` (x * (1 - mix) + y * mix).
---@generic T
---@param x T
---@param y T
---@param mix number
---@return T
---@nodiscard
function math.lerp(x, y, mix) end

---Returns 0 if value is less than v0, returns 1 if it’s more than v1, linear interpolation in-between.
---@param value number
---@param min number
---@param max number
---@return number
---@nodiscard
function math.lerpInvSat(value, min, max) end

---Returns `newA` if `value` equals to `oldA`, `newB` if `value` is `oldB`, applies linear interpolation for other input values. Doesn’t apply clamping.
---@param value number
---@param oldA number
---@param oldB number
---@param newA number
---@param newB number
---@return number
---@nodiscard
function math.remap(value, oldA, oldB, newA, newB) end

---Smoothstep operation. More about it in [wiki](https://en.wikipedia.org/wiki/Smoothstep).
---@param x number
---@return number
---@nodiscard
function math.smoothstep(x) end

---Like a smoothstep operation, but even smoother.
---@param x number
---@return number
---@nodiscard
function math.smootherstep(x) end

---Creates a copy of a vector and normalizes it. Consider using a method `vec:normalize()` instead when you can change the original vector to save on performanceMeter.
---@generic T
---@param x T
---@return T
---@nodiscard
function math.normalize(x) end

---Creates a copy of a vector and runs a cross product on it. Consider avoiding making a copy with `vec:cross(otherVec)`.
---@param x vec3
---@return vec3
---@nodiscard
function math.cross(x, y) end

---Calculates dot product of two vectors.
---@param x vec2|vec3|vec4
---@return number
---@nodiscard
function math.dot(x, y) end

---Calculates angle between vectors in radians.
---@param x vec2|vec3|vec4
---@return number @Radians.
---@nodiscard
function math.angle(x, y) end

---Calculates distance between vectors.
---@param x vec2|vec3|vec4
---@return number
---@nodiscard
function math.distance(x, y) end

---Calculates squared distance between vectors (slightly faster without taking a square root).
---@param x vec2|vec3|vec4
---@return number
---@nodiscard
function math.distanceSquared(x, y) end

---Creates a copy of a vector and projects it onto a different vector. Consider avoiding making a copy with `vec:project(otherVec)`.
---@generic T
---@param x T
---@return T
---@nodiscard
function math.project(x, y) end

---@nodiscard
function math.radians(x) end

---@nodiscard
function math.degress(x) end

---Checks if value is not-a-number.
---@param x number
---@return boolean
---@nodiscard
function math.isnan(x) end

---Checks if value is positive or negative infinity.
---@param x number
---@return boolean
---@nodiscard
function math.isinf(x) end

---Checks if value is finite (not infinite or nan).
---@param x number
---@return boolean
---@nodiscard
function math.isfinite(x) end

---@type number
math.nan = 0/0

---@type number
math.tau = math.pi * 2

---@deprecated Use math.isnan instead.
function math.isNaN(x) end

---@deprecated Use math.nan instead.
math.NaN = 0/0

---@param lag number
---@param dt number
---@return number
---@nodiscard
function math.lagMult(lag, dt) end

---Perlin noise for given input. Returns value within -1…1 range, or outside of it if `octaves` is above 1. If you’re using octaves, make sure `input`
---won’t overflow when being multiplied by two multiple times.
---
---Consider using `math.simplex` instead, it might be a better alternative.
---@param input number|vec2|vec3
---@param octaves integer? @Pass number greater than 1 to generate octave noise instead (sum `octaves` noise functions together increasing input and multiplying amplitude by `persistence` each step). Default value: 1.
---@param persistence number? @Persistance for octave noise. Used only if `octaves` is above 1. Default value: 0.5.
---@return number
---@nodiscard
function math.perlin(input, octaves, persistence) end

---Simplex noise for given input. Returns value within -1…1 range (unlike `math.perlin`, always). If you’re using octaves, make sure `input`
---won’t overflow when being multiplied by two multiple times.
---@param input number|vec2|vec3
---@param octaves integer? @Pass number greater than 1 to generate octave noise instead (sum `octaves` noise functions together increasing input and multiplying amplitude by `persistence` each step). Default value: 1.
---@param lacunarity number? @Frequency increase for subsequent octaves. Used only if `octaves` is above 1. Default value: 2.
---@param persistence number? @Persistance for octave noise. Used only if `octaves` is above 1. Usually set to `1 / lacunarity`. Default value: 0.5.
---@return number
---@nodiscard
function math.simplex(input, octaves, lacunarity, persistence) end

---Roughly convert HDR value to LDR using conversion hints provided by current WeatherFX style. Doesn’t apply nothing like tonemapping or exposure
---correction, simply adjusts for a case where WeatherFX style uses small brightness multiplier or linear color space.
---
---Note: shaders have the same function called `convertHDR()`.
---@generic T: number|rgb|rgbm
---@param input T @Value to convert.
---@param toLDR boolean? @Pass `true` to do the reverse and convert LDR to HDR. Default value: `false`.
---@return T
---@nodiscard
function math.convertHDR(input, toLDR) end

---@generic T : number|vec2|vec3|vec4
---@param value T
---@param target T
---@param lag number
---@param dt number
---@return T
---@nodiscard
function math.applyLag(value, target, lag, dt) end

--[[ common/string.lua ]]

---Function won’t work: while CSP tries its best to guarantee API compatibility, ABI compatibility is not a priority at all,
---and the underlying LuaJIT implementation frequently changes and might even be replaced with something else in the future.
---@return nil
function string.dump() return nil end

---Splits string into an array using separator.
---@param self string @String to split.
---@param separator string? @Separator. If empty, string will be split into individual characters. Default value: ` `.
---@param limit integer? @Limit for pieces of string. Once reached, remaining string is put as a list piece.
---@param trimResult boolean? @Set to `true` to trim found strings. Default value: `false`.
---@param skipEmpty boolean? @Set to `false` to keep empty strings. Default value: `true` (for compatibility reasons).
---@param splitByAnyChar boolean? @Set to `true` to split not by a string `separator`, but by any characters in `separator`.
---@return string[]
function string.split(self, separator, limit, trimResult, skipEmpty, splitByAnyChar) end

---Splits string into a bunch of numbers (not in an array). Any symbol that isn’t a valid part of number is considered to be a delimiter. Does not create an array
---to keep things faster. To make it into an array, simply wrap the call in `{}`.
---@param self string @String to split.
---@param limit integer? @Limit for amount of numbers. Once reached, remaining part is ignored.
---@return ... @Numbers
function string.numbers(self, limit) end

---Pack things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
---Use `a` for half-precision floating point value (two bytes).
---@param self string @Format string.
---@return string
function string.pack(self, ...) end

---Measure size of packed things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
---Use `a` for half-precision floating point value (two bytes).
---@param self string @Format string.
---@return integer
function string.packsize(self) end

---Unpack things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
---Use `a` for half-precision floating point value (two bytes).
---@param self string @Format string.
---@return ...
function string.unpack(self) end

---Checks if string starts with an URL or not. Uses flexible parsing scheme so even URLs not starting with
---a scheme could be found.
---@param self string @Target string.
---@param offset integer? @Starting search index, 1-based.
---@return integer? @Returns length of URL, or `nil` if string is not an URL.
function string.urlCheck(self, offset) end

---Finds next URL in a string. Uses flexible parsing scheme so even URLs not starting with
---a scheme could be found.
---@param self string @Target string.
---@param offset integer? @Starting search index, 1-based.
---@return integer? @First returned value is 1-based index of URL start.
---@return integer? @Second returned value is 1-based index of URL end (both arguments can be passed to `string.sub()` to cut out the URL).
function string.urlNext(self, offset) end

---Works like string.find with plain mode, but ignores case.
---@param self string @String to find `needle` in.
---@param needle string @String to find.
---@param index integer? @Starting search index. Default value: `1`.
---@return integer? @1-based index of a first match, or `nil` if nothing has been found.
function string.findIgnoreCase(self, needle, index) end

---Searches and replaces all the substrings.
---@param self string @String to find `replacee` and replace with `replacer` in.
---@param replacee string @String to find.
---@param replacer string? @String to replace. Default value: ``.
---@param limit integer? @Maximum number of found strings to replace. Default value: `math.huge`.
---@param ignoreCase boolean? @Option for case-incensitive search. Default value: `false`.
---@return string, integer @Second value returned is for the number of replacements.
function string.replace(self, replacee, replacer, limit, ignoreCase) end

---Returns UTF8 string for a corresponding code point.
---@param codePoint integer
---@return string
function string.codePointToUTF8(codePoint) end

---Returns unicode codepoint and length in bytes from a point in a string. Throws an error with invalid UTF-8.
---@param self string @String to get a codepoint from
---@param start integer @Index (starts with 1, if below counts from the end).
---@return integer? @Symbol codepoint (or `nil` if there is no symbol with given index).
---@return integer @Symbol length (or `nil` if there is no symbol with given index).
function string.codePointAt(self, start) end

---Looks for a next emoji in the string. If next emoji is complex, all the symbols will be processed and returned as a single byte sequence. Uses 15th version
---with data from Emoji Keyboard/Display Test Data for UTS #51.
---Not working properly for CSP versions below v0.2.3-preview50.
---@param self string @String to search emojis in.
---@param start integer @Index (starts with 1, if below counts from the end).
---@return integer? @Returns 1-based starting index of an emojis, or `nil` if no emojis have been found.
---@return integer? @Returns 1-based ending index, or `nil` if no emojis have been found.
function string.nextEmoji(self, start) end

---Encodes URL argument.
---@param self string
---@param plusForSpaces boolean? @Use `'+'` for space symbol (works for URLs, but if a regular URL encoding is needed, might be getting in a way). Default value: `true`.
---@return string
function string.urlEncode(self, plusForSpaces) end

---Checks if the beginning of a string matches another string. If string to match is longer than the first one, always returns `false`.
---@param self string @String to check the beginning of.
---@param another string @String to match.
---@param offset integer? @Optional offset for the matching beginning. Default value: `0`.
---@return boolean
function string.startsWith(self, another, offset) end

---Checks if the end of a string matches another string. If string to match is longer than the first one, always returns `false`.
---@param self string @String to check the end of.
---@param another string @String to match.
---@param offset integer? @Optional offset for the matching end. Default value: `0`.
---@return boolean
function string.endsWith(self, another, offset) end

---Compares string alphanumerically.
---@param self string @First string.
---@param another string @Second string.
---@return integer @Returns positive number if first string is larger than second one, or 0 if strings are equal.
function string.alphanumCompare(self, another) end

---Compares string as versions (splits by dots and uses alphanumerical comparator for each piece).
---@param self string @First version.
---@param another string @Second version.
---@return integer @Returns positive number if first version is newer than second one, or 0 if versions are equal.
function string.versionCompare(self, another) end

---Trims string at beginning and end.
---@param self string @String to trim.
---@param characters string? @Characters to remove. Default value: `'\n\r\t '`.
---@param direction integer? @Direction to trim, 0 for trimming both ends, -1 for trimming beginning only, 1 for trimming the end. Default value: `0`.
---@return string
function string.trim(self, characters, direction) end

---Repeats string a given number of times (`repeat` is a reserved keyword, so here we are).
---@param self string @String to trim.
---@param count integer @Number of times to repeat the string.
---@return string
function string.multiply(self, count) end

---Pads string with symbols from `pad` until it reaches the desired length.
---@param self string @String to trim.
---@param targetLength integer @Desired string length. If shorter than current length, string will be trimmed from the end.
---@param pad string? @String to pad with. If empty, no padding will be performed. If has more than one symbol, will be repeated to fill the space. Default value: ` ` (space).
---@param direction integer? @Direction to pad to, 1 for padding at the end, -1 for padding at the start, 0 for padding from both ends centering string. Default value: `1`.
---@return string
function string.pad(self, targetLength, pad, direction) end

---Similar to `string.find()`: looks for the first match of `pattern` and returns indices, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param init integer? @1-based offset to start searching from. Default value: `1`.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return integer? @1-based index of where the match occured, or `nil` if no match has been found.
---@return integer? @1-based index of the ending of found pattern, or `nil` if no match has been found.
---@return ... @Captured elements, if there are any capture groups in the pattern.
---@nodiscard
function string.regfind(self, pattern, init, ignoreCase) end

---Similar to `string.match()`: looks for the first match of `pattern` and returns matches, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param init integer? @1-based offset to start searching from. Default value: `1`.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return string @Captured elements if there are any capture groups in the pattern, or the whole captured string otherwise.
---@nodiscard
function string.regmatch(self, pattern, init, ignoreCase) end

---Similar to `string.gmatch()`: iterates over matches of `pattern`, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return fun():string, ... @Iterator with captured elements if there are any capture groups in the pattern, or the whole captured string otherwise.
---@nodiscard
function string.reggmatch(self, pattern, ignoreCase) end

---Similar to `string.gsub()`: replaces all entries of `pattern` with `repl`, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param repl    string|table|function @Replacement value. Used in the same way as with `string.gsub()`, could be a table or a function.
---@param limit integer? @Limit maximum number of replacements. Default value: `math.huge`.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return string @String with found entries replaced.
---@nodiscard
function string.reggsub(self, pattern, repl, limit, ignoreCase) end

---Compares a string against CSP-style filter (using “?” for “any characters”).
---@param self string @String to check.
---@param filter string @Filter to check. Surround with `{…}` to use complex queries, for example, `'{ ABC? & ! ?DEF }'`.
---@param init integer? @1-based offset to start searching from. Default value: `1`.
---@return boolean
function string.cspmatch(self, filter, init) end

--[[ common/table.lua ]]

---Merges tables into one big table. Tables can be arrays or dictionaries, if it’s a dictionary same keys from subsequent tables will overwrite previously set keys.
---@generic T
---@param table T
---@vararg table
---@return T
---@nodiscard
function table.chain(table, ...) end

--[[ common/table.lua ]]

---Checks if table is an array or not. Arrays are tables that only have consecutive numeric keys. If this function returns `true`, it doesn’t mean
---underlying LuaJIT structure is exactly a dense array, but it does mean that it could be. For example, `{[2]=2, [1]=1}` is not a dense array from
---LuaJIT POV, but semantically it is, and so `table.isArray()` would return `true`.
---@param t table|any[]
---@return boolean
---@nodiscard
function table.isArray(t) end

---Creates a new table with preallocated space for given amount of elements.
---@param arrayElements integer @How many elements the table will have as a sequence.
---@param mapElements integer @How many other elements the table will have.
---@return table
---@nodiscard
function table.new(arrayElements, mapElements) end

---Cleares table without deallocating space using a fast LuaJIT call. Can work
---with both array and non-array tables.
---@param t table
function table.clear(t) end

---Returns the total number of elements in a given Lua table (i.e. from both the array and hash parts combined).
---@param t table
---@return integer
---@nodiscard
function table.nkeys(t) end

---Clones table using a fast LuaJIT call. Doesn’t clone any vectors or colors inside, but it is fast.
---@generic T
---@param t T
---@param deep nil|boolean|'full' @Set to `true` for deep cloning. Default value: `false`. Since 0.2.10, set to `'full'` to clone vectors or colors as well.
---@return T
---@nodiscard
function table.clone(t, deep) end

---Removes first item by value, returns true if any item was removed. Can work
---with both array and non-array tables.
---@generic T
---@param t table<any, T>
---@param item T
---@return boolean
function table.removeItem(t, item) end

---Returns an element from table with a given key. If there is no such element, calls callback
---and uses its return value to add a new element and return that. Can work
---with both array and non-array tables.
---@generic T
---@generic TCallbackData
---@param t table<any, T>
---@param key any
---@param callback fun(callbackData: TCallbackData): T
---@param callbackData TCallbackData?
---@return T
function table.getOrCreate(t, key, callback, callbackData) end

---Returns true if table contains an item. Can work with both array and non-array tables.
---@generic T
---@param t table<any, T>
---@param item T
---@return boolean
---@nodiscard
function table.contains(t, item) end

---Returns a random item from a table. Optional callback works like a filter. Can work
---with both array and non-array tables. Alternatively, optional callback can provide a number
---for a weight of an item.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param filteringCallback nil|fun(item: T, key: TKey, callbackData: TCallbackData): boolean
---@param filteringCallbackData TCallbackData?
---@param randomDevice nil|fun(): number @Optional callback for generating random numbers. Needs to return a value between 0 and 1. If not set, default `math.random` is used.
---@return T
---@nodiscard
function table.random(t, filteringCallback, filteringCallbackData, randomDevice) end

---Returns a key of a given element, or `nil` if there is no such element in a table. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@param t {[TKey]: T}
---@param item T
---@return TKey|nil
---@nodiscard
function table.indexOf(t, item) end

---Returns true if tables contents are the same.
---@generic TKey
---@param t1 table?
---@param t2 table?
---@param deep boolean? @Default value: `true`.
---@return boolean
---@nodiscard
function table.same(t1, t2, deep) end

---Joins elements of a table to a string, works with both arrays and non-array tables. Optinal
---toStringCallback parameter can be used for a custom item serialization. All parameters but
---`t` (for actual table) are optional and can be skipped.
---
---Note: it wouldn’t work as fast as `table.concat`, but it would call a `tostring()` (or custom
---serializer callback) for each element.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param itemsJoin string? @Default value: ','.
---@param keyValueJoin string? @Default value: '='.
---@param toStringCallback nil|fun(item: T, key: TKey, callbackData: TCallbackData): string
---@param toStringCallbackData TCallbackData?
---@overload fun(t: table, itemsJoin: string, toStringCallback: fun(item: any, key: any, callbackData: any), toStringCallbackData: any)
---@overload fun(t: table, toStringCallback: fun(item: any, key: any, callbackData: any), toStringCallbackData: any)
---@return TKey|nil
---@nodiscard
function table.join(t, itemsJoin, keyValueJoin, toStringCallback, toStringCallbackData) end

---Slices array, basically acts like slicing thing in Python.
---@generic T
---@param t T[]
---@param from integer @Starting index.
---@param to integer? @Ending index.
---@param step integer? @Step.
---@return T[]
---@nodiscard
function table.slice(t, from, to, step) end

---Flips table from back to front, requires an array.
---@generic T
---@param t T[]
---@return T[]
---@nodiscard
function table.reverse(t) end

---Calls callback function for each of table elements, creates a new table containing all the resulting values.
---Can work with both array and non-array tables. For non-array tables, new table is going to be an array unless
---callback function would return a key as a second return value.
---
---If callback returns two values, second would be used as a key to create a table-like table (not an array-like one).
---
---Note: if callback returns `nil`, value will be skipped, so this function can act as a filtering one too.
---@generic T
---@generic TKey
---@generic TCallbackData
---@generic TReturnKey
---@generic TReturnValue
---@param t {[TKey]: T}
---@param callback (fun(item: T, index: TKey, callbackData: TCallbackData): TReturnValue, TReturnKey?)|nil @Mapping callback.
---@param callbackData TCallbackData?
---@return {[TReturnKey]: TReturnValue}
---@nodiscard
function table.map(t, callback, callbackData) end

---Calls callback function for each of table elements, creates a new table containing all the resulting values.
---Can work with both array and non-array tables. For non-array tables, new table is going to be an array unless
---callback function would return a key as a second return value.
---
---If callback returns two values, second would be used as a key to create a table-like table (not an array-like one).
---
---Note: if callback returns `nil`, value will be skipped, so this function can act as a filtering one too.
---@generic T
---@generic TKey
---@generic TCallbackData
---@generic TData
---@param t {[TKey]: T}
---@param startingValue TData
---@param callback fun(data: TData, item: T, index: TKey, callbackData: TCallbackData): TData @Reduction callback.
---@param callbackData TCallbackData?
---@return TData
---@nodiscard
function table.reduce(t, startingValue, callback, callbackData) end

---Creates a new table from all elements for which filtering callback returns true. Can work with both
---array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): any @Filtering callback.
---@param callbackData TCallbackData?
---@return {[TKey]: T}
---@nodiscard
function table.filter(t, callback, callbackData) end

---Returns true if callback returns non-false value for every element of the table. Can work with both
---array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return boolean
---@nodiscard
function table.every(t, callback, callbackData) end

---Returns true if callback returns non-false value for at least a single element of the table. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return boolean
---@nodiscard
function table.some(t, callback, callbackData) end

---Counts number of elements for which callback returns non-false value. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback nil|fun(item: T, index: TKey, callbackData: TCallbackData): boolean @If not set, all elements will be counted.
---@param callbackData TCallbackData?
---@return integer
---@nodiscard
function table.count(t, callback, callbackData) end

---Calls callback for each element, returns sum of returned values. Can work
---with both array and non-array tables. If callback is missing, sums actual values in table.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return integer
---@nodiscard
function table.sum(t, callback, callbackData) end

---Returns first element and its key for which callback returns a non-false value. Can work
---with both array and non-array tables. If nothing is found, returns `nil`.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return T, TKey
---@nodiscard
function table.findFirst(t, callback, callbackData) end

---Returns first element and its key for which a certain property matches the value. If nothing is
---found, returns `nil`.
---@generic T
---@generic TKey
---@param t {[TKey]: T}
---@param key string
---@param value any
---@return T, TKey
---@nodiscard
function table.findByProperty(t, key, value) end

---Returns an element and its key for which callback would return the highest numerical value. Can work
---with both array and non-array tables. If callback is missing, actual table elements will be compared.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): number
---@param callbackData TCallbackData?
---@return T, TKey
---@nodiscard
function table.maxEntry(t, callback, callbackData) end

---Returns an element and its key for which callback would return the lowest numerical value. Can work
---with both array and non-array tables. If callback is missing, actual table elements will be compared.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): number
---@param callbackData TCallbackData?
---@return T, TKey
---@nodiscard
function table.minEntry(t, callback, callbackData) end

---Runs callback for each item in a table. Can work with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, key: TKey, callbackData: TCallbackData)
---@param callbackData TCallbackData?
---@return table
---@nodiscard
function table.forEach(t, callback, callbackData) end

---Creates a new table with unique elements from original table only. Optionally, a callback
---can be used to provide a key which uniqueness will be checked. Can work with both array
---and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback nil|fun(item: T, key: TKey, callbackData: TCallbackData): any
---@param callbackData TCallbackData?
---@return {[TKey]: T}
---@nodiscard
function table.distinct(t, callback, callbackData) end

---Finds first element for which `testCallback` returns true, returns index of an element before it.
---Elements should be ordered in such a way that there would be no more elements returning false to the right
---of an element returning true.
---
---If `testCallback` returns true for all elements, would return 0. If `testCallback` returns false for all,
---returns index of the latest element.
---@generic T
---@generic TCallbackData
---@param t T[]
---@param testCallback fun(item: T, index: integer, callbackData: TCallbackData): boolean
---@param testCallbackData nil|TCallbackData
---@return integer
---@nodiscard
function table.findLeftOfIndex(t, testCallback, testCallbackData) end

---Similar to JavaScript’s `Object.assign()`, works with tables and arrays, returns first argument (modified).
---@generic T
---@param target T
---@param ... table
---@return T
function table.assign(target, ...) end

---Flattens table similar to JavaScript function with the same name. Requires an array.
---@param t any[]
---@param maxLevel integer? @Default value: 1.
---@return any[]
---@nodiscard
function table.flatten(t, maxLevel) end

---Creates a new table running in steps from `startingIndex` to `endingIndex`, including `endingIndex`.
---If callback returns two values, second value is used as a key.
---@generic T
---@generic TCallbackData
---@param endingIndex integer?
---@param startingIndex integer
---@param step integer?
---@param callback fun(index: integer, callbackData: TCallbackData): T, integer|string?
---@param callbackData TCallbackData?
---@return T[]
---@overload fun(endingIndex: integer, callback: (fun(index: integer, callbackData: any): any, integer|string?), callbackData: any)
---@overload fun(endingIndex: integer, startingIndex: integer, callback: (fun(index: integer, callbackData: any): any, integer|string?), callbackData: any)
---@nodiscard
function table.range(endingIndex, startingIndex, step, callback, callbackData) end

---Creates a new table from iterator. Supports iterators returning one or two values (if two values are returned, first is considered the key,
---if not, values are simply added to a list).
---@generic T
---@param iterator fun(...): T
---@return T[]
---@nodiscard
function table.build(iterator, k, v) end

--[[ common/io.lua ]]

---Structure containing various file or directory attributes, including various flags and dates. All values are precomputed and ready to be used (there is
---no overhead in accessing them once you get the structure).
---@class io.FileAttributes
---@field fileSize integer @File size in bytes.
---@field creationTime integer @File creation time in seconds from 1970.
---@field lastAccessTime integer @File last access time in seconds from 1970.
---@field lastWriteTime integer @File last write time in seconds from 1970.
---@field exists boolean @True if file exists.
---@field isDirectory boolean @True if file is a directory.
---@field isHidden boolean @The file or directory is hidden. It is not included in an ordinary directory listing.
---@field isReadOnly boolean @A file that is read-only. Applications can read the file, but cannot write to it or delete it.
---@field isEncrypted boolean @A file or directory that is encrypted. For a file, all data streams in the file are encrypted. For a directory, encryption is the default for newly created files and subdirectories.
---@field isCompressed boolean @A file or directory that is compressed. For a file, all of the data in the file is compressed. For a directory, compression is the default for newly created files and subdirectories.
---@field isReparsePoint boolean @A file or directory that has an associated reparse point, or a file that is a symbolic link.
local _fileAttributes = {}

--[[ common/io.lua ]]

---@alias io.ZipEntry {filename: string}|{data: binary}|binary

---Scan directory and call callback function for each of files, passing file name (not full name, but only name of the file) and attributes. If callback function would return
---a non-nil value, iteration will stop and value returned by callback would return from this function. This could be used to
---find a certain file without going through all files in the directory. Optionally, a mask can be used to pre-filter received files
---entries.
---
---If callback function is not provided, it’ll return list of files instead (file names only).
---
---System entries “.” and “..” will not be included in the list of files. Accessing attributes does not add extra cost.
---@generic TCallbackData
---@generic TReturn
---@param directory string @Directory to look for files in. Note: directory is relative to current directory, not to script directory. For AC in general it’s an AC root directory, but do not rely on it, instead use `ac.getFolder(ac.FolderID.Root)`.
---@param mask string? @Mask in a form of usual “*.*”. Default value: '*'.
---@param callback fun(fileName: string, fileAttributes: io.FileAttributes, callbackData: TCallbackData): TReturn? @Callback which will be ran for every file in directory fitting mask until it would return a non-nil value.
---@param callbackData TCallbackData? @Callback data that will be passed to callback as third argument, to avoid creating a capture.
---@return TReturn? @First non-nil value returned by callback.
---@overload fun(directory: string, callback: fun(fileName: string, fileAttributes: io.FileAttributes, callbackData: any), callbackData: any): any
---@overload fun(directory: string, mask: string|nil): string[] @This overload just returns the list
function io.scanDir(directory, mask, callback, callbackData) end

--[[ common/os.lua ]]

---@class os.ConsoleProcessResult
---@field exitCode integer @If process finished successfully, 0. If failed to get the exit code, -1.
---@field stdout string @Contents of stdout stream of ran process.
---@field stderr string @Contents of stderr stream of ran process. Would be set only if `separateStderr` parameter was set to true.

--[[ common/os.lua ]]

---Module with additional functions to help deal with operating system.
os = {}

---Parse date and return a unix timestamp. Uses `std::get_time()` for actual parsing:
---<https://en.cppreference.com/w/cpp/io/manip/get_time>.
---@param date string @String containing date.
---@param format string? @Format string. Default value: `'%Y-%m-%dT%H:%M:%S'`.
---@return integer? @Returns `nil` if failed to parse.
function os.parseDate(date, format) end

---Opens regular Windows file opening dialog, calls callback with either an error or a path to a file selected by user
---(or nil if selection was cancelled). All parameters in `params` table are optional (the whole table too).
---@param params {title: string, defaultFolder: nil|string, folder: string, fileName: string, fileTypes: nil|{ name: string, mask: string }[], addAllFilesFileType: boolean, fileTypeIndex: integer, fileNameLabel: string, okButtonLabel: string, places: string[], flags: os.DialogFlags}|nil|`{defaultFolder = ac.getFolder(ac.FolderID.Root), fileTypes = {{name = 'Images', mask = '*.png;*.jpg;*.jpeg;*.bmp'}}, addAllFilesFileType = true, flags = bit.bor(os.DialogFlags.PathMustExist, os.DialogFlags.FileMustExist)}` "Table with properties:\n- `title` (`string`): Dialog title.\n- `defaultFolder` (`nil|string`): Default folder if there is not a recently used folder value available.\n- `folder` (`string`): Selected folder (unlike `defaultFolder`, overrides recently used folder).\n- `fileName` (`string`): File name that appears in the File name edit box when that dialog box is opened.\n- `fileTypes` (`nil|{ name: string, mask: string }[]`): File types (names and masks).\n- `addAllFilesFileType` (`boolean`): If providing file types, set this to true to automatically add “All Files (*.*)” type at the bottom\n- `fileTypeIndex` (`integer`): File type selected by default (1-based).\n- `fileNameLabel` (`string`): Text of the label next to the file name edit box.\n- `okButtonLabel` (`string`): Text of the Open button.\n- `places` (`string[]`): Additional places to show in the list of locations on the left.\n- `flags` (`os.DialogFlags`): Dialog flags (use `bit.bor()` to combine flags together to avoid errors with adding same flag twice)"
---@param callback fun(err: string, filename: string)
function os.openFileDialog(params, callback) end

---Opens regular Windows file saving dialog, calls callback with either an error or a path to a file selected by user
---(or nil if selection was cancelled). All parameters in `params` table are optional (the whole table too).
---@param params {title: string, defaultFolder: nil|string, defaultExtension: string, folder: string, fileName: string, saveAsItem: string, fileTypes: nil|{ name: string, mask: string }[], addAllFilesFileType: boolean, fileTypeIndex: integer, fileNameLabel: string, okButtonLabel: string, places: string[], flags: os.DialogFlags}|nil|`{defaultFolder = ac.getFolder(ac.FolderID.Root), fileTypes = {{name = 'Images', mask = '*.png;*.jpg;*.jpeg;*.bmp'}}, addAllFilesFileType = true, flags = bit.bor(os.DialogFlags.PathMustExist, os.DialogFlags.OverwritePrompt, os.DialogFlags.NoReadonlyReturn)}` "Table with properties:\n- `title` (`string`): Dialog title.\n- `defaultFolder` (`nil|string`): Default folder if there is not a recently used folder value available.\n- `defaultExtension` (`string`): Sets the default extension to be added to file names, with a dot in front.\n- `folder` (`string`): Selected folder (unlike `defaultFolder`, overrides recently used folder).\n- `fileName` (`string`): File name that appears in the File name edit box when that dialog box is opened.\n- `saveAsItem` (`string`): Ann item to be used as the initial entry in a Save As dialog.\n- `fileTypes` (`nil|{ name: string, mask: string }[]`): File types (names and masks).\n- `addAllFilesFileType` (`boolean`): If providing file types, set this to true to automatically add “All Files (*.*)” type at the bottom\n- `fileTypeIndex` (`integer`): File type selected by default (1-based).\n- `fileNameLabel` (`string`): Text of the label next to the file name edit box.\n- `okButtonLabel` (`string`): Text of the Save button.\n- `places` (`string[]`): Additional places to show in the list of locations on the left.\n- `flags` (`os.DialogFlags`): Dialog flags (use `bit.bor()` to combine flags together to avoid errors with adding same flag twice)"
---@param callback fun(err: string, filename: string)
function os.saveFileDialog(params, callback) end

---Run a console process in background with given arguments, return exit code and output in callback. Launched process will be tied
---to AC process to shut down with AC (works only on Windows 8 and newer).
---@param params {filename: string, arguments: string[], rawArguments: boolean, workingDirectory: string, timeout: integer, environment: table, inheritEnvironment: boolean, stdin: string, separateStderr: boolean, terminateWithScript: boolean|'disposable', assignJob: boolean, dataCallback: fun(err: boolean, data: string)}|`{ filename = '', arguments = {} }` "Table with properties:\n- `filename` (`string`): Application filename.\n- `arguments` (`string[]`): Arguments (quotes will be added automatically unless `rawArguments` is set to true).\n- `rawArguments` (`boolean`): Set to `true` to disable any arguments processing and pass them as they are, simply joining them with a space symbol.\n- `workingDirectory` (`string`): Working directory.\n- `timeout` (`integer`): Timeout in milliseconds. If above zero, process will be killed after given time has passed.\n- `environment` (`table`): If set to a table, values from that table will be used as environment variables instead of inheriting ones from AC process.\n- `inheritEnvironment` (`boolean`): Set to `true` to inherit AC environment variables before adding custom ones.\n- `stdin` (`string`): Optional data to pass to a process in stdin pipe.\n- `separateStderr` (`boolean`): Store stderr data in a separate string.\n- `terminateWithScript` (`boolean|'disposable'`): Terminate process if this Lua script were to terminate (for example, during reload). Since 0.2.10, pass `'disposable'` instead to get `ac.Disposable` back, allowing to terminate the process manually.\n- `assignJob` (`boolean`): Set to `false` to stop CSP from tying the process to AC process (doing so ensures child process would shut down with AC closing).\n- `dataCallback` (`fun(err: boolean, data: string)`): If set to a function, data written in stdout and stderr will be passed to the function instead as it arrives."
---@param callback nil|fun(err: string, data: os.ConsoleProcessResult)
function os.runConsoleProcess(params, callback) end

--[[ common/timer.lua ]]

---Runs callback after certain time. Returns cancellation ID.
---Note: all callbacks will be ran before `update()` call,
---and they would only ran when script runs. So if your script is executed each frame and AC runs at 60 FPS, smallest interval
---would be 0.016 s, and anything lower that you’d set would still act like 0.016 s. Also, intervals would only be called once
---per frame.
---@param callback fun()
---@param delay number? @Delay time in seconds. Default value: 0.
---@param uniqueKey any? @Unique key: if set, timer wouldn’t be added unless there is no more active timers with such ID.
---@return integer
function setTimeout(callback, delay, uniqueKey) end

---Repeteadly runs callback after certain time. Returns cancellation ID.
---Note: all callbacks will be ran before `update()` call,
---and they would only ran when script runs. So if your script is executed each frame and AC runs at 60 FPS, smallest interval
---would be 0.016 s, and anything lower that you’d set would still act like 0.016 s. Also, intervals would only be called once
---per frame.
---@param callback fun(): function? @Return `clearInterval` (actual function) to clear interval.
---@param period number? @Period time in seconds. Default value: 0.
---@param uniqueKey any? @Unique key: if set, timer wouldn’t be added unless there is no more active timers with such ID.
---@return integer
function setInterval(callback, period, uniqueKey) end

---Stops timeout.
---@param cancellationID integer @Value earlier retuned by `setTimeout()`. If a non-numerical value is passed (like a `nil`), call is ignored and returns `false`.
---@return boolean @True if timeout with such ID has been found and stopped.
function clearTimeout(cancellationID) end

---Stops interval.
---@param cancellationID integer @Value earlier retuned by `setInterval()`.
---@return boolean @True if interval with such ID has been found and stopped.
function clearInterval(cancellationID) end

--[[ common/ac_enums.lua ]]

---@alias physics.ColliderType {type: string}

---Different collider types.
physics.Collider = {}

---Box collider.
---@param size vec3
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param up vec3? @Default value: `vec3(0, 1, 0)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Box(size, offset, look, up, debug) end

---Sphere collider.
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Sphere(radius, offset, debug) end

---Capsule collider (like cylinder, but instead of flat caps it has hemispheres and works a bit faster).
---@param length number
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Capsule(length, radius, offset, look, debug) end

---Cylinder collider (slower than capsule, consider using capsule where appropriate).
---@param length number
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Cylinder(length, radius, offset, look, debug) end

--[[ common/ac_extras_ini.lua ]]

---A wrapper for data parsed from an INI files, supports different INI formats. Parsing is done on
---CSP side, rest is on CSP side. Use `:get()` and `:set()` methods to operate values.
---@param format ac.INIFormat 
---@param sections table 
---@return ac.INIConfig
function ac.INIConfig(format, sections) end

---A wrapper for data parsed from an INI files, supports different INI formats. Parsing is done on
---CSP side, rest is on CSP side. Use `:get()` and `:set()` methods to operate values.
---@class ac.INIConfig
---@field sections table<string, table<string, string[]>> @Sections storing actual data.
---@field format ac.INIFormat? @Format used when creating a config. Default value: `ac.INIFormat.Default`.
---@field filename string? @Optional filename for configs loaded from a file.
local _ac_INIConfig = nil

---Get value from parsed INI file. Note: getting vector values creates them anew, so if you’re going to use a value often, consider
---caching it locally.
---@generic T
---@param section string @Section name.
---@param key string @Value key.
---@param defaultValue T @Defines type of value to return, is returned if value is missing. If not set, list of strings is returned.
---@param offset integer? @Optional 1-based offset for data parsed in CSP format (in case value contains several items). Default value: 1.
---@return T
function _ac_INIConfig:get(section, key, defaultValue, offset) end

---Attempts to load a 1D-to-1D LUT from an INI file, supports both inline “(|X=Y|…|)” LUTs and separate files next to configs (only
---for configs loaded by filename or from car data)
---@return ac.DataLUT11? @Returns `nil` if there is no such key or no such file.
function _ac_INIConfig:tryGetLut(section, key) end

---Attempts to load a 2D-to-1D LUT from an INI file, supports both inline “(|X,Y=Z|…|)” LUTs and separate files next to configs (only
---for configs loaded by filename or from car data)
---@return ac.DataLUT21? @Returns `nil` if there is no such key or no such file.
function _ac_INIConfig:tryGet2DLut(section, key) end

---Iterates over sections of INI file with a certain prefix. Order matches order of CSP parsing such data.
---
---Example:
---```
---for index, section in iniConfig:iterate('LIGHT') do
---  print('Color: '..iniConfig:get(section, 'COLOR', 'red'))
---end
---```
---@param prefix string @Prefix for section names.
---@param noPostfixForFirst boolean? @Only for default INI format. If set to `true`, first section would not have “_0” postfix.
---@return fun(): integer?, string? @If you need a list instead of an iterator, use `table.build()`.
function _ac_INIConfig:iterate(prefix, noPostfixForFirst) end

---Iterates over values of INI section with a certain prefix. Order matches order of CSP parsing such data.
---
---Example:
---```
---for index, key in iniConfig:iterateValues('LIGHT_0', 'POSITION', true) do
---  print('Position: '..tostring(iniConfig:get('LIGHT_0', key, vec3())))
---end
---```
---@param prefix string @Prefix for section names.
---@param digitsOnly boolean? @If set to `true`, would only collect keys consisting of a prefix and a number (useful for configs with extra properties).
---@return fun(): integer?, string? @If you need a list instead of an iterator, use `table.build()`.
function _ac_INIConfig:iterateValues(section, prefix, digitsOnly) end

---Takes table with default values and returns a table with values filled from config.
---@generic T
---@param section string @Section name.
---@param defaults T @Table with keys and default values. Keys are the same as INI keys.
---@return T
function _ac_INIConfig:mapSection(section, defaults) end

---Takes table with default values and returns a table with values filled from config.
---@generic T
---@param defaults T @Table with section names and sub-tables with keys and default values. Keys are the same as INI keys.
---@return T
function _ac_INIConfig:mapConfig(defaults) end

---Set an INI value. Pass `nil` as value to remove it.
---@param section string
---@param key string
---@param value string|string[]|number|boolean|nil|vec2|vec3|vec4|rgb|rgbm
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:set(section, key, value) end

---Set an INI value and save file immediately using special old Windows function to edit a single INI value. Compatible only with default
---INI format. Doesn’t provide major peformance improvements, but might be useful if you prefer to keep original formatting as much as possible
---when editing a single value only.
---@param section string
---@param key string
---@param value string|string[]|number|boolean|nil|vec2|vec3|vec4|rgb|rgbm
---@return boolean @Returns `true` if new value is different and config was saved.
function _ac_INIConfig:setAndSave(section, key, value) end

---Serializes data in INI format using format specified on INIConfig creation. You can also use `tostring()` function.
---@return string
function _ac_INIConfig:serialize() end

---Saves contents to a file in INI form.
---@param filename string? @Filename. If filename is not set, saves file with the same name as it was loaded. Updates `filename` field.
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:save(filename) end

--[[ common/ac_extras_ini.lua ]]

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a boolean or, if it’s missing, `nil`.
ac.INIConfig.OptionalBoolean = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a number or, if it’s missing, `nil`.
ac.INIConfig.OptionalNumber = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a string or, if it’s missing, `nil`.
ac.INIConfig.OptionalString = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a list of original values or, if it’s missing, `nil`.
ac.INIConfig.OptionalList = {}

---Parse INI config from a string.
---@param data string @Serialized INI data.
---@param format ac.INIFormat? @Format to parse. Default value: `ac.INIFormat.Default`.
---@param includeFolders ('@cars'|'@tracks'|string)[]? @Optional folders to include files from (only for `ac.INIFormat.ExtendedIncludes` format). Use special values `'@cars'` and `'@tracks'` for car or track configs.
---@return ac.INIConfig
function ac.INIConfig.parse(data, format, includeFolders) end

---Load INI file, optionally with includes.
---@param filename string @INI config filename.
---@param format ac.INIFormat? @Format to parse. Default value: `ac.INIFormat.Default`.
---@param includeFolders ('@cars'|'@tracks'|string)[]? @Optional folders to include files from (only for `ac.INIFormat.ExtendedIncludes` format). If not set, parent folder for config filename is used. Use special values `'@cars'` and `'@tracks'` for car or track configs.
---@return ac.INIConfig
function ac.INIConfig.load(filename, format, includeFolders) end

---Load car data INI file. Supports “data.acd” files as well. Returned files might be tweaked by
---things like custom physics virtual tyres. To get original file, use `ac.INIConfig.load()`.
---
---Returned file can’t be saved.
---@param carIndex number @0-based car index.
---@param fileName string @Car data file name, such as `'tyres.ini'`.
---@return ac.INIConfig
function ac.INIConfig.carData(carIndex, fileName) end

---Load track data INI file. Can be used by track scripts which might not always  have access to those files directly.
---
---Returned file can’t be saved.
---@param fileName string @Car data file name, such as `'tyres.ini'`.
---@return ac.INIConfig
function ac.INIConfig.trackData(fileName) end

---Returns CSP config for a car. Might be slow: some of those configs are huge. Make sure to cache the resulting value if you need to reuse it.
---
---Returned file can’t be saved.
---@param carIndex number @0-based car index.
---@return ac.INIConfig
function ac.INIConfig.carConfig(carIndex) end

---Returns CSP config for a track. Might be slow: some of those configs are huge. Make sure to cache the resulting value if you need to reuse it.
---
---Returned file can’t be saved.
---@return ac.INIConfig
function ac.INIConfig.trackConfig() end

---Returns config with extra online options, the ones that can be set with Content Manager.
---
---Returned file can’t be saved.
---@return ac.INIConfig|nil @If not an online session, returns `nil`.
function ac.INIConfig.onlineExtras() end

---Returns race config (`cfg/race.ini`). Password and online GUID won’t be included.
---
---Returned file can’t be saved.
---@return ac.INIConfig
function ac.INIConfig.raceConfig() end

---Returns video config (`cfg/video.ini`).
---
---Returned file can’t be saved.
---@return ac.INIConfig
function ac.INIConfig.videoConfig() end

---Returns controls config (`cfg/controls.ini`).
---
---Returned file can’t be saved.
---@return ac.INIConfig
function ac.INIConfig.controlsConfig() end

---Returns current setup INI file (either previously loaded or saved). Any changes in actual setup in pits won’t be reflected in the returned
---data unless file was saved.
---
---Returned file can be saved. Use `ac.onSetupFile()` to listen to data changes and either read extra data from setup file, or change the contents after file has been saved.
---@return ac.INIConfig
function ac.INIConfig.currentSetup() end

---Load config of a CSP module by its name.
---@param cspModuleID ac.CSPModuleID @Name of a CSP module.
---@return ac.INIConfig
function ac.INIConfig.cspModule(cspModuleID) end

---Load config of the current Lua script (“settings.ini” in script directory and settings overriden by user, meant to be customizable with Content Manager).
---@return ac.INIConfig
function ac.INIConfig.scriptSettings() end

---Serializes data in INI format using format specified on INIConfig creation. You can also use `tostring()` function.
---@return string
function _ac_INIConfig:serialize() end

---Saves contents to a file in INI form.
---@param filename string? @Filename. If filename is not set, saves file with the same name as it was loaded. Updates `filename` field.
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:save(filename) end

--[[ common/ac_extras_datalut.lua ]]

---Creates a new empty 1D-to-1D LUT. Use `ac.DataLUT11:add(input, output)` to fill it with data.
---@return ac.DataLUT11
function ac.DataLUT11() end

---Parse 1D-to-1D LUT from a string in “(|Input1=Output1|Input2=Output2|…|)” format.
---@param data string @Serialized LUT data.
---@return ac.DataLUT11
function ac.DataLUT11.parse(data) end

---Load 1D-to-1D LUT file.
---@param filename string @LUT filename.
---@return ac.DataLUT11
function ac.DataLUT11.load(filename) end

---Load car data 1D-to-1D LUT file. Supports “data.acd” files as well.
---@param carIndex number @0-based car index.
---@param fileName string @Car data file name, such as `'power.lut'`.
---@return ac.DataLUT11
function ac.DataLUT11.carData(carIndex, fileName) end

---Creates a new empty 2D-to-1D LUT. Use `ac.DataLUT21:add(input, output)` to fill it with data.
---@return ac.DataLUT21
function ac.DataLUT21() end

---Parse 2D-to-1D LUT from a string in “(|X1,Y1=Output1|X2,Y2=Output2|…|)” format.
---@param data string @Serialized LUT data.
---@return ac.DataLUT21
function ac.DataLUT21.parse(data) end

---Load 2D-to-1D LUT file.
---@param filename string @LUT filename.
---@return ac.DataLUT21
function ac.DataLUT21.load(filename) end

---Load car data 2D-to-1D LUT file. Supports “data.acd” files as well.
---@param carIndex number @0-based car index.
---@param fileName string @Car data file name, such as `'speed_throttle.2dlut'`.
---@return ac.DataLUT21
function ac.DataLUT21.carData(carIndex, fileName) end

--[[ common/ac_extras_datalut.lua ]]

---Simple 1D-to-1D lookup table wrapper, helps to deal with all those “.lut“ files in car data.
---@class ac.DataLUT11
---@field useCubicInterpolation boolean @Set to `true` to use cubic interpolation. Default value: `false` (linear interpolation).
---@field extrapolate boolean @Set to `true` to extrapolate if requested value is outside of the data available.
local _ac_DataLUT11 = nil

---Add a new value to LUT.
---@param input number
---@param output number
---@return ac.DataLUT11 @Returns self for easy chaining.
function _ac_DataLUT11:add(input, output) end

---Returns data boundaries.
---@return vec2 @Minimum input and output.
---@return vec2 @Maximum input and output.
function _ac_DataLUT11:bounds() end

---Computes a LUT value using either linear or cubic interpolation (set field `ac.DataLUT11.useCubicInterpolation` to
---`true` to use cubic interpolation).
---@param input number
---@return number
function _ac_DataLUT11:get(input) end

---Returns input value of a certain point of a LUT, or `math.nan` if there is no such point.
---@param index number @0-based index.
---@return number
function _ac_DataLUT11:getPointInput(index) end

---Returns output value of a certain point of a LUT, or `math.nan` if there is no such point.
---@param index number @0-based index.
---@return number
function _ac_DataLUT11:getPointOutput(index) end

---Convert LUT into a string, either in a short (inlined, for an INI config) or long (for a separate file) format.
---@param longFormat boolean? @Set to `true` to use long format. Default value: `false`.
---@return string
function _ac_DataLUT11:serialize(longFormat) end

---Simple 2D-to-1D lookup table wrapper, helps to deal with all those “.2dlut“ files in car data. Tables can miss some values,
---such areas will be further interpolated.
---@class ac.DataLUT21
---@field useBicubicInterpolation boolean @Set to `true` to use bicubic interpolation. Default value: `false` (bilinear interpolation).
local _ac_DataLUT21 = nil

---Returns data boundaries.
---@return vec3 @Minimum input (X, Y) and output (Z).
---@return vec3 @Maximum input (X, Y) and output (Z).
function _ac_DataLUT21:bounds() end

---Add a new value to a 2D LUT.
---@param input vec2
---@param output number
---@return ac.DataLUT21 @Returns self for easy chaining.
function _ac_DataLUT21:add(input, output) end

---Computes a LUT value using either bilinear or bicubic interpolation (set field `ac.DataLUT21.useBicubicInterpolation` to
---`true` to use bicubic interpolation).
---@param input vec2
---@return number
function _ac_DataLUT21:get(input) end

---Convert LUT into a string in a short (inlined, for an INI config) format.
---@return string
function _ac_DataLUT21:serialize() end

--[[ common/ac_extras_connect.lua ]]

---Creates a new shared structure to quickly exchange data between different Lua scripts within a session. Example:
---```
---local sharedData = ac.connect{
---  ac.StructItem.key('myChannel'),        -- optional, to avoid collisions
---  someString = ac.StructItem.string(24), -- 24 is for capacity
---  someInt = ac.StructItem.int(),
---  someDouble = ac.StructItem.double(),
---  someVec = ac.StructItem.vec3()
---}
---```
---
---Note: to connect two scripts, both of them chould use `ac.connect()` and pass exactly the same layouts. Also, consider using more
---specific names to avoid possible unwanted collisions. For example, instead of using `value = ac.StructItem.int()` which might be
---used somewhere else, use `weatherBrightnessValue = ac.StructItem.int()`. Or, simply add `ac.StructItem.key('myUniqueKey')`.
---
---For safety reasons, car scripts can only connect to other car scripts, and track scripts can only connect to other track scripts.
---@generic T
---@param layout T @A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.
---@param keepLive boolean? @Set to true to keep structure even if any references were removed or script was unloaded.
---@param namespace nil|ac.SharedNamespace @Optional namespace stopping scripts of certain types to access data of scripts with different types. For more details check `ac.SharedNamespace` documentation.
---@return T
function ac.connect(layout, keepLive, namespace) end

---Create a new struct from a given layout. Could be used in calls like `ac.structBytes()` and `ac.fillStructWithBytes()`. Each call defines and creates a new struct, so don’t
---call them each frame, I believe LuaJIT doesn’t do garbage collection on struct definitions.
---@generic T
---@param layout T
---@param compact boolean?
---@return T
---@return integer @Structure size.
---@return string @Structure name.
function ac.StructItem.combine(layout, compact) end

--[[ common/ac_struct_item.lua ]]

---Helper to define structures in a safe and secure manner. Create a new table and use values returned
---by these methods as values and pass it to `ac.connect()` or `ac.registerOnlineMessageType()`.
---
---Few notes:
---- Don’t worry about order, elements will be reordered automatically (also, if using associative table
---  in Lua, order would not be strictly defined anyway);
---- If you want to make sure to avoid possible collisions (those functions use format of layout for identifying
---  structures and establishing connections), use `ac.StructItem.key('myOwnUniqueThing')`;
---- If you want to save space (for example, with online messages), there are virtual types `.norm…` and `.unorm…`
---  which would give you floating point values from -1 to 1 (or for 0 to 1 for .unorm… variants), but use 8-bit
---  and 16-bit values for storing, they could help. Also make sure to limit capacity of your strings as much as
---  possible;
---- When accessing string, its checksum will be calculated and compared with checksum of previously accessed value,
---  thus avoiding creating new entities when unnecessary. While it helps with GC, it could incur some overhead
---  on accessing values, so if you need to access string numerous times (let’s say, in a loop), consider copying
---  a reference to it locally.
ac.StructItem = {}

---Adds a key to a structure to ensure its uniqueness. Consider using something like “yourUsername.yourContentID” or something
---like that for a key, so that your data would not interfere with data from Lua scripts written by other developers. Note:
---if you’re exchanging data between physics and graphics thread in your car, you might have to append `car.index` to there as
---well so that different cars would have either own data things.
---@return nil
function ac.StructItem.key(key) end

---Enables explicit ordering for your structures.
---By default, CSP will reorder fields in your structures for optimal data packing. Because all scripts written in Lua share the same algorithm,
---it’s all fine and good, but if you want for your script to exchange data with other programs, explicit order would work much better.
---@param alignment integer? @Optional override for alignment of child structures.
---@param packing integer? @Optional overrider for packing of fields.
---@return nil
function ac.StructItem.explicit(alignment, packing) end

---@return number
function ac.StructItem.half() end

---@return number
function ac.StructItem.float() end

---@return number
function ac.StructItem.double() end

---@return number
function ac.StructItem.norm8() end

---@return number
function ac.StructItem.unorm8() end

---@return number
function ac.StructItem.norm16() end

---@return number
function ac.StructItem.unorm16() end

---@return integer
function ac.StructItem.int16() end

---@return integer
function ac.StructItem.uint16() end

---@return integer
function ac.StructItem.int32() end

---@return integer
function ac.StructItem.uint32() end

---@return integer
function ac.StructItem.int64() end

---@return integer
function ac.StructItem.uint64() end

---@return boolean
function ac.StructItem.boolean() end

---Same as `ac.StructItem.int8()`.
---@return integer
function ac.StructItem.char() end

---Same as `ac.StructItem.uint8()`.
---@return integer
function ac.StructItem.byte() end

---@return integer
function ac.StructItem.int8() end

---@return integer
function ac.StructItem.uint8() end

---@return vec2
function ac.StructItem.vec2() end

---@return vec3
function ac.StructItem.vec3() end

---@return vec4
function ac.StructItem.vec4() end

---@return rgb
function ac.StructItem.rgb() end

---@return rgbm
function ac.StructItem.rgbm() end

---@return hsv
function ac.StructItem.hsv() end

---@return quat
function ac.StructItem.quat() end

---@generic T
---@param elementType T
---@param size integer
---@return T[]
function ac.StructItem.array(elementType, size) end

---@generic T
---@param fields T
---@return T
function ac.StructItem.struct(fields) end

---@param capacity integer? @Maximum string capacity. Default value: 32.
---@return string
function ac.StructItem.string(capacity) end

---@return mat3x3
function ac.StructItem.mat3x3() end

---@return mat4x4
function ac.StructItem.mat4x4() end

---Matrix packed to 6, 9 or 12 bytes (depending on settings).
---
---Note: to update value you need to use assignment operator (`.field = newValue`), altering matrix of this property with methods like
---`:mulSelf()` only changes unpacked value on your side, but not the actual structure value.
---@param compactPosition boolean? @If `true`, position is packed into 3 bytes, otherwise it will take 6 bytes. Default value: `false`.
---@param compactRotation boolean? @If `true`, rotation is packed into 3 bytes, otherwise it will take 6 bytes. Default value: `false`.
---@param rangeFrom number|vec3? @Minimal expected position. Pass it together with `rangeTo` to encode position data more efficiently.
---@param rangeTo number|vec3? @Maximum expected position. Pass it together with `rangeFrom` to encode position data more efficiently.
---@return mat4x4
function ac.StructItem.transform(compactPosition, compactRotation, rangeFrom, rangeTo) end

---Simply create a new FFI structure with a given layout. Doesn’t connect to anything.
---@generic T
---@param layout T @A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.
---@return T
function ac.StructItem.build(layout) end

--[[ common/ac_extras_hashspace.lua ]]

---@param cellSize number @Should be about twice as large as your largest entity.
---@return ac.HashSpace
function ac.HashSpace(cellSize) end

--[[ common/ac_extras_numlut.lua ]]

---@param data string @String with LUT data, in a format similar to AC LUT formats. Please note: rows must be ordered for efficient binary search.
---@param hsvColumns integer[] @1-based indices of columns storing HSV data. Such columns, of course, will be interpolated differently (for example, mixing hues 350 and 20 would produce 10).
---@return ac.Lut
function ac.Lut(data, hsvColumns) end

---@type ac.Lut
ac.LutCpp = ac.Lut

---Creates new ac.LuaJit instance. Deprecated and broken, use `ac.Lut` instead.
---@deprecated
---@param data any
---@param hsvRows integer[] @ 1-based indices of columns (not rows) storing HSV values in them.
---@return table
function ac.LutJit:new(o, data, hsvRows) end

--[[ common/ac_extras_onlineevent.lua ]]

---Creates a new type of online event to exchange between scripts running on different clients in an online
---race. Example:
---```
---local chatMessageEvent = ac.OnlineEvent({
---  -- message structure layout:
---  message = ac.StructItem.string(50),
---  mood = ac.StructItem.float(),
---}, function (sender, data)
---  -- got a message from other client (or ourselves; in such case `sender.index` would be 0):
---  ac.debug('Got message: from', sender and sender.index or -1)
---  ac.debug('Got message: text', data.message)
---  ac.debug('Got message: mood', data.mood)
---end)
---
----- sending a new message:
---chatMessageEvent{ message = 'hello world', mood = 5 }
---```
---
---Note: to exchange messages between two scripts, both of them chould use `ac.OnlineEvent()` and pass exactly the same layouts. Also, consider using more
---specific names to avoid possible unwanted collisions. For example, instead of using `value = ac.StructItem.int()` which might be
---used somewhere else, use `mySpecificValue = ac.StructItem.int()`. Or, simply add `ac.StructItem.key('myUniqueKey')`.
---
---For safety reasons, car scripts can only exchange messages with other car scripts, and track scripts can only exchange messages with other track scripts.
---Your own messages will arrive to you as well unless you were to use `target` with ID different from your session ID, you might need to filter out those
---messages.
---
---If the server is not a custom AC Server (use `ac.getSim().directMessagingAvailable` to check), but the original implementation, following restrictions apply:
---- Each message should be smaller than 175 bytes.
---- At least 200 ms should pass between sending messages.
---- UDP messages are not available (those require `ac.getSim().directUDPMessagingAvailable` flag).
---- Don’t use this system to exchange data too often: it uses chat messages to transfer data, so it’s far from optimal.
---@generic T
---@param layout T @A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.
---@param callback fun(sender: ac.StateCar|nil, message: T) @Callback that will be called when a new message of this type is received. Note: it would be called even if message was sent from this script. Use `sender` to check message origin: if it’s `nil`, message has come from the server, if its `.index` is 0, message has come from this client (and possibly this script).
---@param namespace nil|ac.SharedNamespace @Optional namespace stopping scripts of certain types to access data of scripts with different types. For more details check `ac.SharedNamespace` documentation.
---@param udp nil|boolean|{range: number} @Pass `true` to use UDP messages (available for Lua apps and online scripts only). Use `ac.getSim().directUDPMessagingAvailable` to check if you could use `udp` flag before hand. Note: enabling this option means `repeatForNewConnections` parameter will be ignored. Alternatively, pass a table with advanced UDP settings.
---@param params {processPostponed: boolean?}? @Extra params. Set `processPostponed` to process previously received TCP messages (up to 256, callback will be called in the next frame for all messages from first to last).
---@return fun(message: T?, repeatForNewConnections: nil|boolean, target: nil|integer): boolean @Function for sending new messages of newly created type. Pass a new table to set fields of a new message. If any field is missing, it would be set to the default zero state. Set `repeatForNewConnections` to `true` if this message should be re-sent later for newly connected cars (good if you’re announcing a change of state, like, for example, a custom car paint color). If after setting it to `true` a function would be called again without `repeatForNewConnections` set to `true`, further re-sending will be deactivated. Function returns `true` if message has been sent successfully, or `false` otherwise (for example, if rate limits were exceeded). Note: `repeatForNewConnections` is ignored for `udp` events. Parameter `target` can be used to specify session ID of a car that needs to receive the message. Use negative number to send message to everybody, or `255` to send it to the server (expecting some plugin to pick the message up). CSP builds before 2506 ignore messages with configured `target` parameter.
---@return fun(): T @This function returns the actual data pointer to which you could write arguments directly without having to create a new table, might be useful if you need to send a lot of messages (be careful though, there are all sorts of limits with the original AC server implementation). Call this function once, save the returned reference, and each time you need to send a new message fill it with required data and call the first function with `nil` as `message`.
function ac.OnlineEvent(layout, callback, namespace, udp, params) end

--[[ common/ac_extras_connectmmf.lua ]]

---Opens shared memory file for reading. Do not attempt to modify any of its contents: doing so pretty much always would result in Assetto Corsa
---just straight up crashing.
---@generic T
---@param filename string @Shared memory file filename (without “Local\” bit).
---@param layout T @String for the body of the structure.
---@param persist boolean? @Keep file alive even after the script stopped or the variable was cleared by garbage collector. Default value: `false`.
---@return T
---@overload fun(filename: string, layout: string, persist: boolean?): any
function ac.readMemoryMappedFile(filename, layout, persist) end

---Opens shared memory file for writing. Note: if the file would exist at the moment of opening (for example, created before by a different
---Lua script, or by a separate process), it would retain its current state, but if it’s a new file, it’ll be initialized with all zeroes.
---@generic T
---@param filename string @Shared memory file filename (without “Local\” bit).
---@param layout T @String for the body of the structure.
---@param persist boolean? @Keep file alive even after the script stopped or the variable was cleared by garbage collector. Default value: `false`.
---@return T
---@overload fun(filename: string, layout: string, persist: boolean?): any
function ac.writeMemoryMappedFile(filename, layout, persist) end

---Forcefully closes memory mapped file opened either for reading or writing without waiting for GC to pick it up.
function ac.disposeMemoryMappedFile(reference) end

--[[ common/ac_general_utils.lua ]]

---Estimates lap time and sector times for main car using AC function originally used by Time Attack mode. Could be
---helpful in creating custom time attack modes. Uses “ideal_line.ai” from “track folder/data”, so might not work
---well with mods. If that file is missing, returns nil.
---@return {lapTimeMs: integer, sectorTimesMs: integer[]}|nil @Returns table with times in milliseconds, or `nil` if  “ideal_lane.ai” is missing.
function ac.evaluateLapTime() end

--[[ common/ac_social.lua ]]

---Faster way to deal with driver tags. Any request of unsupported fields will return `false` for further extendability.
---Scripts with access to I/O can also alter fields.
---@param driverName string 
---@return ac.DriverTags
function ac.DriverTags(driverName) end

---Faster way to deal with driver tags. Any request of unsupported fields will return `false` for further extendability.
---Scripts with access to I/O can also alter fields.
---@class ac.DriverTags
---@field color rgbm @User name color. Could be derived from custom color set via `ac.DriverTags` (or `ac.setDriverChatNameColor()`), turns reddish if driver is muted, or uses custom driver tag from CM if any is set, or turns greenish if driver is marked as a friend (in CSP or CM). For the player entry it will always be yellow.
---@field friend boolean @Friend tag, uses CSP and CM databases.
---@field muted boolean @Muted tag, if set messages in chat will be hidden.
local _ac_DriverTags = nil
function ac.DriverTags(driverName) end

---Checks if a user is tagged as a friend. Uses CSP and CM databases. Deprecated, use `ac.DriverTags` instead.
---@deprecated
---@param driverName string @Driver name.
---@return boolean
function ac.isTaggedAsFriend(driverName) end

---Tags user as a friend (or removes the tag if `false` is passed). Deprecated, use `ac.DriverTags` instead.
---@deprecated
---@param driverName string @Driver name.
---@param isFriend boolean? @Default value: `true`.
function ac.tagAsFriend(driverName, isFriend) end

--[[ common/ac_music.lua ]]

---Information about currently playing track. Use function `ac.currentlyPlaying()` to get
---a reference to it.
---
---To draw album cover, pass `ac.MusicData` as an argument to something like `ui.image()`.
---@class ac.MusicData
---@field isPlaying boolean @If `true`, music is currently playing.
---@field hasCover boolean @If `true`, album cover is present.
---@field title string @Name of currently playing track.
---@field album string @Name of currently playing album (if not available, an empty string).
---@field artist string @Name of currently playing artist (if not available, an empty string).
---@field sourceID string @Source ID from where track is coming from. To draw an icon for it, pass it as Icon24 ID. You can check if there is an icon using `ui.isKnownIcon24(playing.sourceID)`.
---@field albumTracksCount integer @Number of tracks in current album, or 0 if value is not available.
---@field trackNumber integer @1-based track number in current album, or 0 if value is not available.
---@field trackDuration integer @Track duration in seconds, or -1 if value is not available.
---@field trackPosition integer @Track position in seconds, or -1 if value is not available.
local _musicData = {}

--[[ common/ac_music.lua ]]

---Syncs information about currently playing music and returns a table with details. Takes data from
---Windows 10 Media API, or from other sources configured in Music module of CSP.
---@return ac.MusicData
function ac.currentlyPlaying() end

--[[ common/ac_weatherconditions.lua ]]

---State of the track surface.
---@param sessionStart number "From 0 to 100."
---@param sessionTransfer number "From 0 to 100."
---@param randomness number 
---@param lapGain number 
---@return ac.TrackConditions
function ac.TrackConditions(sessionStart, sessionTransfer, randomness, lapGain) end

---State of the track surface.
---@class ac.TrackConditions
---@field sessionStart number @From 0 to 100.
---@field sessionTransfer number @From 0 to 100.
---@field randomness number
---@field lapGain number
local _ac_TrackConditions = nil

---@param ambient number "Temperature in C°."
---@param road number "Temperature in C°."
---@return ac.TemperatureParams
function ac.TemperatureParams(ambient, road) end

---@class ac.TemperatureParams
---@field ambient number @Temperature in C°.
---@field road number @Temperature in C°.
local _ac_TemperatureParams = nil

---@param direction number "Direction in degrees."
---@param speedFrom number "Speed in km/h."
---@param speedTo number "Speed in km/h."
---@return ac.WindParams
function ac.WindParams(direction, speedFrom, speedTo) end

---@class ac.WindParams
---@field direction number @Direction in degrees.
---@field speedFrom number @Speed in km/h.
---@field speedTo number @Speed in km/h.
local _ac_WindParams = nil

---@return ac.ConditionsSet
function ac.ConditionsSet() end

---@class ac.ConditionsSet
---@field currentType ac.WeatherType
---@field upcomingType ac.WeatherType
---@field temperatures ac.TemperatureParams
---@field trackState ac.TrackConditions
---@field wind ac.WindParams
---@field transition number @From 0 to 1 (if you’re doing linear transition, better to apply `math.smoothstep()` function to this value).
---@field humidity number @From 0 to 1, 1 for 100% humidity.
---@field pressure number @Pressure In pascals.
---@field variableA number @Custom value for extra data to exchange between controller and implementation (please remember that controller can be swapped with a different one).
---@field variableB number @Custom value for extra data to exchange between controller and implementation (please remember that controller can be swapped with a different one).
---@field variableC number @Custom value for extra data to exchange between controller and implementation (please remember that controller can be swapped with a different one).
---@field rainIntensity number @From 0 to 1, 0.5 for a good heavy-ish rain, everything above is for more absurd thunderstorms.
---@field rainWetness number @From 0 to 1, quickly goes to 1 as rain starts pouring, quickly goes to 0 when rain stops.
---@field rainWater number @Amount of puddles, should slowly move towards rainIntensity value.
local _ac_ConditionsSet = nil

--[[ common/ac_state.lua ]]

---Returns reference to a structure with various information about the state of a car. Very cheap to use.
---This is a new version with shorter name and 0-based indexing (to match other API functions).
---
---Updates once per graphics frame. You can use it in physics scripts to access things such as tyre radius, but
---for anything live there please look for specialized physics-rate updating values.
---
---Note: index starts with 0. Make sure to check result for `nil` if you’re accessing a car that might not be there. First car
---with index 0 is always there.
---@param index integer @0-based index.
---@return ac.StateCar?
function ac.getCar(index) end

---Returns Nth closest to camera car (pass 0 to get an ID of the nearest car). Inactive cars don’t count, so the number of cars
---here might be smaller than total number of cars in the race.
---@param index integer @0-based index.
---@return ac.StateCar?
function ac.getCar.ordered(index) end

---Returns Nth car in the race leaderboard (uses lap times in practice and qualify sessions). Pass 0 to get the top one.
---@param index integer @0-based index.
---@return ac.StateCar?
function ac.getCar.leaderboard(index) end

---Returns Nth car in server entry list. Pass 0 to get the first one. In offline races returns `nil`.
---@param index integer @0-based index.
---@return ac.StateCar?
function ac.getCar.serverSlot(index) end

---Iterates over all the cars from one with 0th index to the last one. Use in a for-loop. To get a Nth car, use `ac.getCar()`.
---
---Example:
---```
---for i, c in ac.iterateCars() do
---  ac.debug(i, car.position)
---end
---```
---@return fun(): integer, ac.StateCar @Iterator to be used in a loop (1-based index and car state)
function ac.iterateCars() end

---Iterates over active cars (excluding disconnected ones online) from nearest to furthest. Use in a for-loop. To get a Nth car, use `ac.getCar.ordered()`.
---
---Example:
---```
---for i, c in ac.iterateCars.ordered() do
---  ac.debug(i, car.position)
---end
---```
---@param inverse boolean? @Set to `true` to iterate in inverse order (available since 0.2.5).
---@return fun(): integer, ac.StateCar @Iterator to be used in a loop (1-based index and car state)
function ac.iterateCars.ordered(inverse) end

---Iterates over cars from first to last in the race leaderboard (uses lap times in practice and qualify sessions). Use in a for-loop. To get a Nth car, use `ac.getCar.leaderboard()`.
---
---Example:
---```
---for i, c in ac.iterateCars.leaderboard() do
---  ac.debug(i, car.position)
---end
---```
---@return fun(): integer, ac.StateCar @Iterator to be used in a loop (1-based index and car state)
function ac.iterateCars.leaderboard() end

---Iterates over cars based on their `sessionID` (index of a session slot). Use in a for-loop. To get a Nth car, use `ac.getCar.serverSlot()`. In offline races
---returns an empty iterator.
---
---Example:
---```
---for i, c in ac.iterateCars.leaderboard() do
---  ac.debug(i, car.position)
---end
---```
---@return fun(): integer, ac.StateCar @Iterator to be used in a loop (1-based index and car state)
function ac.iterateCars.serverSlots() end

--[[ common/ac_state.lua ]]

---@class ac.StateCar
local _ac_StateCar = nil

---@return string
function _ac_StateCar:skin() end

---@return string
function _ac_StateCar:tyresName() end

---@return string
function _ac_StateCar:tyresLongName() end

---@return string
function _ac_StateCar:id() end

---@return string
function _ac_StateCar:name() end

---@return string
function _ac_StateCar:brand() end

---@return string
function _ac_StateCar:country() end

---@return string
function _ac_StateCar:driverName() end

---@return string
function _ac_StateCar:driverNationCode() end

---@return string
function _ac_StateCar:driverNationality() end

---@return string
function _ac_StateCar:driverTeam() end

---@return string
function _ac_StateCar:driverNumber() end

--[[ common/ac_storage.lua ]]

---@class ac.StoredValue
local _ac_StoredValue = {}

---@return string|number|boolean|vec2|vec3|vec4|rgb|rgbm
function _ac_StoredValue:get() end

---@param value string|number|boolean|vec2|vec3|vec4|rgb|rgbm
function _ac_StoredValue:set(value) end

---@type table<string, string>
ac.storage = {}

---Storage function. Easiest way to use is to pass it a table with default values — it would give you a table back
---which would load values on reads and save values on writes. Values have to be either strings, numbers, booleans,
---vectors or colors. Example:
---```
---local storedValues = ac.storage{
---  someKey = 15,
---  someStringValue = 20
---}
---storedValues.someKey = 20
---```
---Alternatively, you can use it as a function which would take a key and a default value and return you an
---`ac.StoredValue` wrapper with methods `:get()` and `:set(newValue)`:
---```
---local stored = ac.storage('someKey', 15)
---stored:get()
---stored:set(20)
---```
---Or, just access it directly in `localStorage` style of JavaScript. Similar to JavaScript, this way you can only store
---strings:
---```
---ac.storage.key = 'value'
---ac.debug('loaded', ac.storage.key)
---```
---Data will be saved in “Documents\Assetto Corsa\cfg\extension\state\lua”, in corresponding subfolder. Actual writing
---will happen a few seconds after new value was pushed, and only if value was changed, so feel free to use this function
---to write things often.
---@generic T
---@param layout T
---@param keyPrefix string|nil @Optional parameter for adding a prefix to keys.
---@return T
---@overload fun(key: string, value: string|number|boolean|vec2|vec3|vec4|rgb|rgbm): ac.StoredValue
function ac.storage(layout, keyPrefix) end

--[[ common/ac_storage.lua ]]

---Checks if storage table created by `ac.storage(table)` has a certain key or not.
---@param storage any
---@param key string
---@return boolean
function ac.storageHasKey(storage, key) end

---Returns `true` if any storage value has changed since the previous call.
---@return boolean
function ac.storageChanged() end

--[[ common/ac_configs.lua ]]

---@class ac.ConfigProvider
local _ac_ConfigProvider = {}

---@param section string
---@param key string
---@param defaultValue boolean|nil
---@return boolean
function _ac_ConfigProvider.bool(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue number
---@return number
function _ac_ConfigProvider.number(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue string|nil
---@return string
function _ac_ConfigProvider.string(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue rgb|nil
---@return rgb
function _ac_ConfigProvider.rgb(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue rgbm|nil
---@return rgbm
function _ac_ConfigProvider.rgbm(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue vec2|nil
---@return vec2
function _ac_ConfigProvider.vec2(section, key, defaultValue) end
---@param section string
---@param key string
---@param defaultValue vec3|nil
---@return vec3
function _ac_ConfigProvider.vec3(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue vec4|nil
---@return vec4
function _ac_ConfigProvider.vec4(section, key, defaultValue) end

---Reads a value from the config of currently loaded track. To use it, you need to specify `defaultValue` value, it would be used to determine
---the type of the value you need (and would be returned if value in config is missing).
---
---Alternatively, if called without arguments, returns ac.ConfigProvider which then can be used to access
---values in a typed manner. For it, `defaultValue` is optional.
---@generic T
---@param section string @Section name in config (the one in square brackets).
---@param key string @Config key (value before “=” sign).
---@param defaultValue T @Value that’s returned as a result if value is missing. Also determines the type needed.
---@return T
---@overload fun(): ac.ConfigProvider
function ac.getTrackConfig(section, key, defaultValue) end

---Reads a value from the config of a car. To use it, you need to specify `defaultValue` value, it would be used to determine
---the type of the value you need (and would be returned if value in config is missing).
---
---Alternatively, if called with car index only, returns ac.ConfigProvider which then can be used to access
---values in a typed manner. For it, `defaultValue` is optional.
---@generic T
---@param carIndex integer @0-based car index.
---@param section string @Section name in config (the one in square brackets).
---@param key string @Config key (value before “=” sign).
---@param defaultValue T @Value that’s returned as a result if value is missing. Also determines the type needed.
---@return T
---@overload fun(carIndex: integer): ac.ConfigProvider
function ac.getCarConfig(carIndex, section, key, defaultValue) end

--[[ common/ac_reftypes.lua ]]

---Stores a boolean value and can be used as a reference to it.
---@param value boolean "Stored value."
---@return refbool
function refbool(value) end

---Stores a boolean value and can be used as a reference to it.
---@class refbool
---@field value boolean @Stored value.
local refbool = nil

---@return boolean
function refbool.isrefbool(x) end

---For easier use with UI controls.
---@param newValue boolean|`true`|`false`
---@return refbool
function refbool:set(newValue) end

---Stores a numerical value and can be used as a reference to it.
---@param value number "Stored value."
---@return refnumber
function refnumber(value) end

---Stores a numerical value and can be used as a reference to it.
---@class refnumber
---@field value number @Stored value.
local refnumber = nil

---@return boolean
function refnumber.isrefnumber(x) end

---For easier use with UI controls.
---@param newValue number
---@return refnumber
function refnumber:set(newValue) end

--[[ common/ac_dualsense.lua ]]

---Return table with gamepad indices for keys and 0-based indices of associated cars for values.
---@return table<integer, integer>
function ac.getDualSenseControllers() end

--[[ common/ac_dualshock.lua ]]

---Return table with gamepad indices for keys and 0-based indices of associated cars for values.
---@return table<integer, integer>
function ac.getDualShockControllers() end

--[[ common/ac_web.lua ]]

---@class WebResponse
---@field status integer
---@field headers table<string, string>
---@field body string
---@field certificate string? @Set `[':https-certificate'] = true` header to get hex-encoded SHA-256 fingerprint of the HTTPS certificate (or fail if HTTPS is not used). Disables caching. Alternatively, set `[':https-certificate'] = 'SHA256_GOES_HERE'` to add a simple direct fingerprint test without disabling cache. Fingerprints match those reported by Firefox as SHA-256 fingerprint. You can also specify this header (with a value) for `web.loadRemote…` functions.
local _webResponse = {}

---Two possible ways to present payload: either as a string with data, or a table with a key `'filename'`.
---Second way can be used as a shortcut for `io.loadAsync()` (it loads data asyncronously).
---Data string can contain zeroes.
---@alias WebPayload string|{filename: string}

--[[ common/ac_web.lua ]]

---Web module.
web = {}

---Configures timeouts in milliseconds for the following web requests. If you’re sure in your server, consider lowering timeouts so that
---in a case of a missing internet connection it wouldn’t take forever to determine the issue. Parameters will be passed to `WinHttpSetTimeouts()`
---function (https://learn.microsoft.com/en-us/windows/win32/api/winhttp/nf-winhttp-winhttpsettimeouts).
---@param resolve integer? @Time in milliseconds for DNS resolve, 0 to disable timeout. Default value: 4000 ms.
---@param connect integer? @Time in milliseconds for establishing connection. Default value: 10000 ms.
---@param send integer? @Time in milliseconds for sending data. Default value: 30000 ms.
---@param receive integer? @Time in milliseconds for receiving data. Default value: 30000 ms.
function web.timeouts(resolve, connect, send, receive) end

---Sends a GET HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method). Another special key added in 0.2.10 is `[':https-certificate'], see `WebResponse` docs for more info.
---@param callback fun(err: string, response: WebResponse)
---@overload fun(url: string, callback: fun(err: string, response: WebResponse))
function web.get(url, headers, callback) end

---Sends a POST HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).
---@param data WebPayload? @Optional data.
---@param callback fun(err: string, response: WebResponse)
---@overload fun(url: string, data: string, callback: fun(err: string, response: WebResponse))
---@overload fun(url: string, callback: fun(err: string, response: WebResponse))
function web.post(url, headers, data, callback) end

---Sends a custom HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param method "'GET'"|"'POST'"|"'PUT'"|"'HEAD'"|"'DELETE'"|"'PATCH'"|"'OPTIONS'" @HTTP method.
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).
---@param data WebPayload? @Optional data.
---@param callback fun(err: string, response: WebResponse)
---@overload fun(method: string, url: string, data: string, callback: fun(err: string, response: WebResponse))
---@overload fun(method: string, url: string, callback: fun(err: string, response: WebResponse))
function web.request(method, url, headers, data, callback) end

---@alias web.SocketParams {onError: nil|fun(err: string), onClose: nil|fun(reason: string?), encoding: nil|'binary'|'utf8'|'json'|'lson', reconnect: boolean?} ---Use property `reconnect` to automatically try and restore connection a few seconds after it got lost. With it, `onError` might be called multiple times, but `onClose` is only called once connection is closed by calling `web.Socket.close()`.
---@alias web.Socket {close: fun()}|fun(data: binary)

---Open a WebSocket connection.
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers.
---@param callback nil|fun(data: binary)
---@param params web.SocketParams?
---@return web.Socket
---@overload fun(url: string, callback: fun(data: binary), params: web.SocketParams): web.Socket
function web.socket(url, headers, callback, params) end

--[[ common/ac_physics_unrestricted.lua ]]

---Physics namespace. Note: most functions here are accessible only if track has expicitly allowed it with its
---extended CSP physics.
---
---To allow scriptable physics, add to surfaces.ini:
---```ini
---[_SCRIPTING_PHYSICS]
---ALLOW_TRACK_SCRIPTS=1    ; choose ones that you need
---ALLOW_DISPLAY_SCRIPTS=1
---ALLOW_NEW_MODE_SCRIPTS=1
---ALLOW_TOOLS=1
---```
---
---And to activate extended physics, use:
---```ini
---[SURFACE_0]
---WAV_PITCH=extended-0
---```
physics = {}

--[[ common/stringify.lua ]]

---Serialize Lua value (table, number, string, etc.) in a Lua table format (similar to how `JSON.stringify` in JavaScript
---generates a thing with JavaScript syntax). Format seems to be called Luaon. Most of Lua entities are supported, including array-like tables, table
---tables and mixed ones. CSP API things, such as vectors or colors, are also supported. For things like threads,
---functions or unknown cdata types instead a placeholder object will be created.
---
---Circular references also result in creating similar objects, for example: `t = {1, 2, 3, t}` would result in
---`{ 1, 2, 3, { type = 'circular reference' } }`.
---
---If any table in given data would have a `__stringify()` function, it would be called as a method (so first argument
---would be the table with `__stringify` itself). If that function would return a string, that string will be used
---instead of regular table serialization. The idea is for classes to define a method like this and output a line of code
---which could be used to create a new instance like this on deserialization. Note: for such like to use a custom function
---like a class constructor, you would either need to register that function with a certain name or provide a table referring
---to it on deserialization. That’s because although deserialization uses `load()` function to parse and run data as Lua code,
---it wouldn’t allow code to access existing functions by default.
---@param obj table|number|string|boolean|nil @Object to serialize.
---@param compact boolean? @If true, resulting string would not have spaces and line breaks, slightly faster and a lot more compact.
---@param depthLimit integer? @Limits how deep serialization would go. Default value: 20.
---@return string @String with input data presented in Lua syntax.
function stringify(obj, compact, depthLimit) end

---Parse a string with Lua table syntax into a Lua object (table, number, string, vector, etc.), can support custom objects as well.
---Only functions from `namespace` can be used (as well as vectors and functions registered earlier with `stringify.register()`),
---so if you’re using custom classes, make sure to either register them earlier or pass them in `namespace` table. Alternatively,
---you can just pass `_G` as `namespace`, but it might be pretty unsecure, so maybe don’t do it.
---
---Would raise an error if failed to parse or if any of initializers would raise an error.
---@param serialized string @Serialized data.
---@param namespace table|nil @Namespace table. Serialized data would be evaluated as Lua code and would have access to it.
---@return table|number|string|boolean|nil
function stringify.parse(serialized, namespace) end

---Parse a string with Lua table syntax into a Lua object (table, number, string, vector, etc.), can support custom objects as well.
---Only functions from `namespace` can be used (as well as vectors and functions registered earlier with `stringify.register()`),
---so if you’re using custom classes, make sure to either register them earlier or pass them in `namespace` table. Alternatively,
---you can just pass `_G` as `namespace`, but it might be pretty unsecure, so maybe don’t do it.
---
---Returns fallback value if failed to parse, or if `serialized` is empty or not set, or if any of initializers would raise an error.
---@generic T
---@param serialized string? @Serialized data.
---@param namespace table|nil @Namespace table. Serialized data would be evaluated as Lua code and would have access to it.
---@param fallback T|nil @Value to return if parsing failed.
---@return T
function stringify.tryParse(serialized, namespace, fallback) end

---Registers a new initializer function with a given name.
---@param name string @Name of an initializer (how serialized data would refer to it).
---@param fn function @Initializer function (returning value for serialized data to use).
---@overload fun(class: ClassDefinition)
function stringify.register(name, fn) end

---Serialization substep. Works similar to `stringify()` itself, but instead of returning string simply adds new terms to
---`out` table. Use it in custom `__stringify` methods for serializing child items if you need the best performance.
---@param out string[] @Output table with words to concatenate later (without any joining string).
---@param ptr integer @Position within `out` table to write next word into. At the very start, when table is empty, it would be 1.
---@param obj any @Item to serialize.
---@param lineBreak string|nil @Line break with some spaces for aligning child items, or `nil` if compact stringify mode is used. One tab is two spaces.
---@param depthLimit integer @Limits how many steps down serialization can go. If 0 or below, no tables would be serialized.
---@return integer @Updated `ptr` value (if one item was added to `out`, should increase by 1).
function stringify.substep(out, ptr, obj, lineBreak, depthLimit) end

---Different serializer, produces binary data instead of human-readable. Faster and with even more compact output, but not human-readable.
---@param obj table|number|string|boolean|nil @Object to serialize.
---@return string @String with input data presented in binary format, so it won’t be readable and will contain zero bytes.
function stringify.binary(obj) end

---Parses binary data prepared with `stringify.binary()`.
---@param serialized string @Serialized data.
---@return table|number|string|boolean|nil
function stringify.binary.parse(serialized) end

---Tries to parse binary data prepared with `stringify.binary()`.
---
---Returns fallback value if failed to parse, or if `serialized` is empty or not set, or if any of initializers would raise an error.
---@generic T
---@param serialized string? @Serialized data.
---@param fallback T|nil @Value to return if parsing failed.
---@return T
function stringify.binary.tryParse(serialized, fallback) end

---A small helper to add as a parent class for EmmyLua to work better.
---@class ClassStringifiable : ClassBase
local _classStringifiable = {}

---Serialize instance of class. Can either return a `string`, or construct it into `out` table and return a new position in it. String itself should be a like of
---Lua code which would reconstruct the object on deserialization. Don’t forget to either register referred function with `stringify.register()` or provide
---a reference to it in `namespace` table with `stringify.parse()`.
---
---Note: to serialize sub-objects, such as constructor arguments, you can use `stringify()` or `stringify.substep()` if you’re using an approach with
---manually constructing `out` table. Alternatively for basic types you can use `string.format()`: “%q” would give you a string in Lua format, so you can use it
---like so:
---```
---function MyClass:__serialize()
---  return string.format('MyClass(%q, %s)', self.stringName, self.numericalCounter)
---end
---```
---@param out string[] @Output table with words to concatenate later (without any joining string).
---@param ptr integer @Position within `out` table to write next word into. At the very start, when table is empty, it would be 1.
---@param obj any @Item to serialize.
---@param lineBreak string|nil @Line break with some spaces for aligning child items, or `nil` if compact stringify mode is used. One tab is two spaces.
---@param depthLimit integer @Limits how many steps down serialization can go. If 0 or below, no tables would be serialized.
---@return integer @Updated `ptr` value (if one item was added to `out`, should increase by 1).
---@overload fun(): string @Simpler version which should work well in 98% of times. Use a more detailed one only if you have a ton of objects and need to improve performance.
function _classStringifiable:__stringify(out, ptr, obj, lineBreak, depthLimit) end

--[[ common/json.lua ]]

---Very basic JSON processing library. Based on json.lua by rxi, but a bit simplified and streamlined.
---In case you need to store and load data within Lua scripts, consider using `stringify()` and 
---`stringify.parse()` instead: it’s faster and more reliable.
JSON = {}

---Serializes a Lua entity (like a table) into a compact JSON.
---@param data table|number|string|boolean|nil
---@return string
function JSON.stringify(data) end

---Parses a compact JSON into a Lua entity. Note: if JSON is damaged, parser won’t throw an error, but
---results might be somewhat unpredictable. It’s an intended behaviour: in 99% of cases JSON parser
---used to exchange data with, for example, API endpoints, will receive correct data, but some of those
---AC JSON files are pretty screwed and often include things like missing commas, comments, etc.
---@param data string?
---@return any
function JSON.parse(data) end

--[[ common/ac_primitive_vec2.d.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec2(x, y)` directly, but the way LuaJIT works,
---that call only works with two numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec2): vec2
---@overload fun(tableOfTwo: number[]): vec2
---@overload fun(value: number): vec2
---@overload fun(value: string): vec2
---@param x? number
---@param y? number
---@return vec2
function vec2.new(x, y) end

---Checks if value is vec2 or not.
---@param p any
---@return boolean
function vec2.isvec2(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec2
function vec2.tmp() end

---Intersects two line segments, one going from `p1` to `p2` and another going from `p3` to `p4`. Returns intersection point or `nil` if there is no intersection.
---@return vec2?
function vec2.intersect(p1, p2, p3, p4) end

---Two-dimensional vector. All operators are overloaded. Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec2()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec2()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@return vec2
function vec2(x, y) end

---Two-dimensional vector. All operators are overloaded. Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec2()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec2()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec2
---@field x number
---@field y number
---@operator add(number|vec2): vec2
---@operator sub(number|vec2): vec2
---@operator mul(number|vec2): vec2
---@operator div(number|vec2): vec2
---@operator pow(number|vec2): vec2
---@operator len: number
---@operator unm: vec2
local vec2 = nil

---Makes a copy of a vector.
---@return vec2
function vec2:clone() end

---Unpacks vec2 into two numbers.
---@return number, number
function vec2:unpack() end

---Turns vec2 into a table with two values.
---@return number[]
function vec2:table() end

---Returns reference to vec2 class.
function vec2:type() end

---@param x vec2|number
---@param y number?
---@return vec2 @Returns itself.
function vec2:set(x, y) end

---@param vec vec2
---@param scale number
---@return vec2 @Returns itself.
function vec2:setScaled(vec, scale) end

---@param value1 vec2
---@param value2 vec2
---@param mix number
---@return vec2 @Returns itself.
function vec2:setLerp(value1, value2, mix) end

---Copies its values to a different vector.
---@param out vec2
---@return vec2 @Returns itself.
function vec2:copyTo(out) end

---@param valueToAdd vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:add(valueToAdd, out) end

---@param valueToAdd vec2
---@param scale number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:div(valueToDivideBy, out) end

---@param exponent vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:pow(exponent, out) end

---@param multiplier number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:scale(multiplier, out) end

---@param otherValue vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:min(otherValue, out) end

---@param otherValue vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:max(otherValue, out) end

---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:saturate(out) end

---@param min vec2
---@param max vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:clamp(min, max, out) end

---@return number
function vec2:length() end

---@return number
function vec2:lengthSquared() end

---@param otherVector vec2
---@return number
function vec2:distance(otherVector) end

---@param otherVector vec2
---@return number
function vec2:distanceSquared(otherVector) end

---@param otherVector vec2
---@param distanceThreshold number
---@return boolean
function vec2:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec2
---@return number @Radians.
function vec2:angle(otherVector) end

---@param otherVector vec2
---@return number
function vec2:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:normalize(out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec2
---@param mix number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:project(otherVector, out) end

--[[ common/ac_primitive_vec3.d.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec3(x, y, z)` directly, but the way LuaJIT works,
---that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec3): vec3
---@overload fun(tableOfThree: number[]): vec3
---@overload fun(value: number): vec3
---@overload fun(value: string): vec3
---@param x number?
---@param y number?
---@param z number?
---@return vec3
function vec3.new(x, y, z) end

---Checks if value is vec3 or not.
---@param p any
---@return boolean
function vec3.isvec3(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec3
function vec3.tmp() end

---Three-dimensional vector. All operators are overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec3()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec3()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@param z number? 
---@return vec3
function vec3(x, y, z) end

---Three-dimensional vector. All operators are overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec3()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec3()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec3
---@field x number
---@field y number
---@field z number
---@operator add(number|vec3): vec3
---@operator sub(number|vec3): vec3
---@operator mul(number|vec3): vec3
---@operator div(number|vec3): vec3
---@operator pow(number|vec3): vec3
---@operator len: number
---@operator unm: vec3
local vec3 = nil

---Makes a copy of a vector.
---@return vec3
function vec3:clone() end

---Unpacks vec3 into three numbers.
---@return number, number, number
function vec3:unpack() end

---Turns vec3 into a table with three values.
---@return number[]
function vec3:table() end

---Returns reference to vec3 class.
function vec3:type() end

---@param x vec3|number
---@param y number?
---@param z number?
---@return vec3 @Returns itself.
function vec3:set(x, y, z) end

---@param vec vec3
---@param scale number
---@return vec3 @Returns itself.
function vec3:setScaled(vec, scale) end

---@param value1 vec3
---@param value2 vec3
---@param mix number
---@return vec3 @Returns itself.
function vec3:setLerp(value1, value2, mix) end

---Sets itself to a normalized result of cross product of value1 and value2.
---@param value1 vec3
---@param value2 vec3
---@return vec3 @Returns itself.
function vec3:setCrossNormalized(value1, value2) end

---Copies its values to a different vector.
---@param out vec3
---@return vec3 @Returns itself.
function vec3:copyTo(out) end

---@param valueToAdd vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:add(valueToAdd, out) end

---@param valueToAdd vec3
---@param scale number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:div(valueToDivideBy, out) end

---@param exponent vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:pow(exponent, out) end

---@param multiplier number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:scale(multiplier, out) end

---@param otherValue vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:min(otherValue, out) end

---@param otherValue vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:max(otherValue, out) end

---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:saturate(out) end

---@param min vec3
---@param max vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:clamp(min, max, out) end

---@return number
function vec3:length() end

---@return number
function vec3:lengthSquared() end

---@param otherVector vec3
---@return number
function vec3:distance(otherVector) end

---@param otherVector vec3
---@return number
function vec3:distanceSquared(otherVector) end

---@param otherVector vec3
---@param distanceThreshold number
---@return boolean
function vec3:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec3
---@return number @Radians.
function vec3:angle(otherVector) end

---@param otherVector vec3
---@return number
function vec3:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:normalize(out) end

---Rewrites own values with values of cross product of itself and other vector (unless different `out` is provided).
---@param otherVector vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:cross(otherVector, out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec3
---@param mix number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:project(otherVector, out) end

---Rewrites own values with values of itself rotated with quaternion (unless different `out` is provided).
---@param quaternion quat
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:rotate(quaternion, out) end

---Returns distance from point to a line. For performance reasons doesn’t do any checks, so be careful with incoming arguments.
---@return number
function vec3:distanceToLine(a, b) end

---Returns squared distance from point to a line. For performance reasons doesn’t do any checks, so be careful with incoming arguments.
---@return number
function vec3:distanceToLineSquared(a, b) end

--[[ common/ac_primitive_vec4.d.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec4(x, y, z, w)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec4): vec4
---@overload fun(tableOfFour: number[]): vec4
---@overload fun(value: number): vec4
---@overload fun(value: string): vec4
---@param x number?
---@param y number?
---@param z number?
---@param w number?
---@return vec4
function vec4.new(x, y, z, w) end

---Checks if value is vec4 or not.
---@param p any
---@return boolean
function vec4.isvec4(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec4
function vec4.tmp() end

---Four-dimensional vector. All operators are also overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec4()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec4()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@param z number? 
---@param w number? 
---@return vec4
function vec4(x, y, z, w) end

---Four-dimensional vector. All operators are also overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec4()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec4()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec4
---@field x number
---@field y number
---@field z number
---@field w number
---@operator add(number|vec4): vec4
---@operator sub(number|vec4): vec4
---@operator mul(number|vec4): vec4
---@operator div(number|vec4): vec4
---@operator pow(number|vec4): vec4
---@operator len: number
---@operator unm: vec4
local vec4 = nil

---Makes a copy of a vector.
---@return vec4
function vec4:clone() end

---Unpacks vec4 into four numbers.
---@return number, number, number, number
function vec4:unpack() end

---Turns vec4 into a table with four values.
---@return number[]
function vec4:table() end

---Returns reference to vec4 class.
function vec4:type() end

---@param x vec4|number
---@param y number?
---@param z number?
---@param w number?
---@return vec4 @Returns itself.
function vec4:set(x, y, z, w) end

---@param vec vec4
---@param scale number
---@return vec4 @Returns itself.
function vec4:setScaled(vec, scale) end

---@param value1 vec4
---@param value2 vec4
---@param mix number
---@return vec4 @Returns itself.
function vec4:setLerp(value1, value2, mix) end

---Sets itself to a normalized result of cross product of value1 and value2.
---@param value1 vec4
---@param value2 vec4
---@return vec4 @Returns itself.
function vec4:setCrossNormalized(value1, value2) end

---Copies its values to a different vector.
---@param out vec4
---@return vec4 @Returns itself.
function vec4:copyTo(out) end

---@param valueToAdd vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:add(valueToAdd, out) end

---@param valueToAdd vec4
---@param scale number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:div(valueToDivideBy, out) end

---@param exponent vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:pow(exponent, out) end

---@param multiplier number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:scale(multiplier, out) end

---@param otherValue vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:min(otherValue, out) end

---@param otherValue vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:max(otherValue, out) end

---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:saturate(out) end

---@param min vec4
---@param max vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:clamp(min, max, out) end

---@return number
function vec4:length() end

---@return number
function vec4:lengthSquared() end

---@param otherVector vec4
---@return number
function vec4:distance(otherVector) end

---@param otherVector vec4
---@return number
function vec4:distanceSquared(otherVector) end

---@param otherVector vec4
---@param distanceThreshold number
---@return boolean
function vec4:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec4
---@return number @Radians.
function vec4:angle(otherVector) end

---@param otherVector vec4
---@return number
function vec4:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:normalize(out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec4
---@param mix number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:project(otherVector, out) end

--[[ common/ac_primitive_rgb.d.lua ]]

---Creates new instance. It’s usually faster to create a new item with `rgb(r, g, b, mult)` directly, but the way LuaJIT works,
---that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(color: rgb): rgb
---@overload fun(color: rgbm): rgb
---@overload fun(color: hsv): rgb
---@overload fun(color: vec4): rgb
---@overload fun(color: vec3): rgb
---@overload fun(tableOfThree: number[]): rgb
---@overload fun(color: number): rgb
---@overload fun(value: string): rgb
---@param r number?
---@param g number?
---@param b number?
---@return rgb
function rgb.new(r, g, b, m) end

---Checks if value is rgb or not.
---@param p any
---@return boolean
function rgb.isrgb(p) end

---Temporary color. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return rgb
function rgb.tmp() end

---Creates color from 0…255 values
---@param r number @From 0 to 255
---@param g number @From 0 to 255
---@param b number @From 0 to 255
---@return rgb
function rgb.from0255(r, g, b, a) end

---Predefined colors. Do not change them unless you want to have some extra fun debugging.
rgb.colors = { transparent = rgb(0, 0, 0), black = rgb(0, 0, 0), silver = rgb(0.75, 0.75, 0.75), gray = rgb(0.5, 0.5, 0.5), white = rgb(1, 1, 1), maroon = rgb(0.5, 0, 0), red = rgb(1, 0, 0), purple = rgb(0.5, 0, 0.5), fuchsia = rgb(1, 0, 1), green = rgb(0, 0.5, 0), lime = rgb(0, 1, 0), olive = rgb(0.5, 0.5, 0), yellow = rgb(1, 1, 0), orange = rgb(1, 0.5, 0), navy = rgb(0, 0, 0.5), blue = rgb(0, 0, 1), teal = rgb(0, 0.5, 0.5), cyan = rgb(0, 0.5, 1), aqua = rgb(0, 1, 1) }

---Three-channel color. All operators are overloaded. White is usually `rgb=1,1,1`.
---@param r number? 
---@param g number? 
---@param b number? 
---@return rgb
function rgb(r, g, b) end

---Three-channel color. All operators are overloaded. White is usually `rgb=1,1,1`.
---@class rgb
---@field r number
---@field g number
---@field b number
---@operator add(number|rgb): rgb
---@operator sub(number|rgb): rgb
---@operator mul(number|rgb): rgb
---@operator div(number|rgb): rgb
---@operator pow(number|rgb): rgb
---@operator len: number
---@operator unm: rgb
local rgb = nil

---Makes a copy of a vector.
---@return rgb
function rgb:clone() end

---Unpacks rgb into three numbers.
---@return rgb, number
function rgb:unpack() end

---Turns rgb into a table with three numbers.
---@return number[]
function rgb:table() end

---Returns reference to rgb class.
function rgb:type() end

---@param r rgb|number
---@param g number?
---@param b number?
---@return rgb @Returns itself.
function rgb:set(r, g, b) end

---@param x rgb
---@param mult number
---@return rgb @Returns itself.
function rgb:setScaled(x, mult) end

---@param value1 rgb
---@param value2 rgb
---@param mix number
---@return rgb @Returns itself.
function rgb:setLerp(value1, value2, mix) end

---@param valueToAdd rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:add(valueToAdd, out) end

---@param valueToAdd rgb
---@param scale number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:sub(valueToSubtract, out) end

---@param valueToMultiplyBy rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:div(valueToDivideBy, out) end

---@param exponent rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:pow(exponent, out) end

---@param multiplier number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:scale(multiplier, out) end

---@param otherValue rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:min(otherValue, out) end

---@param otherValue rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:max(otherValue, out) end

---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:saturate(out) end

---@param min rgb
---@param max rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:clamp(min, max, out) end

---Adjusts saturation using a very simple formula.
---@param saturation number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:adjustSaturation(saturation, out) end

---Makes sure brightest value does not exceed 1.
---@return rgb @Returns itself.
function rgb:normalize() end

---Returns brightest value (aka V in HSV).
---@return number
function rgb:value() end

---Returns hue.
---@return number
function rgb:hue() end

---Returns saturation.
---@return number
function rgb:saturation() end

---Returns luminance value.
---@return number
function rgb:luminance() end

---Returns rgbm.
---@param mult number? @Default value: 1.
---@return rgbm
function rgb:rgbm(mult) end

---Returns HSV color of rgb*mult.
---@param out hsv? @If set, assigns result to given `hsv` instead of creating a new one. Added in 0.2.10.
---@return hsv
function rgb:hsv(out) end

---Returns rgb*mult turned to vec3.
---@return vec3
function rgb:vec3() end

---Returns string with hex representation and leading “#”.
---@return string
function rgb:hex() end

--[[ common/ac_primitive_hsv.d.lua ]]

---Creates new instance. It’s usually faster to create a new item with `hsv(h, s, v)`.
---@param h number?
---@param s number?
---@param v number?
---@return hsv
function hsv.new(h, s, v) end

---Checks if value is hsv or not.
---@param p any
---@return boolean
function hsv.ishsv(p) end

---Temporary HSV color. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return hsv
function hsv.tmp() end

---HSV color (hue, saturation, value). Equality operator is overloaded.
---@param h number? 
---@param s number? 
---@param v number? 
---@return hsv
function hsv(h, s, v) end

---HSV color (hue, saturation, value). Equality operator is overloaded.
---@class hsv
---@field h number
---@field s number
---@field v number
local hsv = nil

---Makes a copy of a vector.
---@return hsv
function hsv:clone() end

---Unpacks hsv into three numbers.
---@return rgb, number
function hsv:unpack() end

---Turns hsv into a table with three numbers.
---@return number[]
function hsv:table() end

---Returns reference to hsv class.
function hsv:type() end

---@param h number
---@param s number
---@param v number
---@return hsv @Returns itself.
function hsv:set(h, s, v) end

---Returns RGB color.
---@param out rgb? @If set, assigns result to given `rgb` instead of creating a new one. Added in 0.2.10.
---@return rgb
function hsv:rgb(out) end

--[[ common/ac_primitive_rgbm.d.lua ]]

---Creates new instance. It’s usually faster to create a new item with `rgbm(r, g, b, mult)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(color: rgbm): rgbm
---@overload fun(color: rgb): rgbm
---@overload fun(color: hsv): rgbm
---@overload fun(color: vec4): rgbm
---@overload fun(color: vec3): rgbm
---@overload fun(tableOfFour: number[]): rgbm
---@overload fun(hexColor: string): rgbm
---@overload fun(colorAlpha: number): rgbm
---@overload fun(color: number, alpha: number): rgbm
---@overload fun(color: rgb, alpha: number): rgbm
---@param r number?
---@param g number?
---@param b number?
---@param m number? @Default value: 1.
---@return rgbm
function rgbm.new(r, g, b, m) end

---Checks if value is rgbm or not.
---@param p any
---@return boolean
function rgbm.isrgbm(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return rgbm
function rgbm.tmp() end

---Creates color from 0…255 values
---@param r number @From 0 to 255.
---@param g number @From 0 to 255.
---@param b number @From 0 to 255.
---@param a number? @From 0 to 1. Default value: 1.
---@return rgbm
function rgbm.from0255(r, g, b, a) end

---Predefined colors. Do not change them unless you want to have some extra fun debugging.
rgbm.colors = { transparent = rgbm(0, 0, 0, 0), black = rgbm(0, 0, 0, 1), silver = rgbm(0.75, 0.75, 0.75, 1), gray = rgbm(0.5, 0.5, 0.5, 1), white = rgbm(1, 1, 1, 1), maroon = rgbm(0.5, 0, 0, 1), red = rgbm(1, 0, 0, 1), purple = rgbm(0.5, 0, 0.5, 1), fuchsia = rgbm(1, 0, 1, 1), green = rgbm(0, 0.5, 0, 1), lime = rgbm(0, 1, 0, 1), olive = rgbm(0.5, 0.5, 0, 1), yellow = rgbm(1, 1, 0, 1), orange = rgbm(1, 0.5, 0, 1), navy = rgbm(0, 0, 0.5, 1), blue = rgbm(0, 0, 1, 1), teal = rgbm(0, 0.5, 0.5, 1), cyan = rgbm(0, 0.5, 1, 1), aqua = rgbm(0, 1, 1, 1) }

---Four-channel color. Fourth value, `mult`, can be used for alpha, for brightness, anything like that. All operators are also 
---overloaded. White is usually `rgb=1,1,1`.
---@param r number? 
---@param g number? 
---@param b number? 
---@param mult number? 
---@return rgbm
function rgbm(r, g, b, mult) end

---Four-channel color. Fourth value, `mult`, can be used for alpha, for brightness, anything like that. All operators are also 
---overloaded. White is usually `rgb=1,1,1`.
---@class rgbm
---@field r number
---@field g number
---@field b number
---@field rgb rgb
---@field mult number
---@operator add(number|rgbm): rgbm
---@operator sub(number|rgbm): rgbm
---@operator mul(number|rgbm): rgbm
---@operator div(number|rgbm): rgbm
---@operator pow(number|rgbm): rgbm
---@operator len: number
---@operator unm: rgbm
local rgbm = nil

---Makes a copy of a vector.
---@return rgbm
function rgbm:clone() end

---Unpacks rgbm into rgb and number.
---@return rgb, number
function rgbm:unpack() end

---Turns rgbm into a table with four values.
---@return number[]
function rgbm:table() end

---Returns reference to rgbm class.
function rgbm:type() end

---@param rgb rgbm|rgb
---@param mult number?
---@return rgbm @Returns itself.
function rgbm:set(rgb, mult) end

---@param value1 rgbm
---@param value2 rgbm
---@param mix number
---@return rgbm @Returns itself.
function rgbm:setLerp(value1, value2, mix) end

---@param valueToAdd rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:add(valueToAdd, out) end

---@param valueToAdd rgbm
---@param scale number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:sub(valueToSubtract, out) end

---@param valueToMultiplyBy rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:div(valueToDivideBy, out) end

---@param exponent rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:pow(exponent, out) end

---@param multiplier number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:scale(multiplier, out) end

---@param otherValue rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:min(otherValue, out) end

---@param otherValue rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:max(otherValue, out) end

---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:saturate(out) end

---@param min rgbm
---@param max rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:clamp(min, max, out) end

---Makes sure brightest value does not exceed 1.
---@return rgbm @Returns itself.
function rgbm:normalize() end

---Returns brightest value.
---@return number
function rgbm:value() end

---Returns luminance value.
---@return number
function rgbm:luminance() end

---Returns color (rgb*mult).
---@return rgb
function rgbm:color() end

---Returns HSV color of rgb*mult.
---@return hsv
function rgbm:hsv() end

---Returns rgb*mult turned to vec3.
---@return vec3
function rgbm:vec3() end

---Returns vec4, where X, Y and Z are RGB values and W is mult.
---@return vec4
function rgbm:vec4() end

---Returns string with hex representation and leading “#”.
---@return string
function rgbm:hex() end

--[[ common/ac_primitive_quat.d.lua ]]

---Creates new quaternion. It’s usually faster to create a new item with `quat(x, y, z, w)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: quat): quat
---@overload fun(tableOfFour: number[]): quat
---@overload fun(value: number): quat
---@param x number?
---@param y number?
---@param z number?
---@param w number?
---@return quat
function quat.new(x, y, z, w) end

---Checks if value is quat or not.
---@param p any
---@return boolean
function quat.isquat(p) end

---Creates a new quaternion.
---@param angle number @In radians.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat
function quat.fromAngleAxis(angle, x, y, z) end

---Creates a new quaternion.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat
function quat.fromDirection(x, y, z) end

---Creates a new quaternion.
---@param u quat
---@param v quat
---@return quat
function quat.between(u, v) end

---Temporary quaternion. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return quat
function quat.tmp() end

---Quaternion. All operators are overloaded.
---@param x number? 
---@param y number? 
---@param z number? 
---@param w number? 
---@return quat
function quat(x, y, z, w) end

---Quaternion. All operators are overloaded.
---@class quat
---@field x number
---@field y number
---@field z number
---@field w number
local quat = nil

---Makes a copy of a quaternion.
---@return quat
function quat:clone() end

---Unpacks quat into four numbers.
---@return number, number, number, number
function quat:unpack() end

---Turns quat into a table with four values.
---@return number[]
function quat:table() end

---Returns reference to quat class.
function quat:type() end

---@param x quat|number
---@param y number?
---@param z number?
---@param w number?
---@return quat @Returns itself.
function quat:set(x, y, z, w) end

---@param angle number @In radians.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat @Returns itself.
function quat:setAngleAxis(angle, x, y, z) end

---@return number @Angle in radians.
---@return number @Axis, X.
---@return number @Axis, Y.
---@return number @Axis, Z.
function quat:getAngleAxis() end

---@param u quat
---@param v quat
---@return quat @Returns itself.
function quat:setBetween(u, v) end

---@param x vec3|number
---@param y number?
---@param z number?
---@return quat @Returns itself.
function quat:setDirection(x, y, z) end

---@param valueToAdd quat|number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:add(valueToAdd, out) end

---@param valueToSubtract quat|number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:sub(valueToSubtract, out) end

---@param valueToMultiplyBy quat
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:mul(valueToMultiplyBy, out) end

---@param multiplier number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:scale(multiplier, out) end

---@return number
function quat:length() end

---Normalizes itself (unless different `out` is provided).
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:normalize(out) end

---Rewrites own values with values of lerp of itself and other quaternion (unless different `out` is provided).
---@param otherVector quat
---@param mix number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:lerp(otherVector, mix, out) end

---Rewrites own values with values of slerp of itself and other quaternion (unless different `out` is provided).
---@param otherVector quat
---@param mix number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:slerp(otherVector, mix, out) end

--[[ lib_hashspace.lua ]]

---@class ac.HashSpaceItem
local HashSpaceItem = class('HashSpaceItem')

---Returns ID associated with an item.
---@return integer
function HashSpaceItem:id() end

---Moves an item to a position.
---@param pos vec3
function HashSpaceItem:update(pos) end

---Removes item from its space.
function HashSpaceItem:dispose() end

---Simple structure meant to speed up collision detection by arranging items in a grid using hashmap. Cells are arranged horizontally.
---@param cellSize number @Should be about twice as large as your largest entity.
---@return ac.HashSpace
function ac.HashSpace(cellSize) end

---Simple structure meant to speed up collision detection by arranging items in a grid using hashmap. Cells are arranged horizontally.
---@class ac.HashSpace
local _ac_HashSpace = nil

---Iterates items around given position.
---@generic T
---@param pos vec3
---@param callback fun(id: integer, callbackData: T)
---@param callbackData T?
function _ac_HashSpace:iterate(pos, callback, callbackData) end

---Checks if there are any items around given position.
---@param pos vec3
---@return boolean
function _ac_HashSpace:anyAround(pos) end

---Count amount of items around given position.
---@param pos vec3
---@return integer
function _ac_HashSpace:count(pos) end

---Returns raw pointers for given position for manual iteration. Be careful!
---@param pos vec3
---@return any, any
function _ac_HashSpace:rawPointers(pos) end

---Adds a new dynamic item to the grid. Each item gets a new ID.
---@return ac.HashSpaceItem
function _ac_HashSpace:add() end

---Adds a fixed item to the grid, with predetermined ID. Avoid mixing dynamic and fixed items in the same grid.
---@param id integer
---@param pos vec3
function _ac_HashSpace:addFixed(id, pos) end

--[[ lib_numlut.lua ]]

---Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
---```
---local lut = ac.Lut([[
--- -100 |  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---  -90 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---  -20 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---]], { 2 })
---assert(lut:calculate(-95)[1] == 0.5)
---```
---@class ac.Lut
---@explicit-contructor ac.Lut
local _ac_Lut = nil

---Interpolate for a given input, return a newly created table. Note: consider using `:calculateTo()` instead to avoid re-creating tables, it would work much more efficiently.
---@param input number
---@return number[]
function _ac_Lut:calculate(input) end

---Interpolate for a given input, write result to a given table.
---@param output number[]
---@param input number
---@return number[] @Same table as was provided in arguments.
function _ac_Lut:calculateTo(output, input) end

--[[ lib_numlut_jit.lua ]]

---Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
---```
---local lutJit = ac.LutJit:new{ data = {
---  { input = -100, output = {  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  { input =  -90, output = {  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  { input =  -20, output = {  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  }, hsvRows = { 2 }}
---assert(lutJit:calculate(-95)[1] == 1)
---```
---Obsolete. Use `ac.Lut` instead, with faster C++ implementation.
---@class ac.LutJit
---@deprecated
ac.LutJit = {}

---Creates new ac.LuaJit instance. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param data any
---@param hsvRows integer[] @ 1-based indices of columns (not rows) storing HSV values in them.
---@return table
function ac.LutJit:new(o, data, hsvRows) end

---Computes a new value. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param input number
---@return number[]
function ac.LutJit:calculate(input) end

---Computes a new value to a preexisting HSV value. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param output number[]
---@param input number
---@return number[] @Same table as was provided in arguments.
function ac.LutJit:calculateTo(output, input) end

--[[ lib_social.lua ]]

---Checks if a user is tagged as a friend. Uses CSP and CM databases. Deprecated, use `ac.DriverTags` instead.
---@deprecated
---@param driverName string @Driver name.
---@return boolean
function ac.isTaggedAsFriend(driverName) end

---Tags user as a friend (or removes the tag if `false` is passed). Deprecated, use `ac.DriverTags` instead.
---@deprecated
---@param driverName string @Driver name.
---@param isFriend boolean? @Default value: `true`.
function ac.tagAsFriend(driverName, isFriend) end

---Loads a ZIP file from a given URL, unpacks first KN5 from it to a cache folder and returns
---its filename through a callback. If file is already in cache storage, doesn’t do anything and
---simply returns filename to it. After callback is called, that filename could be used to load
---KN5 in the scene.
---
---If there is a VAO patch in a ZIP file, it will be extracted next to KN5.
---
---Note: only valid KN5 files and VAO patches are supported. Heavy caching is applied: if model was
---downloaded once, it would not be re-downloaded (unlike with remote textures where proper HTTP caching
---rules apply). If model was not accessed for a couple of weeks, it’ll be removed.
---
---If you need to download several entities and do something afterwards, it might help to use some
---promise Lua library.
---
---Use `web.loadRemoteAssets()` instead.
---@deprecated
---@param source string|{url: string, headers: table<string, string>} @URL to download, or, since 0.2.10, a table.
---@param callback fun(err: string, filename: string)
function web.loadRemoteModel(source, callback) end

---Loads a ZIP file from a given URL, unpacks first KsAnim from it to a cache folder and returns
---its filename through a callback. If file is already in cache storage, doesn’t do anything and
---simply returns filename to it. After callback is called, that filename could be used to animate
---objects in the scene. If animation was not accessed for a couple of weeks, it’ll be removed.
---
---If you need to download several entities and do something afterwards, it might help to use some
---promise Lua library.
---
---Use `web.loadRemoteAssets()` instead.
---@deprecated
---@param source string|{url: string, headers: table<string, string>} @URL to download, or, since 0.2.10, a table.
---@param callback fun(err: string, filename: string)
function web.loadRemoteAnimation(source, callback) end

---Loads a ZIP file from a given URL, unpacks assets from it to a cache folder and returns
---path to the folder in a callback. If files are already in cache storage, doesn’t do anything and
---simply returns the path. After callback is called, you can use path to the folder to get full paths to those assets.
---If assets are not accessed for a couple of weeks, they’ll be removed.
---
---Since 0.2.10, scripts with I/O access are allowed to extract all types of files using this function.
---@param source string|{url: string, headers: table<string, string>, crucial: string?} @URL to download, or, since 0.2.10, a table. Field `crucial` acts similar to `crucial` of `io.extractFromZipAsync()`.
---@param callback fun(err: string, folder: string)
function web.loadRemoteAssets(source, callback) end

---Resolve hostname, return IPv4 via a callback.
---@param url string
---@param callback fun(err: string?, response: string?)
function web.resolveDNS(url, callback) end

---@param key string
---@return string
function web.encryptKey(key) end

---Writes additional data to replay. Use `ac.readReplayBlob()` to extract data later in replay mode. Data written this way is not tied to frames.
---Don’t bother compressing data too much: when writing, data will be compressed automatically.
---@param key string @Existing data with the same key will be overwritten.
---@param data binary?
function ac.writeReplayBlob(key, data) end

---Reads additional data from replay if recorded with `ac.writeReplayBlob()`.
---@param key string
---@return binary?
function ac.readReplayBlob(key) end

---Create a new stream for recording data to replays. Write data in returned structure if not in replay mode, read data if in replay mode (use `sim.isReplayActive` to check if you need to write or read the data).
---Few important points:
--- - Each frame should not exceed 256 bytes to keep replay size appropriate. Limit for car scripts is lower, only 32 bytes.
--- - While data will be interpolated between frames during reading, directional vectors won’t be re-normalized.
--- - If two different apps would open a stream with the same layout, they’ll share a replay entry. Since 0.2.8, they’ll also share memory block, making `ac.ReplayStream()` act similar to `ac.connect()`.
--- - Each opened replay stream will persist through the entire AC session to be saved at the end. Currently, the limit is 320 streams per session (before 0.2.8, the limit was 128).
--- - Default values for unitialized frames are zeroes.
--- - Before 0.2.8, if game is launched in replay mode and there is no such data in replay, `ac.ReplayStream()` could return `nil`. Now, it’ll return the data, but it’ll be empty.
--- - Car scripts (both visual and physics) automatically add car ID and index to the key, ensuring uniqueness. Visual scripts can’t create new streams, but can access streams created by physics scripts, making it an effective way to pass data from physics to render, automatically being recorded in replays.
---@generic T
---@param layout T @A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Unlike other similar functions, here you shouldn’t use string, otherwise data blending won’t work.
---@param callback fun()? @Callback that will be called when replay stops. Use this callback to re-apply data from structure: at the moment of the call it will contain stuff from last recorded frame allowing you to restore the state of a simulation to when replay mode was activated.
---@param frameDivisor integer? @Set to 2 to skip one out of two frames when recording, or 3 to skip two out of three frames. Default value: `1` (no skipping). Reduces replay size.
---@return T @Might return `nil` if there is game is launched in replay mode and there is no such data stored in the replay.
function ac.ReplayStream(layout, callback, frameDivisor) end

---If any type restriction is set, binding will be shown as empty if there is no device fitting the restriction bound. If no type---restriction is set, any input device can be bound overriding all previously configured boundaries, or multiple bindings can be added---with a popup menu.
---@alias ui.ControlButtonControlFlags
---| `ui.ControlButtonControlFlags.None` @Value: 0.
---| `ui.ControlButtonControlFlags.Keyboard` @Type restriction: keyboard only.
---| `ui.ControlButtonControlFlags.Gamepad` @Type restriction: gamepad only.
---| `ui.ControlButtonControlFlags.Controllers` @Type restriction: controllers only.
---| `ui.ControlButtonControlFlags.NoKeyboard` @Type restriction: gamepad or controllers depending on input mode.
---| `ui.ControlButtonControlFlags.IgnoreConflicts` @Do not check if anything else in “controls.ini” is already using the input.
---| `ui.ControlButtonControlFlags.SingleEntry` @Don’t show multiple devices if bound, only a single one, remove other devices on bounding.
---| `ui.ControlButtonControlFlags.AlterRealConfig` @Copy changes to original presets with car-specific controls or presets-per-mode active (use it if your button is more of a global one, not relating to currently selected car).
---| `ui.ControlButtonControlFlags.NoDeleteUnbound` @Don’t unbound inputs by hovering button and pressing Delete.
---| `ui.ControlButtonControlFlags.NoContextMenu` @Use this flag if you want to add your own context menu.
---| `ui.ControlButtonControlFlags.NoHoldSwitch` @Don’t draw hold switch even if button should have one.
ui.ControlButtonControlFlags = {
  None = 0, ---@type ui.ControlButtonControlFlags #Value: 0.
  Keyboard = 1, ---@type ui.ControlButtonControlFlags #Type restriction: keyboard only.
  Gamepad = 2, ---@type ui.ControlButtonControlFlags #Type restriction: gamepad only.
  Controllers = 4, ---@type ui.ControlButtonControlFlags #Type restriction: controllers only.
  NoKeyboard = 6, ---@type ui.ControlButtonControlFlags #Type restriction: gamepad or controllers depending on input mode.
  IgnoreConflicts = 16, ---@type ui.ControlButtonControlFlags #Do not check if anything else in “controls.ini” is already using the input.
  SingleEntry = 32, ---@type ui.ControlButtonControlFlags #Don’t show multiple devices if bound, only a single one, remove other devices on bounding.
  AlterRealConfig = 64, ---@type ui.ControlButtonControlFlags #Copy changes to original presets with car-specific controls or presets-per-mode active (use it if your button is more of a global one, not relating to currently selected car).
  NoDeleteUnbound = 128, ---@type ui.ControlButtonControlFlags #Don’t unbound inputs by hovering button and pressing Delete.
  NoContextMenu = 256, ---@type ui.ControlButtonControlFlags #Use this flag if you want to add your own context menu.
  NoHoldSwitch = 512, ---@type ui.ControlButtonControlFlags #Don’t draw hold switch even if button should have one.
}

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
function ac.setColliderOffset(index, offset) end

---Resets wear value all box colliders where it is allowed.
function ac.resetColliderWears() end

---Gets wear value of a certain box collider.
---@param index integer
---@return number
function ac.getColliderWear(index) end

---Changes CD_GAIN and CL_GAIN of a wing, overriding values set in `aero.ini`.
---@param wingIndex integer
---@param cdGain number
---@param clGain number
function ac.setWingGain(wingIndex, cdGain, clGain) end

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

---Awakes car (it will roll downhill).
function ac.awakeCarPhysics() end

---Changes remaining engine life.
---@param grinding boolean|`true`|`false`
function ac.setGearsGrinding(grinding) end

---Changes time for gear shifting (alters `[GEARBOX] CHANGE_UP_TIME/CHANGE_DN_TIME/AUTO_CUTOFF_TIME`). Values are in milliseconds.
---@param gearUpTime number
---@param gearDownTime number
---@param autoCutoffTime number
function ac.setGearboxTimes(gearUpTime, gearDownTime, autoCutoffTime) end

---Allows and disallows car DRS. If DRS is already disallowed by track zones or physics API, wouldn’t override it, but allows to add more
--- conditions disallowing DRS further. If DRS is already engaged, it’ll be disengaged.
---@param active boolean|`true`|`false` @Set to `false` to disallow use of DRS.
function ac.allowCarDRS(active) end

---Overrides gas pedal value passed to engine. Unlike changing `.gas` property of car data, this one doesn’t show up in instruments, UI widgets and such.
---@param value number @Pass `math.huge` to disable override.
function ac.overrideGasInput(value) end

---Deactivates engine limiter. Use `ac.overrideGasInput()` to implement custom logic.
---@param disable boolean? @Default value: `true`.
function ac.disableEngineLimiter(disable) end

---Changes shifting RPM window simulating gearbox damage.
---@param value number
function ac.setDrivetrainDamageRPMWindow(value) end

---Alters tread efficiency at moving water away for unusual cases.
---@param tyres ac.Wheel
---@param value number
function ac.setRainTreadEfficiencyMultiplier(tyres, value) end

---Changes values of antiroll bars.
---@param kFront number
---@param kRear number
function ac.setAntirollBars(kFront, kRear) end

---Changes fuel consumption coefficient.
---@param value number
function ac.setFuelConsumption(value) end

---Changes current RPM.
---@param value number
function ac.setEngineRPM(value) end

---Changes current steering FFB. Be very careful with this function: crazy values might break some wheels or even hurt people
---using Direct Drive controllers.
---@param value number? @Pass `nil` (or `math.huge`) to disable override. Default value: `nil`.
function ac.setSteeringFFB(value) end

---Changes current steering damping effect. Might not work with some wheels, or be altered by FFB postprocessing script.
---Original AC uses damping for low speed effect only. Calling this function will stop that low speed damping effect from working.
---@param value number? @Pass `nil` (or `math.huge`) to disable override. Default value: `nil`.
function ac.setSteeringDamping(value) end

---Returns wheels inertia.
---@return number
function ac.getWheelsInertia() end

---Adds extra feedback torque from wheels to the engine.
---@param tyres ac.Wheel
---@param torque number
function ac.addWheelsFeedbackTorque(tyres, torque) end

---Changes current drivetrain root speed.
---@param value number
function ac.setDrivetrainRootVelocity(value) end

---Changes current drivetrain drive speed.
---@param value number
function ac.setDrivetrainDriveVelocity(value) end

---Changes max clutch torque.
---@param value number
function ac.setClutchMaxTorque(value) end

---Changes remaining engine life.
---@param value number @Value from 0 (broken engine) to 1000 (new one).
function ac.setEngineLifeLeft(value) end

---Enables or disables engine stalling. Engine with stall enabled wouldn’t automatically get extra RPM if engine is below certain
--- RPM. Note: if you’re using it for recreating manual engine start up, in the future it might lead to regular manual engine starting fix
--- applied to all cars getting disabled for yours.
---
--- Since 0.2.5 with its experiment to enabling stalling for all cars, using this function will stop CSP from handling stalling on its side.
---@param value boolean|`true`|`false`
function ac.setEngineStalling(value) end

---Enables engine stalling and sets this torque as active starter torque (set to 0 to enable stalling without active starter).
---@param torque number
function ac.setEngineStarterTorque(torque) end

---Changes water temperature.
---@param temperature number @Temperature in °C.
---@param disableOriginal boolean? @Set to `true` to completely disable original logic. Default value: `false`.
function ac.setWaterTemperature(temperature, disableOriginal) end

---Changes tyre inflation.
---@param tyres ac.Wheel
---@param inflation number @Set to 0 to blow up a tyre.
function ac.setTyreInflation(tyres, inflation) end

---Changes wear multiplier (rate at which tyre wears off, doesn’t alter existing wear).
---@param tyres ac.Wheel
---@param multiplier number? @Set to 0 to disable further wear accumulation. Default value: 1.
function ac.setTyreWearMultiplier(tyres, multiplier) end

---Changes temperatures of tyre patches getting them closer to `targetTemperature` with `transfer` intensity. Use carefully.
---@param tyres ac.Wheel
---@param targetTemperature number
---@param transfer number
function ac.shiftPatchTemperatures(tyres, targetTemperature, transfer) end

---Sets tyre blankets and invalidates current lap. If set, they would keep tyres at optimal temperature until car would reach 10 km/h,
---and then they would be removed. If you need to set tyres temperature for a moving car, use `physics.setTyresTemperature()`
---(to get optimal tyre temperature, use `ac.getCar(N).wheels[0].tyreOptimumTemperature`.
---@param tyres ac.Wheel
---@param blanketActive boolean? @True to set tyre blankets, false to remove. Default value: `true`.
function ac.setTyresBlankets(tyres, blanketActive) end

---You can also just use `car.turboWastegates[7]` if you less than 8 turbos.
---@param index integer
---@return number
function ac.getTurboUserWastegate(index) end

---Sets custom value for turbo wastegate (aka user setting).
---@param index integer
---@param value number
function ac.setTurboUserWastegate(index, value) end

---Change max turbo boost.
---@param index integer
---@param value number
function ac.setTurboMaxBoost(index, value) end

---Change turbo wastegate.
---@param index integer
---@param wastegate number
---@param isAdjustable boolean|`true`|`false`
function ac.setTurboWastegate(index, wastegate, isAdjustable) end

---Change extra turbo parameters.
--- Use `ac.setTurboExtras2()` instead, this one incorrectly handles lag values.
---@deprecated
---@param index integer
---@param lagUp number
---@param lagDown number
---@param referenceRpm number
---@param gamma number
function ac.setTurboExtras(index, lagUp, lagDown, referenceRpm, gamma) end

---Change extra turbo parameters. This version handles lag values properly. Available since CSP 0.2.5.
---@param index integer
---@param lagUp number
---@param lagDown number
---@param referenceRpm number
---@param gamma number
function ac.setTurboExtras2(index, lagUp, lagDown, referenceRpm, gamma) end

---Overrides turbo boost completely. Note: once used, original turbo logic would no longer apply, all original settings would
--- no longer matter (except for adjustable flag).
---@param index integer @0-based index. Pass `-1` to alter final turbo value used by original AC instruments, audio and such.
---@param newBoost number? @Pass `nil` to revert to original turbo. If negative and no `instrumentsBoost` is provided, negative value is only shown visually and won’t affect physics. Default value: `nil`.
---@param instrumentsBoost number? @If set, `newBoost` can be negative, and this is the value that will be shown on CSP turbo instruments. Default value: `nil`.
function ac.overrideTurboBoost(index, newBoost, instrumentsBoost) end

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
function ac.debugSleep(sleepMs) end

---@return boolean
function ac.isDebugDrawActive() end

---Draw a line to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
---disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.
---
--- Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.
---@param from vec3
---@param to vec3
---@param color rgbm
function ac.drawDebugLine(from, to, color) end

---Draw an arrow to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
---disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.
---
--- Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.
---@param from vec3
---@param to vec3
---@param color rgbm
function ac.drawDebugArrow(from, to, color) end

---Draw a square to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
---disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.
---
--- Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.
---@param pos vec3
---@param nm vec3
---@param size number
---@param color rgbm
function ac.drawDebugSquare(pos, nm, size, color) end

---Draw a box to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
---disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.
---
--- Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.
---@param center vec3
---@param size vec3
---@param color rgbm
function ac.drawDebugBox(center, size, color) end

---Draw a cross to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
---disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.
---
--- Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.
---@param center vec3
---@param size number
---@param color rgbm
function ac.drawDebugCross(center, size, color) end

---Draw some text to highlight what’s going on with physics. Coordinates are in world-space. Use CSP Debug app to activate render of those lines (it’s
---disabled by default to keep things fast). Still, consider removing these calls from the final version of your script to keep things even faster.
---
--- Unlike “render.” functions, this one can be called in “script.update()”, the calls will be stored to be realized later.
---@param center vec3
---@param text string
---@param color rgbm
function ac.drawDebugText(center, text, color) end

---Returns a reference to a custom script setup item. If there is no item with such ID, returns `nil`. Call once
---and reuse returned reference to keep things fast.
---@param id string @ID from section in “setup.ini”.
---@return refnumber?
function ac.getScriptSetupValue(id) end

---Set extra weight to a certain position of a car. Each time this function is called with a new `pos` value,
---new weight will be created (can create up to 4 only). Call is free if the position, weight and mass box doesn’t change.
---@param pos vec3 @Position in meters relative to car.
---@param mass number @Mass value in kg.
---@param massBox vec3? @Inertia box (size of a mass item in meters). Default value: `vec3(1, 1, 1)`.
function ac.setExtraMass(pos, mass, massBox) end

---Report current setup as incompatible preventing user from start the race. Calling it while car is already driving won’t make a difference.
---@param reason string|nil @Please specify what exactly is wrong (not used yet, will be used a bit later. Default value: `nil`.
function ac.reportIncompatibleSetup(reason) end

---Sets a callback which will be called when user changes a setup value matching filter. Doesn’t react to setup values being changed by anything else.
---@param filter string @Section name or filter (use “?” for wildcards.
---@param callback fun(id: string, value: number)
---@return ac.Disposable
function ac.onSetupValueChange(filter, callback) end

---Returns a reference to a setup item value. If there is no item with such index, returns `nil`. Call once
---and reuse returned reference to keep things fast.
---@param id string @ID from section in “setup.ini”.
---@return refnumber?
function ac.getSetupValue(id) end

---Changes value of a setup item by its ID. Better to not call this function every frame (or maybe not even call at all
---to respect user setup).
---@param id string @ID from section in “setup.ini”.
---@param value number
---@return boolean @Returns `false` if there is no such item.
function ac.setScriptSetupValue(id, value) end

---Allows to access a dynamic controller in an INI file. If there is no such controller, returns `nil`.
---@param name string @For example, `'ctrl_script.ini'`.
---@return refnumber?
function ac.getDynamicController(name) end

---Changes current RPM limit.
---@param newValue number
---@param scaleInstruments boolean? @Default value: `false`.
function ac.setEngineRPMLimit(newValue, scaleInstruments) end

---Call this function to prevent a certain extra switch from activating. Unlike similar function available to car displays and such,
---this one can’t be altered without altering car data and overrides all the checks including extra switch activation API.
---@param index integer @0-based switch index.
---@param disallow boolean? @Default value: `false`.
---@param forceDisable boolean? @Set to `true` to forcefully disable the switch. Default value: `false`.
function ac.disallowExtraSwitch(index, disallow, forceDisable) end

---Override ERP and CFM for a certain suspension joint. Add `[_AC_LINK_ALTERATION] PRINT_OUT=1` to “suspensions.ini” of
---a car with extended physics to see the list of suspension joints in CSP log during loading.
---@param wheel integer @0-based wheel index.
---@param joint integer @0-based joint index (within the list of all suspension joints).
---@param erp number
---@param cfm number
---@return boolean @Returns `false` if there is no such wheel or joint.
function ac.suspensionJointConfigure(wheel, joint, erp, cfm) end

---Return a connection point for a certain suspension distance joint in world space. Add `[_AC_LINK_ALTERATION] PRINT_OUT=1` to “suspensions.ini” of
---a car with extended physics to see the list of suspension joints in CSP log during loading.
---@param dst vec3 @Pass a reference to `vec3()` to get the value.
---@param wheel integer @0-based wheel index.
---@param joint integer @0-based joint index (within the list of all suspension joints).
---@param wheelSize boolean|`true`|`false` @Set to `true` to get position on wheel side (relative to wheel) or `false` to get position on body side (relative to body).
---@return boolean @Returns `false` if there is no such wheel or joint, or if it’s not a distance joint.
function ac.getSuspensionJointPointTo(dst, wheel, joint, wheelSize) end

---Change connection points for a certain suspension distance joint. Add `[_AC_LINK_ALTERATION] PRINT_OUT=1` to “suspensions.ini” of
---a car with extended physics to see the list of suspension joints in CSP log during loading.
---
---This function changes connection points keeping distance the same, meaning if your connection points moved further away bodies
---will be forced closer together to maintain the distance.
---
---If you’re using Suspension Debug App, lines won’t shift as they are still drawn based on original suspension geometry. Instead, you can use
---`ac.getSuspensionJointPointTo()` to get coordinates of those points, and `ac.drawDebugLine()` to draw it (use CSP Debug app to activate render of those lines).
---@param wheel integer @0-based wheel index.
---@param joint integer @0-based joint index (within the list of all suspension joints).
---@param posBody vec3 @Body connection point, coordinates relative to car body.
---@param posHub vec3 @Hub connection point, coordinates relative to wheel hub.
---@return boolean @Returns `false` if there is no such wheel or joint, or if it’s not a distance joint.
function ac.suspensionJointReseat(wheel, joint, posBody, posHub) end

---Change distance for a certain suspension distance joint. Add `[_AC_LINK_ALTERATION] PRINT_OUT=1` to “suspensions.ini” of
---a car with extended physics to see the list of suspension joints in CSP log during loading.
---
---This function changes distance keeping connection points the same, meaning if your new distance is larger bodies will be moved
---further away.
---
---If you’re using Suspension Debug App, lines won’t shift as they are still drawn based on original suspension geometry. Instead, you can use
---`ac.getSuspensionJointPointTo()` to get coordinates of those points, and `ac.drawDebugLine()` to draw it (use CSP Debug app to activate render of those lines).
---@param wheel integer @0-based wheel index.
---@param joint integer @0-based joint index.
---@param distance number @Distance in meters.
---@return boolean @Returns `false` if there is no such wheel or joint, or if it’s not a distance joint.
function ac.suspensionJointReseatDistance(wheel, joint, distance) end

---Pauses subsequent `update()` calls for the script until a certain condition is met. Can save some CPU time. Disabling
---does not stop callbacks or timers. Multiple conditions can be combined with `bit.bor()`. Pausing will be disabled
---the next time script activates, so make sure to pause it when you’re done with processing.
---@param condition ac.ScriptResumeCondition
function ac.pauseScriptUntil(condition) end

---Changes AI base lookahead value. Use `ac.INIConfig.carData(carIndex, 'ai.ini'):get('LOOKAHEAD', 'BASE', 12)` to
---load original value first and go from there (don’t re-read it each frame though, it’ll get expensive).
---@param value number @New value.
function ac.setAILookaheadBase(value) end

---Changes AI gas/brake lookahead value. Use `ac.INIConfig.carData(carIndex, 'ai.ini'):get('LOOKAHEAD', 'GAS_BRAKE_LOOKAHEAD', 10)` to
---load original value first and go from there (don’t re-read it each frame though, it’ll get expensive).
---@param value number @New value.
function ac.setAILookaheadGasBrake(value) end

---Changes AI brake hint value. Use `ac.INIConfig.carData(carIndex, 'ai.ini'):get('PEDALS', 'BRAKE_HINT', 1)` to
---load original value first and go from there (don’t re-read it each frame though, it’ll get expensive).
---@param value number @New value.
function ac.setAIBrakeHint(value) end

---Changes extra AI grip (120% by default).
---@param value number @Set to 1 for normal grip.
function ac.setExtraAIGrip(value) end

---Controls if AI goes to pits or not.
---@param value boolean? @Default value: `true`.
function ac.setAIPitStopRequest(value) end

---Triggers brake mistake causing wheels to lock on braking.
---@param time number @Mistake time in seconds.
function ac.setAIBrakeMistake(time) end

---Triggers traction mistake.
---@param time number @Mistake time in seconds.
---@param severity number @Severity, acts like gas pedal multiplier.
function ac.setAITractionMistake(time, severity) end

---@param value number
function ac.setKERSCharge(value) end

---@param value number
function ac.setKERSCurrentKJ(value) end

---Changes behaviour of smoke going off a tyre (won’t affect dust or water splashes). Actual movement of smoke might change with CSP updates.
---@param tyreIndex integer
---@param intensity number @Use `math.nan` to restore original behaviour, or a value from 0 to 1.
---@param thickness number @A value from 0 to 1.
---@param surfaceHeat number? @Values above 0 will get entire surface to emit smoke as well. Default value: 0.
function ac.overrideTyreSmoke(tyreIndex, intensity, thickness, surfaceHeat) end

---Changes label used to display current gear. Label can be up to four symbols long. If label is 2 characters or less, it’ll be stored in a replay as well
---(do any gearboxes have labels longer than that?) Can be useful for creating automatic gearboxes and such: AC widgets will use this label, and other apps can access the label
---using `ac.getCar().gearLabel`.
---@param c string|nil @If empty or `nil`, resets label to default gear label. Default value: `nil`.
function ac.setGearLabel(c) end

---@param mode integer
function ac.setABS(mode) end

---@param mode integer
function ac.setTC(mode) end

---@param turboIndex integer
---@return boolean
function ac.isTurboWastegateAdjustable(turboIndex) end

---@param balance number
function ac.setBrakeBias(balance) end

---@param settingIndex integer
function ac.setEngineBrakeSetting(settingIndex) end

---@param state boolean|`true`|`false`
function ac.setDRS(state) end

---@param state boolean|`true`|`false`
function ac.setKERS(state) end

---@param charging boolean|`true`|`false`
function ac.setMGUHCharging(charging) end

---@param level integer
function ac.setMGUKDelivery(level) end

---@param level integer
function ac.setMGUKRecovery(level) end

function ac.switchToNeutralGear() end

---@param active boolean|`true`|`false`
function ac.setHeadlights(active) end

---Activates flashing lights for a bit.
function ac.flashLights() end

---Sets index of current wiper speed. To get current speed or number of available speeds, check `ac.StateCar`.
---@param wiperMode integer @Wiper mode index from 0 (disabled) to `ac.StateCar.wiperModes` (excluding).
function ac.setWiperMode(wiperMode) end

---Toggles high beams on and off. Note: the way lights work, this only changes if high beams are working with low beams or if low beams are alone (and,
---in reality, they actually switch a low-beam flag used to switch headlights into low-beam mode). To flash high beams without low beams,
---use `ac.flashLights()`.
---@param active boolean|`true`|`false`
function ac.setHighBeams(active) end

---@param active boolean|`true`|`false`
function ac.setDaytimeLights(active) end

---@param threshold number? @Default value: 0.01.
function ac.setBrakingLightsThreshold(threshold) end

---@param mode ac.TurningLights
function ac.setTurningLights(mode) end

---Changes the state of an extra switch. Note: if switch is in hold mode, it’ll reset to its disabled state after a few frames.
--- This function ignores availability checks (but wouldn’t work if the switch has been disabled from car custom physics script).
---@param index integer @0-based index.
---@param value boolean|`true`|`false`
---@return boolean
function ac.setExtraSwitch(index, value) end

---Checks if an extra switch is available.
---@param index integer @0-based index.
---@param availableToCarControl boolean? @Car control scripts can toggle a switch even if it’s not available to user with switch flags unless switch has been disabled by car physics script. Set this parameter to `false` to check if user can toggle the state with a hotkey, or leave it as `true` if you need to verify if the switch hasn’t been disabled by physics. Default value: `true`.
---@return boolean
function ac.isExtraSwitchAvailable(index, availableToCarControl) end

---Returns `true` if script can affect physics engine. If not, only `physics.raycastTrack()` is available.
---@return boolean
function physics.allowed() end

---Casts a ray from given position in a certain direction to check if it hits any physics surfaces. Returns distance to a hit,
---or -1 if there wasn’t any. Optionally can return contact point and normal too, if vectors in their place are passed.
---
---Note: smaller rays are faster to cast. Also, rays going straight down are slightly faster as well.
---@param pos vec3
---@param dir vec3
---@param length number
---@param point vec3|nil @Default value: `nil`.
---@param normal vec3|nil @Default value: `nil`.
---@return number
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
---@field dirt number
---@field collisionCategory integer
---@field isValidTrack boolean
---@field blackFlagTime number
---@field sinHeight number
---@field sinLength number
---@field isPitlane boolean
---@field damping number
---@field granularity number
---@field vibrationGain number
---@field vibrationLength number
local _ac_StateCphysSurface = nil

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

--[[ common/ac_extras_binaryinput.lua ]]

---A good way to listen to user pressing buttons configured in AC control settings. Handles everything for you automatically, and if you’re working
---on a Lua app has a `:control()` method drawing a button showing current binding and allowing to change it in-game.
---
---Could be used for original AC button bindings, new bindings added by CSP, or even for creating custom bindings. For that, make sure to pass a
---reliably unique ID when creating a control button, maybe even prefixed by your app name.
---
---Note: inputs for car scripts (both display and physics ones) would work only if the car is currently controlled by the user and not in a replay.
---When possible, consider binding to car state instead. If your script runs at lower rate than graphics thread (skipping frames), either use `:down()`
---or, better yet, sign to events, `:pressed()` call might return `false`.
---@class ac.ControlButton
local _ac_ControlButton = nil

---Button is configured.
---@return boolean
function _ac_ControlButton:configured() end

---Button is disabled.
---@return boolean
function _ac_ControlButton:disabled() end

---Button is using hold mode.
---@return boolean
function _ac_ControlButton:holdMode() end

---Button was just pressed. For buttons in hold mode returns `true` on both press and release.
---@return boolean
function _ac_ControlButton:pressed() end

---Button was just released. For buttons in hold mode returns `true` on both press and release.
---@return boolean
function _ac_ControlButton:released() end

---Button is held down. For buttons in hold mode works similar to `:pressed()`.
---@return boolean
function _ac_ControlButton:down() end

---Sets a callback to be called when the button is pressed. For buttons in hold mode calls callback on both presses and releases. If button is held down
---when this method is called, callback will be called the next frame.
---@param callback fun()
---@return ac.Disposable
function _ac_ControlButton:onPressed(callback) end

---Sets a callback to be called when the button is released. For buttons in hold mode calls callback shortly after both presses and releases.
---@param callback fun()
---@return ac.Disposable
function _ac_ControlButton:onReleased(callback) end

---Always active buttons work even if AC is paused or in, for example, pits menu.
---@param value boolean? @Default value: `true`.
---@return ac.ControlButton
function _ac_ControlButton:setAlwaysActive(value) end

---Disabled buttons ignore presses but remember their settings.
---@param value boolean? @Default value: `true`.
---@return ac.ControlButton
function _ac_ControlButton:setDisabled(value) end

--[[ common/ac_car_control_physics.lua ]]

---A helper structure to simulate some inputs for controlling the car.
---@class ac.CarExtraSwitchParams
---@field unavailable boolean @Set to `true` to make a switch inaccessible by user with hotkeys. Car controlling scripts would still be able to alter its state.
---@field holdMode boolean @Set to `true` to get switch to work only if a button is currently held down.
---@field stationaryOnly boolean @Set to `true` to only allow user to change the flag if car is stationary.
---@field neutralGearOnly boolean @Set to `true` to only allow user to change the flag if car is in neutral gear.
---@field requiresBrake boolean @Set to `true` to only allow user to change the flag if brake pedal is fully pressed.
local _ac_CarExtraSwitchParams = nil

---@param index integer @0-based switch index.
---@return ac.CarExtraSwitchParams? @Returns `nil` if there is no switch with such index.
function ac.accessExtraSwitchParams(index) end

--[[ common/ac_physics_raycast.lua ]]

---Physics namespace. Provides access to physics raycast only. For more functions, try a different type of script.
physics = {}
