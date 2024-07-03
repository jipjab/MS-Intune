<#
.SYNOPSIS
    Install New MS teams

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
    
    Sources: https://learn.microsoft.com/fr-fr/microsoftteams/new-teams-bulk-install-client
    TeamsBootstrapper.exe: https://go.microsoft.com/fwlink/?linkid=2243204&clcid=0x409
    Teams MSIX x64: https://go.microsoft.com/fwlink/?linkid=2196106

#>

$msix = "$($PSScriptRoot)\MSTeams-x64.msix"
$destination = "C:\ProgramData\Microsoft\NEW-TEAMS-TEMP"
$exePath = "$($PSScriptRoot)\teamsbootstrapper.exe"

if(!(Test-Path $destination))
{
    mkdir $destination
}

Copy-Item -Path $msix -Destination $destination -Force

Start-Process -FilePath $exePath -ArgumentList "-p", "-o", "$($destination)\MSTeams-x64.msix" -Wait -WindowStyle Hidden