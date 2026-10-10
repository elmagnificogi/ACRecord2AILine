@echo off
cd /d "%~dp0"
where py >nul 2>nul
if not errorlevel 1 (
  py -3.12 -c "import sys" >nul 2>nul
  if not errorlevel 1 (
    py -3.12 "%~dp0restore_workspace.py" %*
  ) else (
    py -3 "%~dp0restore_workspace.py" %*
  )
  goto done
)
where python >nul 2>nul
if not errorlevel 1 (
  python "%~dp0restore_workspace.py" %*
  goto done
)
if exist "D:\Python\Python312\python.exe" (
  "D:\Python\Python312\python.exe" "%~dp0restore_workspace.py" %*
  goto done
)
echo Install Git LFS and Python 3.11 or newer with Tkinter first.
exit /b 1
:done
if errorlevel 1 (
  echo Restore failed. Check the message above.
  pause
  exit /b 1
)
echo SU7 workspace restored.
