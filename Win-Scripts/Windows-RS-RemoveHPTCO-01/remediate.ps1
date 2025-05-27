<#
.SYNOPSIS
    Detect and remove desktop shortcuts using Proactive Remediations in Microft Endpoint Manager. 
   
.DESCRIPTION
    Detect and remove desktop shortcuts using Proactive Remediations in Microft Endpoint Manager.
    Shortcuts on All Users desktop (public desktop) or the current user's desktop can be detected and removed.

.NOTES
    Filename: Remediation-DeleteShortcuts.ps1
    Version: 1.0
    Author: Martin Bengtsson
    Blog: www.imab.dk
    Twitter: @mwbengtsson

.LINK
    https://imab.dk/remove-desktop-shortcuts-for-the-current-user-and-public-profile-using-powershell-and-proactive-remediations   
#>

Remove-Item "C:\Users\%username%\OneDrive - FIPOI\Bureau\TCO Certified.lnk" -Force:$true