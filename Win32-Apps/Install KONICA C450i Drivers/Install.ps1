<#
.SYNOPSIS
    Detect if $DriverName= "KONICA MINOLTA Universal PCL v3.9.4" is installed

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
#>

# Variables
$DriverName= "KONICA MINOLTA Universal PCL v3.9.4" #This must match the exact name of the Driver
# $ScriptRoot = Split-Path -Path $MyInvocation.MyCommand.Path
$DriverPathLocation = "C:\Program Files\KONICA MINOLTA\"
# Full path of the INF file
$DriverINF = "C:\Program Files\KONICA MINOLTA\Universal PCL6 x64 Multi-Lingual driver\KOAX3J__.inf"


#If the file does not exist, create it.
if (-not(Test-Path -Path $DriverINF -PathType Leaf)) {
    try {
        $null = New-Item -ItemType File -Path $DriverINF -Force -ErrorAction Stop
        # Create Driver Folder Location
        New-Item -ItemType Directory -Path "C:\Program Files\KONICA MINOLTA"
        
        # copy the drivers folder to the program files
        Copy-Item -Path "$PSScriptRoot\Universal PCL6 x64 Multi-Lingual driver" -Destination $DriverPathLocation -Recurse
        Write-Host "The file [$DriverINF] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
}
# If the file already exists, show the message and do nothing.
else {
    Write-Host "Cannot create [$file] because a file with that name already exists."
}

#If the driver is not installed, install it.
$InstalledPrinterDrivers = Get-PrinterDriver

If ($InstalledPrinterDrivers.name -contains $DriverName){
    write-Host $DriverName Found
} else {
    write-Host $DriverName NOT Found
    pnputil /add-driver "C:\Program Files\KONICA MINOLTA\Universal PCL6 x64 Multi-Lingual driver\KOAX3J__.inf" /install
    Add-PrinterDriver -Name "KONICA MINOLTA Universal PCL v3.9.4" -Verbose 
}