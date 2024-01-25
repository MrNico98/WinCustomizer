if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "WinCustomizer necessita di essere lanciato come Amministratore. Riavvio."
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "irm -Uri https://bit.ly/WinCustomizer | iex"
    break
}

Remove-Item -Path "$env:USERPROFILE\Desktop\WinCustomizer" -Recurse -Force |out-null
if (Test-Path -Path "$env:USERPROFILE\Desktop\WinCustomizer"-PathType Leaf) {Remove-Item -Path "$env:USERPROFILE\OneDrive\Desktop\WinCustomizer" -Recurse -Force}

# Change to the desktop directory
cd "$env:USERPROFILE\Desktop"
if (Test-Path -Path "$env:USERPROFILE\Desktop"-PathType Leaf) {cd "$env:USERPROFILE\OneDrive\Desktop"}

# Download the script from GitHub
Invoke-WebRequest -Uri "https://github.com/MrNico98/WinCustomizer/archive/refs/heads/main.zip" -OutFile "WinCustomizer-main.zip"


Expand-Archive -Path "WinCustomizer-main.zip" -DestinationPath "." -Force


Move-Item -Path "WinCustomizer-main\WinCustomizer" -Destination "WinCustomizer" -Force


Remove-Item -Path "WinCustomizer-main" -Recurse -Force


Remove-Item -Path "WinCustomizer-main.zip" -Force


Start-Process -FilePath ".\WinCustomizer\WinCustomizer.exe"
