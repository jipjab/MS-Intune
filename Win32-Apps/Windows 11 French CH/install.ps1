<#
.SYNOPSIS
    Add French Suiss language pack

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 17/07/2024

    Author: Mutuyimana Jean-Paul (Kyos)

    Wallpaper
    make Right Click like in Windows 10
#>
function Log() {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$false)] [String] $message
	)

	$ts = get-date -f "yyyy/MM/dd hh:mm:ss tt"
	Write-Output "$ts $message"
}

# If we are running as a 32-bit process on an x64 system, re-launch as a 64-bit process
if ("$env:PROCESSOR_ARCHITEW6432" -ne "ARM64")
{
    if (Test-Path "$($env:WINDIR)\SysNative\WindowsPowerShell\v1.0\powershell.exe")
    {
        & "$($env:WINDIR)\SysNative\WindowsPowerShell\v1.0\powershell.exe" -ExecutionPolicy bypass -NoProfile -File "$PSCommandPath"
        Exit $lastexitcode
    }
}

# Create a tag file just so Intune knows this was installed
if (-not (Test-Path "$($env:ProgramData)\Microsoft\KYOS"))
{
    Mkdir "$($env:ProgramData)\Microsoft\KYOS"
}
Set-Content -Path "$($env:ProgramData)\Microsoft\KYOS\KYOS_Win11FrenchLang.ps1.tag" -Value "Installed"

# Start logging
Start-Transcript "$($env:ProgramData)\Microsoft\KYOS\KYOS_Win11FrenchLang.log"


$installFolder = "$PSScriptRoot\"

Dism /online /Add-Package /PackagePath:$($installFolder)languageFiles\Microsoft-Windows-Client-Language-Pack_x64_fr-fr.cab /NoRestart
Dism /online /Add-Package /PackagePath:$($installFolder)languageFiles\Microsoft-Windows-LanguageFeatures-Basic-fr-ch-Package~31bf3856ad364e35~amd64~~.cab /NoRestart
Dism /online /Add-Package /PackagePath:$($installFolder)languageFiles\Microsoft-Windows-LanguageFeatures-OCR-fr-fr-Package~31bf3856ad364e35~amd64~~.cab /NoRestart

# Set the system locale
Set-WinSystemLocale fr-CH

# Set the user language list
Set-WinUserLanguageList fr-CH -Force

# Set the default input method
Set-WinDefaultInputMethodOverride -InputTip "fr-CH:100C:0000100C"

Set-SystemPreferredUILanguage -Language fr-CH


# Set-WinDefaultInputMethodOverride -InputTip "fr-CH:100C:0000100C"
# French (Switzerland) 	fr-CH: Swiss French keyboard (100C:0000100C) de-CH: Swiss German keyboard (0807:00000807)