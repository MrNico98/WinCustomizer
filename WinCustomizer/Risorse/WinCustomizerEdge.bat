@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

title WinCustomizer Rimozione Edge

for %%# in (%_args%) do (if /i "%%#"=="-qedit" set quedit=1)
reg query HKCU\Console /v QuickEdit %nul2% | find /i "0x0" %nul1% || if not defined quedit (
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d "0" /f %nul1%
start cmd.exe /c ""!_batf!" %_args% -qedit"
exit /b
)

IF exist PowerRun.exe (
    echo ok
) ELSE (
    echo powerrun not present! && pause && exit /b 1
)

echo.
echo Killing Microsoft Edge...
echo.
taskkill /F /IM msedge.exe 2>nul

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f

PowerRun.exe cmd.exe /c "rmdir /s / q "C:\Program Files (x86)\Microsoft\Edge""
PowerRun.exe cmd.exe /c "rmdir /s / q "C:\Program Files\Microsoft\Edge""

del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"2>nul
del "%appdata%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"2>nul

timeout 7

powershell write-host -fore Green "Rebooting in 15 seconds"
timeout 15
shutdown /r /t 00 
