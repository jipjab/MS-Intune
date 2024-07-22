<#
.NOTES
    Version:        1.2
    Creation Date:  27/01/2023
    Author:         Mutuyimana Jean-Paul
.DESCRIPTION
	Windows autopilot company customization bootstrap
.FUNCTIONALITY
	Show Known file extentions
    USER Context
#>

############################################################################################

# Start logging
Start-Transcript "$($env:ProgramData)\Microsoft\Kyos\AutopilotShowKnowFileExtentions.log"

############################################################################################

Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0