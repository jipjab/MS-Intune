<#
.SYNOPSIS
    Install Adobe CC & Acrobat

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
#>

# Set the path to the MSI installer using $PSScriptRoot
$msiPath = Join-Path $PSScriptRoot "Adobe CC and Acrobat.msi"

# Check if the MSI file exists
if (Test-Path $msiPath) {
    # Install Adobe Creative Cloud silently
    try {
        Start-Process msiexec.exe -ArgumentList "/i `"$msiPath`" /qn" -Wait -NoNewWindow -ErrorAction Stop
        Write-Host "Adobe Creative Cloud installed successfully."
    }
    catch {
        Write-Host "Installation failed. Error: $_"
    }
}
else {
    Write-Host "MSI installer not found at: $msiPath"
}
