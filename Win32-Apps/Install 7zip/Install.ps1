<#
.SYNOPSIS
    Install 7zip

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana

    # DETECTION RULE
    # Rule type: File
    # Path: C:\Program Files\7-Zip\
    # File or Folder: 7zG.exe
    # Detection methode: File or Folder exists
    # Associate with Win32 app: No
#>

msiexec /i "$($PSScriptRoot)\7z2407-x64.msi" /qn