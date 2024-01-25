@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

set "packageName=Microsoft.549981C3F5F10"

for /f "tokens=*" %%i in ('wmic product where "Name like '%%%packageName%%%' and Vendor like '%%Microsoft%%'" get IdentifyingNumber /value ^| find "="') do (
    msiexec /x %%i /quiet /qn
)

endlocal
powershell write-host -fore Green "Completato"
timeout 4 >NUL