@echo off
setlocal enabledelayedexpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

:: Stop services
sc stop bits
sc stop wuauserv
sc stop cryptsvc

:: Remove Catroot2 directory
rmdir /s /q "%SystemRoot%\System32\Catroot2"

:: Start cryptsvc service
sc start cryptsvc

:: Remove WindowsUpdate.log file
del /f /q "%windir%\WindowsUpdate.log"

:: System32 path and files to register
set "system32Path=%SystemRoot%\System32"
set "filesToRegister=atl.dll jscript.dll msxml3.dll softpub.dll wuapi.dll wuaueng.dll wuaueng1.dll wucltui.dll wups.dll wups2.dll wuweb.dll quartz.dll"

:: Register DLL files
for %%i in (%filesToRegister%) do (
    set "dllPath=%system32Path%\%%i"
    if exist "!dllPath!" (
        regsvr32 /s "!dllPath!" || echo Failed to register: !dllPath!
    ) else (
        echo DLL not found: !dllPath!
    )
)

:: Remove registry properties
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f

regedit /s "Windows_Update.reg"

:: Start services
sc start bits
sc start wuauserv
net start trustedinstaller
net start usosvc
net start cryptsvc
net start waasmedicsvc
net start dosvc

endlocal
powershell write-host -fore Green "Completato, riavvio il pc tra 5 secondi"
timeout 4 >NUL
shutdown /r /t 00