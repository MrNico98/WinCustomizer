Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.MessageBoxButtons]::OK,
[System.Windows.Forms.MessageBoxIcon]::Error


$currentPath = $PWD

Function Error([String] $Message)
{
    If (($Message -ne $null) -and ($Message.Length -gt 0))
    {
        $Time = Get-Date -DisplayHint Time
        Write-Host "[$Time] [ERROR] > $Message" -ForegroundColor Red
    }
}

Function Warning([String] $Message)
{
    If (($Message -ne $null) -and ($Message.Length -gt 0))
    {
        $Time = Get-Date -DisplayHint Time
        Write-Host "[$Time] [WARNING] > $Message" -ForegroundColor Yellow
    }
}

Function Log([String] $Message)
{
    If (($Message -ne $null) -and ($Message.Length -gt 0))
    {
        $Time = Get-Date -DisplayHint Time
        Write-Host "[$Time] [LOG] > $Message" -ForegroundColor Cyan
    }
}


Function True([String] $Message)
{
    If (($Message -ne $null) -and ($Message.Length -gt 0))
    {
        $Time = Get-Date -DisplayHint Time
        Write-Host "[$Time] [OK] > $Message" -ForegroundColor Green
    }
}


$inputXML = @"
<Window x:Class="wincustomizer.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:wincustomizer"
        mc:Ignorable="d"
        Title="WinCustomizer" Height="378" Width="430" AllowDrop="True">
    <Grid Background="#FF96FF83" Height="361" VerticalAlignment="Top">
        <Grid.RowDefinitions>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <Button Content="Tool ISO" Name="tooliso" Margin="37,45,233,0" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True" Height="35" VerticalAlignment="Top"/>
        <Image Name="ISO" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/immagine-iso.png" Margin="34,41,0,0" ScrollViewer.CanContentScroll="False" AllowDrop="True" HorizontalAlignment="Left" Width="46" Height="42" VerticalAlignment="Top"/>
        <Button Content="Tips Windows" Name="tips" Margin="37,93,233,0" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True" Height="35" VerticalAlignment="Top"/>
        <Image Name="TipsWindows" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/Tips.png" Margin="24,89,0,0" RenderTransformOrigin="-0.288,1.552" ScrollViewer.CanContentScroll="False" AllowDrop="True" HorizontalAlignment="Left" Width="58" Height="51" VerticalAlignment="Top"/>
        <Button Content="Attiva WSA" Name="sottosistema" Height="35" Margin="235,45,35,0" VerticalAlignment="Top" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True"/>
        <Image x:Name="AttivaWSA" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/WSA.png" Margin="239,48,0,0" RenderTransformOrigin="-0.288,1.552" Height="30" Width="40" ScrollViewer.CanContentScroll="False" AllowDrop="True" VerticalAlignment="Top" HorizontalAlignment="Left"/>
        <Button Content="Edizione Windows" Name="cambiowindows" Margin="235,93,35,0" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True" Height="35" VerticalAlignment="Top"/>
        <Image x:Name="EdizioneWindows" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/cambioedizione.png" Margin="220,93,0,0" RenderTransformOrigin="-0.288,1.552" ScrollViewer.CanContentScroll="False" AllowDrop="True" HorizontalAlignment="Left" Width="34" Height="35" VerticalAlignment="Top"/>
        <Button Content="Attiva Windows" Name="attivawin" Margin="235,150,35,0" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True" Height="35" VerticalAlignment="Top"/>
        <Image x:Name="AttivaWindows" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/maxresdefault.png" Margin="236,154,0,0" RenderTransformOrigin="-0.288,1.552" Width="30" ScrollViewer.CanContentScroll="False" AllowDrop="True" HorizontalAlignment="Left" Height="30" VerticalAlignment="Top"/>
        <Button Content="Office" Name="off" Margin="235,198,35,0" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True" Height="35" VerticalAlignment="Top"/>
        <Image x:Name="Office" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/office.png" Margin="235,201,0,0" RenderTransformOrigin="0.5,0.5" Width="29" Height="30" ScrollViewer.CanContentScroll="True" AllowDrop="True" VerticalAlignment="Top" HorizontalAlignment="Left"/>
        <Label Content="Ver.: 5.0" HorizontalAlignment="Left" Height="30" Margin="370,320,0,0" VerticalAlignment="Top" Width="62"/>
        <Label Content="Developer: MrNico98" HorizontalAlignment="Left" Height="30" Margin="2,320,0,0" VerticalAlignment="Top" Width="133"/>
        <Button Content="WinCustomizerTweakst" x:Name="deb" Margin="37,148,233,0" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True" Height="35" VerticalAlignment="Top"/>
        <Image x:Name="debloimage" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/Picsart_23-09-22_22-29-23-192.png" RenderTransformOrigin="0.5,0.5" Width="30" Height="30" ScrollViewer.CanContentScroll="True" AllowDrop="True" VerticalAlignment="Top" HorizontalAlignment="Left" Margin="40,148,0,0"/>
        <Button Content="Copilot" x:Name="cop" Margin="37,196,233,0" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True" Height="35" VerticalAlignment="Top"/>
        <Image x:Name="imcopilot" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/1698851956_microsoft-copilot_story.jpg" RenderTransformOrigin="0.5,0.5" Width="30" Height="30" ScrollViewer.CanContentScroll="True" AllowDrop="True" VerticalAlignment="Top" HorizontalAlignment="Left" Margin="40,198,0,0"/>
        <Button Content="Attiva WSL" x:Name="wsl" Margin="129,254,141,0" Background="White" BorderBrush="White" Foreground="#FFFF0909" Focusable="False" ScrollViewer.CanContentScroll="False" AllowDrop="True" Height="34" VerticalAlignment="Top"/>
        <Image x:Name="windoswub" Source="https://raw.githubusercontent.com/MrNico98/Icone-Wincustomizer/main/wsl.png" RenderTransformOrigin="0.5,0.5" Width="45" Height="42" ScrollViewer.CanContentScroll="True" AllowDrop="True" VerticalAlignment="Top" HorizontalAlignment="Left" Margin="129,256,0,0"/>
        <TextBlock HorizontalAlignment="Left" Height="30" Margin="129,5,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="200" FontFamily="Jokerman" FontSize="22" FontWeight="Bold"><Run Language="it-it" Text="WinCustomizer"/></TextBlock>
    </Grid>
</Window>
"@

$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window'
    [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
    [xml]$XAML = $inputXML
    #Read XAML
    
        $reader=(New-Object System.Xml.XmlNodeReader $xaml) 
    try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
    catch [System.Management.Automation.MethodInvocationException] {
        Write-Warning "We ran into a problem with the XAML code.  Check the syntax for this control..."
        write-host $error[0].Exception.Message -ForegroundColor Red
        if ($error[0].Exception.Message -like "*button*"){
            write-warning "Ensure your &lt;button in the `$inputXML does NOT have a Click=ButtonClick property.  PS can't handle this`n`n`n`n"}
    }
    catch{#if it broke some other way <img draggable="false" role="img" class="emoji" alt="😀" src="https://s0.wp.com/wp-content/mu-plugins/wpcom-smileys/twemoji/2/svg/1f600.svg">
        Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."
            }
    
    $xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
    
    Function Get-FormVariables{
    get-variable WPF*
    }
    
    Get-FormVariables | Out-Null


$WPFtooliso.Add_Click({

    # Create the second form
    $secondForm = New-Object System.Windows.Forms.Form
    $secondForm.Text = "Tool ISO"
    $secondForm.StartPosition              = "CenterScreen"
    $secondForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $secondForm.Size = New-Object System.Drawing.Size(330, 250)

    # Create a button on the second form
    $iso11 = New-Object System.Windows.Forms.Button
    $iso11.Text = "Modifca ISO Windows 11"
    $iso11.AutoSize                 = $True
    $iso11.width            = 150
    $iso11.height           = 30
    $iso11.Location = New-Object System.Drawing.Point(70, 10)
    $iso11.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $secondForm.Controls.AddRange($iso11)

    $iso11.Add_Click({
    Log('Avvio Tool ISO11')
    cd "$currentPath"
    Start-Process -FilePath ".\isotool11.bat" -Wait
    if (-not (Test-Path -Path "$currentPath\isotool11.bat" -PathType Leaf)) {
    Error('Il programma non presente')} else {True('FATTO')}
    })

    $iso10 = New-Object System.Windows.Forms.Button
    $iso10.Text = "Modifica ISO Windows 10"
    $iso10.AutoSize                 = $True
    $iso10.width            = 150
    $iso10.height           = 30
    $iso10.Location = New-Object System.Drawing.Point(70, 50)
    $iso10.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $secondForm.Controls.AddRange($iso10)

    $iso10.Add_Click({
    Log('Avvio Tool ISO10')
    cd "$currentPath"
    Start-Process -FilePath ".\isotool10.bat" -Wait
    if (-not (Test-Path -Path "$currentPath\isotool10.bat" -PathType Leaf)) {
    Error('Il programma non presente')} else {True('FATTO')}
    })

    $preattivazione = New-Object System.Windows.Forms.Button
    $preattivazione.Text = "Preattiva ISO Windows"
    $preattivazione.AutoSize                 = $True
    $preattivazione.width            = 150
    $preattivazione.height           = 30
    $preattivazione.Location = New-Object System.Drawing.Point(70, 90)
    $preattivazione.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $secondForm.Controls.AddRange($preattivazione)

    $preattivazione.Add_Click({
    Log('Avvio Preattivazione Windows')
    Start-Process powershell.exe -Verb RunAs -ArgumentList "irm -Uri https://bit.ly/preattivazioneiso | iex  | Out-Host" -Wait -WindowStyle Maximized
        
    True('FATTO')
    })

    # Show the second form
    $secondForm.ShowDialog()
   })

$WPFdeb.Add_Click({
    Log('Avvio WinCustomizerTweaks')
    powerShell -ExecutionPolicy Bypass -File "Risorse\WinCustomizerDebloat3.0.ps1"
    if (-not (Test-Path -Path "$currentPath\Risorse\WinCustomizerDebloat3.0.ps1" -PathType Leaf)) {
    Error('Il programma non presente')} else {True('FATTO')}
    })

$WPFtips.Add_Click({

    $terzaForm = New-Object System.Windows.Forms.Form
    $terzaForm.Text = "Tips Windows"
    $terzaForm.StartPosition              = "CenterScreen"
    $terzaForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $terzaForm.Size = New-Object System.Drawing.Size(300, 180)

    $debloat = New-Object System.Windows.Forms.Button
    $debloat.Text = "Sezione Debloat"
    $debloat.AutoSize                 = $True
    $debloat.Location = New-Object System.Drawing.Point(70, 10)
    $debloat.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $terzaForm.Controls.AddRange($debloat)

    $debloat.Add_Click({
     
    $debloatForm = New-Object System.Windows.Forms.Form
    $debloatForm.Text = "Debloat"
    $debloatForm.StartPosition              = "CenterScreen"
    $debloatForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $debloatForm.Size = New-Object System.Drawing.Size(850, 200)

    
    $debloatcalssico = New-Object System.Windows.Forms.Button
    $debloatcalssico.Text = "Debloat"
    $debloatcalssico.AutoSize                 = $True
    $debloatcalssico.width            = 100
    $debloatcalssico.height           = 30
    $debloatcalssico.Location = New-Object System.Drawing.Point(70, 10)
    $debloatcalssico.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($debloatcalssico)
    
     $debloatcalssico.Add_Click({
     Log('Avvio Debloat')
     systeminfo | find "Windows 11"
     if ($?) {Write-Host "11"
     $os=11}
     systeminfo | find "Windows 10"
     if ($?) {Write-Host "10"
     $os=10}
     
     If (11 -eq $os) {
     log ('Inizio Debloat')
     $ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Notepad|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} | Remove-AppxPackage
     Get-Process OneDrive | Stop-Process -Force
     C:\Windows\System32\OneDriveSetup.exe /uninstall
     Set-ItemProperty -Path "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
     Set-ItemProperty -Path "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
     Set-ItemProperty -Path "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
     Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
     cmd.exe /c sc config wsearch start=auto
     clear
     True('FATTO')
      }

      If (10 -eq $os) {
      log ('Inzio Debloat')
     $ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} | Remove-AppxPackage
     Get-Process OneDrive | Stop-Process -Force
     C:\Windows\System32\OneDriveSetup.exe /uninstall
     Set-ItemProperty -Path "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
     Set-ItemProperty -Path "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
     Set-ItemProperty -Path "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
     Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeature"s -Type DWord -Value 1
     cmd.exe /c sc config wsearch start=auto
     clear
     True('FATTO')
      }
     })
    
    $tweaks = New-Object System.Windows.Forms.Button
    $tweaks.Text = "Tweaks"
    $tweaks.AutoSize     = $True
    $tweaks.width            = 100
    $tweaks.height           = 30
    $tweaks.Location = New-Object System.Drawing.Point(70, 45)
    $tweaks.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($tweaks)
   
   $tweaks.Add_Click({
   Log('Avvio Tweaks')
   systeminfo | find "Windows 11"
     if ($?) {Write-Host "11"
     $os=11}
     systeminfo | find "Windows 10"
     if ($?) {Write-Host "10"
     $os=10}
     
If (11 -eq $os) {
Log('Eseguo i Tweaks')
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -PropertyType DWORD -Value 1 -Force
New-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "ImmersiveApplicationForeground" -PropertyType String -Value "255 255 255" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "AllowOnlineTips" -PropertyType DWORD -Value 0 -Force
Remove-Item -Path "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Force
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" -Name "ChatIcon" -PropertyType DWORD -Value 3 -Force
New-ItemProperty -Path "HKCU:\Control Panel\UnsupportedHardwareNotificationCache" -Name "SV1" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Control Panel\UnsupportedHardwareNotificationCache" -Name "SV2" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SYSTEM\Setup\MoSetup" -Name "AllowUpgradesWithUnsupportedTPMOrCPU" -PropertyType DWORD -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType DWORD -Value 1 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -PropertyType DWORD -Value 0 -Force
cmd.exe /c sc config wsearch start=auto
True('FATTO')
 }

if (10 -eq $os) {
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -PropertyType DWORD -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -PropertyType DWORD -Value 1 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -PropertyType DWORD -Value 2 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -PropertyType DWORD -Value 1 -Force
New-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "ImmersiveApplicationForeground" -PropertyType String -Value "255 255 255" -Force
Remove-Item -Path "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Force
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType DWORD -Value 1 -Force
cmd.exe /c sc config wsearch start=auto
cmd.exe /c sc config DiagTrack start=disabled
cmd.exe /c sc config dmwappushservice start=disabled
}
 })

    $visualfx = New-Object System.Windows.Forms.Button
    $visualfx.Text = "Effetti Visivi"
    $visualfx.AutoSize     = $True
    $visualfx.Location = New-Object System.Drawing.Point(400, 45)
    $visualfx.width            = 100
    $visualfx.height           = 30
    $visualfx.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($visualfx)

    $visualfx.Add_Click({

    $visualfxForm = New-Object System.Windows.Forms.Form
    $visualfxForm.Text = "Effetti Visivi"
    $visualfxForm.StartPosition              = "CenterScreen"
    $visualfxForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $visualfxForm.Size = New-Object System.Drawing.Size(300, 200)

    
    $remuvevisualfx = New-Object System.Windows.Forms.Button
    $remuvevisualfx.Text = "Rimuovi Alcuni Effetti Visivi"
    $remuvevisualfx.AutoSize                 = $True
    $remuvevisualfx.width            = 100
    $remuvevisualfx.height           = 30
    $remuvevisualfx.Location = New-Object System.Drawing.Point(70, 10)
    $remuvevisualfx.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $visualfxForm.Controls.AddRange($remuvevisualfx)
    
     $remuvevisualfx.Add_Click({
    Log('Aggiusto gli effetti visivi per maggiore performance')
    Stop-Process -Name explorer -Force
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 200
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](144,18,3,128,16,0,0,0))
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Value 0
    Start-Process explorer
    True('FATTO')
})

    $restoreVisual = New-Object System.Windows.Forms.Button
    $restoreVisual.Text = "Resetta gli Effetti Visivi"
    $restoreVisual.AutoSize                 = $True
    $restoreVisual.width            = 100
    $restoreVisual.height           = 30
    $restoreVisual.Location = New-Object System.Drawing.Point(70, 45)
    $restoreVisual.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $visualfxForm.Controls.AddRange($restoreVisual)

   $restoreVisual.Add_Click({
	Log('Resetto gli effettiv visivi')
    Stop-Process -Name explorer -Force
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 400
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](158,30,7,128,18,0,0,0))
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
    Start-Process explorer
    True('FATTO')
})

    $visualfxForm.ShowDialog()
   })
 
    $edgerimozione = New-Object System.Windows.Forms.Button
    $edgerimozione.Text = "Rimuovi Edge"
    $edgerimozione.AutoSize     = $True
    $edgerimozione.width            = 100
    $edgerimozione.height           = 30
    $edgerimozione.Location = New-Object System.Drawing.Point(70, 80)
    $edgerimozione.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($edgerimozione)
   
   $edgerimozione.Add_Click({
   LOG('Rimuovo Edge')
   cd "$currentPath\Risorse"
    Start-Process -FilePath ".\WinCustomizerEdge.bat" -Wait
    if (-not (Test-Path -Path "$currentPath\Risorse\WinCustomizerEdge.bat" -PathType Leaf)) {
    Error('Programma non presente')} else {True('FATTO')}
    })


   $defender = New-Object System.Windows.Forms.Button
   $defender.Text = "Windows Defender"
   $defender.AutoSize     = $True
   $defender.width            = 100
   $defender.height           = 30
   $defender.Location = New-Object System.Drawing.Point(200, 45)
   $defender.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
   $debloatForm.Controls.AddRange($defender)
   
  $defender.Add_Click({

    $defenderForm = New-Object System.Windows.Forms.Form
    $defenderForm.Text = "Windows Defeneder"
    $defenderForm.StartPosition              = "CenterScreen"
    $defenderForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $defenderForm.Size = New-Object System.Drawing.Size(300, 200)

    $rimuovidefender = New-Object System.Windows.Forms.Button
    $rimuovidefender.Text = "Rimuovi Defender"
    $rimuovidefender.AutoSize                 = $True
    $rimuovidefender.width            = 100
    $rimuovidefender.height           = 30
    $rimuovidefender.Location = New-Object System.Drawing.Point(70, 10)
    $rimuovidefender.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $defenderForm.Controls.AddRange($rimuovidefender)
    
     $rimuovidefender.Add_Click({
     Log('Avvio Rimozione Windows Defender')
  Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f"
  Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f"
  Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f"
  Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f"
  Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f"
  Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f"
  Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 4 /f"
  True('FATTO, riavvio sistema in 20 secondi')
  timeout 20
  shutdown /r /t 00
  })

    $adddefender = New-Object System.Windows.Forms.Button
    $adddefender.Text = "Riattiva Defender"
    $adddefender.AutoSize                 = $True
    $adddefender.width            = 100
    $adddefender.height           = 30
    $adddefender.Location = New-Object System.Drawing.Point(70, 45)
    $adddefender.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $defenderForm.Controls.AddRange($adddefender)
    
     $adddefender.Add_Click({
     Log('Avvio riprisino Windows Defeneder')
     PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f"
Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 0 /f"
Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 0 /f"
Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 0 /f"
Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 0 /f"
Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 2 /f"
Risorse\PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 2 /f"
  True('FATTO, riavvio sistema in 20 secondi')
  timeout 20
  shutdown /r /t 00 
  })

  $defenderForm.ShowDialog()
   })
   
    $microstore = New-Object System.Windows.Forms.Button
    $microstore.Text = "Microsoft Store"
    $microstore.AutoSize     = $True
    $microstore.width            = 100
    $microstore.height           = 30
    $microstore.Location = New-Object System.Drawing.Point(200, 80)
    $microstore.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($microstore)
   
   $microstore.Add_Click({

    $microstoreForm = New-Object System.Windows.Forms.Form
    $microstoreForm.Text = "Microsoft Store"
    $microstoreForm.StartPosition              = "CenterScreen"
    $microstoreForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $microstoreForm.Size = New-Object System.Drawing.Size(800, 200)

    
    $delmicrostore = New-Object System.Windows.Forms.Button
    $delmicrostore.Text = "Rimuovi Microsoft Store"
    $delmicrostore.AutoSize                 = $True
    $delmicrostore.width            = 100
    $delmicrostore.height           = 30
    $delmicrostore.Location = New-Object System.Drawing.Point(70, 10)
    $delmicrostore.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $microstoreForm.Controls.AddRange($delmicrostore)
    
     $delmicrostore.Add_Click({
   Log('Avvio rimozione Microsoft Store')
   Get-AppxPackage *windowsstore* | Remove-AppxPackage
   True('FATTO')
   })

    $addstore = New-Object System.Windows.Forms.Button
    $addstore.Text = "Aggiungi Microsoft Store"
    $addstore.AutoSize                 = $True
    $addstore.width            = 100
    $addstore.height           = 30
    $addstore.Location = New-Object System.Drawing.Point(70, 45)
    $addstore.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $microstoreForm.Controls.AddRange($addstore)
    
    $addstore.Add_Click({
    Log('Aggiungo Microsoft Store')
     WSReset -i
     start-sleep 20 | out-null
     WSReset -i
     True('FATTO, Microsoft Store si sta scaricando')
     })

     $microstoreForm.ShowDialog()
   })

    $rimuovicortana = New-Object System.Windows.Forms.Button
    $rimuovicortana.Text = "Rimuovi Cortana"
    $rimuovicortana.AutoSize     = $True
    $rimuovicortana.width            = 100
    $rimuovicortana.height           = 30
    $rimuovicortana.Location = New-Object System.Drawing.Point(560, 10)
    $rimuovicortana.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($rimuovicortana)
   
   $rimuovicortana.Add_Click({
   Log('Avvio rimozione Cortana')
   $packageName="*Microsoft.549981C3F5F10*"
   if (Get-AppxPackage -Name $packageName -ErrorAction SilentlyContinue) {
    Remove-AppxPackage -Package $packageName
    True('FATTO')
} else {
    Warning('Cortana non presente nel tuo Windows')
}
   })


    $edgelite = New-Object System.Windows.Forms.Button
    $edgelite.Text = "Rimuovi Account Microsot Edge"
    $edgelite.AutoSize     = $True
    $edgelite.Location = New-Object System.Drawing.Point(560, 45)
    $edgelite.width            = 100
    $edgelite.height           = 30
    $edgelite.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($edgelite)
   
   $edgelite.Add_Click({
   Log('Avvio rimozione account Microsoft Edge')
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "SyncDisabled" -Type DWord -Value 1 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "BrowserSignin" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "NewSmartScreenLibraryEnabled" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "SmartScreenEnabled" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "SmartScreenPuaEnabled" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "StartupBoostEnabled" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "BingAdsSuppression" -Type DWord -Value 1 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "BackgroundModeEnabled" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "ComponentUpdatesEnabled" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "EdgeShoppingAssistantEnabled" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "ForceGoogleSafeSearch" -Type DWord -Value 1 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" -Name "MAUEnabled" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" -Name "AutoUpdateCheckPeriodMinutes" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" -Name "UpdateDefault" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" -Name "UpdatePolicy" -Type DWord -Value 0 SilentlyContinue
   Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft" -Name "DoNotUpdateToEdgeWithChromium" -Type DWord -Value 1 SilentlyContinue
   True('FATTO')
})
 
    $winupdate = New-Object System.Windows.Forms.Button
    $winupdate.Text = "Windows Update"
    $winupdate.AutoSize     = $True
    $winupdate.Location = New-Object System.Drawing.Point(400, 10)
    $winupdate.width            = 100
    $winupdate.height           = 30
    $winupdate.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($winupdate)
   
   $winupdate.Add_Click({

    $winupdateForm = New-Object System.Windows.Forms.Form
    $winupdateForm.Text = "Windows Update"
    $winupdateForm.StartPosition              = "CenterScreen"
    $winupdateForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $winupdateForm.Size = New-Object System.Drawing.Size(300, 180)

    
    $remwinupdate = New-Object System.Windows.Forms.Button
    $remwinupdate.Text = "Disabilita Windows Update"
    $remwinupdate.AutoSize                 = $True
    $remwinupdate.Location = New-Object System.Drawing.Point(70, 10)
    $remwinupdate.width            = 100
    $remwinupdate.height           = 30
    $remwinupdate.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $winupdateForm.Controls.AddRange($remwinupdate)
    
     $remwinupdate.Add_Click({
     Log('Avvio disabilitazione Windows Update')
      @("wuauserv", "WaaSMedicSvc", "UsoSvc") | ForEach-Object{
        Set-Service -Name $_ -StartupType Disabled -ErrorAction SilentlyContinue | Out-Null
        Stop-Service -Name $_ -ErrorAction SilentlyContinue | Out-Null
    }
    Disable-ScheduledTask -TaskName "\Microsoft\Windows\WindowsUpdate\Scheduled Start" | Out-Null
    if (!(Test-Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings")){
        New-Item -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Name "UxOption" -Type DWord -Value 1
    Stop-Process -Name "MoUsoCoreWorker" -Force -PassThru -ErrorAction SilentlyContinue | Out-Null
    Stop-Process -Name "TiWorker" -Force -PassThru -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\WaaSMedicSvc" -Name Start -Value 4
    True('FATTO')
})

    $abilwinupdate = New-Object System.Windows.Forms.Button
    $abilwinupdate.Text = "Abilita Windows Update"
    $abilwinupdate.AutoSize                 = $True
    $abilwinupdate.Location = New-Object System.Drawing.Point(70, 45)
    $abilwinupdate.width            = 100
    $abilwinupdate.height           = 30
    $abilwinupdate.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $winupdateForm.Controls.AddRange($abilwinupdate)
    
     $abilwinupdate.Add_Click({
     Log('Avvio abilitazione Windows Update')
     @("wuauserv", "WaaSMedicSvc", "UsoSvc") | ForEach-Object{
        Set-Service -Name $_ -StartupType Automatic -ErrorAction SilentlyContinue | Out-Null
        Start-Service -Name $_ -ErrorAction SilentlyContinue | Out-Null
    }
    Enable-ScheduledTask -TaskName "\Microsoft\Windows\WindowsUpdate\Scheduled Start" | Out-Null
    if (!(Test-Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings")){
        New-Item -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Name "UxOption" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\WaaSMedicSvc" -Name Start -Value 2
    True('FATTO')
    })


    $winupdateForm.ShowDialog()
    })

    $debloatplus = New-Object System.Windows.Forms.Button
    $debloatplus.Text = "Debloat Plus"
    $debloatplus.AutoSize     = $True
    $debloatplus.Location = New-Object System.Drawing.Point(400, 80)
    $debloatplus.width            = 100
    $debloatplus.height           = 30
    $debloatplus.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $debloatForm.Controls.AddRange($debloatplus)
   
   $debloatplus.Add_Click({
   Log('Avvio Debloat Plus')
     write-host("Disabling Telemetry...")
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    write-host("Disabling Application suggestions...")
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManagzer" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
    write-host("Disabling Activity History...")
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    write-host("Disabling Location Tracking...")
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    write-host("Disabling automatic Maps updates...")
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    write-host("Disabling Feedback...")
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    write-host("Disabling Tailored Experiences...")
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    write-host("Disabling Advertising ID...")
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    write-host("Disabling write-host reporting...")
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    write-host("Stopping and disabling Diagnostics Tracking Service...")
    Stop-Service "DiagTrack" -WarningAction SilentlyContinue
    Set-Service "DiagTrack" -StartupType Disabled
    write-host("Stopping and disabling WAP Push Service...")
    Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
    Set-Service "dmwappushservice" -StartupType Disabled
    write-host("Enabling F8 boot menu options...")
    bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
    write-host("Disabling Remote Assistance...")
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0
    write-host("Disabling Storage Sense...")
    Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue
    write-host("Stopping and disabling Superfetch service...")
    Stop-Service "SysMain" -WarningAction SilentlyContinue
    Set-Service "SysMain" -StartupType Disabled
    write-host("Showing file operations details...")
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
    write-host("Hiding Task View button...")
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    write-host("Hiding People icon...")
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
    write-host("Changing default Explorer view to This PC...")
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1
    write-host("Hiding 3D Objects icon from This PC...")
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
    #Network Tweaks (Most of the tweaks were provided to me by emilwojcik93) | https://github.com/emilwojcik93/sc-cmd#introduction
	#Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20 # Causes problems with Mapped Drives and File Sharing Programs!
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SizReqBuf" -Type DWord -Value 17424
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name DefaultTTL -Value 64
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name TCP1323Opts -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name MaxFreeTcbs -Value 65536
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name MaxUserPort -Value 65534
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name GlobalMaxTcpWindowSize -Value 65535
	#SVCHost Tweak
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4194304
    write-host("Disable News and Interests")
    if (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds")){
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0
    #Remove news and interest from taskbar
    Set-ItemProperty -Path  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Type DWord -Value 2
    #Remove meet now button from taskbar
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1

    #Disable LockScreen
    If (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\Personalization")) {
 	    New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\Personalization" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Type DWord -Value 1
    write-host("Lock Screen has been disabled")

    #Disable Advertising ID
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
	    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Type DWord -Value 0
    write-host("Advertising ID has been disabled")

    #Disable SmartScreen
    if (!(Test-Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer")){
        New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Type String -Value "Off"
    if (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost")){
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -Value 0
    write-host("SmartScreen has been disabled")

    #Disable File History
    if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\FileHistory")){
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\FileHistory" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\FileHistory" -Name "Disabled" -Type DWord -Value 1

    #Disable Hand Writing Reports
    if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Handwritingwrite-hostReports")){
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Handwritingwrite-hostReports" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Handwritingwrite-hostReports" -Name "PreventHandwritingwrite-hostReports" -Type DWord -Value 1

    #Disable Location Tracking...
    if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors")){
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocationScripting" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableSensors" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableWindowsLocationProvider" -Type DWord -Value 1

    #Disable Auto Map Downloading/Updating
    if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Maps")){
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Maps" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Maps" -Name "AutoDownloadAndUpdateMapData" -Type DWord -Value 0

    # Disable Application Notifications / This might break some notifications like Windows Defender ones!
    # Thanks Niecks#2591 for reporting
    # Line to remove it : Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "NoTileApplicationNotification" -Force | Out-Null

    if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings")){
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Force | Out-Null
    }
    Get-ChildItem -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" -ErrorAction SilentlyContinue | ForEach-Object {
        Set-ItemProperty -Path $_.PsPath -Name "Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path $_.PsPath -Name "LastNotificationAddedTime" -Type QWord -Value "0"
    }

    #Disable Windows Feeds
    if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds")){
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0

    #Disable Game DVR
    if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR")){
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Type DWord -Value 0

    #Disable Keyboard BS
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "506"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Value "122"
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value "58"

    #Disable Mitigations
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name FeatureSettingsOverride -Value 3
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name FeatureSettingsOverrideMask -Value 3

    # Clean Taskbar
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarDa -Value 0 -Force
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarMn -Value 0 -Force
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarAl -Value 0 -Force

    write-host("Disabling some services and scheduled tasks")

    $Services = @(
        #"*xbox*" # Xbox Services
        #"*Xbl*" # Xbox Services
        #"XboxNetApiSvc" # Xbox Services
        #"LanmanWorkstation" # Causes problems with Mapped Drives and File Sharing Programs!
        #"workfolderssvc" # Causes problems with Mapped Drives and File Sharing Programs!
        #"WSearch" # Windows Search
        #"PushToInstall" # Needed for Microsoft Store
        #"icssvc" # Mobile Hotspot
        "MixedRealityOpenXRSvc" # Mixed Reality
        "WMPNetworkSvc" # Windows Media Player Sharing
        #"LicenseManager" # License Manager for Microsoft Store
        #"wisvc" # Insider Program
        "WerSvc" # write-host Reporting
        #"WalletService" # Wallet Service
        #"lmhosts" # TCP/IP NetBIOS Helper
        "SysMain" # SuperFetch - Safe to disable if you have a SSD
        #"svsvc" # Spot Verifier
        #"sppsvc" # Software Protection
        "SCPolicySvc" # Smart Card Removal Policy
        "ScDeviceEnum" # Smart Card Device Enumeration Service
        "SCardSvr" # Smart Card
        #"LanmanServer" # Server # Causes problems with Mapped Drives and File Sharing Programs!
        #"SensorService" # Sensor Service
        "RetailDemo" # Retail Demo Service
        #"RemoteRegistry" # Remote Registry # Issue by V1ce
        #"UmRdpService" # Remote Desktop Services UserMode Port Redirector # Issue by V1ce
        #"TermService" # Remote Desktop Services # Issue by V1ce
        #"SessionEnv" # Remote Desktop Configuration # Issue by V1ce
        #"RasMan" # Remote Access Connection Manager # Issue by V1ce
        #"RasAuto" # Remote Access Auto Connection Manager # Issue by V1ce
        #"TroubleshootingSvc" # Recommended Troubleshooting Service
        #"RmSvc" # Radio Management Service (Might be needed for laptops)
        #"QWAVE" # Quality Windows Audio Video Experience
        #"wercplsupport" # Problem Reports Control Panel Support
        #"Spooler" # Print Spooler # Issue by V1ce
        #"PrintNotify" # Printer Extensions and Notifications # Issue by V1ce
        #"PhoneSvc" # Phone Service
        #"SEMgrSvc" # Payments and NFC/SE Manager
        "WpcMonSvc" # Parental Controls
        #"CscService" # Offline Files
        #"InstallService" # Microsoft Store Install Service
        #"SmsRouter" # Microsoft Windows SMS Router Service
        #"smphost" # Microsoft Storage Spaces SMP
        #"NgcCtnrSvc" # Microsoft Passport Container
        #"MsKeyboardFilter" # Microsoft Keyboard Filter ... thanks (.AtomRadar treasury Ã¢â„¢â€º#8267) for report. 
        #"cloudidsvc" # Microsoft Cloud Identity Service
        #"wlidsvc" # Microsoft Account Sign-in Assistant
        "*diagnosticshub*" # Microsoft (R) Diagnostics Hub Standard Collector Service
        #"iphlpsvc" # IP Helper - Might break some VPN Clients
        #"lfsvc" # Geolocation Service # Issue by V1ce
        #"fhsvc" # File History Service # Issue by V1ce
        #"Fax" # Fax # Issue by V1ce
        #"embeddedmode" # Embedded Mode
        "MapsBroker" # Downloaded Maps Manager
        "TrkWks" # Distributed Link Tracking Client
        "WdiSystemHost" # Diagnostic System Host
        "WdiServiceHost" # Diagnostic Service Host
        "DPS" # Diagnostic Policy Service
        "diagsvc" # Diagnostic Execution Service
        #"DusmSvc" # Data Usage
        #"VaultSvc" # Credential Manager
        #"AppReadiness" # App Readiness
    )

    #Disable Services listed above
    foreach ($Service in $Services) {
    Get-Service -Name $Service -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled
        if($Service.Status -match "Run"){
            Stop-Service -Name $Service -Force -ErrorAction SilentlyContinue | Out-Null
            write-host("Trying to disable $($Service.DisplayName)")
        }
    }

    #Disable Delivery Optimization
    #Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DoSvc" -Name Start -Value 4
    #Disable WinHTTP Web Proxy Auto-Discovery Service (Please do not disable this, this will fuck up Windows Explorer)
    #Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" -Name Start -Value 4
     
    [Array] @(
        "\Microsoft\Windows\ApplicationData\CleanupTemporaryState"
        "\Microsoft\Windows\ApplicationData\DsSvcCleanup"
        "\Microsoft\Windows\AppxDeploymentClient\Pre-stagedappcleanup"
        "\Microsoft\Windows\Autochk\Proxy"
        "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask"
        "\Microsoft\Windows\capabilityaccessmanager\maintenancetasks"
        "\Microsoft\Windows\Chkdsk\ProactiveScan"
        "\Microsoft\Windows\Chkdsk\SyspartRepair"
        "\Microsoft\Windows\Clip\LicenseValidation"
        "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
        "\Microsoft\Windows\CustomerExperienceImprovementProgram\Consolidator"
        "\Microsoft\Windows\CustomerExperienceImprovementProgram\UsbCeip"
        "\Microsoft\Windows\Defrag\ScheduledDefrag"
        "\Microsoft\Windows\DeviceInformation\Device"
        "\Microsoft\Windows\DeviceInformation\DeviceUser"
        "\Microsoft\Windows\DeviceSetup\MetadataRefresh"
        "\Microsoft\Windows\ExploitGuard\ExploitGuardMDMpolicyRefresh"
        "\Microsoft\Windows\Feedback\Siuf\DmClient"
        "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
        "\Microsoft\Windows\FileHistory\FileHistory*"
        "\Microsoft\Windows\Location\Notifications"
        "\Microsoft\Windows\Location\WindowsActionDiawrite-host"
        "\Microsoft\Windows\Maps\MapsToastTask"
        "\Microsoft\Windows\Maps\MapsUpdateTask"
        "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
        "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
        "\Microsoft\Windows\MUI\LPRemove"
        "\Microsoft\Windows\Multimedia\SystemSoundsService"
        "\Microsoft\Windows\OfflineFiles\BackgroundSynchronization"
        "\Microsoft\Windows\OfflineFiles\write-hostonSynchronization"
        "\Microsoft\Windows\Printing\EduPrintProv"
        "\Microsoft\Windows\Printing\PrinterCleanupTask"
        "\Microsoft\Windows\PushToInstall\write-hostinCheck"
        "\Microsoft\Windows\PushToInstall\Registration"
        "\Microsoft\Windows\RetailDemo\CleanupOfflineContent"
        "\Microsoft\Windows\Servicing\StartComponentCleanup"
        "\Microsoft\Windows\Setup\SetupCleanupTask"
        "\Microsoft\Windows\SharedPC\AccountCleanup"
        "\Microsoft\Windows\UNP\RunUpdateNotificationMgr"
        "\Microsoft\Windows\Windowswrite-hostReporting\QueueReporting"
        "\Microsoft\XblGameSave\XblGameSaveTask"
    ) | ForEach-Object{
        Disable-ScheduledTask -TaskName $_ -ErrorAction SilentlyContinue | Out-Null
        write-host("Task `"$($_)`" was disabled")
    }

    if(!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching")){ New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Force -ErrorAction SilentlyContinue }
    if(!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power")){ New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Force -ErrorAction SilentlyContinue }
    if(!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling")){ New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Force -ErrorAction SilentlyContinue }
    if(!(Test-Path "HKCU:\System\GameConfigStore")){ New-Item -Path "HKCU:\System\GameConfigStore" -Force -ErrorAction SilentlyContinue }
    if(!(Test-Path "HKCU:\Control Panel\Desktop")){ New-Item -Path "HKCU:\Control Panel\Desktop" -Force -ErrorAction SilentlyContinue }
    if(!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1")){ New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" -Force -ErrorAction SilentlyContinue }
    if(!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c")){ New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" -Force -ErrorAction SilentlyContinue }
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' -Name 'SearchOrderConfig' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling' -Name 'PowerThrottlingOff' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\System\GameConfigStore' -Name 'GameDVR_FSEBehaviorMode' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\System\GameConfigStore' -Name 'Win32_AutoGameModeDefaultProfile' -Value ([byte[]](0x01,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00)) -PropertyType Binary -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\System\GameConfigStore' -Name 'Win32_GameModeRelatedProcesses' -Value ([byte[]](0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00)) -PropertyType Binary -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\System\GameConfigStore' -Name 'GameDVR_HonorUserFSEBehaviorMode' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\System\GameConfigStore' -Name 'GameDVR_DXGIHonorFSEWindowsCompatible' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\System\GameConfigStore' -Name 'GameDVR_EFSEFeatureFlags' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'MenuShowDelay' -Value '0' -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'WaitToKillAppTimeout' -Value '5000' -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'HungAppTimeout' -Value '4000' -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'AutoEndTasks' -Value '1' -PropertyType String -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'LowLevelHooksTimeout' -Value 4096 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'WaitToKillServiceTimeout' -Value 8192 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1' -Name 'Attributes' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e' -Name 'ACSettingIndex' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e' -Name 'DCSettingIndex' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' -Name 'ACSettingIndex' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e' -Name 'ACSettingIndex' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e' -Name 'DCSettingIndex' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' -Name 'ACSettingIndex' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

    Stop-Process -Name explorer
    write-host("Disabling Bing Search in Start Menu...")
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
    
    write-host("executionpolicy")
    Set-ExecutionPolicy Unrestricted -Scope CurrentUser

    write-host("Hiding Taskbar Search icon / box...")
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
    write-host("Disabling Cortana...")
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
        
    Stop-Process -Name explorer -Force
    write-host("Disabled Cortana")

    write-host("Disabling Background application access...")
    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" |  ForEach-Object{
        Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
        Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
    }
    if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications")){
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1
    write-host("Disabled Background application access")

    write-host("Disabling OneDrive...")
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
    write-host("Uninstalling OneDrive...")
    Stop-Process -Name *onedrive* -ErrorAction SilentlyContinue -Force
    Start-Sleep -Seconds 2
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    If (!(Test-Path $onedrive)) {
        $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
    Start-Sleep -Seconds 2
    Restart-Process -Process "explorer" -Restart -RestartDelay 5
    Start-Sleep -Seconds 2
    If (!(Test-Path "HKCR:")) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    If ((Get-ChildItem "$env:userprofile\OneDrive" -Recurse | Measure-Object).Count -gt 0) {
        [Void][System.Windows.Forms.MessageBox]::Show(
            "Hey, you still have your files in OneDrive folder!", "", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning
        )
    }
    write-host("Disabled OneDrive")

    write-host("Removing bloatware, wait...")
    $BloatwareList = @(
        "Microsoft.BingNews"
        "Microsoft.BingWeather"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.PowerAutomateDesktop"
        "Microsoft.SecHealthUI"
        "Microsoft.People"
        "Microsoft.Todos"
        "Microsoft.WindowsAlarms"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.YourPhone"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
        "MicrosoftTeams"
        "ClipChamp.ClipChamp"
    )
    foreach($Bloat in $BloatwareList){
        if((Get-AppxPackage -Name $Bloat).NonRemovable -eq $false)
        {
            Log("Trying to remove $Bloat")
            Try {
                Get-AppxPackage -Name $Bloat | Remove-AppxPackage -ErrorAction Stop | Out-Null
                Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online -ErrorAction Stop
            }
            Catch {
                Error('Failed to remove $Bloat, exception : $($_)')
            }
            
        }  
    }
    True('FATTO')

    Shutdown /r
})

  $debloatForm.ShowDialog()
   })

   
   $ripristinopc = New-Object System.Windows.Forms.Button
   $ripristinopc.Text = "Ripristino PC"
   $ripristinopc.AutoSize                 = $True
   $ripristinopc.Location = New-Object System.Drawing.Point(70, 45)
   $ripristinopc.width            = 100
   $ripristinopc.height           = 30
   $ripristinopc.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
   $terzaForm.Controls.AddRange($ripristinopc) 

   $ripristinopc.Add_Click({
    $ripristinoForm = New-Object System.Windows.Forms.Form
    $ripristinoForm.Text = "Ripristino PC"
    $ripristinoForm.StartPosition              = "CenterScreen"
    $ripristinoForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $ripristinoForm.Size = New-Object System.Drawing.Size(1000, 300)
    $sfcscan = New-Object System.Windows.Forms.Button
    $sfcscan.Text = "Ripristina System32 con SFC"
    $sfcscan.AutoSize                 = $True
    $sfcscan.Location = New-Object System.Drawing.Point(70, 10)
    $sfcscan.width            = 100
    $sfcscan.height           = 30
    $sfcscan.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($sfcscan)

    $sfcscan.Add_Click({
   Log('Riprisstino System32 con SFC')
    Start-Process -FilePath "sfc.exe" -ArgumentList "/scannow" -Wait
    True('FATTO')
    })
    
    $dismscan = New-Object System.Windows.Forms.Button
    $dismscan.Text = "Ripristina Windows metodo DISM"
    $dismscan.AutoSize                 = $True
    $dismscan.Location = New-Object System.Drawing.Point(70, 45)
    $dismscan.width            = 100
    $dismscan.height           = 30
    $dismscan.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($dismscan)

    $dismscan.Add_Click({
   Log('Ripristino Windows con DISM')
    Start-Process -FilePath "dism.exe" -ArgumentList "/online /cleanup-image /checkhealth" -Wait
    Start-Process -FilePath "dism.exe" -ArgumentList "/online /cleanup-image /scanhealth" -Wait
    Start-Process -FilePath "dism.exe" -ArgumentList "/online /cleanup-image /RestoreHealth" -Wait
    True('FATTO')
    })

    $deletefiledeal = New-Object System.Windows.Forms.Button
    $deletefiledeal.Text = "Elimina i file deallocati"
    $deletefiledeal.AutoSize                 = $True
    $deletefiledeal.Location = New-Object System.Drawing.Point(70, 80)
    $deletefiledeal.width            = 100
    $deletefiledeal.height           = 30
    $deletefiledeal.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($deletefiledeal)

    $deletefiledeal.Add_Click({
    Log('Avvio eliminazione file deallocati')
    Start-Process -FilePath "cipher.exe" -ArgumentList "/w:c" -Wait
    True('FATTO')
    })

    $chekdisk = New-Object System.Windows.Forms.Button
    $chekdisk.Text = "Controlla stato SSD/HDD"
    $chekdisk.AutoSize                 = $True
    $chekdisk.Location = New-Object System.Drawing.Point(350, 10)
    $chekdisk.width            = 100
    $chekdisk.height           = 30
    $chekdisk.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($chekdisk)

    $chekdisk.Add_Click({
    Log('Avvio controllo SSD/HDD')
    Start-Process -FilePath "chkdsk.exe" -ArgumentList "/x /r /f" -Wait
    True('FATTO')
    })

    $bios = New-Object System.Windows.Forms.Button
    $bios.Text = "Vai nel BIOS"
    $bios.AutoSize                 = $True
    $bios.Location = New-Object System.Drawing.Point(350, 45)
    $bios.width            = 100
    $bios.height           = 30
    $bios.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($bios)

    $bios.Add_Click({
    Log('Inizio la procedura')
    shutdown /r /o /f /t 00
    True('FATTO')
    })


    $checkram = New-Object System.Windows.Forms.Button
    $checkram.Text = "Verifica integrita RAM"
    $checkram.AutoSize                 = $True
    $checkram.Location = New-Object System.Drawing.Point(350, 80)
    $checkram.width            = 100
    $checkram.height           = 30
    $checkram.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($checkram)

    $checkram.Add_Click({
    Log('Avvio verifica RAM')
    mdsched
    True('FATTO')
    })
    
    $cleanupdate = New-Object System.Windows.Forms.Button
    $cleanupdate.Text = "Pulizia Windows Update"
    $cleanupdate.AutoSize                 = $True
    $cleanupdate.Location = New-Object System.Drawing.Point(70, 120)
    $cleanupdate.width            = 100
    $cleanupdate.height           = 30
    $cleanupdate.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($cleanupdate)

    $cleanupdate.Add_Click({
    Log('Avvio pulizia Windows Update')
    Stop-Service -Name wuauserv
    Start-Process -FilePath "DISM.exe" -ArgumentList "/Online /Cleanup-Image /StartComponentCleanup /ResetBase" -Wait
    Start-Process -Wait -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:1"
    Start-Sleep -Seconds 10
    Start-Sleep -Seconds 10
    True('FATTO')
    })

    $cleandefender = New-Object System.Windows.Forms.Button
    $cleandefender.Text = "Pulizia Cronologia Windows Defender"
    $cleandefender.AutoSize                 = $True
    $cleandefender.Location = New-Object System.Drawing.Point(350, 120)
    $cleandefender.width            = 100
    $cleandefender.height           = 30
    $cleandefender.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($cleandefender)

    $cleandefender.Add_Click({
    Log('Avvio pulizia cronologia Windows Defender')
    Set-MpPreference -DisableRealtimeMonitoring $true
    Remove-MpPreference -RemoveHistory
    Set-MpPreference -DisableRealtimeMonitoring $false
    True('FATTO')
    })

    $resetupdate = New-Object System.Windows.Forms.Button
    $resetupdate.Text = "Resetta Windows Update"
    $resetupdate.AutoSize                 = $True
    $resetupdate.Location = New-Object System.Drawing.Point(70, 200)
    $resetupdate.width            = 100
    $resetupdate.height           = 30
    $resetupdate.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($resetupdate)

    $resetupdate.Add_Click({
    Log('Avvio pulizia cronologia Windows Defender')
    Stop-Service -Name bits, wuauserv, cryptsvc
    Remove-Item -Path "$env:SystemRoot\System32\Catroot2" -Force -Recurse
    Start-Service -Name cryptsvc
    Remove-Item -Path "$env:windir\WindowsUpdate.log" -Force
    $system32Path = "$env:SystemRoot\System32"
    $filesToRegister = @("atl.dll", "jscript.dll", "msxml3.dll", "softpub.dll", "wuapi.dll", "wuaueng.dll", "wuaueng1.dll", "wucltui.dll", "wups.dll", "wups2.dll", "wuweb.dll", "quartz.dll")
    foreach ($file in $filesToRegister) {
    $dllPath = Join-Path -Path $system32Path -ChildPath $file
    if (Test-Path $dllPath) {
        try {
            regsvr32 /s $dllPath
        } catch {
            Write-Host "Failed to register: $dllPath"
        }
    } else {
        Write-Host "DLL not found: $dllPath"
    }
 }
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name AccountDomainSid -Force
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name PingID -Force
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name SusClientId -Force
    Start-Service -Name bits, wuauserv
    True('FATTO')
    })

    $savedriver = New-Object System.Windows.Forms.Button
    $savedriver.Text = "Salva i driver del PC"
    $savedriver.AutoSize                 = $True
    $savedriver.Location = New-Object System.Drawing.Point(700, 10)
    $savedriver.width            = 100
    $savedriver.height           = 30
    $savedriver.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($savedriver)

    $savedriver.Add_Click({
    Log('Inizio a salvare i driver del PC')
    New-Item -ItemType Directory -Path "C:\DriverPC" | out-null
    Export-WindowsDriver -Online -Destination "C:\DriverPC"
    $desktopPath = "C:\DriverPC"
    $outputFilePath = Join-Path -Path $desktopPath -ChildPath '\driver.txt'
    driverquery > $outputFilePath
    warning('Trovi la cartella in C:\DriverPC')
    New-Item -ItemType Directory -Path "C:\DriverPC\DriverDISM" | out-null
    start-process -filepath "dism.exe" -ArgumentList "/online /export-driver /destination:C:\DriverPC\DriverDISM"
    warning('Per ripristinare tutti i driver, salvati la cartella su usb e iso installata dai "pnputil /add-driver "percorsodriver\*.inf" /subdirs /install /reboot"')
    True('FATTO')
    })

    $battery = New-Object System.Windows.Forms.Button
    $battery.Text = "Verifica stato batteria"
    $battery.AutoSize                 = $True
    $battery.Location = New-Object System.Drawing.Point(700, 45)
    $battery.width            = 100
    $battery.height           = 30
    $battery.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($battery)

    $battery.Add_Click({
    Log('Verifico stato batteria')
    $battery = Get-WmiObject -Class Win32_Battery

   if ($battery) {
    # Mostra lo stato della batteria
    Warning "Stato della batteria:"
    Warning " - Carica residua: $($battery.EstimatedChargeRemaining)%"
    Warning " - Capacita designata: $($battery.DesignCapacity) mWh"
    Warning " - Capacita massima: $($battery.FullChargeCapacity) mWh"
    Warning " - Stato: $($battery.BatteryStatus)"
    } else {
    Error('Nessuna batteria trovata nel sistema.')
    True('FATTO')
    }
    })

    $tempfile = New-Object System.Windows.Forms.Button
    $tempfile.Text = "Elimina i file temporanei"
    $tempfile.AutoSize                 = $True
    $tempfile.Location = New-Object System.Drawing.Point(700, 80)
    $tempfile.width            = 100
    $tempfile.height           = 30
    $tempfile.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($tempfile)

    $tempfile.Add_Click({
    Log('Avvio eliminazione file temporanei')
    cmd.exe /c del /s /f /q "%TEMP%\*.*"
	cmd.exe /c del /s /f /q "%SYSTEMROOT%\Temp\*.*"
    start-process -filepath "cleanmgr.exe" -ArgumentList "/verylowdisk" -Wait
    True('FATTO')
    })

    $resetsxs = New-Object System.Windows.Forms.Button
    $resetsxs.Text = "Ripristina la cartella WinSxS"
    $resetsxs.AutoSize        = $True
    $resetsxs.Location = New-Object System.Drawing.Point(700, 120)
    $resetsxs.width            = 100
    $resetsxs.height           = 30
    $resetsxs.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $ripristinoForm.Controls.AddRange($resetsxs)

    $resetsxs.Add_Click({  
    Log('Avvio ripristino cartella WinSxS')
     Start-Process -FilePath "DISM.exe" -ArgumentList "/Online /Cleanup-Image /StartComponentCleanup" -Wait*
     True('FINE')
    })
    
    $ripristinoForm.ShowDialog()
   })


   $mofichepc = New-Object System.Windows.Forms.Button
   $mofichepc.Text = "Modifiche PC"
   $mofichepc.AutoSize                 = $True
   $mofichepc.Location = New-Object System.Drawing.Point(70, 80)
   $mofichepc.width            = 100
   $mofichepc.height           = 30
   $mofichepc.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
   $terzaForm.Controls.AddRange($mofichepc) 

   $mofichepc.Add_Click({
   
    $modifiform = New-Object System.Windows.Forms.Form
    $modifiform.Text = "Modifiche PC"
    $modifiform.StartPosition              = "CenterScreen"
    $modifiform.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $modifiform.Size = New-Object System.Drawing.Size(700, 200)

     
    $customtaskbar = New-Object System.Windows.Forms.Button
    $customtaskbar.Text = "Personalizza Taskbar"
    $customtaskbar.AutoSize                 = $True
    $customtaskbar.Location = New-Object System.Drawing.Point(50, 10)
    $customtaskbar.width            = 100
    $customtaskbar.height           = 30
    $customtaskbar.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $modifiform.Controls.AddRange($customtaskbar)
    
    $customtaskbar.Add_Click({

    $taskbarform = New-Object System.Windows.Forms.Form
    $taskbarform.Text = "Personalizza Taskbar"
    $taskbarform.StartPosition              = "CenterScreen"
    $taskbarform.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $taskbarform.Size = New-Object System.Drawing.Size(290, 150)

     
    $taskbarsini = New-Object System.Windows.Forms.Button
    $taskbarsini.Text = "Icone taskbar a sinistra"
    $taskbarsini.AutoSize                 = $True
    $taskbarsini.Location = New-Object System.Drawing.Point(50, 10)
    $taskbarsini.width            = 100
    $taskbarsini.height           = 30
    $taskbarsini.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $taskbarform.Controls.AddRange($taskbarsini)
   
    $taskbarsini.Add_Click({
     systeminfo | find "Windows 10"
     if ($?) {Error "Funzione abilitata solo per Windows 11"}
     else {
    Log('Setto icone taskbar a sinistra')
    $registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $valueName = "TaskbarAl"
    $valueData = 0
    New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWORD -Force 
    True('FATTO')
    }
    })

    $taskbarcen = New-Object System.Windows.Forms.Button
    $taskbarcen.Text = "Icone taskbar al centro"
    $taskbarcen.AutoSize                 = $True
    $taskbarcen.Location = New-Object System.Drawing.Point(50, 45)
    $taskbarcen.width            = 100
    $taskbarcen.height           = 30
    $taskbarcen.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $taskbarform.Controls.AddRange($taskbarcen)
   
    $taskbarcen.Add_Click({
        systeminfo | find "Windows 10"
     if ($?) {Error "Funzione abilitata solo per Windows 11"}
     else {
    Log('Setto icone taskbar al centro')
    $registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $valueName = "TaskbarAl"
    $valueData = 1
    New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWORD -Force 
    True('FATTO')
    }
    })
    
      
    $taskbarform.ShowDialog()
    })

    
    $modificarighitclick = New-Object System.Windows.Forms.Button
    $modificarighitclick.Text = "Modifica Tasto Destro"
    $modificarighitclick.AutoSize                 = $True
    $modificarighitclick.Location = New-Object System.Drawing.Point(50, 45)
    $modificarighitclick.width            = 100
    $modificarighitclick.height           = 30
    $modificarighitclick.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $modifiform.Controls.AddRange($modificarighitclick)

    $modificarighitclick.Add_Click({

    $rightclickform = New-Object System.Windows.Forms.Form
    $rightclickform.Text = "Modifica Tasto Destro"
    $rightclickform.StartPosition              = "CenterScreen"
    $rightclickform.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $rightclickform.Size = New-Object System.Drawing.Size(290, 150)

    $rightclickfull = New-Object System.Windows.Forms.Button
    $rightclickfull.Text = "Abilita tasto destro completo"
    $rightclickfull.AutoSize                 = $True
    $rightclickfull.Location = New-Object System.Drawing.Point(70, 10)
    $rightclickfull.width            = 100
    $rightclickfull.height           = 30
    $rightclickfull.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $rightclickform.Controls.AddRange($rightclickfull)
   
    $rightclickfull.Add_Click({
    Log('Abilito tasto destro mouse completo')
    systeminfo | find "Windows 10"
     if ($?) {Error "Funzione abilitata solo per Windows 11"}
     else {
    cmd.exe /c reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve
    Stop-Process -Name explorer -Force
    Start-Process explorer
    True('FATTO')
    }
    })

    $defutlrightclick = New-Object System.Windows.Forms.Button
    $defutlrightclick.Text = "Tasto destro default"
    $defutlrightclick.AutoSize                 = $True
    $defutlrightclick.Location = New-Object System.Drawing.Point(70, 45)
    $defutlrightclick.width            = 100
    $defutlrightclick.height           = 30
    $defutlrightclick.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $rightclickform.Controls.AddRange($defutlrightclick)
   
    $defutlrightclick.Add_Click({
     systeminfo | find "Windows 10"
     if ($?) {Error "Funzione abilitata solo per Windows 11"}
     else {
    Log('Ripristino il tasto destro del mouse')
    cmd.exe /c reg delete HKCU\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2} /f
    Stop-Process -Name explorer -Force
    Start-Process explorer
    True('FATTO')
    }
    })

   $rightclickform.ShowDialog()
   })

    $orologio = New-Object System.Windows.Forms.Button
    $orologio.Text = "Modifica orologio windows"
    $orologio.AutoSize                 = $True
    $orologio.Location = New-Object System.Drawing.Point(50, 80)
    $orologio.width            = 100
    $orologio.height           = 30
    $orologio.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $modifiform.Controls.AddRange($orologio)

    $orologio.Add_Click({
    $orologioform = New-Object System.Windows.Forms.Form
    $orologioform.Text = "Modifica orologio windows"
    $orologioform.StartPosition              = "CenterScreen"
    $orologioform.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $orologioform.Size = New-Object System.Drawing.Size(290, 150)

    $showseconds = New-Object System.Windows.Forms.Button
    $showseconds.Text = "Abilita secondi sull'orologio"
    $showseconds.AutoSize                 = $True
    $showseconds.Location = New-Object System.Drawing.Point(70, 10)
    $showseconds.width            = 100
    $showseconds.height           = 30
    $showseconds.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $orologioform.Controls.AddRange($showseconds)
   
    $showseconds.Add_Click({
    Log('INIZIO LA PROCEDURA')
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 1 -Force
    True('FINE')
    })

    $restoresecond = New-Object System.Windows.Forms.Button
    $restoresecond.Text = "Ripristina Orologio Default"
    $restoresecond.AutoSize                 = $True
    $restoresecond.Location = New-Object System.Drawing.Point(70, 45)
    $restoresecond.width            = 100
    $restoresecond.height           = 30
    $restoresecond.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $orologioform.Controls.AddRange($restoresecond)
   
    $restoresecond.Add_Click({
    Log('INIZIO LA PROCEDURA')
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 0 -Force
    True('FINE')
    })

   $orologioform.ShowDialog()
   })

    $uac = New-Object System.Windows.Forms.Button
    $uac.Text = "Modifica UAC"
    $uac.AutoSize                 = $True
    $uac.Location = New-Object System.Drawing.Point(300, 10)
    $uac.width            = 100
    $uac.height           = 30
    $uac.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $modifiform.Controls.AddRange($uac)

    $uac.Add_Click({
    $uacform = New-Object System.Windows.Forms.Form
    $uacform.Text = "Modifica UAC"
    $uacform.StartPosition              = "CenterScreen"
    $uacform.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $uacform.Size = New-Object System.Drawing.Size(280, 150)

    $abiluac = New-Object System.Windows.Forms.Button
    $abiluac.Text = "Abilita UAC"
    $abiluac.AutoSize                 = $True
    $abiluac.Location = New-Object System.Drawing.Point(70, 10)
    $abiluac.width            = 100
    $abiluac.height           = 30
    $abiluac.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $uacform.Controls.AddRange($abiluac)

    $abiluac.Add_Click({
    Log('Abilito UAC')
    cmd.exe /c reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
    write-host "Riavvio il sistema in 20 secondi"
    timeout 20
    shutdown /r /t 00 
    True('FATTO')
    })

    $disauac = New-Object System.Windows.Forms.Button
    $disauac.Text = "Disabilita UAC"
    $disauac.AutoSize                 = $True
    $disauac.Location = New-Object System.Drawing.Point(70, 45)
    $disauac.width            = 100
    $disauac.height           = 30
    $disauac.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $uacform.Controls.AddRange($disauac)

    $disauac.Add_Click({
    Log('Disabilito UAC')
    cmd.exe /c reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
    write-host "Riavvio il sistema in 20 secondi"
    timeout 20
    shutdown /r /t 00 
    True('FATTO')
    })
    $uacform.ShowDialog()
    })

    $velointernet = New-Object System.Windows.Forms.Button
    $velointernet.Text = "Setta Configurazione Internet"
    $velointernet.AutoSize                 = $True
    $velointernet.Location = New-Object System.Drawing.Point(50, 120)
    $velointernet.width            = 100
    $velointernet.height           = 30
    $velointernet.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $modifiform.Controls.AddRange($velointernet)
    
    $velointernet.Add_Click({
    Log('Avvio settaggio migliore per Internet')
    cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v IRPStackSize /t REG_DWORD /d 50 /f
    cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v SizReqBuf /t REG_DWORD /d 17424 /f
    cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DefaultTTL /t REG_DWORD /d 62 /f
    cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TCP1323Opts /t REG_DWORD /d 1 /f
    cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v MaxFreeTcbs /t REG_DWORD /d 65536 /f
    cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v MaxUserPort /t REG_DWORD /d 65534 /f
    cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v GlobalMaxTcpWindowSize /t REG_DWORD /d 65535 /f
    Write-Host "1-Change DNS"
    $adapterName = (Get-NetAdapter | Where-Object { $_.Name -like "Ethernet*" -or $_.Name -like "Wi-Fi*" }).Name
    Write-Host "Adapter $adapterName"
    $dnsServers = Get-DnsClientServerAddress -AddressFamily IPv4
    Write-Host "Current DNS: $($dnsServers.ServerAddresses[0]) , $($dnsServers.ServerAddresses[1])"
    $adapterChoice = Read-Host "Scrivi il numero, poi premi invio (1 per Ethernet o 2 per Wi-Fi):"
    if ($adapterChoice -eq "1") {
    $adapterName = "Ethernet"
}
    elseif ($adapterChoice -eq "2") {
    $adapterName = "Wi-Fi"
}
    netsh interface ipv4 set dnsservers name="$adapterName" source=dhcp
    Write-Host "All DNS servers removed successfully."
    $dns1 ="8.8.8.8"
    $dns2 ="8.8.4.4"
    netsh interface ipv4 set dnsservers "$adapterName" static $dns1 primary
    netsh interface ip add dns "$adapterName" $dns2 index=2
    ipconfig /flushdns
    Write-Host "DNS set successfully."
    Read-Host "Press Enter to exit..."
    Function pingtest {
    param (
        [string]$dns
    )
    $pingResult = Test-Connection -ComputerName $dns -Count 1
    $responseTime = $pingResult.ResponseTime
    $global:ms1 = $responseTime
    $global:ms2 = $responseTime
}
    True('FATTO')
    })
    
    $risparmioenerg = New-Object System.Windows.Forms.Button
    $risparmioenerg.Text = "Modifica Risparmio Energetico"
    $risparmioenerg.AutoSize                 = $True
    $risparmioenerg.Location = New-Object System.Drawing.Point(300, 80)
    $risparmioenerg.width            = 100
    $risparmioenerg.height           = 30
    $risparmioenerg.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $modifiform.Controls.AddRange($risparmioenerg)
    
    $risparmioenerg.Add_Click({
    $rispenergform = New-Object System.Windows.Forms.Form
    $rispenergform.Text = "Modifica Risparmio Energetico"
    $rispenergform.StartPosition              = "CenterScreen"
    $rispenergform.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $rispenergform.Size = New-Object System.Drawing.Size(300, 150)

    $risparmelevate = New-Object System.Windows.Forms.Button
    $risparmelevate.Text = "Prestazioni Elevato"
    $risparmelevate.AutoSize                 = $True
    $risparmelevate.Location = New-Object System.Drawing.Point(70, 10)
    $risparmelevate.width            = 100
    $risparmelevate.height           = 30
    $risparmelevate.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $rispenergform.Controls.AddRange($risparmelevate)

    $risparmelevate.Add_Click({
    Log('Setto prestazioni Elevate')
    POWERCFG /SETACTIVE SCHEME_MIN
    True('FATTO')
    })
        
    $risparmeccellenti = New-Object System.Windows.Forms.Button
    $risparmeccellenti.Text = "Prestazioni Eccllenti"
    $risparmeccellenti.AutoSize                 = $True
    $risparmeccellenti.Location = New-Object System.Drawing.Point(70, 45)
    $risparmeccellenti.width            = 100
    $risparmeccellenti.height           = 30
    $risparmeccellenti.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $rispenergform.Controls.AddRange($risparmeccellenti)

    $risparmeccellenti.Add_Click({
    Log('Setto prestazioni Eccellenti')
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    True('FATTO')
    })
    $rispenergform.ShowDialog()
    })


    $admincartella = New-Object System.Windows.Forms.Button
    $admincartella.Text = "Admin Cartella"
    $admincartella.AutoSize                 = $True
    $admincartella.Location = New-Object System.Drawing.Point(300, 120)
    $admincartella.width            = 100
    $admincartella.height           = 30
    $admincartella.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $modifiform.Controls.AddRange($admincartella)

    $admincartella.Add_Click({
    $admincartellaForm = New-Object System.Windows.Forms.Form
    $admincartellaForm.Text = "Admin Cartella"
    $admincartellaForm.StartPosition              = "CenterScreen"
    $admincartellaForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $admincartellaForm.Size = New-Object System.Drawing.Size(470, 150)

    $prendiproprieta = New-Object System.Windows.Forms.Button
    $prendiproprieta.Text = "Aggiungi pulsante Take Ownership"
    $prendiproprieta.AutoSize                 = $True
    $prendiproprieta.Location = New-Object System.Drawing.Point(70, 10)
    $prendiproprieta.width            = 100
    $prendiproprieta.height           = 30
    $prendiproprieta.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $admincartellaForm.Controls.AddRange($prendiproprieta)

    $prendiproprieta.Add_Click({
    Log('Creo il pulsante')
    if(!(Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership")){
        Log("Adding 'Take Ownership' to context menu!")
        if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership") -ne $true){
            New-Item "HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership" -force -ea SilentlyContinue
        }
        if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership\command") -ne $true){
            New-Item "HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership\command" -force -ea SilentlyContinue
        }
        if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership") -ne $true){
            New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership" -force -ea SilentlyContinue
        }
        if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership\command") -ne $true){
            New-Item "HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership\command" -force -ea SilentlyContinue
        }
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership' -Name '(default)' -Value 'Take Ownership' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership' -Name 'HasLUAShield' -Value '' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership' -Name 'NoWorkingDirectory' -Value '' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership' -Name 'Position' -Value 'middle' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership\command' -Name '(default)' -Value 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/c takeown /f \"%1\" && icacls \"%1\" /grant *S-1-3-4:F /c /l'' -Verb runAs' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\*\shell\TakeOwnership\command' -Name 'IsolatedCommand' -Value 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/c takeown /f \"%1\" && icacls \"%1\" /grant *S-1-3-4:F /c /l'' -Verb runAs' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership' -Name '(default)' -Value 'Take Ownership' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership' -Name 'AppliesTo' -Value 'NOT (System.ItemPathDisplay:="C:\Users" OR System.ItemPathDisplay:="C:\ProgramData" OR System.ItemPathDisplay:="C:\Windows" OR System.ItemPathDisplay:="C:\Windows\System32" OR System.ItemPathDisplay:="C:\Program Files" OR System.ItemPathDisplay:="C:\Program Files (x86)")' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership' -Name 'HasLUAShield' -Value '' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership' -Name 'NoWorkingDirectory' -Value '' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership' -Name 'Position' -Value 'middle' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership\command' -Name '(default)' -Value 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant *S-1-3-4:F /c /l /q'' -Verb runAs' -PropertyType String -Force -ea SilentlyContinue;
        New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\Directory\shell\TakeOwnership\command' -Name 'IsolatedCommand' -Value 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant *S-1-3-4:F /c /l /q'' -Verb runAs' -PropertyType String -Force -ea SilentlyContinue;
        True('FATTO')
    } else {
        Clear-Host
        Error('Hai gia il pulsante nel menu destro del mouse')
    }
})


    $RemoveTakeOwnership = New-Object System.Windows.Forms.Button
    $RemoveTakeOwnership.Text = "Rimuovi pulsante Take Ownership"
    $RemoveTakeOwnership.AutoSize                 = $True
    $RemoveTakeOwnership.Location = New-Object System.Drawing.Point(70, 45)
    $RemoveTakeOwnership.width            = 100
    $RemoveTakeOwnership.height           = 30
    $RemoveTakeOwnership.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $admincartellaForm.Controls.AddRange($RemoveTakeOwnership)

    $RemoveTakeOwnership.Add_Click({
    Log('Rimuovo il pulsante Take Ownership')
    Start-Process -FilePath "CMD" -ArgumentList "/c REG DELETE `"HKEY_CLASSES_ROOT\*\shell\TakeOwnership`" /F" -Verb RunAs -WindowStyle Hidden -Wait
    Start-Process -FilePath "CMD" -ArgumentList "/c REG DELETE `"HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership`" /F" -Verb RunAs -WindowStyle Hidden -Wait
    True('FATTO')
})

   $admincartellaForm.ShowDialog()
   })

   $modifiform.ShowDialog()
   })
 $terzaForm.ShowDialog()
 })

$WPFsottosistema.Add_Click({
  $androidform = New-Object System.Windows.Forms.Form
  $androidform.Text = "Attiva Sottosistema Andorid"
    $androidform.StartPosition              = "CenterScreen"
    $androidform.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $androidform.Size = New-Object System.Drawing.Size(290, 150)

    $wsadownload = New-Object System.Windows.Forms.Button
    $wsadownload.Text = "Abilita il WSA"
    $wsadownload.AutoSize                 = $True
    $wsadownload.Location = New-Object System.Drawing.Point(70, 10)
    $wsadownload.width            = 100
    $wsadownload.height           = 30
    $wsadownload.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $androidform.Controls.AddRange($wsadownload)

    $wsadownload.Add_Click({
     Log('Avvio abilitazione WSA')
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
    
     })

    $abilpacman = New-Object System.Windows.Forms.Button
    $abilpacman.Text = "Attiva PacMan"
    $abilpacman.AutoSize                 = $True
    $abilpacman.Location = New-Object System.Drawing.Point(70, 45)
    $abilpacman.width            = 100
    $abilpacman.height           = 30
    $abilpacman.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $androidform.Controls.AddRange($abilpacman)

    $abilpacman.Add_Click({
    Log('Avvio attivazione PacMan')
    $dek=[Environment]::GetFolderPath("Desktop")
    cd $dek
    Invoke-WebRequest -Uri "https://github.com/MrNico98/pacman/archive/refs/heads/main.zip" -OutFile "pacman-main.zip"
    Expand-Archive -Path "pacman-main.zip" -DestinationPath "." -Force
    Move-Item -Path "pacman-main\WSA-pacman-v1.5.0-portable" -Destination "WSA-pacman-v1.5.0-portable" -Force
    Remove-Item -Path "pacman-main" -Recurse -Forc
    Remove-Item -Path "pacman-main.zip" -Force
    Rename-Item -Path "$dek\WSA-pacman-v1.5.0-portable" -NewName "PacManWSA"
    Start-Process -FilePath "$dek\PacManWSA\WSA-pacman.exe"
    True('FATTO')
    })

     $androidform.ShowDialog()
    })

$WPFcambiowindows.Add_Click({
Log('Avvio cambio edizione windows')
    cd "$currentPath\Risorse"
    Start-Process -FilePath ".\WinCustomizerEdizioneWindows.cmd" -Wait
    if (-not (Test-Path -Path "$currentPath\Risorse\WinCustomizerEdizioneWindows.cmd" -PathType Leaf)) {
    Error('Programma non presente')} else {True('FATTO')}
    })

$WPFattivawin.Add_Click({
Log('Avvio attivazione Windows')
 cd "$currentPath"
 Start-Process -FilePath ".\Risorse\WinCustomizerAttivatore.bat"
 if (-not (Test-Path -Path "$currentPath\Risorse\WinCustomizerAttivatore.bat" -PathType Leaf)) {
 Error('Programma non presente')} else {True('FATTO')}
 })

$WPFoff.Add_Click({

    $officeForm = New-Object System.Windows.Forms.Form
    $officeForm.Text = "Menu OFFICE"
    $officeForm.StartPosition              = "CenterScreen"
    $officeForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $officeForm.Size = New-Object System.Drawing.Size(300, 250)

    $downloadoff = New-Object System.Windows.Forms.Button
    $downloadoff.Text = "Scarica OFFICE"
    $downloadoff.AutoSize                 = $True
    $downloadoff.Location = New-Object System.Drawing.Point(70, 10)
    $downloadoff.width            = 100
    $downloadoff.height           = 30
    $downloadoff.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $officeForm.Controls.AddRange($downloadoff)

    $downloadoff.Add_Click({
    
    $downloadoffForm = New-Object System.Windows.Forms.Form
    $downloadoffForm.Text = "Scarica OFFICE"
    $downloadoffForm.StartPosition              = "CenterScreen"
    $downloadoffForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ccccff")
    $downloadoffForm.Size = New-Object System.Drawing.Size(600, 200)

    $office64 = New-Object System.Windows.Forms.Button
    $office64.Text = "OFFICE 2021 64bit"
    $office64.AutoSize                 = $True
    $office64.Location = New-Object System.Drawing.Point(50, 10)
    $office64.width            = 100
    $office64.height           = 30
    $office64.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $downloadoffForm.Controls.AddRange($office64)

    $office64.Add_Click({
    Log('Avvio download OFFICE 2021 64bit')
    cd "$currentPath"
    Invoke-WebRequest -Uri "https://github.com/MrNico98/Office2021/archive/refs/heads/main.zip" -OutFile "Office2021-main.zip"
    Expand-Archive -Path "Office2021-main.zip" -DestinationPath "." -Force
    Move-Item -Path "Office2021-main\Office2021" -Destination "Office2021" -Force
    Remove-Item -Path "Office2021-main" -Recurse -Force
    Remove-Item -Path "Office2021-main.zip" -Recurse -Force
    mkdir "$currentPath\Office2021\configuration"
    Move-Item -Path "Risorse\configuration-x64-complete.xml" -Destination "Office2021\configuration\configuration-x64-complete.xml" -Force 
    Start-Process -FilePath ".\Office2021\Install-x64-complete.bat" -Wait
    Remove-Item -Path "$currentPath\Office2021" -Recurse -Force
    True('FATTO')
    })

    $office32 = New-Object System.Windows.Forms.Button
    $office32.Text = "OFFICE 2021 32bit"
    $office32.AutoSize                 = $True
    $office32.Location = New-Object System.Drawing.Point(50, 45)
    $office32.width            = 100
    $office32.height           = 30
    $office32.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $downloadoffForm.Controls.AddRange($office32)

    $office32.Add_Click({
    Log('Avvio download OFFICE 2021 32bit')
    cd "$currentPath"
    Invoke-WebRequest -Uri "https://github.com/MrNico98/Office2021/archive/refs/heads/main.zip" -OutFile "Office2021-main.zip"
    Expand-Archive -Path "Office2021-main.zip" -DestinationPath "." -Force
    Move-Item -Path "Office2021-main\Office2021" -Destination "Office2021" -Force
    Remove-Item -Path "Office2021-main" -Recurse -Force
    Remove-Item -Path "Office2021-main.zip" -Recurse -Force
    mkdir "$currentPath\Office2021\configuration"
    Copy-Item "Risorse\configuration-x32-complete.xml" -Destination "Office2021\configuration\configuration-x32-complete.xml" -Force 
    Start-Process -FilePath ".\Office2021\Install-x64-complete.bat" -Wait
    Remove-Item -Path "$currentPath\Office2021" -Recurse -Force
    True('FATTO')
    })


    $office1964 = New-Object System.Windows.Forms.Button
    $office1964.Text = "OFFICE 2021 x64 personalizzato"
    $office1964.AutoSize                 = $True
    $office1964.Location = New-Object System.Drawing.Point(250, 10)
    $office1964.width            = 100
    $office1964.height           = 30
    $office1964.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $downloadoffForm.Controls.AddRange($office1964)

    $office1964.Add_Click({
    Log('OFFICE 2021 x64 personalizzato')
    
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
True('FATTO')
    })

    $office1932 = New-Object System.Windows.Forms.Button
    $office1932.Text = "OFFICE 2021 x32 personalizzato"
    $office1932.AutoSize                 = $True
    $office1932.Location = New-Object System.Drawing.Point(250, 45)
    $office1932.width            = 100
    $office1932.height           = 30
    $office1932.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $downloadoffForm.Controls.AddRange($office1932)

    $office1932.Add_Click({
    Log('Avvio download OFFICE 2021 x32 completo')
    
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
if ($OneNote -eq "1") {$OneNote=""} elseif ($onedrive -eq "2") {$OneNote="OneNote"}
$outlook = Read-Host "Vuoi l'app OFFICE OUTLOOK? [1] Si [2] No"
if ($outlook -eq "1") {$outlook=""} elseif ($outlook -eq "2") {$outlook="Outlook"}
$powerpoint = Read-Host "Vuoi l'app OFFICE POWERPOINT? [1] Si [2] No"
if ($powerpoint -eq "1") {$powerpoint=""} elseif ($powerpoint -eq "2") {$powerpoint="PowerPoint"}
$publisher = Read-Host "Vuoi l'app OFFICE PUBLISHER? [1] Si [2] No"
if ($publisher -eq "1") {$publisher=""} elseif ($publisher -eq "2") {$onedrive="Publisher"}

# Create the configuration XML
$configXML = @"
<Configuration ID="37d1a293-ccee-4ee2-a953-86c3143f0337">
  <Add OfficeClientEdition="32" Channel="PerpetualVL2021" MigrateArch="TRUE">
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
$configXML | Out-File -FilePath "C:\configuration-x32-complete.xml" -Encoding UTF8

# Prompt the user for Visio and Project choices
$visio = Read-Host "Vuoi Visio? [1] SI [2] NO"
if ($visio -eq "1") {
    @"
<Product ID="VisioPro2021Volume" PIDKEY="KNH8D-FGHT4-T8RK3-CTDYJ-K2HT4">
  <Language ID="it-it" />
  <ExcludeApp ID="Lync" />
</Product>
"@ | Out-File -Append -FilePath "C:\configuration-x32-complete.xml" -Encoding UTF8
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
"@ | Out-File -Append -FilePath "C:\configuration-x32-complete.xml" -Encoding UTF8
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
"@ | Out-File -Append -FilePath "C:\configuration-x32-complete.xml" -Encoding UTF8
}

start-sleep 4

cd "$currentPath"
Invoke-WebRequest -Uri "https://github.com/MrNico98/Office2021/archive/refs/heads/main.zip" -OutFile "Office2021-main.zip"
Expand-Archive -Path "Office2021-main.zip" -DestinationPath "." -Force
Move-Item -Path "Office2021-main\Office2021" -Destination "Office2021" -Force
Remove-Item -Path "Office2021-main" -Recurse -Force
Remove-Item -Path "Office2021-main.zip" -Recurse -Force
mkdir "$currentPath\Office2021\configuration"
Move-Item -Path "C:\configuration-x32-complete.xml" -Destination "$currentPath\Office2021\configuration" -Force
Start-Process -FilePath ".\Office2021\Install-x32-complete.bat" -Wait
Remove-Item -Path "$currentPath\Office2021" -Recurse -Force
True('FATTO')
    })

   $downloadoffForm.ShowDialog()
   })


  $attivaoffice = New-Object System.Windows.Forms.Button
  $attivaoffice.Text = "Attiva OFFICE"
  $attivaoffice.AutoSize                 = $True
  $attivaoffice.Location = New-Object System.Drawing.Point(70, 45)
  $attivaoffice.width            = 100
  $attivaoffice.height           = 30
  $attivaoffice.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
  $officeForm.Controls.AddRange($attivaoffice)

  $attivaoffice.Add_Click({
  log('Attivo Office')
  cd "$currentPath\Risorse"
  start-process -FilePath "WinCustomizerOfficeAttivatore.cmd"
  if (-not (Test-Path -Path "$currentPath\Risorse\WinCustomizerOfficeAttivatore.cmd" -PathType Leaf)) {
  Error('Programma non presente')} else {True('FATTO')}
  })

  $scruboffice = New-Object System.Windows.Forms.Button
  $scruboffice.Text = "Disinstalla OFFICE"
  $scruboffice.AutoSize                 = $True
  $scruboffice.Location = New-Object System.Drawing.Point(70, 80)
  $scruboffice.width            = 100
  $scruboffice.height           = 30
  $scruboffice.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
  $officeForm.Controls.AddRange($scruboffice)

  $scruboffice.Add_Click({
  log('Disinstallo office Office')
  cd "$currentPath\Risorse"
  start-process -FilePath "WinCustomizerDisinstallaOffice.bat"
  if (-not (Test-Path -Path "$currentPath\Risorse\WinCustomizerDisinstallaOffice.bat" -PathType Leaf)) {
  Error('Programma non presente')} else {True('FATTO')}
  True('FATTO')
  })

   $officeForm.ShowDialog()
   })

$WPFcop.Add_Click({
 Log('Avvio Copilot Windows')
 cd "$currentPath"
 Start-Process -FilePath ".\Risorse\WinCustomizerCopilot.cmd"
 if (-not (Test-Path -Path "$currentPath\Risorse\WinCustomizerCopilot.cmd" -PathType Leaf)) {
 Error('Programma non presente')} else {True('FATTO')}
 })
  
$WPFwsl.Add_Click({
    Log('Avvio WSL')
    Start-Process powershell.exe -ArgumentList "-NoExit", "-File", "Risorse\WinCustomizerWSL.ps1"
    if (-not (Test-Path -Path "$currentPath\Risorse\WinCustomizerWSL.ps1" -PathType Leaf)) {
        Error('Programma non presente')} else {True('FATTO')}
    })

$Form.ShowDialog() | out-null