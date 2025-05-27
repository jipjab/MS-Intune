<#
.SYNOPSIS
    Set Adobe as the default reader for PDF files
    This script checks for the presence of Adobe Acrobat first and sets it as the default if found; otherwise, it sets Adobe Reader as the default.

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 14/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)
#>

# Check if Adobe Reader or Acrobat is the default PDF reader
$defaultPDFHandler = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice").ProgId

if ($defaultPDFHandler -like "Adobe.Acrobat*" -or $defaultPDFHandler -like "AcroExch.Document*") {
    Write-Output "Adobe is already the default PDF reader."
    Exit 0
} else {
    Write-Output "Adobe is not the default PDF reader."
    Exit 1
}
