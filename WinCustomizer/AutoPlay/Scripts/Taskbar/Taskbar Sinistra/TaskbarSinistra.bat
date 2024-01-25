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
    echo Setto icone taskbar a sinistra
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAl" /t REG_DWORD /d 0 /f
)

endlocal
powershell write-host -fore Green "Completato"
timeout 4 >NUL