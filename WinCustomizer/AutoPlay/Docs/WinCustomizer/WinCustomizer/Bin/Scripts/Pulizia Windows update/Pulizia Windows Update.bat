@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

sc stop wuauserv

start /wait DISM.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase

start /wait cleanmgr.exe /sagerun:1

endlocal
powershell write-host -fore Green "Completato"
timeout 4 >NUL