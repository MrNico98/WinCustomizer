     if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "$PSCommandPath"
        break
    }
    
     
     Start-Process "https://graph.org/Guida-Installazione-WSA-10-03"

     systeminfo | find "Windows 11"
     if ($?) {Write-Host "11"
     $os=11}
     systeminfo | find "Windows 10"
     if ($?) {Write-Host "10"
     $os=10}
     systeminfo | find "ARM64-based PC"
     if ($?) {write-host "ARM64"
     $cercoos=65}
     systeminfo | find "x64-based PC"
     if ($?) {write-host "x64"
     $typeos=64}

     If (11 -eq $os) { if(64 -eq $typeos) {
     $origine="$env:USERPROFILE\Downloads\WSAwin11x64.zip"
     $medio="$currentPath\Risorse"
     $medino="$currentPath\WSA"
     $rename="$currentPath\WSAwin11x64"
     $fine="$env:USERPROFILE\Desktop"
     if (Test-Path -Path "$env:USERPROFILE\Desktop"-PathType Leaf) {$fine="$env:USERPROFILE\OneDrive\Desktop"}


     Start-Process "https://mega.nz/file/Ti5l1I4B#5n_BpNnOCE99hL6fp5V-ly99WqV49QzapOWKTPYP2-w"
     Read-host "Salva nella cartella Downloads e digita 'FINE' al termine del download"
     Move-Item -path $origine -Destination $medio -Force
     Expand-Archive "Risorse\WSAwin11x64.zip"
     Rename-Item "$rename" "WSA"
     Move-Item -path $medino -Destination $fine -Force
     Start-Process "$env:USERPROFILE\Desktop\WSA\Run.bat" -Wait
     if (Test-Path -Path "$env:USERPROFILE\Desktop\WSA\Run.bat"-PathType Leaf) {Start-Process "$env:USERPROFILE\OneDrive\Desktop\WSA\Run.bat" -Wait}
     }
     }
     
     If (10 -eq $os) {
     $origine="$env:USERPROFILE\Downloads\WSAwin10x64.zip"
     $medio="$currentPath\Risorse"
     $medino="$currentPath\WSA"
     $rename="$currentPath\WSAwin10x64"
     $fine="$env:USERPROFILE\Desktop"
     if (Test-Path -Path "$env:USERPROFILE\Desktop"-PathType Leaf) {$fine="$env:USERPROFILE\OneDrive\Desktop"}

     Start-Process "https://mega.nz/file/27RDDIqQ#a3V6HGawK6JsptuFzYZDT-M7DMCr6S67OMbEXjZmjdc"
     Read-host "Salva nella cartella Downloads e digita 'FINE' al termine del download"
     Move-Item -path $origine -Destination $medio -Force
     Expand-Archive "Risorse\WSAwin10x64.zip"
     Rename-Item "$rename" "WSA"
     Move-Item -path $medino -Destination $fine -Force
     Start-Process "$env:USERPROFILE\Desktop\WSA\Run.bat" -Wait
     if (Test-Path -Path "$env:USERPROFILE\Desktop\WSA\Run.bat"-PathType Leaf) {Start-Process "$env:USERPROFILE\OneDrive\Desktop\WSA\Run.bat" -Wait}
     }
     
     If (65 -eq $cercoos) {
     $origine="$env:USERPROFILE\Downloads\WSAwin11arm64.zip"
     $medio="$currentPath\Risorse"
     $medino="$currentPath\WSA"
     $rename="$currentPath\WSAwin11arm64"
     $fine="$env:USERPROFILE\Desktop"
     if (Test-Path -Path "$env:USERPROFILE\Desktop"-PathType Leaf) {$fine="$env:USERPROFILE\OneDrive\Desktop"}

     Start-Process "https://mega.nz/file/zywiDAgb#d0EaBjIo_KWrRVXnhJ8MbRC736lh7olWm-W-rQjvG8w"
     Read-host "Salva nella cartella Downloads e digita 'FINE' al termine del download"
     Move-Item -path $origine -Destination $medio -Force
     Expand-Archive "Risorse\WSAwin11arm64.zip"
     Rename-Item "$rename" "WSA"
     Move-Item -path $medino -Destination $fine -Force
     Start-Process "$env:USERPROFILE\Desktop\WSA\Run.bat" -Wait
     if (Test-Path -Path "$env:USERPROFILE\Desktop\WSA\Run.bat"-PathType Leaf) {Start-Process "$env:USERPROFILE\OneDrive\Desktop\WSA\Run.bat" -Wait}
     True('FATTO')
     }