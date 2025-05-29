<#
.SYNOPSIS
.Removes bloat from a fresh Windows build
.DESCRIPTION
.Removes AppX Packages
.Disables Cortana
.Removes McAfee
.Removes HP Bloat
.Removes Dell Bloat
.Removes Lenovo Bloat
.Windows 10 and Windows 11 Compatible
.Removes any unwanted installed applications
.Removes unwanted services and tasks
.Removes Edge Surf Game
.Based on the script from Andrew Taylor : https://andrewstaylor.com/2022/08/09/removing-bloatware-from-windows-10-11-via-script/
.INPUTS
.OUTPUTS
C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Debloat\Debloat.log
.NOTES
  Version:        1.0
  Author:         Jean-Paul
  Creation Date:  29/05/2025

  Purpose/Change: Initial script development
  Change 29/05/2025 : Added the creation of the Debloat folder if it does not exist
  Change 29/05/2025 : Added the log folder path for storing logs under the official Intune Management Extension logs folder
  Change 29/05/2025 : Added the download of the RemoveBloat.ps1 script from GitHub
  Change 29/05/2025 : Added the execution of the RemoveBloat.ps1 script
  Change 29/05/2025 : Added the use of Invoke-WebRequest to download the script
  Change 29/05/2025 : Added the use of Invoke-Expression to execute the downloaded script
  Change 29/05/2025 : Added the use of Start-Sleep to wait for the folder creation
  Change 29/05/2025 : Added the use of Write-Output to log messages
  Change 29/05/2025 : Added the use of -UseBasicParsing to avoid issues with Invoke-WebRequest in non-interactive sessions

N/A
#>

$DebloatFolder = "%ProgramData%\Microsoft\IntuneManagementExtension\Logs\Debloat"
If (Test-Path $DebloatFolder) {
    Write-Output "$DebloatFolder exists. Skipping."
}
Else {
    Write-Output "The folder '$DebloatFolder' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$DebloatFolder" -ItemType Directory
    Write-Output "The folder $DebloatFolder was successfully created."
}

$templateFilePath = "C:\ProgramData\Debloat\removebloat.ps1"

Invoke-WebRequest `
-Uri "https://github.com/jipjab/MS-Intune/blob/main/Win-Scripts/Windows-PS-Debloater-01/RemoveBloat.ps1" `
-OutFile $templateFilePath `
-UseBasicParsing `
-Headers @{"Cache-Control"="no-cache"}

invoke-expression -Command $templateFilePath