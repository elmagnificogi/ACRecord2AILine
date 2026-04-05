#Requires -Version 5.1
<#
.SYNOPSIS
  用 acrp 解析录像，将轨迹写入任意赛道的 data\ideal_line.ai（版本 7）。
.DESCRIPTION
  简易用法（acrp.exe 与脚本同目录为默认）:
    powershell -ExecutionPolicy Bypass -File .\BuildIdealLineFromReplay.ps1 `
      -Replay "C:\path\lap.acreplay" -TrackFolder "C:\...\content\tracks\zhuhai"

  多车手录像请指定 -DriverName。已导出 JSON 时可省略 -Replay，改用 -JsonPath。

  -TrackFolder: 赛道根目录（其下应有 data\ideal_line.ai，除非用 -IdealLinePath 覆盖）。
  -AcRpPath:  默认 = 脚本目录\acrp.exe

  路径可为绝对路径（如 C:\...\x.acreplay）、相对当前目录、或 ~ 开头（用户主目录）；首尾引号会自动去掉。

  轨迹与赛道：ideal_line 只按录像里的世界坐标 x/y/z 重采样，与「目标赛道文件夹」无自动校验，
  请自行保证录像对应该赛道。计时线模式：在起点 currentLap 等于 -Lap 的若干区间中，直接取弧长最长的一段作为一圈（出场短段自然被排除）。

  -Lap 对应录像 JSON 里的 currentLap 整型（通常第 1 圈=0，第 2 圈=1 …），不限于 0/1；第 N 圈飞行一般传 N-1。
  不确定时用 -ShowLapHints 列出每个计时区间起点的 currentLap。
#>
[CmdletBinding()]
param(
    [string]$Replay,
    [string]$TrackFolder,
    [string]$AcRpPath,
    [string]$DriverName,
    [string]$JsonPath,
    [string]$CsvPath,
    [string]$IdealLinePath,
    [int]$Lap = 0,
    [bool]$UseTimingLine = $true,
    [double]$MinSegmentMeters = 50.0,
    [double]$DedupePlanarMin = 0.05,
    [switch]$WhatIf,
    [switch]$KeepTempJson,
    [switch]$ShowLapHints
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Resolve-FsPath([string]$Path) {
    if ($null -eq $Path -or [string]::IsNullOrWhiteSpace($Path)) { return $Path }
    $p = $Path.Trim()
    while ($p.Length -ge 2 -and $p.StartsWith('"') -and $p.EndsWith('"')) {
        $p = $p.Substring(1, $p.Length - 2).Trim()
    }
    if ($p.StartsWith('~')) {
        $rest = $p.Substring(1).TrimStart('\', '/')
        $p = if ($rest) { Join-Path $HOME $rest } else { $HOME }
    }
    return [IO.Path]::GetFullPath($p)
}

function Show-Usage {
    Write-Host @"
用法:
  BuildIdealLineFromReplay.ps1 -Replay <录像.acreplay> -TrackFolder <赛道文件夹> [选项]

必填（二选一）:
  -Replay         Assetto Corsa 录像路径
  -TrackFolder     赛道根目录（内含 data\ideal_line.ai）

或已手动用 acrp 导出:
  -JsonPath / -CsvPath  与 -IdealLinePath（或 -TrackFolder）

常用选项:
  -DriverName      多车时指定车手名（传给 acrp --driver-name）
  -AcRpPath        默认: 脚本所在目录\acrp.exe
  -IdealLinePath   默认: <TrackFolder>\data\ideal_line.ai
  -Lap             与录像 currentLap 一致（第 2 圈多为 1，第 3 圈多为 2，依此类推）
  -ShowLapHints    只打印计时线分段与每段起点 currentLap，不写 ideal_line（仅需 JSON）
  -MinSegmentMeters  计时线模式下，若「该 Lap 最长区间」弧长仍小于此值(m)则放弃切段（防数据损坏），默认 50
  -UseTimingLine:`$false  关闭计时线截取
  -WhatIf          只预览不写文件

示例:
  powershell -ExecutionPolicy Bypass -File .\BuildIdealLineFromReplay.ps1 `
    -Replay ".\my.acreplay" -TrackFolder "..\zhuhai"
"@
}

$scriptDir = $PSScriptRoot
if (-not $AcRpPath -or [string]::IsNullOrWhiteSpace($AcRpPath)) {
    $AcRpPath = Join-Path $scriptDir 'acrp.exe'
} else {
    $AcRpPath = Resolve-FsPath $AcRpPath
}

$useJson = $false
$tempWork = $null

if ($Replay) {
    if (-not $TrackFolder) { throw "使用 -Replay 时必须同时指定 -TrackFolder（赛道根目录）。" }
    if (-not (Test-Path -LiteralPath $AcRpPath)) {
        throw "找不到 acrp.exe: $AcRpPath （可设置 -AcRpPath，或把 acrp.exe 放在脚本同目录）"
    }
    $replayFull = Resolve-FsPath $Replay
    if (-not (Test-Path -LiteralPath $replayFull)) { throw "找不到录像: $replayFull" }

    $trackFull = Resolve-FsPath $TrackFolder
    if (-not (Test-Path -LiteralPath $trackFull -PathType Container)) {
        throw "赛道目录不存在: $trackFull"
    }
    if (-not $IdealLinePath) {
        $IdealLinePath = Resolve-FsPath (Join-Path $trackFull 'data\ideal_line.ai')
    } else {
        $ilRaw = $IdealLinePath.Trim()
        if ($ilRaw.StartsWith('~') -or [IO.Path]::IsPathRooted($ilRaw)) {
            $IdealLinePath = Resolve-FsPath $ilRaw
        } else {
            $IdealLinePath = Resolve-FsPath (Join-Path $trackFull $ilRaw)
        }
    }

    $tempWork = Join-Path ([IO.Path]::GetTempPath()) ('ac_ideal_' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $tempWork -Force | Out-Null
    $outPrefix = Join-Path $tempWork 'acrp_out'

    $argList = New-Object System.Collections.Generic.List[string]
    [void]$argList.Add('-o')
    [void]$argList.Add($outPrefix)
    if ($DriverName) {
        [void]$argList.Add('--driver-name')
        [void]$argList.Add($DriverName)
    }
    [void]$argList.Add($replayFull)

    Write-Host "运行 acrp: $AcRpPath"
    $proc = Start-Process -FilePath $AcRpPath -ArgumentList $argList.ToArray() -Wait -PassThru -NoNewWindow
    if ($proc.ExitCode -ne 0) {
        if (-not $KeepTempJson) { Remove-Item -LiteralPath $tempWork -Recurse -Force -ErrorAction SilentlyContinue }
        throw "acrp.exe 退出码 $($proc.ExitCode)"
    }

    $jsonFiles = @(Get-ChildItem -LiteralPath $tempWork -Filter *.json -File | Sort-Object LastWriteTime -Descending)
    if ($jsonFiles.Count -eq 0) {
        if (-not $KeepTempJson) { Remove-Item -LiteralPath $tempWork -Recurse -Force -ErrorAction SilentlyContinue }
        throw "acrp 未在临时目录生成 JSON: $tempWork"
    }
    if ($jsonFiles.Count -gt 1 -and -not $DriverName) {
        if (-not $KeepTempJson) { Remove-Item -LiteralPath $tempWork -Recurse -Force -ErrorAction SilentlyContinue }
        throw "生成多个 JSON（多车？），请添加 -DriverName 指定车手。文件: $($jsonFiles.Name -join ', ')"
    }
    $JsonPath = $jsonFiles[0].FullName
    Write-Host "已解析: $JsonPath"
    $useJson = $true
} elseif ($JsonPath -or $CsvPath) {
    if ($JsonPath -and $CsvPath) { throw "请只指定 -JsonPath 或 -CsvPath 其中之一。" }
    if ($JsonPath) {
        $JsonPath = Resolve-FsPath $JsonPath
        if (-not (Test-Path -LiteralPath $JsonPath)) { throw "找不到 JSON: $JsonPath" }
        $useJson = $true
    } else {
        $CsvPath = Resolve-FsPath $CsvPath
        if (-not (Test-Path -LiteralPath $CsvPath)) { throw "找不到 CSV: $CsvPath" }
    }
    if (-not $IdealLinePath) {
        if (-not $TrackFolder) {
            if ($ShowLapHints -and $JsonPath) {
                $IdealLinePath = Join-Path ([IO.Path]::GetTempPath()) '_BuildIdealLine_skip.ai'
            } else {
                throw "使用 -JsonPath/-CsvPath 且未指定 -IdealLinePath 时，需要 -TrackFolder。"
            }
        } else {
            $IdealLinePath = Resolve-FsPath (Join-Path (Resolve-FsPath $TrackFolder) 'data\ideal_line.ai')
        }
    } else {
        $ilRaw = $IdealLinePath.Trim()
        if ($ilRaw.StartsWith('~') -or [IO.Path]::IsPathRooted($ilRaw)) {
            $IdealLinePath = Resolve-FsPath $ilRaw
        } else {
            if (-not $TrackFolder) {
                if (-not $ShowLapHints) {
                    throw "相对路径的 -IdealLinePath 需要同时指定 -TrackFolder 作为基准目录。"
                }
            } else {
                $IdealLinePath = Resolve-FsPath (Join-Path (Resolve-FsPath $TrackFolder) $ilRaw)
            }
        }
    }
} else {
    Show-Usage
    throw "请提供 -Replay 与 -TrackFolder，或提供 -JsonPath / -CsvPath。"
}

if (-not $ShowLapHints) {
    if (-not (Test-Path -LiteralPath $IdealLinePath)) {
        if ($tempWork -and -not $KeepTempJson) { Remove-Item -LiteralPath $tempWork -Recurse -Force -ErrorAction SilentlyContinue }
        throw "找不到 ideal_line.ai: $IdealLinePath"
    }
}

# --- 解析轨迹并写 ideal_line ---

function Parse-CsvLine([string]$line) {
    $cells = New-Object System.Collections.Generic.List[string]
    $cur = New-Object System.Text.StringBuilder
    $inQ = $false
    for ($i = 0; $i -lt $line.Length; $i++) {
        $c = $line[$i]
        if ($c -eq '"') {
            $inQ = -not $inQ
        } elseif (($c -eq ',') -and -not $inQ) {
            [void]$cells.Add($cur.ToString())
            [void]$cur.Clear()
        } else {
            [void]$cur.Append($c)
        }
    }
    [void]$cells.Add($cur.ToString())
    return ,$cells.ToArray()
}

function Get-SfCrossingIndices($j) {
    $cross = New-Object System.Collections.Generic.List[int]
    $nF = $j.currentLapTime.Count
    for ($i = 1; $i -lt $nF; $i++) {
        $a = [int]$j.currentLapTime[$i - 1]
        $b = [int]$j.currentLapTime[$i]
        $lapInc = [int]$j.currentLap[$i] - [int]$j.currentLap[$i - 1]
        if (($a - $b -gt 500) -or ($lapInc -gt 0)) {
            $prev = if ($cross.Count -gt 0) { $cross[$cross.Count - 1] } else { -9999 }
            if (($i - $prev) -gt 2) { [void]$cross.Add($i) }
        }
    }
    return $cross
}

function Measure-ArcJson($j, [int]$i0, [int]$i1Exclusive) {
    $s = 0.0
    $px = $null; $py = $null; $pz = $null
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

function Select-TimingSegment($j, [int]$Lap, [double]$MinSegmentMeters) {
    $cross = Get-SfCrossingIndices $j
    if ($cross.Count -lt 2) {
        return @{ Start = -1; End = -1; Length = 0.0; Mode = 'no_crossings' }
    }
    $bestLen = -1.0
    $bestA = -1
    $bestB = -1
    for ($k = 0; $k -lt $cross.Count - 1; $k++) {
        $a = $cross[$k]
        $b = $cross[$k + 1]
        if ([int]$j.currentLap[$a] -ne $Lap) { continue }
        $len = Measure-ArcJson $j $a $b
        if ($len -gt $bestLen) {
            $bestLen = $len
            $bestA = $a
            $bestB = $b
        }
    }
    if ($bestA -lt 0) {
        return @{ Start = -1; End = -1; Length = 0.0; Mode = 'no_match' }
    }
    if ($bestLen -lt $MinSegmentMeters) {
        return @{ Start = -1; End = -1; Length = $bestLen; Mode = 'segment_too_short' }
    }
    return @{ Start = $bestA; End = $bestB; Length = $bestLen; Mode = 'longest_for_lap' }
}

if ($ShowLapHints) {
    if (-not $useJson) { throw "-ShowLapHints 仅支持 JSON（-Replay 或 -JsonPath），不支持 CSV。" }
    $jh = Get-Content -LiteralPath $JsonPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if (-not $jh.currentLap -or -not $jh.currentLapTime) {
        throw "JSON 缺少 currentLap 或 currentLapTime，无法分析计时线。"
    }
    $nH = $jh.currentLap.Count
    if ($jh.currentLapTime.Count -ne $nH) { throw "currentLap 与 currentLapTime 长度不一致。" }
    $xc = Get-SfCrossingIndices $jh
    Write-Host "=== ShowLapHints: $JsonPath ==="
    Write-Host "帧数=$nH  检测到计时线交叉索引数=$($xc.Count)"
    Write-Host "（过线后该帧的 currentLap 即「已开始计时的那一圈」编号，通常从 0 递增）"
    for ($ki = 0; $ki -lt $xc.Count; $ki++) {
        $ix = $xc[$ki]
        Write-Host ("  交叉#{0}: frame={1}  currentLap={2}  currentLapTime={3} ms" -f $ki, $ix, [int]$jh.currentLap[$ix], [int]$jh.currentLapTime[$ix])
    }
    for ($ki = 0; $ki -lt $xc.Count - 1; $ki++) {
        $a = $xc[$ki]
        $b = $xc[$ki + 1]
        $alen = Measure-ArcJson $jh $a $b
        $lapAtStart = [int]$jh.currentLap[$a]
        Write-Host ("  区间 frame {0}..{1}: 起点 currentLap={2}  弧长约 {3:F1} m  （同 Lap 多段时脚本取最长段）" -f $a, $b, $lapAtStart, $alen)
    }
    Write-Host "当前默认 -Lap=$Lap；若飞行圈是「第 3 圈」且 AC 从 0 编号，多为 -Lap 2。"
    if ($tempWork -and (Test-Path -LiteralPath $tempWork) -and -not $KeepTempJson) {
        Remove-Item -LiteralPath $tempWork -Recurse -Force -ErrorAction SilentlyContinue
    }
    exit 0
}

try {
$pts = New-Object System.Collections.Generic.List[object]
$hasPedals = $false
$timingMode = 'n/a'
if ($useJson) {
    $j = Get-Content -LiteralPath $JsonPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if (-not $j.x -or -not $j.y -or -not $j.z) { throw "JSON 缺少 x/y/z 数组（请确认为 acrp 导出）。" }
    if (-not $j.currentLap) { throw "JSON 缺少 currentLap 数组。" }
    $nF = $j.x.Count
    if ($j.y.Count -ne $nF -or $j.z.Count -ne $nF -or $j.currentLap.Count -ne $nF) {
        throw "JSON 中 x/y/z/currentLap 长度不一致。"
    }
    if ($j.gas -and $j.brake -and ($j.gas.Count -eq $nF) -and ($j.brake.Count -eq $nF)) {
        $hasPedals = $true
    }

    $iStart = 0
    $iEnd = $nF
    $timingUsed = $false
    if (-not $UseTimingLine) {
        $timingMode = 'timing_disabled'
    } elseif ($j.currentLapTime -and ($j.currentLapTime.Count -eq $nF)) {
        $seg = Select-TimingSegment $j $Lap $MinSegmentMeters
        if ($seg.Start -ge 0) {
            $iStart = $seg.Start
            $iEnd = $seg.End
            $timingUsed = $true
            $timingMode = $seg.Mode
        } elseif ($seg.Mode -eq 'segment_too_short') {
            $timingMode = 'segment_too_short'
            Write-Warning ("计时线切段: 该 Lap 下最长区间仅 {0:F1} m，低于 -MinSegmentMeters ({1} m)，已放弃切段。可调小 -MinSegmentMeters 或检查录像。" -f $seg.Length, $MinSegmentMeters)
        } elseif ($seg.Mode -eq 'no_crossings') {
            $timingMode = 'no_crossings'
            Write-Warning "录像中未检测到计时线交叉（currentLapTime/圈数变化），已按整段 -Lap 过滤取点。"
        } else {
            $timingMode = 'lap_filter_pending'
        }
    } else {
        $timingMode = 'no_currentLapTime'
        Write-Warning "JSON 无 currentLapTime 或与帧数不一致，已跳过计时线切段，仅按 -Lap 过滤。"
    }

    for ($i = $iStart; $i -lt $iEnd; $i++) {
        if (-not $timingUsed) {
            if ([int]$j.currentLap[$i] -ne $Lap) { continue }
        }
        $g = if ($hasPedals) { [int]$j.gas[$i] } else { 0 }
        $bk = if ($hasPedals) { [int]$j.brake[$i] } else { 0 }
        if ($g -lt 0) { $g = 0 } elseif ($g -gt 255) { $g = 255 }
        if ($bk -lt 0) { $bk = 0 } elseif ($bk -gt 255) { $bk = 255 }
        [void]$pts.Add([pscustomobject]@{
                X = [float][double]$j.x[$i]
                Y = [float][double]$j.y[$i]
                Z = [float][double]$j.z[$i]
                G = $g
                Bk = $bk
            })
    }
    if ($UseTimingLine -and -not $timingUsed) {
        if ($timingMode -eq 'lap_filter_pending') { $timingMode = 'no_segment_for_lap' }
        Write-Warning "未找到起点 currentLap=$Lap 的计时区间（或交叉点不足），已回退为整段 Lap 过滤。可运行 -ShowLapHints 查看每段起点应对的 -Lap，或 -UseTimingLine:`$false。"
    }
} else {
    $timingMode = 'csv'
    $hdr = Get-Content -LiteralPath $CsvPath -TotalCount 1 -Encoding UTF8
    $names = Parse-CsvLine $hdr
    $ixX = [array]::IndexOf($names, 'position.x')
    $ixY = [array]::IndexOf($names, 'position.y')
    $ixZ = [array]::IndexOf($names, 'position.z')
    $ixLap = [array]::IndexOf($names, 'currentLap')
    $ixGas = [array]::IndexOf($names, 'gas')
    $ixBrake = [array]::IndexOf($names, 'brake')
    if ($ixX -lt 0 -or $ixY -lt 0 -or $ixZ -lt 0) { throw "CSV 缺少 position.x/y/z 列，请确认由 acreplay-parser 导出。" }
    if ($ixLap -lt 0) { throw "CSV 缺少 currentLap 列。" }
    if ($ixGas -ge 0 -and $ixBrake -ge 0) { $hasPedals = $true }

    $reader = [IO.StreamReader]::new($CsvPath, [Text.Encoding]::UTF8, $true)
    try {
        [void]$reader.ReadLine()
        while ($null -ne ($line = $reader.ReadLine())) {
            if ([string]::IsNullOrWhiteSpace($line)) { continue }
            $c = Parse-CsvLine $line
            if ($c.Count -le [Math]::Max($ixX, [Math]::Max($ixY, [Math]::Max($ixZ, $ixLap)))) { continue }
            $lapVal = 0
            [void][int]::TryParse($c[$ixLap].Trim(), [ref]$lapVal)
            if ($lapVal -ne $Lap) { continue }
            $x = [double]::Parse($c[$ixX].Trim(), [Globalization.CultureInfo]::InvariantCulture)
            $y = [double]::Parse($c[$ixY].Trim(), [Globalization.CultureInfo]::InvariantCulture)
            $z = [double]::Parse($c[$ixZ].Trim(), [Globalization.CultureInfo]::InvariantCulture)
            $g = 0; $bk = 0
            if ($hasPedals) {
                [void][int]::TryParse($c[$ixGas].Trim(), [ref]$g)
                [void][int]::TryParse($c[$ixBrake].Trim(), [ref]$bk)
            }
            if ($g -lt 0) { $g = 0 } elseif ($g -gt 255) { $g = 255 }
            if ($bk -lt 0) { $bk = 0 } elseif ($bk -gt 255) { $bk = 255 }
            [void]$pts.Add([pscustomobject]@{ X = [float]$x; Y = [float]$y; Z = [float]$z; G = $g; Bk = $bk })
        }
    } finally { $reader.Close() }
}

if ($DedupePlanarMin -gt 0 -and $pts.Count -gt 2) {
    $dd = New-Object System.Collections.Generic.List[object]
    [void]$dd.Add($pts[0])
    for ($di = 1; $di -lt $pts.Count; $di++) {
        $a = $dd[$dd.Count - 1]
        $b = $pts[$di]
        $dh = [Math]::Sqrt([double](($b.X - $a.X) * ($b.X - $a.X) + ($b.Z - $a.Z) * ($b.Z - $a.Z)))
        if ($dh -ge $DedupePlanarMin) { [void]$dd.Add($b) }
    }
    $pts = $dd
}

if ($pts.Count -lt 200) { throw "该圈采样点过少 ($($pts.Count))，请检查 -DriverName / -Lap / -UseTimingLine。" }

$clean = New-Object System.Collections.Generic.List[object]
[void]$clean.Add($pts[0])
for ($i = 1; $i -lt $pts.Count; $i++) {
    $a = $clean[$clean.Count - 1]
    $b = $pts[$i]
    $d = [Math]::Sqrt([double](($b.X - $a.X) * ($b.X - $a.X) + ($b.Z - $a.Z) * ($b.Z - $a.Z)))
    if ($d -lt 80.0) { [void]$clean.Add($b) }
}
$pts = $clean
if ($pts.Count -lt 200) { throw "过滤跳变后点数不足 ($($pts.Count))。" }

$segLen = New-Object double[] ($pts.Count)
$cum = New-Object double[] ($pts.Count)
$cum[0] = 0.0
for ($i = 1; $i -lt $pts.Count; $i++) {
    $dx = [double]$pts[$i].X - [double]$pts[$i - 1].X
    $dy = [double]$pts[$i].Y - [double]$pts[$i - 1].Y
    $dz = [double]$pts[$i].Z - [double]$pts[$i - 1].Z
    $segLen[$i] = [Math]::Sqrt($dx * $dx + $dy * $dy + $dz * $dz)
    $cum[$i] = $cum[$i - 1] + $segLen[$i]
}
$replayTotal = $cum[$pts.Count - 1]
if ($replayTotal -lt 100.0) { throw "该圈弧长异常短 ($replayTotal m)，请换 -Lap 或检查录像。" }

function Get-PointAtDistance([object[]]$p, [double[]]$c, [double]$dist) {
    if ($dist -le 0) { return $p[0] }
    $max = $c[$p.Length - 1]
    if ($dist -ge $max) { return $p[$p.Length - 1] }
    $lo = 0
    $hi = $p.Length - 1
    while ($hi - $lo -gt 1) {
        $mid = [int](($lo + $hi) / 2)
        if ($c[$mid] -le $dist) { $lo = $mid } else { $hi = $mid }
    }
    $i = $lo
    $t = if (($c[$i + 1] - $c[$i]) -gt 1e-6) { ($dist - $c[$i]) / ($c[$i + 1] - $c[$i]) } else { 0.0 }
    $ax = [double]$p[$i].X; $ay = [double]$p[$i].Y; $az = [double]$p[$i].Z
    $bx = [double]$p[$i + 1].X; $by = [double]$p[$i + 1].Y; $bz = [double]$p[$i + 1].Z
    return [pscustomobject]@{
        X = [float]($ax + $t * ($bx - $ax))
        Y = [float]($ay + $t * ($by - $ay))
        Z = [float]($az + $t * ($bz - $az))
    }
}

function Get-Pedal01AtDistance([object[]]$p, [double[]]$c, [double]$dist, [bool]$pickGas) {
    if ($dist -le 0) {
        $v = if ($pickGas) { [double]$p[0].G } else { [double]$p[0].Bk }
        return [float]($v / 255.0)
    }
    $max = $c[$p.Length - 1]
    if ($dist -ge $max) {
        $v = if ($pickGas) { [double]$p[$p.Length - 1].G } else { [double]$p[$p.Length - 1].Bk }
        return [float]($v / 255.0)
    }
    $lo = 0
    $hi = $p.Length - 1
    while ($hi - $lo -gt 1) {
        $mid = [int](($lo + $hi) / 2)
        if ($c[$mid] -le $dist) { $lo = $mid } else { $hi = $mid }
    }
    $i = $lo
    $tt = if (($c[$i + 1] - $c[$i]) -gt 1e-6) { ($dist - $c[$i]) / ($c[$i + 1] - $c[$i]) } else { 0.0 }
    $va = if ($pickGas) { [double]$p[$i].G } else { [double]$p[$i].Bk }
    $vb = if ($pickGas) { [double]$p[$i + 1].G } else { [double]$p[$i + 1].Bk }
    return [float](($va + $tt * ($vb - $va)) / 255.0)
}

$bytes = [IO.File]::ReadAllBytes($IdealLinePath)
$ver = [BitConverter]::ToInt32($bytes, 0)
if ($ver -ne 7) { throw "ideal_line 版本为 $ver，本脚本仅按版本 7 处理。" }
$n = [BitConverter]::ToInt32($bytes, 4)
if ($n -lt 10) { throw "点数异常: $n" }

$oldLens = New-Object float[] $n
for ($i = 0; $i -lt $n; $i++) {
    $o = 16 + $i * 20 + 12
    $oldLens[$i] = [BitConverter]::ToSingle($bytes, $o)
}
$oldMax = [double]$oldLens[$n - 1]
if ($oldMax -lt 1.0) { throw "原线累计长度异常。" }

if ($WhatIf) {
    $pedalNote = if ($hasPedals) { "写入 Gas/Brake" } else { "无油门刹车数据，不改颜色" }
    Write-Host "WhatIf: $IdealLinePath | $n 点 | Lap=$Lap | timing=$timingMode | 采样 $($pts.Count) | 弧长 $replayTotal m | 原线长 $oldMax m | $pedalNote"
    exit 0
}

$bak = $IdealLinePath + ".bak_" + (Get-Date -Format "yyyyMMdd_HHmmss")
Copy-Item -LiteralPath $IdealLinePath -Destination $bak -Force
Write-Host "已备份: $bak"

$newLens = New-Object float[] $n
for ($i = 0; $i -lt $n; $i++) {
    $frac = [double]$oldLens[$i] / $oldMax
    $d = $frac * $replayTotal
    $newLens[$i] = [float]$d
    $q = Get-PointAtDistance $pts $cum $d
    $o = 16 + $i * 20
    [Array]::Copy([BitConverter]::GetBytes($q.X), 0, $bytes, $o, 4)
    [Array]::Copy([BitConverter]::GetBytes($q.Y), 0, $bytes, $o + 4, 4)
    [Array]::Copy([BitConverter]::GetBytes($q.Z), 0, $bytes, $o + 8, 4)
    [Array]::Copy([BitConverter]::GetBytes($newLens[$i]), 0, $bytes, $o + 12, 4)
}

$PointExtraStride = 72
$nEx = [BitConverter]::ToInt32($bytes, 16 + 20 * $n)
$extraStart = 16 + 20 * $n + 4
if ($hasPedals -and ($nEx -eq $n) -and (($bytes.Length - $extraStart) -ge ($n * $PointExtraStride))) {
    $ptArr = $pts.ToArray()
    for ($i = 0; $i -lt $n; $i++) {
        $d = [double]$newLens[$i]
        $gas01 = Get-Pedal01AtDistance $ptArr $cum $d $true
        $brake01 = Get-Pedal01AtDistance $ptArr $cum $d $false
        $eo = $extraStart + $i * $PointExtraStride
        [Array]::Copy([BitConverter]::GetBytes($gas01), 0, $bytes, $eo + 4, 4)
        [Array]::Copy([BitConverter]::GetBytes($brake01), 0, $bytes, $eo + 8, 4)
    }
    Write-Host "已更新 PointsExtra 的 Gas/Brake。"
} elseif ($hasPedals) {
    Write-Warning "PointsExtra 与点数不匹配，已跳过颜色写入。"
}

[IO.File]::WriteAllBytes($IdealLinePath, $bytes)
Write-Host "完成: $IdealLinePath"
}
finally {
    if ($tempWork -and (Test-Path -LiteralPath $tempWork) -and -not $KeepTempJson) {
        Remove-Item -LiteralPath $tempWork -Recurse -Force -ErrorAction SilentlyContinue
    }
}
