@echo off
setlocal
"%~dp0BuildIdealLineFromReplay.exe" %*
exit /b %ERRORLEVEL%
