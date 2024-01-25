@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

:: Check if 'Take Ownership' is already in the context menu
reg query "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership" > nul 2>&1
if %errorlevel% neq 0 (
    echo Adding 'Take Ownership' to context menu!
    
    :: Create registry keys
    reg add "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership" /f /reg:32 > nul 2>&1
    reg add "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership\command" /f /reg:32 > nul 2>&1
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership" /f /reg:32 > nul 2>&1
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership\command" /f /reg:32 > nul 2>&1
    
    :: Set registry values
    reg add "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership" /v "(default)" /d "Take Ownership" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership" /v "HasLUAShield" /d "" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership" /v "NoWorkingDirectory" /d "" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership" /v "Position" /d "middle" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership\command" /v "(default)" /d "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \"%1\" && icacls \"%1\" /grant *S-1-3-4:F /c /l'\" -Verb runAs" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\*\shell\TakeOwnership\command" /v "IsolatedCommand" /d "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \"%1\" && icacls \"%1\" /grant *S-1-3-4:F /c /l'\" -Verb runAs" /t REG_SZ /f
    
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership" /v "(default)" /d "Take Ownership" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership" /v "AppliesTo" /d "NOT (System.ItemPathDisplay:=\"C:\Users\" OR System.ItemPathDisplay:=\"C:\ProgramData\" OR System.ItemPathDisplay:=\"C:\Windows\" OR System.ItemPathDisplay:=\"C:\Windows\System32\" OR System.ItemPathDisplay:=\"C:\Program Files\" OR System.ItemPathDisplay:=\"C:\Program Files (x86)\")" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership" /v "HasLUAShield" /d "" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership" /v "NoWorkingDirectory" /d "" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership" /v "Position" /d "middle" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership\command" /v "(default)" /d "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant *S-1-3-4:F /c /l /q'\" -Verb runAs" /t REG_SZ /f
    reg add "HKLM\SOFTWARE\Classes\Directory\shell\TakeOwnership\command" /v "IsolatedCommand" /d "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant *S-1-3-4:F /c /l /q'\" -Verb runAs" /t REG_SZ /f
    
    echo FATTO
) else (
    echo Hai gia il pulsante nel menu destro del mouse
)

endlocal
powershell write-host -fore Green "Completato"
timeout 4 >NUL