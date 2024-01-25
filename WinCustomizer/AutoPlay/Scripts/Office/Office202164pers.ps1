        $currentPath = $PWD

    
# Prompt the user for Office application choices
$word = Read-Host "Vuoi l'app OFFICE WORD? [1] Si [2] No"
if ($word -eq "1") {$word=""} elseif ($word -eq "2") {$word="Word"}

$excel = Read-Host "Vuoi l'app OFFICE EXCEL? [1] Si [2] No"
if ($excel -eq "1") {$excel=""} elseif ($excel -eq "2") {$excel="Excel"}

$acces = Read-Host "Vuoi l'app OFFICE ACCESS? [1] Si [2] No"
if ($acces -eq "1") {$acces=""} elseif ($acces -eq "2") {$acces="Access"}

$onedrive = Read-Host "Vuoi l'app OFFICE ONEDRIVE? [1] Si [2] No"
if ($onedrive -eq "1") {$onedrive=""} elseif ($onedrive -eq "2") {$onedrive="OneDrive"}

$OneNote = Read-Host "Vuoi l'app OFFICE ONENOTE? [1] Si [2] No"
if ($OneNote -eq "1") {$OneNote=""} elseif ($OneNote -eq "2") {$OneNote="OneNote"}

$outlook = Read-Host "Vuoi l'app OFFICE OUTLOOK? [1] Si [2] No"
if ($outlook -eq "1") {$outlook=""} elseif ($outlook -eq "2") {$outlook="Outlook"}

$powerpoint = Read-Host "Vuoi l'app OFFICE POWERPOINT? [1] Si [2] No"
if ($powerpoint -eq "1") {$powerpoint=""} elseif ($powerpoint -eq "2") {$powerpoint="PowerPoint"}

$publisher = Read-Host "Vuoi l'app OFFICE PUBLISHER? [1] Si [2] No"
if ($publisher -eq "1") {$publisher=""} elseif ($publisher -eq "2") {$publisher="Publisher"}

# Create the configuration XML
$configXML = @"
<Configuration ID="37d1a293-ccee-4ee2-a953-86c3143f0337">
  <Add OfficeClientEdition="64" Channel="PerpetualVL2021" MigrateArch="TRUE">
    <Product ID="ProPlus2021Volume" PIDKEY="FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH">
      <Language ID="it-it" />
      <ExcludeApp ID="$acces" />
      <ExcludeApp ID="$excel" />
      <ExcludeApp ID="Lync" />
      <ExcludeApp ID="$onedrive" />
      <ExcludeApp ID="$OneNote" />
      <ExcludeApp ID="$outlook" />
      <ExcludeApp ID="$powerpoint" />
      <ExcludeApp ID="$publisher" />
      <ExcludeApp ID="$word" />
    </Product>
"@

# Save the configuration to a file
$configXML | Out-File -FilePath "C:\configuration-x64-complete.xml" -Encoding UTF8

# Prompt the user for Visio and Project choices
$visio = Read-Host "Vuoi Visio? [1] SI [2] NO"
if ($visio -eq "1") {
    @"
<Product ID="VisioPro2021Volume" PIDKEY="KNH8D-FGHT4-T8RK3-CTDYJ-K2HT4">
  <Language ID="it-it" />
  <ExcludeApp ID="Lync" />
</Product>
"@ | Out-File -Append -FilePath "C:\configuration-x64-complete.xml" -Encoding UTF8
}

$project = Read-Host "Vuoi Project? [1] SI [2] NO"
if ($project -eq "1") {
    @"
<Product ID="ProjectPro2021Volume" PIDKEY="FTNWT-C6WBT-8HMGF-K9PRX-QV9H8">
  <Language ID="it-it" />
  <ExcludeApp ID="Lync" />
</Product>
 </Add>
<Property Name="SharedComputerLicensing" Value="0" />
<Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
<Property Name="DeviceBasedLicensing" Value="0" />
<Property Name="SCLCacheOverride" Value="0" />
<Property Name="AUTOACTIVATE" Value="1" />
<Updates Enabled="TRUE" />
<RemoveMSI />
</Configuration>
"@ | Out-File -Append -FilePath "C:\configuration-x64-complete.xml" -Encoding UTF8
}
else {
    @"
</Add>
<Property Name="SharedComputerLicensing" Value="0" />
<Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
<Property Name="DeviceBasedLicensing" Value="0" />
<Property Name="SCLCacheOverride" Value="0" />
<Property Name="AUTOACTIVATE" Value="1" />
<Updates Enabled="TRUE" />
<RemoveMSI />
</Configuration>
"@ | Out-File -Append -FilePath "C:\configuration-x64-complete.xml" -Encoding UTF8
}

Start-Sleep 4
cd "$currentPath"
Invoke-WebRequest -Uri "https://github.com/MrNico98/Office2021/archive/refs/heads/main.zip" -OutFile "Office2021-main.zip"
Expand-Archive -Path "Office2021-main.zip" -DestinationPath "." -Force
Move-Item -Path "Office2021-main\Office2021" -Destination "Office2021" -Force
Remove-Item -Path "Office2021-main" -Recurse -Force
Remove-Item -Path "Office2021-main.zip" -Recurse -Force
mkdir "$currentPath\Office2021\configuration"
Move-Item -Path "C:\configuration-x64-complete.xml" -Destination "$currentPath\Office2021\configuration" -Force
Start-Process -FilePath ".\Office2021\Install-x64-complete.bat" -Wait
Remove-Item -Path "$currentPath\Office2021" -Recurse -Force