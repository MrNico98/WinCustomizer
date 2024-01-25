@echo off
setlocal enabledelayedexpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

dism.exe /online /cleanup-image /checkhealth
dism.exe /online /cleanup-image /scanhealth
dism.exe /online /cleanup-image /RestoreHealth

endlocal
powershell write-host -fore Green "Completato, riavvio il pc tra 5 secondi"
timeout 4 >NUL
shutdown /r /t 00