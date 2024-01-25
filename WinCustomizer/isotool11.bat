@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

title WinCustomizer Debloat ISO 11

if exist "%TEMP%\consoleSettingsBackup.reg" regedit /S "%TEMP%\consoleSettingsBackup.reg"&DEL /F /Q "%TEMP%\consoleSettingsBackup.reg"&goto :mainstart
regedit /S /e "%TEMP%\consoleSettingsBackup.reg" "HKEY_CURRENT_USER\Console"
echo REGEDIT4>"%TEMP%\disablequickedit.reg"
echo [HKEY_CURRENT_USER\Console]>>"%TEMP%\disablequickedit.reg"
(echo "QuickEdit"=dword:00000000)>>"%TEMP%\disablequickedit.reg"
regedit /S "%TEMP%\disablequickedit.reg"
DEL /F /Q "%TEMP%\disablequickedit.reg"
start "" "cmd" /c "%~dpnx0"&exit

:mainstart
cls
echo ==================PULIZIA DISM=============
echo Ora eseguiro' una pulizia rimani in attesa
echo ===========================================
dism /cleanup-mountpoints

rem Download iso
:scarica
cls
color 02
echo. ================ISO=============
echo. Scaricare la ISO di win11?
echo.        [1] SI
echo.        [2] NO
echo. ================================
set /p answer="Seleziona Numero: "
if /i "%answer%"=="1" ( start "" "https://www.microsoft.com/it-it/software-download/windows11" goto :attesaiso )
if /i "%answer%"=="2" ( goto :cartellaISO )
else ( echo ATTENZIONE! I valori accettati sono solamente '1' '2' )

rem In attesa di ISO
:attesaiso
cls
powerShell -Command "Write-Host 'Digita 'FINE' al termine del download per proseguire' -ForegroundColor 7; exit"
SET /P answer=":"
IF /I '%answer%'=='fine' GOTO :cartellaISO

:: Check for the pressed button 
if %errorlevel%==1 ( goto :cartellaISO )

rem verifica cartelle
:cartellaISO
cls
color 02
IF NOT EXIST "C:\ISO\WinISO" ( goto :isofolder )
IF EXIST "C:\ISO\WinISO" ( 
    echo "ERRORE: C\ISO\WinISO esiste gia', elimina la cartella? si,no"
    goto :domande )

:domande
SET /P answer=":" 
IF /I '%answer%'=='si' GOTO :eliminacartella
IF /I '%answer%'=='no' GOTO :winfolder

:eliminacartella
echo Elimino la cartella, attendi...
dism /unmount-image /mountdir:C:\mount\mount /discard >NUL
rmdir "C:\ISO\WinISO" /s /q
goto :cartellaISO

:isofolder
cls 
mkdir "C:\ISO\WinISO"

:winfolder
color 02
IF EXIST "C:\mount\mount" (
    dism /unmount-image /mountdir:C:\mount\mount /discard >NUL
    rmdir "C:\mount\mount" /s /q
)
mkdir "C:\mount\mount"

:iso
cls
rem set iso path
set "filepath="
set "dialogTitle=seleziona il file iso"

rem Open file dialog to select file
:select_file
powerShell -Command "Write-Host 'Seleziona il file iso di windows 11' -ForegroundColor Green; exit"  
for /f "usebackq delims=" %%f in (`powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $openFileDialog.InitialDirectory = [Environment]::GetFolderPath('Desktop'); $openFileDialog.Title = '%dialogTitle%'; $openFileDialog.Filter = 'ISO files (*.iso)|*.iso'; $openFileDialog.FilterIndex = 1; $openFileDialog.Multiselect = $false; $openFileDialog.ShowDialog() | Out-Null; $openFileDialog.FileName}"`) do set "filepath=%%f"

if defined filepath (
  powerShell -Command "Write-Host 'Hai selezionato %filepath%' -ForegroundColor Green; exit"  
  cls
) ELSE (
  echo Nessun file selezionato
  goto :select_file
)

powerShell -Command "Write-Host 'Sto estraendo la iso in C:\ISO\WinISO... Attendi!' -ForegroundColor Green; exit"  
Risorse\7z.exe x -y -o"C:\ISO\WinISO" "%filepath%" > nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Estrazione della ISO completata!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Estrazione fallita!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

IF NOT EXIST "C:\ISO\WinISO\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\WinISO\sources\$OEM$\$$\Panther"
)

:checkesdwim
cls
rem check if wim or esd
IF EXIST "C:\ISO\WinISO\sources\install.wim" (
    goto :wim
)

IF EXIST "C:\ISO\WinISO\sources\install.esd" (
    goto :esd
)

:esd
cls
echo ========================INDICE==============================
dism /Get-WimInfo /WimFile:C:\ISO\WinISO\sources\install.esd
echo ============================================================
set /p index="Indice: "
cls
powerShell -Command "Write-Host 'Attendi' -ForegroundColor white; exit"
dism /export-image /SourceImageFile:C:\ISO\WinISO\sources\install.esd /SourceIndex:%index% /DestinationImageFile:C:\ISO\WinISO\sources\install.wim /Compress:max /CheckIntegrity
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Immagine esportata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile esportare l''immagine!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :copy_esd

:wim
cls
rem export windows edition
echo ========================INDICE=============================
dism /Get-WimInfo /WimFile:C:\ISO\WinISO\sources\install.wim
echo ===========================================================
set /p index="Indice: "
cls
powerShell -Command "Write-Host 'Attendi' -ForegroundColor 7; exit"  
dism /Export-Image /SourceImageFile:"C:\ISO\WinISO\sources\install.wim" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\WinISO\sources\install_pro.wim" /compress:max
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Immagine esportata con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile esportare l''immagine!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:copy_wim
cls
rem copy the new install.wim
del "C:\ISO\WinISO\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.wim eliminato!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare old install.wim!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

move "C:\ISO\WinISO\sources\install_pro.wim" "C:\ISO\WinISO\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Il nuovo install.wim e'' stato spostato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile spostare il nuovo install.wim!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :mountwim

rem copy the new install.esd
:copy_esd
cls
del "C:\ISO\WinISO\sources\install.esd"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.esd eliminato!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare old install.esd!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :mountwim

:mountwim
rem mount the image with dism
powerShell -Command "Write-Host 'Sto montando l''immagine' -ForegroundColor 7; exit"  
dism /mount-image /imagefile:"C:\ISO\WinISO\sources\install.wim" /index:1 /mountdir:"C:\mount\mount"
cls

rem ISO bypass
:selectunattend
cls
echo. ==============UNATTEND==============
echo.              [1] Bypass
echo.              [2] Stock
echo. ====================================
set /p answer="Seleziona Numero: "
if /i "%answer%"=="1" ( goto :bypass )
if /i "%answer%"=="2" ( goto :stock )
else ( echo ATTENZIONE! I valori accettati sono solamente '1' '2'.)

:bypass
rem copy unattended.xml
copy "Risorse\unattend.xml" "C:\ISO\WinISO\sources\$OEM$\$$\Panther\unattend.xml"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'unattend.xml copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare unattend.xml!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

reg load HKLM\TK_COMPONENTS "C:\mount\mount\Windows\System32\config\COMPONENTS"
reg load HKLM\TK_DEFAULT "C:\mount\mount\Windows\System32\config\default" 
reg load HKLM\TK_NTUSER "C:\mount\mount\Users\Default\ntuser.dat"
reg load HKLM\TK_SOFTWARE "C:\mount\mount\Windows\System32\config\SOFTWARE" 
reg load HKLM\TK_SYSTEM "C:\mount\mount\Windows\System32\config\SYSTEM" 
			Reg add "HKLM\TK_DEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f
			Reg add "HKLM\TK_DEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f 
			Reg add "HKLM\TK_NTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f 
			Reg add "HKLM\TK_NTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f 
			Reg add "HKLM\TK_SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f
			Reg add "HKLM\TK_SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f 
			Reg add "HKLM\TK_SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f 
			Reg add "HKLM\TK_SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f 
			Reg add "HKLM\TK_SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f 
			Reg add "HKLM\TK_SYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /t REG_DWORD /d "1" /f
reg unload HKLM\TK_COMPONENTS 
reg unload HKLM\TK_DEFAULT 
reg unload HKLM\TK_DRIVERS 
reg unload HKLM\TK_NTUSER 
reg unload HKLM\TK_SCHEMA 
reg unload HKLM\TK_SOFTWARE 
reg unload HKLM\TK_SYSTEM 

mkdir "C:\mount\boot"
dism /mount-image /imagefile:"C:\ISO\WinISO\sources\boot.wim" /index:2 /mountdir:"C:\mount\boot"
	Reg load "HKLM\TK_BOOT_SYSTEM" "C:\mount\boot\Windows\System32\Config\SYSTEM" 
	Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f 
	Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f 
	Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f 
	Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f 
	Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f 
	Reg unload "HKLM\TK_BOOT_SYSTEM" 
  move "C:\ISO\WinISO\sources\appraiserres.dll" "C:\ISO\WinISO\sources\appraiserres.dll.bak"
  dism /unmount-image /mountdir:"C:\mount\boot" /commit
cls
goto :menuprincipale

:stock
cls
rem copy unattended.xml
copy "Risorse\unattendstock.xml" "C:\ISO\WinISO\sources\$OEM$\$$\Panther\unattend.xml"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'unattend.xml copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare unattend.xml!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :menuprincipale

cls
rem menuprincipale
:menuprincipale
cls
echo =========================MENU=======================
echo                         [1] Rimozione Processi
echo                         [2] Rimozione Microsoft Edge
echo                         [3] Rimozione Windows Defender
echo                         [4] Tweaks (Necessario per debloat)
echo                         [5] Blocca Windows Update
echo                         [6] Fine
echo =============================================================
set /p answer="Seleziona numero: "
if /i "%answer%"=="1" ( goto :compomicrosoft )
if /i "%answer%"=="2" ( goto :edge )
if /i "%answer%"=="3" ( goto :defender )
if /i "%answer%"=="4" ( goto :tweaksbat )
if /i "%answer%"=="5" ( goto :windowsupdate )
if /i "%answer%"=="6" ( goto :fine )
else ( echo ATTENZIONE! I valori accettati sono solamente '1' '2' '3' '4' '5' '6'.
    goto :menuprincipale)

rem windows update win11
:windowsupdate
cls
reg load HKLM\TK_SOFTWARE "C:\mount\mount\Windows\System32\config\SOFTWARE"
Reg add "HKLM\TK_SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx" /t REG_DWORD /d "1" /f
Reg add "HKLM\TK_SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d "1" /f
reg unload HKLM\TK_SOFTWARE
echo > C:\mount\mount\Windows\noupdate.pref
goto :menuprincipale

rem delete edge
:edge
cls
echo > C:\mount\mount\Windows\noedge.pref
copy "Risorse\OperaGXSetup.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Installer di OperaGXSetup.exe copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare l''installer di OperaGXSetup.exe!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
copy "Risorse\PowerRun.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'PowerRun.exe copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare PowerRun.exe!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :menuprincipale

rem disable defender
:defender
cls
echo > C:\mount\mount\Windows\nodefender.pref
copy "Risorse\PowerRun.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'PowerRun.exe copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare PowerRun.exe!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :menuprincipale

:compomicrosoft
powerShell -Command "Write-Host 'Iniziamo la rimozione...' -ForegroundColor Green; exit"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-InternetExplorer-Optional-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Kernel-LA57-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Handwriting*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-OCR*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Speech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-TextToSpeech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-MediaPlayer-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-TabletPCMath-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Wallpaper-Content-Extended-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powerShell -Command "Write-Host 'Completato' -ForegroundColor Green; exit"
goto :menuprincipale

:tweaksbat
rem copy batch file
cls
copy "Risorse\tweaks.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'tweaks.bat copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare tweaks.bat!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy debloater
cls
copy "Risorse\WinCustomizerDebloat3.0.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'WinCustomizerDebloat3.0 copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare WinCustomizerDebloat3.0.ps1!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy start.ps1
cls
copy "Risorse\start.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'start.ps1 copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare start.ps1!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy attivatore
copy "Risorse\WinCustomizerAttivatore.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'WinCustomizerAttivatore.bat copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare WinCustomizerAttivatore.bat!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy fixatt
copy "Risorse\testfix.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'testfix.ps1 copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare testfix.ps1!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy reg
copy "Risorse\lower-ram-usage.reg" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'lower-ram-usage.reg copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare lower-ram-usage.reg!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy main
copy "Risorse\main.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'main.ps1 copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare main.ps1!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy Start Debloat
copy "Risorse\WinCustomizerStartDebloat.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'WinCustomizerStartDebloat.bat copiato con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare WinCustomizerStartDebloat.bat!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

goto :menuprincipale

:fine
cls
rem unmount the image
powerShell -Command "Write-Host 'Smontando l''immagine' -ForegroundColor 7; exit" 
dism /unmount-image /mountdir:"C:\mount\mount" /commit

cls
echo =========WIM/ESD=========
echo       [1] ESD
echo       [2] WIM
echo =========================
set /p "answer=Seleziona Numero: "
if /i "%answer%"=="1" ( goto :esdre )
if /i "%answer%"=="2" ( goto :wimre )

cls
:esdre
powerShell -Command "Write-Host 'Creo il .esd' -ForegroundColor 7; exit" 
dism /export-image /SourceImageFile:"C:\ISO\WinISO\sources\install.wim" /SourceIndex:1 /DestinationImageFile:"C:\ISO\WinISO\sources\install.esd" /Compress:recovery /CheckIntegrity
cls

echo Cancello il .wim
del "C:\ISO\WinISO\sources\install.wim"
cls

rem rebuild image
:wimre
cls
powerShell -Command "Write-Host 'Creando la ISO' -ForegroundColor 7; exit"  
Risorse\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\WinISO\boot\etfsboot.com#pEF,e,bC:\ISO\WinISO\efi\microsoft\boot\efisys.bin C:\ISO\WinISO C:\ISO\WindowsISO_edited.iso
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO creata con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile creare la ISO!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy the iso and clean
cls
copy "C:\ISO\WindowsISO_edited.iso" "C:\"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO copiata con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare la ISO in C!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\ISO" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'La directory1 usata per la creazione della ISO e'' stata eliminata con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare la directory1 usata per la creazione della ISO!" && pause && del "Risorsenattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\mount" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'La directory2 usata per la creazione della ISO e'' stata eliminata con successo!' -ForegroundColor 7; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare la directory2 usatq per la creazione della ISO!" && pause && del "Risorse\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:: Enable QuickEdit Mode
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f

powerShell -Command "Write-Host 'Processo completato troverari la tua ISO in C:! -ForegroundColor Green; exit"  
endlocal

::##################################################################################################################################################
