<#
.SYNOPSIS
    Install Abacus

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
#>

$exeSource = "$($PSScriptRoot)\SignAgent.exe"
$destination = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"

if(!(Test-Path $destination))
{
    mkdir $destination
}

Copy-Item -Path $exeSource -Destination $destination -Force