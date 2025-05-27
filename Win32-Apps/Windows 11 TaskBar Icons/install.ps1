<#
.SYNOPSIS
    Set the default taskbar Layout for Windows 11

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 02/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)
#>

# Create a tag file just so Intune knows this was installed
# C:\ProgramData\Microsoft\KYOS
if (-not (Test-Path "$($env:ProgramData)\Microsoft\KYOS"))
{
    Mkdir "$($env:ProgramData)\Microsoft\KYOS"
}
Set-Content -Path "$($env:ProgramData)\Microsoft\KYOS\KYOS_Win11TaskBarIcons.ps1.tag" -Value "Installed"

#>

# Import the Start Layout
Import-StartLayout -LayoutPath "$PSScriptRoot\taskbar_layout.xml" -MountPath $env:SystemDrive\
