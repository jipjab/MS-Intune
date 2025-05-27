<#
.SYNOPSIS
    Detect and remove desktop shortcuts using Proactive Remediations in Microft Endpoint Manager. 
   
.DESCRIPTION
    Detect and remove desktop shortcuts using Proactive Remediations in Microft Endpoint Manager.
    Shortcuts on All Users desktop (public desktop) or the current user's desktop can be detected and removed.

.NOTES
    Filename: Detection-DeleteShortcuts.ps1
    Version: 1.0
    Author: Jean-Paul Mutuyimana
#>

if (Test-Path -Path "C:\Users\%username%\OneDrive - FIPOI\Bureau\TCO Certified.lnk") {
    write-Host Found shortcut
    exit 1
 }
 Else {
    Write-Host Shortcut not found
    exit 0
 }