#Requires -Version 5.1
# 将 BuildIdealLineFromReplay.ps1 / DrawZhuhaiLapCorners.ps1 打成 exe。
# 先输出到 %TEMP% 再复制到 tools，避免目标 exe 被占用时 PS2EXE 无法删除旧文件导致打包失败。
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
Import-Module (Join-Path $here 'ps2exe-module\ps2exe.psd1') -Force

function Stop-ToolProcess([string]$exeFileName) {
    $base = [IO.Path]::GetFileNameWithoutExtension($exeFileName)
    Get-Process -Name $base -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}

function Copy-ExeToTools {
    param([string]$TempExe, [string]$DestExe)
    Copy-Item -LiteralPath $TempExe -Destination $DestExe -Force
}

$targets = @(
    @{ In = 'BuildIdealLineFromReplay.ps1'; Out = 'BuildIdealLineFromReplay.exe'; Title = 'BuildIdealLineFromReplay'; ConHost = $true },
    @{ In = 'DrawZhuhaiLapCorners.ps1'; Out = 'DrawZhuhaiLapCorners.exe'; Title = 'DrawZhuhaiLapCorners'; ConHost = $false }
)
foreach ($t in $targets) {
    $inPath = Join-Path $here $t.In
    $outPath = Join-Path $here $t.Out
    Write-Host "Building $outPath ..."
    Stop-ToolProcess $t.Out
    Start-Sleep -Milliseconds 400
    $tmp = Join-Path $env:TEMP ('ps2exe_' + [guid]::NewGuid().ToString('N') + '_' + $t.Out)
    try {
        # Draw：System.Drawing 用 -STA；-conHost 会导致脚本未跑完、PNG 不落盘。
        # BuildIdealLine：-conHost 便于无控制台/部分自动化场景结束等待。
        if ($t.ConHost) {
            Invoke-ps2exe -inputFile $inPath -outputFile $tmp -conHost -title $t.Title
        } else {
            Invoke-ps2exe -inputFile $inPath -outputFile $tmp -STA -noConsole:$false -title $t.Title
        }
        Copy-ExeToTools -TempExe $tmp -DestExe $outPath
        Write-Host "  -> $outPath"
    } finally {
        Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue
    }
}
Write-Host 'Done.'
