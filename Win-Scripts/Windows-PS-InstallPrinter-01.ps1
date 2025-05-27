<#
.SYNOPSIS
    Add Secure Printer

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 02/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)

    Wallpaper
    make Right Click like in Windows 10
#>

# Define the network path to the shared printer
$printerPath = "\\NYX\SECURE_PRINT"

# Add the network printer
(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($printerPath)

# Set it as the default printer
(New-Object -ComObject WScript.Network).SetDefaultPrinter($printerPath)
