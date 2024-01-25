@echo off
setlocal enabledelayedexpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem Check the system architecture
systeminfo | find "Windows 11"
IF "%ERRORLEVEL%"=="0" echo "win11!" && goto :win11
systeminfo | find "Windows 10"
IF "%ERRORLEVEL%"=="0" echo "win11!" && goto :win10

:win11
powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Notepad|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} | Remove-AppxPackage"
powershell -command "Get-Process OneDrive | Stop-Process -Force"
powershell -command "C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v  "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v  "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
sc config wsearch start=auto
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "dontdisplaylastusername" /t REG_DWORD /d 0 /f
goto :exit



:win10
powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Notepad|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} | Remove-AppxPackage"
powershell -command "Get-Process OneDrive | Stop-Process -Force"
powershell -command "C:\Windows\System32\OneDriveSetup.exe /uninstall"
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeature"s -Type DWord -Value 1
sc config wsearch start=auto
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "dontdisplaylastusername" /t REG_DWORD /d 0 /f


:exit
endlocal
powershell write-host -fore Green "Completato"
timeout 4 >NUL