<#
.SYNOPSIS
    Install Fonts on Windows

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana

    # Add fonts on a windows machine
    Run the Instal.cmd:
    this will copy all the fonts in C:\ProgramData\InstallFonts
    if C:\ProgramData\InstallFonts does not exist it will be created
#>
if (!(Test-Path "C:\ProgramData\InstallFonts")) {
    New-Item -Path C:\ProgramData\InstallFonts -ItemType Directory
}
Start-Transcript -Path "C:\ProgramData\InstallFonts\Installfonts.log"
$FontstoInstall = Get-ChildItem -Path C:\ProgramData\InstallFonts\ | Where-Object Name -Like "*.ttf"
foreach ($FontFile in $FontstoInstall){
    try{
        Write-Output "Font file '$($FontFile.Name)' passed as argument"
        Write-Output "Copying item to: '$("$env:windir\Fonts\$($FontFile.Name)")'"
        Copy-Item -Path "C:\ProgramData\InstallFonts\$($FontFile.Name)" -Destination "$env:windir\Fonts" -Force -PassThru -ErrorAction Stop
        Write-Output "Creating item: "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts\$($FontFile.Name)""
        New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts' -Name $($FontFile.Name) -PropertyType String -Value $($FontFile.Name) -Force
    }catch{
        Write-Error $_
    }
}
Stop-Transcript