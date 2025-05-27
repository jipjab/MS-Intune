<#
.SYNOPSIS
    Remove Home Dev on Windows 11
    The detection script should check for the presence of Home Dev and return an exit code based on its findings. 

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 09/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)
#>

# Detection Script
$Path = "C:\Path\To\HomeDev" # Replace with the actual path
If (Test-Path -Path $Path) {
    Write-Host "Home Dev is installed"
    Exit 1  # Non-compliant, trigger remediation
} Else {
    Write-Host "Home Dev is not installed"
    Exit 0  # Compliant
}
