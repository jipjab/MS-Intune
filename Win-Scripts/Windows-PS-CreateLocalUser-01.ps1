<#
.SYNOPSIS
    Create a windows local user with a random password. The password is then changed by LAPS

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana

#>

# Generate random password
$password = -join ((33..126) | Get-Random -Count 16 | % {[char]$_})
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Create new local admin account
$userName = "admin-foj"
New-LocalUser -Name $userName -Password $securePassword -FullName "admin" -Description "Admin FOJ"
Add-LocalGroupMember -Group "Administrators" -Member $userName

# Set account properties
$user = [ADSI]"WinNT://$env:COMPUTERNAME/$userName,user"
$user.UserFlags = 65536 # ADS_UF_DONT_EXPIRE_PASSWD
$user.SetInfo()

# Output the password (for one-time use)
Write-Host "Username: $userName"
Write-Host "Password: $password"
