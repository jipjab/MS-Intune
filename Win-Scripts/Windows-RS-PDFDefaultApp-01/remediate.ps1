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

# Function to set default app associations
function Set-DefaultPDFReader {
    param (
        [string]$ProgId
    )
    
    $userChoicePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice"
    
    # Remove existing UserChoice key
    Remove-Item -Path $userChoicePath -Force -ErrorAction SilentlyContinue
    
    # Create new UserChoice key
    New-Item -Path $userChoicePath -Force | Out-Null
    
    # Set ProgId
    New-ItemProperty -Path $userChoicePath -Name "ProgId" -Value $ProgId -PropertyType String -Force | Out-Null
}

# Check if Adobe Reader is installed
$adobeReaderPath = "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
$adobeReaderInstalled = Test-Path $adobeReaderPath

# Check if Adobe Acrobat is installed
$adobeAcrobatPath = "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.exe"
$adobeAcrobatInstalled = Test-Path $adobeAcrobatPath

if ($adobeAcrobatInstalled) {
    Set-DefaultPDFReader -ProgId "Acrobat.Document.DC"
    Write-Output "Adobe Acrobat set as default PDF reader."
    Exit 0
} elseif ($adobeReaderInstalled) {
    Set-DefaultPDFReader -ProgId "AcroExch.Document.DC"
    Write-Output "Adobe Reader set as default PDF reader."
    Exit 0
} else {
    Write-Output "Neither Adobe Reader nor Adobe Acrobat is installed."
    Exit 1
}
