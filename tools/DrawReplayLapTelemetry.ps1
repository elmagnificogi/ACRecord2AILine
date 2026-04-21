#Requires -Version 5.1
<#
.SYNOPSIS
  Generic replay lap analyzer: detect brake/throttle onsets and render trajectory markers.
  If replay/corners data files are missing, they are auto-generated from the provided replay.
#>
param(
    [string]$JsonPath = '',
    [string]$TrackFolder = '',
    [string]$CornersJson = '',
    [string]$ReplayPath = '',
    [string]$AcRpPath = '',
    [string]$DriverName = '',
    [string]$OutputPath = '',
    [int]$Lap = 0,
    [bool]$AutoFastestLap = $true,
    [double]$MinSegmentMeters = 50.0,
    [int]$ImageWidth = 1800,
    [int]$ImageHeight = 1350,
    [double]$InnerMarginPercent = 5.0,
    [float]$FontSizeTitle = 20.0,
    [float]$FontSizeMarker = 14.0,
    [double]$BrakeMinSeconds = 0.3,
    [double]$ThrottleMinSeconds = 0.5,
    [int]$BrakePedalThreshold = 25,
    [int]$GasPedalThreshold = 180,
    [double]$GasReapplyMinSeconds = 0.06,
    [int]$GasReapplyThreshold = 60,
    [int]$GasReapplyDelta = 20,
    [int]$GasReapplyBrakeMax = 20,
    [bool]$AllowOverlapThrottleBetweenBrakes = $true,
    [double]$SectorExpandMeters = 20.0,
    [switch]$DebugEventTrace,
    [string]$DebugOutputPath = '',
    [switch]$HideCornerCenterLabel,
    [switch]$NoVerticalFlip,
    [switch]$FlipWorldZ,
    [switch]$KeepIntermediateFiles
)

$ErrorActionPreference = 'Stop'
# PS2EXE 嵌入执行时 $PSScriptRoot / $PSCommandPath 可能为空；
# 优先使用进程主模块路径，确保在“当前目录不等于exe目录”时也能稳定定位工具目录。
$toolDir = $null
if ($PSCommandPath) {
    $toolDir = Split-Path -LiteralPath $PSCommandPath
} elseif ($PSScriptRoot) {
    $toolDir = $PSScriptRoot
} else {
    try {
        $exePath = [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
        if ($exePath -and (Test-Path -LiteralPath $exePath)) {
            $toolDir = Split-Path -LiteralPath $exePath
        }
    } catch { }
    if (-not $toolDir) {
        $a0 = [Environment]::GetCommandLineArgs()[0]
        if ($a0 -and (Test-Path -LiteralPath $a0)) {
            $toolDir = Split-Path -LiteralPath $a0
        } else {
            $toolDir = (Get-Location).Path
        }
    }
}
if (-not $toolDir) { throw 'Cannot resolve tool directory (expected exe or .ps1 path).' }
if (-not $TrackFolder) { $TrackFolder = Join-Path (Split-Path $toolDir -Parent) 'zhuhai' }
Add-Type -AssemblyName System.Drawing

$capPath = Join-Path $toolDir 'draw_trajectory_captions.json'
$cap = [pscustomobject]@{ sf = 'S/F'; titlePrefix = 'Replay Lap Analysis'; legend = 'Blue=track Orange=S/F Red=brake Green=throttle' }
if (Test-Path -LiteralPath $capPath) {
    $cj = ConvertFrom-JsonFile $capPath
    if ($cj.sf) { $cap.sf = [string]$cj.sf }
    if ($cj.titlePrefix) { $cap.titlePrefix = [string]$cj.titlePrefix }
    if ($cj.legend) { $cap.legend = [string]$cj.legend }
}

function Resolve-FsPath([string]$Path) {
    if ([string]::IsNullOrWhiteSpace($Path)) { return $Path }
    $p = $Path.Trim()
    while ($p.Length -ge 2 -and (
        ($p.StartsWith('"') -and $p.EndsWith('"')) -or
        ($p.StartsWith("'") -and $p.EndsWith("'"))
    )) {
        $p = $p.Substring(1, $p.Length - 2).Trim()
    }
    if ($p.StartsWith('~')) {
        $rest = $p.Substring(1).TrimStart('\', '/')
        $p = if ($rest) { Join-Path $HOME $rest } else { $HOME }
    }
    return [IO.Path]::GetFullPath($p)
}

function Get-JsonTextFromBytes([byte[]]$bytes) {
    if ($null -eq $bytes -or $bytes.Length -eq 0) { return [string]::Empty }
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        return [Text.Encoding]::UTF8.GetString($bytes, 3, $bytes.Length - 3)
    }
    if ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE) {
        return [Text.Encoding]::Unicode.GetString($bytes, 2, $bytes.Length - 2)
    }
    if ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFE -and $bytes[1] -eq 0xFF) {
        return [Text.Encoding]::BigEndianUnicode.GetString($bytes, 2, $bytes.Length - 2)
    }
    return [Text.Encoding]::UTF8.GetString($bytes)
}

function ConvertFrom-JsonFile([string]$LiteralPath) {
    $bytes = [IO.File]::ReadAllBytes($LiteralPath)
    $text = Get-JsonTextFromBytes $bytes
    try {
        return ($text | ConvertFrom-Json)
    } catch {
        $errUtf = $_.Exception.Message
        try {
            $gb = [Text.Encoding]::GetEncoding(936)
            return ($gb.GetString($bytes) | ConvertFrom-Json)
        } catch {
            throw "JSON parse failed (UTF-8/UTF-16 then CP936): $LiteralPath — $errUtf"
        }
    }
}

function Get-FileStem([string]$pathOrName, [string]$fallback) {
    if ([string]::IsNullOrWhiteSpace($pathOrName)) { return $fallback }
    $nm = [IO.Path]::GetFileNameWithoutExtension($pathOrName)
    if ([string]::IsNullOrWhiteSpace($nm)) { return $fallback }
    return $nm
}

function Clamp-Int([int]$v, [int]$lo, [int]$hi) {
    if ($v -lt $lo) { return $lo }
    if ($v -gt $hi) { return $hi }
    return $v
}

function Get-SfCrossingIndices($j) {
    $cross = New-Object System.Collections.Generic.List[int]
    if (-not $j.currentLapTime -or ($j.currentLapTime.Count -ne $j.x.Count)) { return $cross }
    for ($i = 1; $i -lt $j.currentLapTime.Count; $i++) {
        $a = [int]$j.currentLapTime[$i - 1]; $b = [int]$j.currentLapTime[$i]
        $lapInc = [int]$j.currentLap[$i] - [int]$j.currentLap[$i - 1]
        if (($a - $b -gt 500) -or ($lapInc -gt 0)) {
            $prev = if ($cross.Count -gt 0) { $cross[$cross.Count - 1] } else { -9999 }
            if (($i - $prev) -gt 2) { [void]$cross.Add($i) }
        }
    }
    return $cross
}

function Measure-ArcJson($j, [int]$i0, [int]$i1Exclusive) {
    $s = 0.0; $px = $null; $py = $null; $pz = $null
    for ($i = $i0; $i -lt $i1Exclusive; $i++) {
        $x = [double]$j.x[$i]; $y = [double]$j.y[$i]; $z = [double]$j.z[$i]
        if ($null -ne $px) {
            $dx = $x - $px; $dy = $y - $py; $dz = $z - $pz
            $s += [Math]::Sqrt($dx * $dx + $dy * $dy + $dz * $dz)
        }
        $px = $x; $py = $y; $pz = $z
    }
    return $s
}

function Select-TimingSegment($j, [int]$LapVal, [double]$MinSeg) {
    $cross = Get-SfCrossingIndices $j
    if ($cross.Count -lt 2) { return @{ Start = -1; End = -1; Length = 0.0; Mode = 'no_crossings' } }
    $bestLen = -1.0; $bestA = -1; $bestB = -1
    for ($k = 0; $k -lt $cross.Count - 1; $k++) {
        $a = $cross[$k]; $b = $cross[$k + 1]
        if ([int]$j.currentLap[$a] -ne $LapVal) { continue }
        $len = Measure-ArcJson $j $a $b
        if ($len -gt $bestLen) { $bestLen = $len; $bestA = $a; $bestB = $b }
    }
    if ($bestA -lt 0) { return @{ Start = -1; End = -1; Length = 0.0; Mode = 'no_match' } }
    if ($bestLen -lt $MinSeg) { return @{ Start = -1; End = -1; Length = $bestLen; Mode = 'segment_too_short' } }
    return @{ Start = $bestA; End = $bestB; Length = $bestLen; Mode = 'ok' }
}

function Select-FastestTimingSegment($j, [double]$MinSeg) {
    $cross = Get-SfCrossingIndices $j
    if ($cross.Count -lt 2) { return @{ Start = -1; End = -1; Length = 0.0; Mode = 'no_crossings'; Lap = -1; TimeMs = -1 } }

    $best = $null
    for ($k = 0; $k -lt $cross.Count - 1; $k++) {
        $a = $cross[$k]; $b = $cross[$k + 1]
        $lapVal = [int]$j.currentLap[$a]
        $len = Measure-ArcJson $j $a $b
        if ($len -lt $MinSeg) { continue }

        $timeMs = -1
        if ($j.PSObject.Properties.Name -contains 'currentLapTime') {
            $ti = [int]$j.currentLapTime[[Math]::Max($a, $b - 1)]
            if ($ti -gt 0) { $timeMs = $ti }
        }
        if ($timeMs -le 0) {
            $dt = Get-FrameDtSeconds $j
            $timeMs = [int][Math]::Round(($b - $a) * $dt * 1000.0)
        }

        $cand = @{
            Start = $a
            End = $b
            Length = $len
            Mode = 'ok'
            Lap = $lapVal
            TimeMs = $timeMs
        }
        if ($null -eq $best -or $cand.TimeMs -lt $best.TimeMs) {
            $best = $cand
        }
    }

    if ($null -eq $best) { return @{ Start = -1; End = -1; Length = 0.0; Mode = 'no_valid_segment'; Lap = -1; TimeMs = -1 } }
    return $best
}

function Get-SpeedKmh($j, [int]$fi) {
    $vx = [double]$j.velocityX[$fi]; $vy = [double]$j.velocityY[$fi]; $vz = [double]$j.velocityZ[$fi]
    return [Math]::Sqrt($vx * $vx + $vy * $vy + $vz * $vz) * 3.6
}

function Get-FrameDtSeconds($j) {
    if ($j.PSObject.Properties.Name -contains 'recordingInterval') {
        $ri = [double]$j.recordingInterval
        if ($ri -gt 0 -and $ri -le 100.0) { return $ri / 1000.0 }
        if ($ri -gt 100.0) { return 1.0 / $ri }
    }
    return (1.0 / 60.0)
}

function Format-LapTime([int]$timeMs) {
    if ($timeMs -lt 0) { return 'N/A' }
    $ts = [TimeSpan]::FromMilliseconds($timeMs)
    return ('{0:D2}:{1:D2}.{2:D3}' -f [int]$ts.Minutes, [int]$ts.Seconds, [int]$ts.Milliseconds)
}

function Get-BoundariesFromSegmentEnds([double[]]$ends) {
    if ($ends.Count -ne 14) { throw 'segmentEndFraction must have 14 elements, last=1.0' }
    if ([Math]::Abs($ends[13] - 1.0) -gt 0.001) { throw 'segmentEndFraction[13] must be 1.0' }
    $b = New-Object double[] 15
    $b[0] = 0.0
    for ($i = 0; $i -lt 14; $i++) { $b[$i + 1] = $ends[$i] }
    return $b
}

function Find-KRangeForArc([double[]]$sArr, [double]$lapLen, [double]$f0, [double]$f1, [int]$m) {
    $s0 = [Math]::Max(0.0, $f0 * $lapLen)
    $s1 = [Math]::Min($lapLen, $f1 * $lapLen)
    $k0 = 0
    for ($k = 0; $k -lt $m; $k++) {
        if ($sArr[$k] -ge $s0) { $k0 = $k; break }
    }
    $k1 = $m - 1
    for ($k = $m - 1; $k -ge 0; $k--) {
        if ($sArr[$k] -le $s1) { $k1 = $k; break }
    }
    if ($k1 -lt $k0) { $k1 = $k0 }
    return $k0, $k1
}

function Find-KClosestToS([double[]]$sArr, [double]$targetS, [int]$k0, [int]$k1) {
    $best = $k0
    $bd = [Math]::Abs($sArr[$k0] - $targetS)
    for ($k = $k0; $k -le $k1; $k++) {
        $d = [Math]::Abs($sArr[$k] - $targetS)
        if ($d -lt $bd) { $bd = $d; $best = $k }
    }
    return $best
}

function Find-FirstSustainedAbove([int[]]$vals, [int]$k0, [int]$k1, [int]$thr, [int]$minFrames) {
    if ($minFrames -lt 1) { $minFrames = 1 }
    for ($start = $k0; $start -le $k1; $start++) {
        if ($vals[$start] -lt $thr) { continue }
        $ok = $true
        for ($i = 0; $i -lt $minFrames; $i++) {
            $kk = $start + $i
            if ($kk -gt $k1) { $ok = $false; break }
            if ($vals[$kk] -lt $thr) { $ok = $false; break }
        }
        if ($ok) { return $start }
    }
    return -1
}

function Find-FirstRisingSustainedAbove([int[]]$vals, [int]$k0, [int]$k1, [int]$thr, [int]$minFrames) {
    if ($minFrames -lt 1) { $minFrames = 1 }
    $st0 = [Math]::Max(1, $k0)
    for ($start = $st0; $start -le $k1; $start++) {
        # Rising edge: previous frame below threshold, current frame reaches threshold.
        if ($vals[$start - 1] -ge $thr) { continue }
        if ($vals[$start] -lt $thr) { continue }
        $ok = $true
        for ($i = 0; $i -lt $minFrames; $i++) {
            $kk = $start + $i
            if ($kk -gt $k1) { $ok = $false; break }
            if ($vals[$kk] -lt $thr) { $ok = $false; break }
        }
        if ($ok) { return $start }
    }
    return -1
}

function Find-FirstGasReapply([int[]]$gasVals, [int[]]$brkVals, [int]$k0, [int]$k1, [int]$minGas, [int]$minDelta, [int]$brakeMax, [int]$minFrames) {
    if ($minFrames -lt 1) { $minFrames = 1 }
    $st0 = [Math]::Max(1, $k0)
    for ($start = $st0; $start -le $k1; $start++) {
        if ($brkVals[$start] -gt $brakeMax) { continue }
        if ($gasVals[$start] -lt $minGas) { continue }
        if (($gasVals[$start] - $gasVals[$start - 1]) -lt $minDelta) { continue }
        $ok = $true
        for ($i = 0; $i -lt $minFrames; $i++) {
            $kk = $start + $i
            if ($kk -gt $k1) { $ok = $false; break }
            if ($gasVals[$kk] -lt $minGas) { $ok = $false; break }
            if ($brkVals[$kk] -gt $brakeMax) { $ok = $false; break }
        }
        if ($ok) { return $start }
    }
    return -1
}

function Find-FirstGasReapplyOverlap([int[]]$gasVals, [int]$k0, [int]$k1, [int]$minGas, [int]$minDelta, [int]$minFrames) {
    if ($minFrames -lt 1) { $minFrames = 1 }
    $st0 = [Math]::Max(1, $k0)
    for ($start = $st0; $start -le $k1; $start++) {
        if ($gasVals[$start] -lt $minGas) { continue }
        if (($gasVals[$start] - $gasVals[$start - 1]) -lt $minDelta) { continue }
        $ok = $true
        for ($i = 0; $i -lt $minFrames; $i++) {
            $kk = $start + $i
            if ($kk -gt $k1) { $ok = $false; break }
            if ($gasVals[$kk] -lt $minGas) { $ok = $false; break }
        }
        if ($ok) { return $start }
    }
    return -1
}

function Get-ContiguousRunEnd([int[]]$vals, [int]$start, [int]$k1, [int]$thr) {
    $e = $start
    for ($k = $start; $k -le $k1; $k++) {
        if ($vals[$k] -ge $thr) { $e = $k } else { break }
    }
    return $e
}

function Get-LongestRunAbove([int[]]$vals, [int]$k0, [int]$k1, [int]$thr) {
    if ($k1 -lt $k0) { return 0 }
    $best = 0
    $cur = 0
    for ($k = $k0; $k -le $k1; $k++) {
        if ($vals[$k] -ge $thr) {
            $cur++
            if ($cur -gt $best) { $best = $cur }
        } else {
            $cur = 0
        }
    }
    return $best
}

function New-CjkDrawingFont([float]$emSize, [System.Drawing.FontStyle]$style) {
    $unit = [System.Drawing.GraphicsUnit]::Point
    foreach ($n in @('Microsoft YaHei UI', 'Microsoft YaHei', 'SimHei', 'Segoe UI')) {
        try {
            $fam = New-Object System.Drawing.FontFamily $n
            if ($fam.IsStyleAvailable($style)) { return [System.Drawing.Font]::new($fam, $emSize, $style, $unit) }
        } catch { }
    }
    return [System.Drawing.Font]::new('Segoe UI', $emSize, $style, $unit)
}

function Ensure-ReplayJson([string]$TargetJsonPath, [string]$ReplayPathIn, [string]$AcRpPathIn, [string]$DriverNameIn, [bool]$ForceRegenerate) {
    if ((-not $ForceRegenerate) -and (Test-Path -LiteralPath $TargetJsonPath)) { return }
    $acrp = if ([string]::IsNullOrWhiteSpace($AcRpPathIn)) { Join-Path $toolDir 'acrp.exe' } else { Resolve-FsPath $AcRpPathIn }
    if (-not (Test-Path -LiteralPath $acrp)) {
        throw "Replay JSON missing and acrp.exe not found: $acrp"
    }

    $replay = $ReplayPathIn
    if ([string]::IsNullOrWhiteSpace($replay)) {
        $rp = @(Get-ChildItem -LiteralPath $toolDir -Filter *.acreplay -File | Sort-Object LastWriteTime -Descending)
        if ($rp.Count -lt 1) { throw "Replay JSON missing and no .acreplay found in $toolDir" }
        $replay = $rp[0].FullName
    } else {
        $replay = Resolve-FsPath $replay
    }
    if (-not (Test-Path -LiteralPath $replay)) { throw "Replay file not found: $replay" }

    $outDir = Split-Path -Parent $TargetJsonPath
    if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
        New-Item -ItemType Directory -Path $outDir -Force | Out-Null
    }

    $tempWork = Join-Path ([IO.Path]::GetTempPath()) ('ac_lap_' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $tempWork -Force | Out-Null
    $outPrefix = Join-Path $tempWork 'acrp_out'
    try {
        $argList = New-Object System.Collections.Generic.List[string]
        [void]$argList.Add('-o')
        [void]$argList.Add($outPrefix)
        if (-not [string]::IsNullOrWhiteSpace($DriverNameIn)) {
            [void]$argList.Add('--driver-name')
            [void]$argList.Add($DriverNameIn)
        }
        [void]$argList.Add($replay)

        Write-Host "Generating replay JSON via acrp: $replay"
        & $acrp @argList
        $acrpExitCode = $LASTEXITCODE
        if ($acrpExitCode -ne 0) { throw "acrp.exe exit code $acrpExitCode" }

        $jsonFiles = @(Get-ChildItem -LiteralPath $tempWork -Filter *.json -File | Sort-Object LastWriteTime -Descending)
        if ($jsonFiles.Count -lt 1) { throw "acrp generated no JSON in: $tempWork" }
        if ($jsonFiles.Count -gt 1 -and [string]::IsNullOrWhiteSpace($DriverNameIn)) {
            throw "acrp generated multiple JSON files; pass -DriverName to pick one."
        }
        Copy-Item -LiteralPath $jsonFiles[0].FullName -Destination $TargetJsonPath -Force
        Write-Host "Generated: $TargetJsonPath"
    } finally {
        Remove-Item -LiteralPath $tempWork -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Build-CornerJsonFromReplay($j, [string]$TargetPath, [int]$LapVal, [double]$MinSegMeters, [double]$DedupMinGapMeters, [bool]$AutoFastestLapVal) {
    $seg = if ($AutoFastestLapVal) { Select-FastestTimingSegment $j $MinSegMeters } else { Select-TimingSegment $j $LapVal $MinSegMeters }
    if ($seg.Mode -ne 'ok' -or $seg.Start -lt 0) { throw "Cannot build corners: timing segment $($seg.Mode)" }
    $iStart = $seg.Start; $iEnd = $seg.End
    $idx = New-Object System.Collections.Generic.List[int]
    for ($i = $iStart; $i -lt $iEnd; $i++) { [void]$idx.Add($i) }
    if ($idx.Count -lt 200) { throw "Cannot build corners: too few frames ($($idx.Count))" }

    $m = $idx.Count
    $s = New-Object double[] $m
    $brk = New-Object int[] $m
    for ($k = 0; $k -lt $m; $k++) {
        $fi = $idx[$k]
        if ($k -gt 0) {
            $pi = $idx[$k - 1]
            $dx = [double]$j.x[$fi] - [double]$j.x[$pi]
            $dy = [double]$j.y[$fi] - [double]$j.y[$pi]
            $dz = [double]$j.z[$fi] - [double]$j.z[$pi]
            $s[$k] = $s[$k - 1] + [Math]::Sqrt($dx * $dx + $dy * $dy + $dz * $dz)
        }
        $brk[$k] = [int]$j.brake[$fi]
    }
    $lapLen = $s[$m - 1]
    if ($lapLen -lt 100.0) { throw "Cannot build corners: lap length abnormal ($lapLen)" }

    $cand = New-Object System.Collections.Generic.List[object]
    for ($k = 1; $k -lt $m; $k++) {
        $prev = $brk[$k - 1]; $cur = $brk[$k]
        $isOnset = ($cur -ge 35 -and $prev -lt 25) -or ($cur -ge 22 -and $prev -lt 12) -or (($cur - $prev) -ge 20 -and $cur -ge 18)
        if ($isOnset) {
            [void]$cand.Add([pscustomobject]@{
                K = $k
                S = $s[$k]
                Fraction = ($s[$k] / $lapLen)
                Score = ($cur + [Math]::Max(0, $cur - $prev))
            })
        }
    }
    if ($cand.Count -lt 14) { throw "Cannot build corners: brake onset candidates <14 ($($cand.Count))" }

    $selected = New-Object System.Collections.Generic.List[object]
    foreach ($c in ($cand | Sort-Object Score -Descending)) {
        if ($selected.Count -ge 14) { break }
        $ok = $true
        foreach ($slt in $selected) {
            $d = [Math]::Abs($c.S - $slt.S)
            $dc = [Math]::Min($d, $lapLen - $d)
            if ($dc -lt $DedupMinGapMeters) { $ok = $false; break }
        }
        if ($ok) { [void]$selected.Add($c) }
    }
    if ($selected.Count -lt 14) {
        foreach ($c in ($cand | Sort-Object Score -Descending)) {
            if ($selected.Count -ge 14) { break }
            $exists = $false
            foreach ($slt in $selected) { if ([int]$slt.K -eq [int]$c.K) { $exists = $true; break } }
            if (-not $exists) { [void]$selected.Add($c) }
        }
    }
    if ($selected.Count -lt 14) { throw "Cannot build corners: selected <14 ($($selected.Count))" }

    $bf = @($selected | Sort-Object Fraction | Select-Object -First 14 | ForEach-Object { [double]$_.Fraction })
    $ends = @()
    for ($i = 0; $i -lt 13; $i++) { $ends += [Math]::Round((($bf[$i] + $bf[$i + 1]) / 2.0), 6) }
    $ends += 1.0

    $b = @(0.0) + $ends
    $center = @()
    for ($i = 0; $i -lt 14; $i++) { $center += [Math]::Round((($b[$i] + $b[$i + 1]) / 2.0), 6) }

    $obj = [ordered]@{
        _comment = "Auto-generated by DrawReplayLapTelemetry from replay brake onsets."
        _comment2 = "segmentEndFraction[13] fixed at 1.0; cornerCenterFraction is sector midpoint."
        segmentEndFraction = $ends
        cornerCenterFraction = $center
    }
    $outDir = Split-Path -Parent $TargetPath
    if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
        New-Item -ItemType Directory -Path $outDir -Force | Out-Null
    }
    ($obj | ConvertTo-Json -Depth 6) | Set-Content -LiteralPath $TargetPath -Encoding UTF8
    Write-Host "Generated: $TargetPath"
}

$userProvidedJson = -not [string]::IsNullOrWhiteSpace($JsonPath)
$userProvidedCorners = -not [string]::IsNullOrWhiteSpace($CornersJson)
$ReplayPath = Resolve-FsPath $ReplayPath
$legacyJson = Join-Path $toolDir 'zhuhai_replay_out_elmagnifico.json'
$legacyCorners = Join-Path $toolDir 'zhuhai_t1_t14_apex_fractions.json'

if ([string]::IsNullOrWhiteSpace($JsonPath)) {
    if (-not [string]::IsNullOrWhiteSpace($ReplayPath)) {
        $rpDir = Split-Path -Parent $ReplayPath
        $rpStem = Get-FileStem $ReplayPath 'replay'
        $JsonPath = Join-Path $rpDir ($rpStem + '_replay.json')
    } elseif (Test-Path -LiteralPath $legacyJson) {
        $JsonPath = $legacyJson
    } else {
        throw "Please provide -ReplayPath or -JsonPath."
    }
}
if ([string]::IsNullOrWhiteSpace($CornersJson)) {
    if (-not [string]::IsNullOrWhiteSpace($ReplayPath)) {
        $rpDir = Split-Path -Parent $ReplayPath
        $rpStem = Get-FileStem $ReplayPath 'replay'
        $CornersJson = Join-Path $rpDir ($rpStem + '_corners.json')
    } elseif (Test-Path -LiteralPath $legacyCorners) {
        $CornersJson = $legacyCorners
    } else {
        $jDir = Split-Path -Parent $JsonPath
        $jStem = Get-FileStem $JsonPath 'replay'
        $CornersJson = Join-Path $jDir ($jStem + '_corners.json')
    }
}
if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    if (-not [string]::IsNullOrWhiteSpace($ReplayPath)) {
        $rpDir = Split-Path -Parent $ReplayPath
        $rpStem = Get-FileStem $ReplayPath 'replay'
        $OutputPath = Join-Path $rpDir ($rpStem + '_brake_throttle_points.png')
    } else {
        $jDir = Split-Path -Parent $JsonPath
        $jStem = Get-FileStem $JsonPath 'replay'
        $OutputPath = Join-Path $jDir ($jStem + '_brake_throttle_points.png')
    }
}
if ([string]::IsNullOrWhiteSpace($DebugOutputPath)) {
    $DebugOutputPath = [IO.Path]::ChangeExtension($OutputPath, '.debug.csv')
}

$JsonPath = Resolve-FsPath $JsonPath
$CornersJson = Resolve-FsPath $CornersJson
$OutputPath = Resolve-FsPath $OutputPath
$DebugOutputPath = Resolve-FsPath $DebugOutputPath
$forceReplayJson = (-not [string]::IsNullOrWhiteSpace($ReplayPath)) -and (-not $userProvidedJson)
$forceReplayCorners = (-not [string]::IsNullOrWhiteSpace($ReplayPath)) -and (-not $userProvidedCorners)
$cleanupPaths = New-Object System.Collections.Generic.List[string]
if ((-not $KeepIntermediateFiles) -and $forceReplayJson) { [void]$cleanupPaths.Add($JsonPath) }
if ((-not $KeepIntermediateFiles) -and $forceReplayCorners) { [void]$cleanupPaths.Add($CornersJson) }

Ensure-ReplayJson $JsonPath $ReplayPath $AcRpPath $DriverName $forceReplayJson

$j = ConvertFrom-JsonFile $JsonPath
if ($forceReplayCorners -or (-not (Test-Path -LiteralPath $CornersJson))) {
    Build-CornerJsonFromReplay $j $CornersJson $Lap $MinSegmentMeters 28.0 $AutoFastestLap
}

$apexObj = ConvertFrom-JsonFile $CornersJson
if (-not $apexObj.segmentEndFraction) { throw 'CornersJson needs segmentEndFraction[14] ending with 1.0' }
$se = @([double[]]@($apexObj.segmentEndFraction))
$boundaries = Get-BoundariesFromSegmentEnds $se
$cornerCenter = $null
if ($apexObj.cornerCenterFraction) {
    $cornerCenter = @([double[]]@($apexObj.cornerCenterFraction))
    if ($cornerCenter.Count -ne 14) { throw 'cornerCenterFraction must have 14 elements if set' }
}

$nF = $j.x.Count
if ($j.velocityX.Count -ne $nF) { throw 'JSON needs velocityX/Y/Z same length as x.' }

$dt = Get-FrameDtSeconds $j
$brkFrames = [int][math]::Ceiling($BrakeMinSeconds / $dt)
$gasFrames = [int][math]::Ceiling($ThrottleMinSeconds / $dt)
$gasReapplyFrames = [int][math]::Ceiling($GasReapplyMinSeconds / $dt)
Write-Host "Frame dt=${dt}s  brake>=${BrakeMinSeconds}s -> ${brkFrames} frames  throttle>=${ThrottleMinSeconds}s -> ${gasFrames} frames"

$seg = if ($AutoFastestLap) { Select-FastestTimingSegment $j $MinSegmentMeters } else { Select-TimingSegment $j $Lap $MinSegmentMeters }
$iStart = 0; $iEnd = $nF; $timingUsed = $false
if ($seg.Mode -eq 'ok' -and $seg.Start -ge 0) {
    $iStart = $seg.Start; $iEnd = $seg.End; $timingUsed = $true
    if ($AutoFastestLap) {
        $Lap = [int]$seg.Lap
        Write-Host "Timing (fastest lap): lap=$Lap time_ms=$($seg.TimeMs) frames $($seg.Start)..$($seg.End) length_m=$([math]::Round($seg.Length,1))"
    } else {
        Write-Host "Timing: frames $($seg.Start)..$($seg.End) length_m=$([math]::Round($seg.Length,1))"
    }
} else {
    Write-Warning "Timing: $($seg.Mode)"
}

$idx = New-Object System.Collections.Generic.List[int]
for ($i = $iStart; $i -lt $iEnd; $i++) {
    if (-not $timingUsed) {
        if ([int]$j.currentLap[$i] -ne $Lap) { continue }
    }
    [void]$idx.Add($i)
}
if ($idx.Count -lt 200) { throw "Too few frames: $($idx.Count)" }

$m = $idx.Count
$s = New-Object double[] $m
$sp = New-Object double[] $m
$brk = New-Object int[] $m
$gas = New-Object int[] $m
$xs = New-Object double[] $m
$zs = New-Object double[] $m
for ($k = 0; $k -lt $m; $k++) {
    $fi = $idx[$k]
    $xs[$k] = [double]$j.x[$fi]; $zs[$k] = [double]$j.z[$fi]
    if ($k -gt 0) {
        $pi = $idx[$k - 1]
        $dx = [double]$j.x[$fi] - [double]$j.x[$pi]
        $dy = [double]$j.y[$fi] - [double]$j.y[$pi]
        $dz = [double]$j.z[$fi] - [double]$j.z[$pi]
        $s[$k] = $s[$k - 1] + [Math]::Sqrt($dx * $dx + $dy * $dy + $dz * $dz)
    }
    $sp[$k] = Get-SpeedKmh $j $fi
    $brk[$k] = [int]$j.brake[$fi]
    $gas[$k] = [int]$j.gas[$fi]
}

$lapLen = $s[$m - 1]
if ($lapLen -lt 100.0) { throw "Lap length abnormal: $lapLen" }
$lapTimeMs = -1
if ($j.currentLapTime -and ($j.currentLapTime.Count -eq $nF)) {
    $lastIdx = [int]$idx[$idx.Count - 1]
    $ct = [int]$j.currentLapTime[$lastIdx]
    if ($ct -gt 0) { $lapTimeMs = $ct }
}
if ($lapTimeMs -le 0) {
    $lapTimeMs = [int][Math]::Round($idx.Count * $dt * 1000.0)
}
$lapTimeText = Format-LapTime $lapTimeMs

$xmin = ($xs | Measure-Object -Minimum).Minimum
$xmax = ($xs | Measure-Object -Maximum).Maximum
$zmin = ($zs | Measure-Object -Minimum).Minimum
$zmax = ($zs | Measure-Object -Maximum).Maximum
$innerFrac = [Math]::Max(0.0, [Math]::Min(0.45, $InnerMarginPercent / 100.0))
$bmpW = $ImageWidth; $bmpH = $ImageHeight
$iw = $bmpW * (1.0 - 2.0 * $innerFrac); $ih = $bmpH * (1.0 - 2.0 * $innerFrac)
$rw = [Math]::Max(1e-9, $xmax - $xmin); $rz = [Math]::Max(1e-9, $zmax - $zmin)
$sc = [Math]::Min($iw / $rw, $ih / $rz)
$offX = $bmpW * $innerFrac + ($iw - $sc * $rw) / 2.0
$offZ = $bmpH * $innerFrac + ($ih - $sc * $rz) / 2.0

$pxi = New-Object int[] $m
$pzi = New-Object int[] $m
for ($k = 0; $k -lt $m; $k++) {
    $pxd = $offX + ($xs[$k] - $xmin) * $sc
    if ($FlipWorldZ.IsPresent) { $pzd = $offZ + ($zs[$k] - $zmin) * $sc }
    else { $pzd = $offZ + ($zmax - $zs[$k]) * $sc }
    $pxi[$k] = Clamp-Int ([int][Math]::Round($pxd)) 0 ($bmpW - 1)
    $pzi[$k] = Clamp-Int ([int][Math]::Round($pzd)) 0 ($bmpH - 1)
}
if (-not $NoVerticalFlip.IsPresent) {
    for ($k = 0; $k -lt $m; $k++) { $pzi[$k] = $bmpH - 1 - $pzi[$k] }
}

$bmp = New-Object System.Drawing.Bitmap $bmpW, $bmpH
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias
$g.Clear([System.Drawing.Color]::White)
$fontTitle = New-CjkDrawingFont $FontSizeTitle ([System.Drawing.FontStyle]::Bold)
$fontMk = New-CjkDrawingFont $FontSizeMarker ([System.Drawing.FontStyle]::Bold)
$brushTxt = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(240, 30, 30, 30))
$penTrace = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(200, 40, 90, 200)), 3
$brushRed = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(230, 200, 40, 40))
$brushGreen = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(230, 30, 150, 50))
$brushSf = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 200, 130, 0))
$penLeader = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(160, 90, 90, 90)), 1.0

for ($k = 1; $k -lt $m; $k++) {
    $g.DrawLine($penTrace, $pxi[$k - 1], $pzi[$k - 1], $pxi[$k], $pzi[$k])
}

$occupied = New-Object 'System.Collections.Generic.List[System.Drawing.RectangleF]'

function Test-RectOverlap([System.Drawing.RectangleF]$a, [System.Drawing.RectangleF]$b, [float]$pad) {
    $ax1 = $a.Left - $pad; $ay1 = $a.Top - $pad; $ax2 = $a.Right + $pad; $ay2 = $a.Bottom + $pad
    $bx1 = $b.Left - $pad; $by1 = $b.Top - $pad; $bx2 = $b.Right + $pad; $by2 = $b.Bottom + $pad
    return -not (($ax2 -lt $bx1) -or ($ax1 -gt $bx2) -or ($ay2 -lt $by1) -or ($ay1 -gt $by2))
}

function New-LabelPlacement {
    param($Graphics, $Font, [string]$Text, [int]$cx, [int]$cy, [int]$imgW, [int]$imgH, $Occupied, [float[]]$OffsetCandidates)
    $sz = $Graphics.MeasureString($Text, $Font)
    $w = $sz.Width + 6; $h = $sz.Height + 4
    $pad = [float]4
    for ($ci = 0; $ci -lt $OffsetCandidates.Length; $ci += 2) {
        $tx = [float]($cx + $OffsetCandidates[$ci]); $ty = [float]($cy + $OffsetCandidates[$ci + 1])
        if ($tx + $w -gt $imgW - 4) { $tx = [float]($imgW - 4 - $w) }
        if ($tx -lt 4) { $tx = 4 }
        if ($ty + $h -gt $imgH - 4) { $ty = [float]($imgH - 4 - $h) }
        if ($ty -lt 4) { $ty = 4 }
        $rc = [System.Drawing.RectangleF]::new($tx, $ty, $w, $h)
        $hit = $false
        foreach ($o in $Occupied) { if (Test-RectOverlap $rc $o $pad) { $hit = $true; break } }
        if (-not $hit) {
            [void]$Occupied.Add($rc)
            return @{ Tx = $tx; Ty = $ty; W = $w; H = $h }
        }
    }
    # Fallback: radial search around anchor to minimize collisions in dense areas.
    for ($rad = 26.0; $rad -le 190.0; $rad += 12.0) {
        for ($ang = 0.0; $ang -lt 360.0; $ang += 20.0) {
            $rx = [Math]::Cos($ang * [Math]::PI / 180.0) * $rad
            $ry = [Math]::Sin($ang * [Math]::PI / 180.0) * $rad
            $tx = [float]($cx + $rx)
            $ty = [float]($cy + $ry)
            if ($tx + $w -gt $imgW - 4) { $tx = [float]($imgW - 4 - $w) }
            if ($tx -lt 4) { $tx = 4 }
            if ($ty + $h -gt $imgH - 4) { $ty = [float]($imgH - 4 - $h) }
            if ($ty -lt 4) { $ty = 4 }
            $rc = [System.Drawing.RectangleF]::new($tx, $ty, $w, $h)
            $hit = $false
            foreach ($o in $Occupied) { if (Test-RectOverlap $rc $o $pad) { $hit = $true; break } }
            if (-not $hit) {
                [void]$Occupied.Add($rc)
                return @{ Tx = $tx; Ty = $ty; W = $w; H = $h }
            }
        }
    }
    # Last resort: place at corner to guarantee visibility.
    $tx0 = [float]4; $ty0 = [float]4
    $rc0 = [System.Drawing.RectangleF]::new($tx0, $ty0, $w, $h)
    [void]$Occupied.Add($rc0)
    return @{ Tx = $tx0; Ty = $ty0; W = $w; H = $h }
}

function Draw-StringWithLeader {
    param($Graphics, $Font, $Brush, $PenL, [int]$cx, [int]$cy, [string]$Text, $Place)
    $Graphics.DrawString($Text, $Font, $Brush, $Place.Tx, $Place.Ty)
    $mx = $Place.Tx + $Place.W / 2.0; $my = $Place.Ty + $Place.H / 2.0
    $Graphics.DrawLine($PenL, [float]$cx, [float]$cy, $mx, $my)
}

$sfOff = [float[]]@(20.0, -28.0, -120.0, -28.0, 20.0, 22.0)
$sfPl = New-LabelPlacement $g $fontMk $cap.sf $pxi[0] $pzi[0] $bmpW $bmpH $occupied $sfOff
$g.FillEllipse($brushSf, $pxi[0] - 10, $pzi[0] - 10, 20, 20)
Draw-StringWithLeader $g $fontMk $brushTxt $penLeader $pxi[0] $pzi[0] $cap.sf $sfPl

$bOff = [float[]]@(16.0, -28.0, -120.0, -28.0, 20.0, 22.0, -130.0, 24.0, 95.0, -34.0, 110.0, 12.0)
$gOff = [float[]]@(-16.0, 26.0, 90.0, 26.0, -26.0, -18.0, 110.0, -24.0, -120.0, 30.0, 24.0, 44.0)

$prevBrakeRunEnd = -1
$prevGasRunEnd = -1
$events = New-Object System.Collections.Generic.List[object]
$debugRows = New-Object System.Collections.Generic.List[object]
for ($ti = 0; $ti -lt 14; $ti++) {
    $f0 = $boundaries[$ti]; $f1 = $boundaries[$ti + 1]
    $sLo = [Math]::Max(0.0, ($f0 * $lapLen) - $SectorExpandMeters)
    $sHi = [Math]::Min($lapLen, ($f1 * $lapLen) + $SectorExpandMeters)
    $ff0 = $sLo / $lapLen
    $ff1 = $sHi / $lapLen
    $k0, $k1 = Find-KRangeForArc $s $lapLen $ff0 $ff1 $m

    # Avoid repeated brake markers when one long brake run spans adjacent sectors.
    $searchK0 = [Math]::Max($k0, $prevBrakeRunEnd + 1)
    $bk = Find-FirstRisingSustainedAbove $brk $searchK0 $k1 $BrakePedalThreshold $brkFrames
    $brkEnd = -1
    if ($bk -ge 0) {
        $brkEnd = Get-ContiguousRunEnd $brk $bk $k1 $BrakePedalThreshold
        if ($brkEnd -gt $prevBrakeRunEnd) { $prevBrakeRunEnd = $brkEnd }
    }

    $gasFrom = $k0
    if ($brkEnd -ge 0) { $gasFrom = [Math]::Min($k1, $brkEnd + 1) }
    $gasSearchK0 = [Math]::Max($gasFrom, $prevGasRunEnd + 1)

    $tkRise = Find-FirstRisingSustainedAbove $gas $gasSearchK0 $k1 $GasPedalThreshold $gasFrames
    $tkSustain = -1
    $tkReapply = -1
    $tk = $tkRise
    $tkSource = 'rise'
    if ($tk -lt 0) {
        # Fallback: if no clean rising edge exists in this window, still capture first sustained high-gas point.
        $tkSustain = Find-FirstSustainedAbove $gas $gasSearchK0 $k1 $GasPedalThreshold $gasFrames
        $tk = $tkSustain
        $tkSource = 'sustain'
    }
    if ($tk -lt 0) {
        # Fallback 2: capture lower-threshold throttle reapply when speed rises but full gas threshold isn't reached.
        $tkReapply = Find-FirstGasReapply $gas $brk $gasSearchK0 $k1 $GasReapplyThreshold $GasReapplyDelta $GasReapplyBrakeMax $gasReapplyFrames
        $tk = $tkReapply
        $tkSource = 'reapply'
    }
    if ($tk -lt 0) { $tkSource = 'none' }
    if ($tk -ge 0) {
        $gasEnd = Get-ContiguousRunEnd $gas $tk $k1 $GasPedalThreshold
        if ($gasEnd -gt $prevGasRunEnd) { $prevGasRunEnd = $gasEnd }
    }

    if ($bk -ge 0) {
        [void]$events.Add([pscustomobject]@{
            K = $bk
            Kind = 'brake'
            Sector = ($ti + 1)
            Source = 'rise'
            GasValue = 0
            Speed = [int][math]::Round($sp[$bk], 0)
            Px = $pxi[$bk]
            Py = $pzi[$bk]
        })
    }

    if ($tk -ge 0) {
        [void]$events.Add([pscustomobject]@{
            K = $tk
            Kind = 'gas'
            Sector = ($ti + 1)
            Source = $tkSource
            GasValue = [int]$gas[$tk]
            Speed = [int][math]::Round($sp[$tk], 0)
            Px = $pxi[$tk]
            Py = $pzi[$tk]
        })
    }

    if ($DebugEventTrace.IsPresent) {
        $secMaxGas = ($gas[$k0..$k1] | Measure-Object -Maximum).Maximum
        $secMaxBrk = ($brk[$k0..$k1] | Measure-Object -Maximum).Maximum
        [void]$debugRows.Add([pscustomobject]@{
            Phase = 'sector'
            Sector = ('T{0}' -f ($ti + 1))
            k0 = $k0
            k1 = $k1
            searchBrakeK0 = $searchK0
            bk = $bk
            brkEnd = $brkEnd
            gasSearchK0 = $gasSearchK0
            tkRise = $tkRise
            tkSustain = $tkSustain
            tkReapply = $tkReapply
            tkPicked = $tk
            tkSource = $tkSource
            secMaxGas = $secMaxGas
            secMaxBrk = $secMaxBrk
        })
    }
}

$markerId = 0
$orderedEvents = @($events | Sort-Object K, Kind)

# Global补漏：若两次刹车之间无油门点，则在中间区间再做一次补油搜索。
$brakeEvents = @($orderedEvents | Where-Object { $_.Kind -eq 'brake' } | Sort-Object K)
if ($brakeEvents.Count -ge 2) {
    for ($bi = 0; $bi -lt $brakeEvents.Count - 1; $bi++) {
        $kA = [int]$brakeEvents[$bi].K
        $kB = [int]$brakeEvents[$bi + 1].K
        if (($kB - $kA) -lt 3) { continue }

        $hasGasBetween = $false
        foreach ($ev2 in $orderedEvents) {
            if ($ev2.Kind -eq 'gas' -and $ev2.K -gt $kA -and $ev2.K -lt $kB) {
                $hasGasBetween = $true
                break
            }
        }
        if ($hasGasBetween) { continue }

        $g0 = $kA + 1
        $g1 = $kB - 1
        $tkMid = Find-FirstRisingSustainedAbove $gas $g0 $g1 $GasPedalThreshold $gasFrames
        if ($tkMid -lt 0) {
            $tkMid = Find-FirstSustainedAbove $gas $g0 $g1 $GasPedalThreshold $gasFrames
        }
        if ($tkMid -lt 0) {
            $tkMid = Find-FirstGasReapply $gas $brk $g0 $g1 $GasReapplyThreshold $GasReapplyDelta $GasReapplyBrakeMax $gasReapplyFrames
        }
        if ($tkMid -lt 0 -and $AllowOverlapThrottleBetweenBrakes) {
            # Only in brake-to-brake gaps: allow overlap throttle reapply without brake-max constraint.
            $tkMid = Find-FirstGasReapplyOverlap $gas $g0 $g1 $GasReapplyThreshold $GasReapplyDelta $gasReapplyFrames
            if ($tkMid -lt 0) {
                # If gas is already high in this gap (no rise edge), capture the first sustained high-gas sample.
                $tkMid = Find-FirstSustainedAbove $gas $g0 $g1 $GasReapplyThreshold $gasReapplyFrames
            }
            if ($tkMid -lt 0) {
                # Final fallback for brake-to-brake gap: pick max-gas point in gap to avoid missing obvious refill.
                $bestK = -1
                $bestG = -1
                for ($kk = $g0; $kk -le $g1; $kk++) {
                    if ($gas[$kk] -gt $bestG) { $bestG = $gas[$kk]; $bestK = $kk }
                }
                if ($bestG -ge $GasReapplyThreshold) { $tkMid = $bestK }
            }
        }
        if ($DebugEventTrace.IsPresent) {
            [void]$debugRows.Add([pscustomobject]@{
                Phase = 'global_gap_probe'
                Sector = ('T{0}->T{1}' -f $brakeEvents[$bi].Sector, $brakeEvents[$bi + 1].Sector)
                k0 = $g0
                k1 = $g1
                searchBrakeK0 = ''
                bk = $kA
                brkEnd = $kB
                gasSearchK0 = $g0
                tkRise = ''
                tkSustain = ''
                tkReapply = ''
                tkPicked = $tkMid
                tkSource = if ($tkMid -ge 0) { 'global_probe_hit' } else { 'global_probe_miss' }
                secMaxGas = ($gas[$g0..$g1] | Measure-Object -Maximum).Maximum
                secMaxBrk = ($brk[$g0..$g1] | Measure-Object -Maximum).Maximum
            })
        }
        if ($tkMid -ge 0) {
            [void]$events.Add([pscustomobject]@{
                K = $tkMid
                Kind = 'gas'
                Sector = 0
                Source = 'global_gap_fill_overlap_ok'
                GasValue = [int]$gas[$tkMid]
                Speed = [int][math]::Round($sp[$tkMid], 0)
                Px = $pxi[$tkMid]
                Py = $pzi[$tkMid]
            })
            if ($DebugEventTrace.IsPresent) {
                [void]$debugRows.Add([pscustomobject]@{
                    Phase = 'global_gap_fill'
                    Sector = ('T{0}->T{1}' -f $brakeEvents[$bi].Sector, $brakeEvents[$bi + 1].Sector)
                    k0 = $g0
                    k1 = $g1
                    searchBrakeK0 = ''
                    bk = $brakeEvents[$bi].K
                    brkEnd = $brakeEvents[$bi + 1].K
                    gasSearchK0 = $g0
                    tkRise = ''
                    tkSustain = ''
                    tkReapply = ''
                    tkPicked = $tkMid
                    tkSource = 'global_gap_fill'
                    secMaxGas = ($gas[$g0..$g1] | Measure-Object -Maximum).Maximum
                    secMaxBrk = ($brk[$g0..$g1] | Measure-Object -Maximum).Maximum
                })
            }
        }
    }
    $orderedEvents = @($events | Sort-Object K, Kind)
}

# Second-pass robust补漏（仅连续刹车之间）:
# If a brake-to-brake gap still has no gas marker, insert one at max-gas position in that gap.
if ($AllowOverlapThrottleBetweenBrakes) {
    $orderedEvents = @($events | Sort-Object K, Kind)
    $brakeEvents2 = @($orderedEvents | Where-Object { $_.Kind -eq 'brake' } | Sort-Object K)
    if ($brakeEvents2.Count -ge 2) {
        for ($bi2 = 0; $bi2 -lt $brakeEvents2.Count - 1; $bi2++) {
            $kA2 = [int]$brakeEvents2[$bi2].K
            $kB2 = [int]$brakeEvents2[$bi2 + 1].K
            if (($kB2 - $kA2) -lt 3) { continue }

            $hasGasBetween2 = $false
            foreach ($evx in $orderedEvents) {
                if ($evx.Kind -eq 'gas' -and $evx.K -gt $kA2 -and $evx.K -lt $kB2) {
                    $hasGasBetween2 = $true
                    break
                }
            }
            if ($hasGasBetween2) { continue }

            $g02 = $kA2 + 1
            $g12 = $kB2 - 1
            $bestK2 = -1
            $bestG2 = -1
            for ($kk2 = $g02; $kk2 -le $g12; $kk2++) {
                if ($gas[$kk2] -gt $bestG2) { $bestG2 = $gas[$kk2]; $bestK2 = $kk2 }
            }
            if ($bestK2 -ge 0 -and $bestG2 -ge $GasReapplyThreshold) {
                [void]$events.Add([pscustomobject]@{
                    K = $bestK2
                    Kind = 'gas'
                    Sector = 0
                    Source = 'global_gap_force_max'
                    GasValue = [int]$gas[$bestK2]
                    Speed = [int][math]::Round($sp[$bestK2], 0)
                    Px = $pxi[$bestK2]
                    Py = $pzi[$bestK2]
                })
            }
        }
        $orderedEvents = @($events | Sort-Object K, Kind)
    }
}

# Rule: between two consecutive brake points, keep at most one gas point.
if ($orderedEvents.Count -gt 0) {
    $removeIdx = New-Object 'System.Collections.Generic.HashSet[int]'
    $brakeIdx = New-Object System.Collections.Generic.List[int]
    for ($i = 0; $i -lt $orderedEvents.Count; $i++) {
        if ($orderedEvents[$i].Kind -eq 'brake') { [void]$brakeIdx.Add($i) }
    }
    for ($bi3 = 0; $bi3 -lt $brakeIdx.Count - 1; $bi3++) {
        $ia = $brakeIdx[$bi3]
        $ib = $brakeIdx[$bi3 + 1]
        $gasCandidates = New-Object System.Collections.Generic.List[int]
        for ($i = $ia + 1; $i -lt $ib; $i++) {
            if ($orderedEvents[$i].Kind -eq 'gas') { [void]$gasCandidates.Add($i) }
        }
        if ($gasCandidates.Count -le 1) { continue }
        # Keep earliest gas marker between two brake markers.
        $keep = $gasCandidates | Sort-Object { [int]$orderedEvents[$_].K } | Select-Object -First 1
        foreach ($gi in $gasCandidates) {
            if ($gi -ne $keep) { [void]$removeIdx.Add([int]$gi) }
        }
    }
    if ($removeIdx.Count -gt 0) {
        $filtered = New-Object System.Collections.Generic.List[object]
        for ($i = 0; $i -lt $orderedEvents.Count; $i++) {
            if (-not $removeIdx.Contains($i)) { [void]$filtered.Add($orderedEvents[$i]) }
        }
        $orderedEvents = $filtered.ToArray()
    }
}

foreach ($ev in $orderedEvents) {
    $markerId++
    $lbl = ('A{0} {1} km/h' -f $markerId, $ev.Speed)
    if ($ev.Kind -eq 'brake') {
        $pl = New-LabelPlacement $g $fontMk $lbl $ev.Px $ev.Py $bmpW $bmpH $occupied $bOff
        $g.FillEllipse($brushRed, $ev.Px - 7, $ev.Py - 7, 14, 14)
    } else {
        $pl = New-LabelPlacement $g $fontMk $lbl $ev.Px $ev.Py $bmpW $bmpH $occupied $gOff
        $g.FillEllipse($brushGreen, $ev.Px - 7, $ev.Py - 7, 14, 14)
    }
    Draw-StringWithLeader $g $fontMk $brushTxt $penLeader $ev.Px $ev.Py $lbl $pl
}

if ($DebugEventTrace.IsPresent) {
    $aRows = New-Object System.Collections.Generic.List[object]
    $aId = 0
    foreach ($ev in $orderedEvents) {
        $aId++
        [void]$aRows.Add([pscustomobject]@{
            Phase = 'A_sequence'
            Sector = if ($ev.Sector -gt 0) { 'T' + $ev.Sector } else { '-' }
            A = 'A' + $aId
            Kind = $ev.Kind
            Source = $ev.Source
            K = $ev.K
            AbsFrame = $idx[$ev.K]
            ArcS_m = [Math]::Round($s[$ev.K], 3)
            Speed_kmh = $ev.Speed
        })
    }

    $gapRows = New-Object System.Collections.Generic.List[object]
    $brOnly = @($aRows | Where-Object { $_.Kind -eq 'brake' })
    for ($gi = 0; $gi -lt $brOnly.Count - 1; $gi++) {
        $a = $brOnly[$gi]
        $b = $brOnly[$gi + 1]
        $ka = [int]$a.K; $kb = [int]$b.K
        if (($kb - $ka) -lt 2) { continue }
        $lo = $ka + 1; $hi = $kb - 1
        $hasGas = ($aRows | Where-Object { $_.Kind -eq 'gas' -and [int]$_.K -gt $ka -and [int]$_.K -lt $kb } | Select-Object -First 1)
        $maxGas = ($gas[$lo..$hi] | Measure-Object -Maximum).Maximum
        $maxBrk = ($brk[$lo..$hi] | Measure-Object -Maximum).Maximum
        $run180 = Get-LongestRunAbove $gas $lo $hi 180
        $run60 = Get-LongestRunAbove $gas $lo $hi 60
        $run40 = Get-LongestRunAbove $gas $lo $hi 40
        [void]$gapRows.Add([pscustomobject]@{
            Phase = 'brake_gap'
            Sector = ($a.A + '->' + $b.A)
            A = ''
            Kind = ''
            Source = if ($hasGas) { 'has_gas' } else { ("no_gas(run180={0},run60={1},run40={2})" -f $run180, $run60, $run40) }
            K = "$lo..$hi"
            AbsFrame = "$($idx[$lo])..$($idx[$hi])"
            ArcS_m = [Math]::Round(($s[$lo] + $s[$hi]) / 2.0, 3)
            Speed_kmh = ''
            MaxGas = $maxGas
            MaxBrake = $maxBrk
        })
    }

    $all = @($debugRows + $aRows + $gapRows) | ForEach-Object {
        [pscustomobject]@{
            Phase = if ($_.PSObject.Properties.Name -contains 'Phase') { $_.Phase } else { '' }
            Sector = if ($_.PSObject.Properties.Name -contains 'Sector') { $_.Sector } else { '' }
            A = if ($_.PSObject.Properties.Name -contains 'A') { $_.A } else { '' }
            Kind = if ($_.PSObject.Properties.Name -contains 'Kind') { $_.Kind } else { '' }
            Source = if ($_.PSObject.Properties.Name -contains 'Source') { $_.Source } else { '' }
            K = if ($_.PSObject.Properties.Name -contains 'K') { $_.K } else { '' }
            AbsFrame = if ($_.PSObject.Properties.Name -contains 'AbsFrame') { $_.AbsFrame } else { '' }
            ArcS_m = if ($_.PSObject.Properties.Name -contains 'ArcS_m') { $_.ArcS_m } else { '' }
            Speed_kmh = if ($_.PSObject.Properties.Name -contains 'Speed_kmh') { $_.Speed_kmh } else { '' }
            MaxGas = if ($_.PSObject.Properties.Name -contains 'MaxGas') { $_.MaxGas } else { '' }
            MaxBrake = if ($_.PSObject.Properties.Name -contains 'MaxBrake') { $_.MaxBrake } else { '' }
            k0 = if ($_.PSObject.Properties.Name -contains 'k0') { $_.k0 } else { '' }
            k1 = if ($_.PSObject.Properties.Name -contains 'k1') { $_.k1 } else { '' }
            searchBrakeK0 = if ($_.PSObject.Properties.Name -contains 'searchBrakeK0') { $_.searchBrakeK0 } else { '' }
            bk = if ($_.PSObject.Properties.Name -contains 'bk') { $_.bk } else { '' }
            brkEnd = if ($_.PSObject.Properties.Name -contains 'brkEnd') { $_.brkEnd } else { '' }
            gasSearchK0 = if ($_.PSObject.Properties.Name -contains 'gasSearchK0') { $_.gasSearchK0 } else { '' }
            tkRise = if ($_.PSObject.Properties.Name -contains 'tkRise') { $_.tkRise } else { '' }
            tkSustain = if ($_.PSObject.Properties.Name -contains 'tkSustain') { $_.tkSustain } else { '' }
            tkReapply = if ($_.PSObject.Properties.Name -contains 'tkReapply') { $_.tkReapply } else { '' }
            tkPicked = if ($_.PSObject.Properties.Name -contains 'tkPicked') { $_.tkPicked } else { '' }
            tkSource = if ($_.PSObject.Properties.Name -contains 'tkSource') { $_.tkSource } else { '' }
            secMaxGas = if ($_.PSObject.Properties.Name -contains 'secMaxGas') { $_.secMaxGas } else { '' }
            secMaxBrk = if ($_.PSObject.Properties.Name -contains 'secMaxBrk') { $_.secMaxBrk } else { '' }
        }
    }
    $all | Export-Csv -LiteralPath $DebugOutputPath -NoTypeInformation -Encoding UTF8
    $a1415 = $gapRows | Where-Object { $_.Sector -eq 'A14->A15' } | Select-Object -First 1
    if ($null -ne $a1415) {
        Write-Host ("Debug A14->A15: source={0} maxGas={1} maxBrake={2} gapK={3}" -f $a1415.Source, $a1415.MaxGas, $a1415.MaxBrake, $a1415.K)
    }
    Write-Host "Debug trace saved: $DebugOutputPath"
}

$sub = ('dt={0}ms brake>={1}s thr={2} gas>={3} expand={4}m' -f [int]($dt * 1000), $BrakeMinSeconds, $ThrottleMinSeconds, $GasPedalThreshold, $SectorExpandMeters)
$title = $cap.titlePrefix + '  Lap=' + $Lap + '  Time=' + $lapTimeText + '  L=' + [math]::Round($lapLen, 0) + 'm  ' + $sub
$g.DrawString($title, $fontTitle, $brushTxt, 10.0, 8.0)
$leg = $cap.legend + '  |  ' + $sub
$g.DrawString($leg, $fontMk, $brushTxt, 10.0, [float]($bmpH - 42))

$bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
$penTrace.Dispose(); $penLeader.Dispose()
$brushRed.Dispose(); $brushGreen.Dispose(); $brushTxt.Dispose(); $brushSf.Dispose()
$fontTitle.Dispose(); $fontMk.Dispose()
Write-Host "Saved: $OutputPath"
if (-not $KeepIntermediateFiles) {
    $deleted = New-Object System.Collections.Generic.List[string]
    foreach ($p in $cleanupPaths) {
        if ([string]::IsNullOrWhiteSpace($p)) { continue }
        if (Test-Path -LiteralPath $p) {
            Remove-Item -LiteralPath $p -Force -ErrorAction SilentlyContinue
            if (-not (Test-Path -LiteralPath $p)) { [void]$deleted.Add($p) }
        }
    }
    if ($deleted.Count -gt 0) {
        Write-Host ("Cleaned intermediate files: " + ($deleted -join '; '))
    }
}

# PS2EXE 的 draw 宿主在部分环境会在脚本结束后悬挂不退出；
# 打包为独立 exe 时强制结束进程，保证命令返回。
$arg0 = [Environment]::GetCommandLineArgs()[0]
$isPackagedExe = $false
if ($arg0) {
    $leaf = [IO.Path]::GetFileName($arg0).ToLowerInvariant()
    $isPackagedExe = ($leaf -ne 'powershell.exe' -and $leaf -ne 'pwsh.exe' -and $leaf.EndsWith('.exe'))
}
if ($isPackagedExe) {
    [Environment]::Exit(0)
}
exit 0
