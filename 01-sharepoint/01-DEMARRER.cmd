@echo off
setlocal
cd /d "%~dp0"
where pwsh.exe >nul 2>nul
if errorlevel 1 (
  echo PowerShell 7 pwsh.exe introuvable. Installer PowerShell 7 avant execution.
  pause
  exit /b 1
)
pwsh.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File ".\scripts\DSE-Create-Production-Structure.ps1"
pause
