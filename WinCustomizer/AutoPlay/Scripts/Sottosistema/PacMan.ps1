    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "$PSCommandPath"
        break
    }
    
    $dek=[Environment]::GetFolderPath("Desktop")
    cd $dek
    Invoke-WebRequest -Uri "https://github.com/MrNico98/pacman/archive/refs/heads/main.zip" -OutFile "pacman-main.zip"
    Expand-Archive -Path "pacman-main.zip" -DestinationPath "." -Force
    Move-Item -Path "pacman-main\WSA-pacman-v1.5.0-portable" -Destination "WSA-pacman-v1.5.0-portable" -Force
    Remove-Item -Path "pacman-main" -Recurse -Forc
    Remove-Item -Path "pacman-main.zip" -Force
    Rename-Item -Path "$dek\WSA-pacman-v1.5.0-portable" -NewName "PacManWSA"
    Start-Process -FilePath "$dek\PacManWSA\WSA-pacman.exe"