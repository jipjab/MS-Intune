<#
.NOTES
    Version:        1.2
    Creation Date:  27/01/2023
    Author:         Mutuyimana Jean-Paul
.DESCRIPTION
	Windows autopilot company customization bootstrap
.FUNCTIONALITY
	Remove FAX
    USER Context
#>

############################################################################################

# Start logging
Start-Transcript "$($env:ProgramData)\Microsoft\Kyos\RmoveFax.log"

############################################################################################

Remove-Printer -Name "fax"