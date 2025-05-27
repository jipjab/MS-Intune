<#
.SYNOPSIS
    Pin applications on the taskbar

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 09/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)
#>


$taskbar_layout =
@"
<?xml version="1.0" encoding="utf-8"?>
<LayoutModificationTemplate
    xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification"
    xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout"
    xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout"
    xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout"
    Version="1">
  <CustomTaskbarLayoutCollection PinListPlacement="Replace">
    <defaultlayout:TaskbarLayout>
      <taskbar:TaskbarPinList>
        <taskbar:DesktopApp DesktopApplicationID="Microsoft.WindowsTerminal_8wekyb3d8bbwe!app" />
        <taskbar:DesktopApp DesktopApplicationID="Microsoft.Windows.Explorer" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" />
        <taskbar:DesktopApp DesktopApplicationID="MSEdge"/>
        <taskbar:DesktopApp DesktopApplicationID="Microsoft.Office.OUTLOOK.EXE.15" />
        <taskbar:DesktopApp DesktopApplicationID="Microsoft.Office.WINWORD.EXE.15" />
        <taskbar:DesktopApp DesktopApplicationID="Microsoft.Office.EXCEL.EXE.15" />
        <taskbar:DesktopApp DesktopApplicationID="Microsoft.Office.POWERPNT.EXE.15" />
      </taskbar:TaskbarPinList>
    </defaultlayout:TaskbarLayout>
 </CustomTaskbarLayoutCollection>
</LayoutModificationTemplate>
"@

# prepare provisioning folder
[System.IO.FileInfo]$provisioning = "$($env:ProgramData)\provisioning\tasbar_layout.xml"
if (!$provisioning.Directory.Exists) {
    $provisioning.Directory.Create()
}

$taskbar_layout | Out-File $provisioning.FullName -Encoding utf8

$settings = [PSCustomObject]@{
    Path  = "SOFTWARE\Policies\Microsoft\Windows\Explorer"
    Value = $provisioning.FullName
    Name  = "StartLayoutFile"
    Type  = [Microsoft.Win32.RegistryValueKind]::ExpandString
},
[PSCustomObject]@{
    Path  = "SOFTWARE\Policies\Microsoft\Windows\Explorer"
    Value = 1
    Name  = "LockedStartLayout"
} | group Path

foreach ($setting in $settings) {
    $registry = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($setting.Name, $true)
    if ($null -eq $registry) {
        $registry = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($setting.Name, $true)
    }
    $setting.Group | % {
        if (!$_.Type) {
            $registry.SetValue($_.name, $_.value)
        }
        else {
            $registry.SetValue($_.name, $_.value, $_.type)
        }
    }
    $registry.Dispose()
}