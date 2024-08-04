<#
.SYNOPSIS
    Change Current user language to CH

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 02/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)

    Wallpaper
    make Right Click like in Windows 10
#>
<#
# Create a tag file just so Intune knows this was installed
if (-not (Test-Path "$($env:ProgramData)\Microsoft\KYOS"))
{
    Mkdir "$($env:ProgramData)\Microsoft\KYOS"
}
Set-Content -Path "$($env:ProgramData)\Microsoft\KYOS\KYOS_Win11fr-CH.ps1.tag" -Value "Installed"
#>
# Get the current system culture
$currentUserLanguage = Get-WinUserLanguageList

# Check if the current culture is fr-CH
if ($currentUserLanguage.Name -eq "fr-CH") {
    Write-Host "fr-CH is already the default system language."
} else {
    try {
        # Attempt to set fr-CH as the default system language
        Set-WinSystemLocale -SystemLocale fr-CH

        Write-Host "Successfully set fr-CH as the default system language."
        Write-Host "Please restart your computer for the changes to take effect."
    } catch {
        Write-Host "An error occurred while trying to set fr-CH as the default system language:"
        Write-Host $_.Exception.Message
    }
}
