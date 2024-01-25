@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem Check OS
wmic os get Caption | find "11">NUL
IF "%ERRORLEVEL%"=="0" echo "windows 11" && goto :11

wmic os get Caption | find "10">NUL
IF "%ERRORLEVEL%"=="0" echo "windows 10" && goto :copilot


REM Check if hotfix KB5032278 is installed

:11
REM Check if hotfix KB5030310 is installed
set 'command=powershell -command "Get-HotFix | Where-Object {$_.HotFixID -eq 'KB5030310'}"'
for /f %%a in ('%command%') do set "output=%%a"

REM Trova la build del sistema operativo utilizzando WMIC
for /F "tokens=2 delims==." %%a in ('wmic os get BuildNumber /value ^| findstr /r "[0-9]"') do (
    set "build_number=%%a"
)

REM Confronta il numero di build con 22621
if %build_number% GEQ 22621 (
    echo La versione di build del sistema superiore o uguale a 22621
    goto :copilot
) else (
    echo La versione di build del sistema inferiore a 22621
    goto :installupdate11
)


:installupdate11
cd %temp%
PowerShell -Command "Start-BitsTransfer -Source "https://catalog.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/02a8ad05-42e4-4a6d-aa03-27cf6a0a1533/public/windows11.0-kb5030310-x64_2b759815a3b7626cc8f508753553172aa444d454.msu" -Destination "%temp%\windows11.0-kb5030310-x64_2b759815a3b7626cc8f508753553172aa444d454.msu""
wusa.exe "windows11.0-kb5030310-x64_2b759815a3b7626cc8f508753553172aa444d454.msu" /quiet /norestart
echo Update installed successfully.

:copilot
echo ==========COPILOT==========
echo     [1] Attiva COPILOT
echo     [2] Disattiva COPILOT
echo ===========================
set /p "ansewer=Digita il numero, poi premi invio:"
if /i "%answer%"== "1" ( goto :active )
if /i "%answer%"== "2" ( goto :disab )


:active
echo.
echo downloading
powershell -Command "$url = (Invoke-RestMethod -Uri 'https://api.github.com/repos/thebookisclosed/ViVe/releases/latest').assets[1].browser_download_url; Invoke-WebRequest -Uri $url -OutFile \"$env:APPDATA\\\vivetool.zip\""

echo.
echo unzipping
7z.exe x -y -o"C:\vivetool" "%appdata%\vivetool.zip"

echo.
echo using the tool
C:\vivetool\ViVeTool.exe /enable /id:44774629,44776738,44850061,42105254,41655236

echo.
echo apply reg
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Copilot\BingChat" /v IsUserEligible /t REG_DWORD /d 1 /f

rmdir "C:\vivetool" /s /q

IF exist "C:\Users\%USERNAME%\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\Desktop"
)

IF exist "C:\Users\%USERNAME%\OneDrive\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\OneDrive\Desktop"
)

set "target=microsoft-edge://?ux=copilot&tcp=1&source=taskbar"
set "shortcutName=Copilot.lnk"
set "shortcutPath=%USERPROFILE%\Desktop\%shortcutName%"

echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%shortcutPath%" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%target%" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs
cls
echo Collegamento Copilot creato sul Desktop
timeout 4
goto :end

:disab
echo.
echo downloading
powershell -Command "$url = (Invoke-RestMethod -Uri 'https://api.github.com/repos/thebookisclosed/ViVe/releases/latest').assets[1].browser_download_url; Invoke-WebRequest -Uri $url -OutFile \"$env:APPDATA\\\vivetool.zip\""

echo.
echo unzipping
7z.exe x -y -o"C:\vivetool" "%appdata%\vivetool.zip"

echo.
echo using the tool
C:\vivetool\ViVeTool.exe /disable /id:44774629,44776738,44850061,42105254,41655236

echo.
echo apply reg
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Copilot\BingChat" /v IsUserEligible /t REG_DWORD /d 0 /f

rmdir "C:\vivetool" /s /q

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /t REG_DWORD /d 0 /f

IF exist "C:\Users\%USERNAME%\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\Desktop"
)

IF exist "C:\Users\%USERNAME%\OneDrive\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\OneDrive\Desktop"
)

rmdir /s / q  "Copilot.lnk"

:end
endlocal
powershell write-host -fore Green "Completato,riavvio il PC tra 5 secondi"
timeout 4 >NUL
shutdown /r /t 00
