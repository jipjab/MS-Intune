
<#
.SYNOPSIS
    Find and remove Classic Teams on Windows 11

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 03/07/2024
#>

# ===== Variables =====

#Script detects the new Microsoft Teams consumer app on Windows 11.

if ($null -eq (Get-AppxPackage -Name MicrosoftTeams)) {
	Write-Host "Microsoft Teams client not found"
	exit 0
} Else {
	Write-Host "Microsoft Teams client found"
    Write-Host "Removing Microsoft Teams"
    Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage -ErrorAction stop
	Exit 1
}