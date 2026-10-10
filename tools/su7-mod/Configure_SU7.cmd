@echo off
cd /d "%~dp0"
if exist "%~dp0..\..\.venv\Scripts\pythonw.exe" (
  "%~dp0..\..\.venv\Scripts\pythonw.exe" "%~dp0configure.py"
  exit /b
)
if exist "D:\Python\Python312\pythonw.exe" (
  "D:\Python\Python312\pythonw.exe" "%~dp0configure.py"
  exit /b
)
where pyw >nul 2>nul
if not errorlevel 1 (
  pyw -3 "%~dp0configure.py"
  exit /b
)
where python >nul 2>nul
if not errorlevel 1 (
  python "%~dp0configure.py"
  exit /b
)
echo Python 3 with Tkinter is required. Open README.zh-CN.md for the command.
pause
