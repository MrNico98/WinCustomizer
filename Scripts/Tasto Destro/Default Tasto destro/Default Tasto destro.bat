@echo off
setlocal enabledelayedexpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

:: Check Windows version
systeminfo | find "Windows 10" > nul
if %errorlevel% equ 0 (
    echo Funzione abilitata solo per Windows 11
) else (
 reg delete HKCU\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2} /f
 taskkill /f /im StartMenuExperienceHost.exe & taskkill /f /im explorer.exe & start explorer.exe
)

endlocal
powershell write-host -fore Green "Completato"
timeout 4 >NUL