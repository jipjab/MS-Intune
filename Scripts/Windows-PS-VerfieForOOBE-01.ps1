<#
.SYNOPSIS
    Verifie si le script ou l'application s'install durant l'ESP (OOBE)

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 03/07/2024

    Author: Mutuyimana Jean-Paul (Kyos).
    source: https://github.com/stevecapacity/intuneToast/blob/main/requirement.ps1
#>
$process = Get-Process -Name SecurityHealthsystray -ErrorAction SilentlyContinue

# If process is not found, we're not in OOBE (Out-of-Box-Experience)
if($process -ne $null)
{
  Write-Output "not-OOBE"
  exit 0
}
else
{
  # If process IS null, we are in OOBE
  Write-Output "OOBE"
  exit 0
}
 