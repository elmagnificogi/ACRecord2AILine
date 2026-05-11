# ACRecord2AILine

将 Assetto Corsa 回放（`.acreplay`）解析并转换为：

- 赛道 `ideal_line.ai`（可用于 AI 线更新）
- 刹车/补油点可视化图（PNG）

当前仓库内已经提供可直接运行的 Windows 可执行文件（`exe`），使用时不依赖本地 `ps1` 源脚本。

## 工具列表

### BuildIdealLineFromReplay.exe

用途：从回放或已导出的 JSON/CSV 重采样，写入 `ideal_line.ai`。

- 默认会调用同目录下的 `acrp.exe` 解析 `.acreplay`
- 目标输出由 `-IdealLinePath` 决定
- 若未指定 `-IdealLinePath`，默认输出为 `<TrackFolder>\data\ideal_line.ai`

### DrawReplayLapTelemetry.exe

用途：从回放或 JSON 计算走线上的刹车/油门/速度关键点，输出轨迹标注图（PNG）。

- 可自动生成 `<replay>_replay.json` / `<replay>_corners.json`
- 主要输出为 `<replay>_brake_throttle_points.png`

### tools 目录其他 exe 说明

- `acrp.exe`
  - 用途：将 `.acreplay` 解析为 JSON（核心依赖工具）。
  - 被 `BuildIdealLineFromReplay.exe` 与 `DrawReplayLapTelemetry.exe` 自动调用。
  - 建议与上述两个 exe 放在同一目录，避免额外传 `-AcRpPath`。

## 运行前准备

1. Windows 环境（PowerShell/cmd 均可）
2. `exe` 与 `acrp.exe` 放在同一目录（推荐）
3. 回放文件（`.acreplay`）可读

> 说明：`DrawReplayLapTelemetry.exe` 运行本身不依赖 `.ps1`。  
> `BuildIdealLineFromReplay.exe` 如果要写 `ideal_line.ai`，需要有可写目标路径；若目标文件不存在，会尝试从 `TrackFolder\data\ideal_line.ai` 复制模板（若存在）。

## BuildIdealLineFromReplay.exe 用法

### 前置依赖（请先确认）

必需依赖（使用 `-Replay` 时）：

- `BuildIdealLineFromReplay.exe`
- `acrp.exe`（默认需与 `BuildIdealLineFromReplay.exe` 同目录，或通过 `-AcRpPath` 指定）
- 回放文件（`.acreplay`）
- 输出目标文件 `ideal_line.ai` 或可用模板（见下）

`ideal_line.ai` 模板来源规则：

- 若 `-IdealLinePath` 指向的文件已存在：直接在该文件上改写
- 若 `-IdealLinePath` 不存在：会优先从 `TrackFolder\data\ideal_line.ai` 复制模板到目标路径
- 若 `TrackFolder\data\ideal_line.ai` 不存在：会回退尝试 `TrackFolder\data\fast_lane.ai`
- 若 `fast_lane.ai` 也不存在：再回退尝试 `TrackFolder\data\idle_line.ai`
- 若三者都不存在：工具会报错（无法从 0 生成）

使用 `-JsonPath` / `-CsvPath` 时：

- 可不需要 `acrp.exe`
- 仍需要可写的目标 `ideal_line.ai`（或可复制的模板）

最小可运行文件集（推荐）：

- `BuildIdealLineFromReplay.exe`
- `acrp.exe`
- `*.acreplay`
- 赛道目录中的 `data\ideal_line.ai`（作为模板）

### 1) 从回放直接生成/更新 ideal_line

```bat
BuildIdealLineFromReplay.exe -Replay ".\1.01.acreplay" -TrackFolder "G:\ACRecord2AILine\zhuhai" -IdealLinePath ".\ideal_line.ai"
```

结果：

- 生成/更新当前目录下 `ideal_line.ai`
- 自动生成备份：`ideal_line.ai.bak_yyyyMMdd_HHmmss`
- 默认启用 `-AutoFastestLap:$true`，自动按计时线分段选择最快圈

### 2) 只检查参数与流程（不写文件）

```bat
BuildIdealLineFromReplay.exe -Replay ".\1.01.acreplay" -TrackFolder "G:\ACRecord2AILine\zhuhai" -IdealLinePath ".\ideal_line.ai" -WhatIf
```

### 3) 查看可用 Lap 提示（不写 ideal_line）

```bat
BuildIdealLineFromReplay.exe -JsonPath ".\1.01_replay.json" -ShowLapHints
```

### 常见参数

- `-Replay`：输入回放文件
- `-TrackFolder`：赛道目录（用于定位模板/默认输出）
- `-IdealLinePath`：目标输出文件（建议显式传入）
- `-AutoFastestLap`：是否自动选择最快圈（默认 `true`）
- `-Lap`：固定圈编号（仅 `-AutoFastestLap:$false` 时生效；常见第 1 圈=0，第 2 圈=1）
- `-DriverName`：多车手回放时指定车手
- `-AcRpPath`：指定 `acrp.exe` 路径

固定圈号示例（关闭自动最快圈）：

```bat
BuildIdealLineFromReplay.exe -Replay ".\1.01.acreplay" -TrackFolder "G:\ACRecord2AILine\zhuhai" -IdealLinePath ".\ideal_line.ai" -AutoFastestLap:$false -Lap 1
```

## DrawReplayLapTelemetry.exe 用法

### 1) 从回放直接出图（自动补齐 json/corners）

```bat
DrawReplayLapTelemetry.exe -ReplayPath ".\1.01.acreplay" -OutputPath ".\1.01_brake_throttle_points.png"
```

### 2) 用现有 JSON/Corners 快速出图

```bat
DrawReplayLapTelemetry.exe -JsonPath ".\1.01_replay.json" -CornersJson ".\1.01_corners.json" -OutputPath ".\1.01_brake_throttle_points.png"
```

示例输出图：

![DrawReplayLapTelemetry 示例输出](docs/drawzhuhai_example.png)

### 常见参数

- `-ReplayPath`：输入回放文件
- `-JsonPath`：已解析回放 JSON
- `-CornersJson`：分段/弯心配置 JSON
- `-OutputPath`：输出 PNG 路径
- `-Lap`：目标圈（默认自动最快圈）

## 新目录分发建议

如果在新目录（例如 `G:\tt`）使用，建议至少放这些文件：

- `BuildIdealLineFromReplay.exe`
- `DrawReplayLapTelemetry.exe`
- `acrp.exe`
- 回放文件（如 `1.01.acreplay`）

示例：

```bat
cd /d G:\tt
DrawReplayLapTelemetry.exe -ReplayPath ".\1.01.acreplay" -OutputPath ".\test_points.png"
BuildIdealLineFromReplay.exe -Replay ".\1.01.acreplay" -TrackFolder "G:\ACRecord2AILine\zhuhai" -IdealLinePath ".\ideal_line.ai"
```

## 重新打包 exe

在 `tools` 目录执行：

```bat
powershell -ExecutionPolicy Bypass -File ".\Package-ToolsWithPs2exe.ps1"
```

会重新生成：

- `tools\BuildIdealLineFromReplay.exe`
- `tools\DrawReplayLapTelemetry.exe`



## Quote

> https://elmagnifico.tech/2026/04/06/AC-Replay2AILine/
