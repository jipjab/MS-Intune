<#
.SYNOPSIS
    Install CMTrace for reading windows logs easily

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana

    This script copy CMTrace to C:\Windows\

    Source: https://www.microsoft.com/en-us/evalcenter/download-microsoft-endpoint-configuration-manager 
    and extract it to a folder using 7Zip or WinRAR.
    mtrace can be found under SMSSETUP\TOOLS 

    Detect: C:\Windows\CMTrace.exe
#>

Copy-Item “$($PSScriptRoot)\CMTrace.exe” -Destination C:\Windows\CMTrace.exe -Force