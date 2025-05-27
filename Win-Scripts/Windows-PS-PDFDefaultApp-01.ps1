<#
.SYNOPSIS
    Set Adobe as the default reader for PDF files
    This script checks for the presence of Adobe Acrobat first and sets it as the default if found; otherwise, it sets Adobe Reader as the default.

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 09/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)
#>

# Function to check if a program is installed
function IsProgramInstalled {
    param (
        [string]$programName
    )
    $programs = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%$programName%'"
    return $programs.Count -gt 0
}

# Check if Adobe Acrobat is installed
$acrobatInstalled = IsProgramInstalled "Adobe Acrobat"

# Check if Adobe Reader is installed
$readerInstalled = IsProgramInstalled "Adobe Reader"

# Set default PDF application based on installation
if ($acrobatInstalled) {
    # Set Adobe Acrobat as default PDF handler
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" -Name ProgId -Value "Acrobat.Document.DC"
    Write-Output "Adobe Acrobat is set as the default PDF application."
} elseif ($readerInstalled) {
    # Set Adobe Reader as default PDF handler
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" -Name ProgId -Value "AcroExch.Document.DC"
    Write-Output "Adobe Reader is set as the default PDF application."
} else {
    Write-Output "Neither Adobe Acrobat nor Adobe Reader is installed."
}
