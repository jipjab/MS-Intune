<#
.SYNOPSIS
    installer une imprimante Secure Print

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
#>

# Specify the network printer path
$printerPath = "\\nyx\SECURE_PRINT"


# Create a Windows Script Host Network object
$network = New-Object -ComObject WScript.Network

try {
    # Add the network printer
    $network.AddWindowsPrinterConnection($printerPath)
    
    # Optionally, set the newly added printer as the default
    $network.SetDefaultPrinter($printerPath)
    
    Write-Host "Printer '$printerPath' has been successfully mapped."
} catch {
    Write-Host "Failed to map printer '$printerPath'. Error: $($_.Exception.Message)"
}

# Verify the printer was added
if (Get-Printer -Name $printerPath -ErrorAction SilentlyContinue) {
    Write-Host "Printer '$printerPath' is now available in the system."
} else {
    Write-Host "Printer '$printerPath' is not visible in the system. You may need to refresh or restart the print spooler."
}
