    Invoke-WebRequest -Uri "https://github.com/MrNico98/Office2021/archive/refs/heads/main.zip" -OutFile "Office2021-main.zip"
    Expand-Archive -Path "Office2021-main.zip" -DestinationPath "." -Force
    Move-Item -Path "Office2021-main\Office2021" -Destination "Office2021" -Force
    Remove-Item -Path "Office2021-main" -Recurse -Force
    Remove-Item -Path "Office2021-main.zip" -Recurse -Force
    mkdir "$currentPath\Office2021\configuration"
    Move-Item -Path "Risorse\configuration-x64-complete.xml" -Destination "Office2021\configuration\configuration-x64-complete.xml" -Force 
    Start-Process -FilePath ".\Office2021\Install-x64-complete.bat" -Wait
    Remove-Item -Path "$currentPath\Office2021" -Recurse -Force