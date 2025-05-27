<#
.SYNOPSIS
    Remove Home Dev on Windows 11
    The remediation script should remove Home Dev if it is detected by the detection script

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 09/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)
#>

# Remediation Script
$Path = "C:\Path\To\HomeDev" # Replace with the actual path
If (Test-Path -Path $Path) {
    Remove-Item -Path $Path -Recurse -Force
    Write-Host "Home Dev has been removed"
    Exit 0
} Else {
    Write-Host "Home Dev is not present"
    Exit 0
}
