<#
.SYNOPSIS
    Install Adobe CC & Acrobat

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
#>

# Path to the setup executable
$setupPath = "$PSScriptRoot\Setup.exe"

# Execute the setup with the silent switch
Start-Process -FilePath $setupPath -ArgumentList "--silent" -Wait
