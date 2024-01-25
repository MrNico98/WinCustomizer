@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

for %%i in ("wuauserv", "WaaSMedicSvc", "UsoSvc") do (
    sc config %%i start=auto
    sc start %%i
)

schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /enable

if not exist "HKLM\Software\Microsoft\WindowsUpdate\UX\Settings" (
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UX\Settings" /f
)

reg add "HKLM\Software\Microsoft\WindowsUpdate\UX\Settings" /v "UxOption" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\ControlSet001\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 2 /f

endlocal
powershell write-host -fore Green "Completato, riavvio il pc tra 5 secondi"
timeout 4 >NUL
shutdown /r /t 00