<#
.SYNOPSIS
    Set Adobe as the default reader for PDF files
    This script checks for the presence of Adobe Acrobat first and sets it as the default if found; otherwise, it sets Adobe Reader as the default.

    The remediation script sets Adobe Acrobat or Adobe Reader as the default PDF application based on which one is installed.

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

# Function to set default PDF application
function Set-DefaultPDFApplication {
    param (
        [string]$progId
    )
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" -Name ProgId -Value $progId
}

# Check if Adobe Acrobat is installed
$acrobatInstalled = IsProgramInstalled "Adobe Acrobat"

# Check if Adobe Reader is installed
$readerInstalled = IsProgramInstalled "Adobe Reader"

# Remediate if necessary
if ($acrobatInstalled) {
    Set-DefaultPDFApplication -progId "Acrobat.Document.DC"
    Write-Output "Remediated: Set Adobe Acrobat as the default PDF application."
} elseif ($readerInstalled) {
    Set-DefaultPDFApplication -progId "AcroExch.Document.DC"
    Write-Output "Remediated: Set Adobe Reader as the default PDF application."
} else {
    Write-Output "Neither Adobe Acrobat nor Adobe Reader is installed."
}
