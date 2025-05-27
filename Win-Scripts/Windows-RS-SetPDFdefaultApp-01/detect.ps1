<#
.SYNOPSIS
    Set Adobe as the default reader for PDF files
    This script checks for the presence of Adobe Acrobat first and sets it as the default if found; otherwise, it sets Adobe Reader as the default.

    The detection script checks whether the default PDF application is set to either Adobe Acrobat or Adobe Reader.

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 09/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)
#>

# Function to get current default PDF application
function Get-DefaultPDFApplication {
    try {
        $currentDefault = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" -Name ProgId
        return $currentDefault
    } catch {
        return $null
    }
}

# Check current default PDF application
$currentDefault = Get-DefaultPDFApplication

# Output result for detection
if ($currentDefault -eq "Acrobat.Document.DC" -or $currentDefault -eq "AcroExch.Document.DC") {
    # Exit code 0 means compliant
    exit 0
} else {
    # Exit code 1 means non-compliant
    exit 1
}
