@echo off
setlocal enabledelayedexpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

@echo off
setlocal enabledelayedexpansion

:: Set registry values
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v IRPStackSize /t REG_DWORD /d 50 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v SizReqBuf /t REG_DWORD /d 17424 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DefaultTTL /t REG_DWORD /d 62 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TCP1323Opts /t REG_DWORD /d 1 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v MaxFreeTcbs /t REG_DWORD /d 65536 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v MaxUserPort /t REG_DWORD /d 65534 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v GlobalMaxTcpWindowSize /t REG_DWORD /d 65535 /f

:: Change DNS
echo 1-Change DNS
for /f "tokens=2 delims=:" %%i in ('netsh interface show interface ^| find /i "Ethernet"') do set "Ethernet=%%i"
for /f "tokens=2 delims=:" %%i in ('netsh interface show interface ^| find /i "Wi-Fi"') do set "Wi-Fi=%%i"

echo Adapter Ethernet: %Ethernet%
echo Adapter Wi-Fi: %Wi-Fi%

set /p adapterChoice=Scrivi il numero, poi premi invio (1 per Ethernet o 2 per Wi-Fi):

if "%adapterChoice%"=="1" (
    set "adapterName=Ethernet"
) elseif "%adapterChoice%"=="2" (
    set "adapterName=Wi-Fi"
) else (
    echo Scelta non valida
    goto :EOF
)

netsh interface ipv4 set dnsservers name="%adapterName%" source=dhcp
echo All DNS servers removed successfully.

set "dns1=8.8.8.8"
set "dns2=8.8.4.4"
netsh interface ipv4 set dnsservers "%adapterName%" static %dns1% primary
netsh interface ip add dns "%adapterName%" %dns2% index=2
ipconfig /flushdns
echo DNS set successfully.

echo Press Enter to exit...
pause

:: Function pingtest
:pingtest
set "dns=%1"
for /f "tokens=7" %%a in ('ping -n 1 !dns! ^| find "time="') do set "ms1=%%a"
set "ms2=!ms1:~0,-2!"
echo !ms2!

endlocal
powershell write-host -fore Green "Completato"
timeout 4 >NUL