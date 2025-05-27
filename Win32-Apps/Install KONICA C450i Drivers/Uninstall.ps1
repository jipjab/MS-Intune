<#
.SYNOPSIS
    Detect if $DriverName= "KONICA MINOLTA Universal PCL v3.9.4" is installed

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
#>

# Variables
$DriverName= "KONICA MINOLTA Universal PCL v3.9.4" #This must match the exact name of the Driver
$ScriptRoot = Split-Path -Path $MyInvocation.MyCommand.Path
$DriverPathLocation = "C:\Program Files\KONICA MINOLTA\Universal PCL6 x64 Multi-Lingual driver"
$DriverINF = "$DriverPathLocation\KOAX3J__.inf"

# Function to remove the driver
function RemoveKonicaDriver {
    pnputil /delete-driver $DriverINF
}

RemoveKonicaDriver