@echo off
setlocal enabledelayedexpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

:: Create directory
mkdir "C:\DriverPC" 2>nul

:: Export drivers using dism.exe
dism /online /export-driver /destination:C:\DriverPC

:: Run driverquery and save the output to a file
driverquery > "C:\DriverPC\driver.txt"

endlocal
powershell write-host -fore Green "Completato, driver salvati in C:\DriverPC"
timeout 4 >NUL