@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

WSReset -i 1>nul 2>nul
TimeOut 20 2>nul
WSReset -i 1>nul 2>nul
timeout 04 2>nul

endlocal
powershell write-host -fore Green "Completato,lo store si sta scaricando attendi"
timeout 4 >NUL