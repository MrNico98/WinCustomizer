if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "WinCustomizerGUI necessita di essere lanciato come Amministratore. Riavvio."
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "irm -Uri https://bit.ly/wincustomizergui | iex"
    break
}

Remove-Item -Path "$env:USERPROFILE\Desktop\WinCustomizerGUI" -Recurse -Force
if (Test-Path -Path "$env:USERPROFILE\Desktop\WinCustomizerGUI"-PathType Leaf) {cd "$env:USERPROFILE\OneDrive\Desktop\WinCustomizerGUI"}

Set-MpPreference -ExclusionPath $env:USERPROFILE\Desktop\WinCustomizerGUI-main

# Change to the desktop directory
cd "$env:USERPROFILE\Desktop"
if (Test-Path -Path "$env:USERPROFILE\Desktop"-PathType Leaf) {cd "$env:USERPROFILE\OneDrive\Desktop"}

# Download the script from GitHub
Invoke-WebRequest -Uri "https://github.com/MrNico98/WinCustomizerGUI/archive/refs/heads/main.zip" -OutFile "WinCustomizerGUI-main.zip"


Expand-Archive -Path "WinCustomizerGUI-main.zip" -DestinationPath "." -Force


Move-Item -Path "WinCustomizerGUI-main\WinCustomizerGUI" -Destination "WinCustomizerGUI" -Force


Remove-Item -Path "WinCustomizerGUI-main" -Recurse -Force


Remove-Item -Path "WinCustomizerGUI-main.zip" -Force


Start-Process -FilePath ".\WinCustomizerGUI\Start.bat"
