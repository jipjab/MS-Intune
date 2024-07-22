<#
.SYNOPSIS
    Verifie si le script ou l'application s'install durant l'ESP (OOBE)

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
Set-Content -Path "$($env:ProgramData)\Microsoft\KYOS\KYOS_Win11Settings.ps1.tag" -Value "Installed"

# Start logging
Start-Transcript "$($env:ProgramData)\Microsoft\KYOS\KYOS_Win11Settings.log"


# Don't let Edge create a desktop shortcut (roams to OneDrive, creates mess)
Log "Turning off (old) Edge desktop shortcut"
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v DisableEdgeDesktopShortcutCreation /t REG_DWORD /d 1 /f /reg:64 | Out-Host


New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS

$user = (Get-WmiObject -Class Win32_ComputerSystem | Select-Object Username).Username
$sid = (New-Object System.Security.Principal.NTAccount($user)).Translate([System.Security.Principal.SecurityIdentifier]).Value
$userRegPath = "HKU\$($sid)\SOFTWARE"

# # Configure background
Log "copie the background image to C:\Windows\Web\Wallpaper"
$installFolder = "$PSScriptRoot\"
Copy-Item -Path "$($installFolder)\Autopilot.jpeg" -Destination "C:\Windows\Web\Wallpaper" -Force

Log "Setting up Autopilot theme"
Mkdir "C:\Windows\Resources\OEM Themes" -Force | Out-Null
Copy-Item "$installFolder\Autopilot.theme" "C:\Windows\Resources\OEM Themes\Autopilot.theme" -Force
Mkdir "C:\Windows\web\wallpaper\Autopilot" -Force | Out-Null
Copy-Item "$installFolder\Autopilot.jpg" "C:\Windows\web\wallpaper\Autopilot\Autopilot.jpg" -Force
Log "Setting Autopilot theme as the new user default"
reg.exe load HKLM\TempUser "C:\Users\Default\NTUSER.DAT" | Out-Host
reg.exe add "HKLM\TempUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v InstallTheme /t REG_EXPAND_SZ /d "%SystemRoot%\resources\OEM Themes\Autopilot.theme" /f | Out-Host
reg.exe add "HKLM\TempUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f | Out-Host
reg.exe add "HKLM\TempUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V AutoCheckSelect /T REG_DWORD /D 0 /F | Out-Host
reg.exe add "HKLM\TempUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V TaskbarAl /T REG_DWORD /D 0 /F | Out-Host
reg.exe add "HKLM\TempUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f | Out-Host
reg.exe add "HKLM\TempUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f | Out-Host
reg.exe add "HKLM\TempUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAl" /t REG_DWORD /d 0 /f | Out-Host
reg.exe unload HKLM\TempUser | Out-Host


# make Right Click like in Windows 10 
reg.exe add "$($userRegPath)\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve /reg:64 | Out-Host


Stop-Process -Name explorer -Force