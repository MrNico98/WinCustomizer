@ECHO OFF
rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

:: Disable QuickEdit Mode
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 0 /f

powershell.exe -ExecutionPolicy Bypass -Command "Set-MpPreference -ExclusionPath 'C:\Users\%USERNAME%\Desktop\WinCustomizerGUI', 'C:\Users\%USERNAME%\Desktop\MrNico98Debloat3.0.exe'"

"WinCustomizerGUI.exe"
