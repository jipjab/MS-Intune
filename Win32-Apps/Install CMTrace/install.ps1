<#
.SYNOPSIS
    Install CMTrace for reading windows logs easily

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana

    This script copy CMTrace to C:\Windows\

    Source: https://www.microsoft.com/en-us/evalcenter/download-microsoft-endpoint-configuration-manager 
    and extract it to a folder using 7Zip or WinRAR.
    mtrace can be found under SMSSETUP\TOOLS 

    Detect: C:\Windows\CMTrace.exe
#>

# Copy-Item “$($PSScriptRoot)\CMTrace.exe” -Destination C:\Windows\CMTrace.exe -Force

# Check if C:\Windows\CCM\ exists, if not create it
if (-not (Test-Path -Path "C:\Windows\CCM")) {
    New-Item -Path "C:\Windows\CCM" -ItemType Directory -Force | Out-Null
    Write-Host "Created C:\Windows\CCM directory."
}

# Copy CMTrace.exe
Copy-Item -Path "$($PSScriptRoot)\CMTrace.exe" -Destination "C:\Windows\CCM\CMTrace.exe" -Force

# Create registry keys and set file associations
New-Item -Path 'HKLM:\Software\Classes\.lo_' -Force | Out-Null
New-Item -Path 'HKLM:\Software\Classes\.log' -Force | Out-Null
New-Item -Path 'HKLM:\Software\Classes\Log.File' -Force | Out-Null
New-Item -Path 'HKLM:\Software\Classes\Log.File\shell\open\command' -Force | Out-Null

Set-ItemProperty -Path 'HKLM:\Software\Classes\.lo_' -Name '(Default)' -Value 'Log.File' -Force
Set-ItemProperty -Path 'HKLM:\Software\Classes\.log' -Name '(Default)' -Value 'Log.File' -Force
Set-ItemProperty -Path 'HKLM:\Software\Classes\Log.File\shell\open\command' -Name '(Default)' -Value '"C:\Windows\CCM\CMTrace.exe" "%1"' -Force

# Modify OEMDefaultAssociations.xml
$content = [xml](Get-Content -Path "$env:SystemDrive\Windows\System32\OEMDefaultAssociations.xml")
$logAssociation = $content.DefaultAssociations.Association | Where-Object {$_.Identifier -eq '.log'}
if ($logAssociation) {
    $logAssociation.ProgId = 'Log.File'
    $logAssociation.ApplicationName = 'Configuration Manager Trace Log Tool'
} else {
    $newAssociation = $content.CreateElement('Association')
    $newAssociation.SetAttribute('Identifier', '.log')
    $newAssociation.SetAttribute('ProgId', 'Log.File')
    $newAssociation.SetAttribute('ApplicationName', 'Configuration Manager Trace Log Tool')
    $content.DefaultAssociations.AppendChild($newAssociation)
}
$content.Save("$env:SystemDrive\Windows\System32\OEMDefaultAssociations.xml")

# Create Active Setup entry
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\CMtrace" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\CMtrace" -Name "Version" -Value 1 -Type String -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\CMtrace" -Name "StubPath" -Value 'reg.exe add HKCU\Software\Microsoft\Trace32 /v "Register File Types" /d 0 /f' -Type ExpandString -Force

# Set CMTrace as default program for .log files
$assocPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.log\UserChoice"
if (Test-Path $assocPath) {
    Remove-Item -Path $assocPath -Force
}
New-Item -Path $assocPath -Force | Out-Null
Set-ItemProperty -Path $assocPath -Name "ProgId" -Value "Log.File" -Force
