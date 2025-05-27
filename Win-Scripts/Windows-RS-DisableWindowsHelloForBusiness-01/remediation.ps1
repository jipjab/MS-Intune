# Delete the Windows Hello for Business container
certutil.exe -deleteHelloContainer

# Disable Windows Hello for Business via registry
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork" -Name "Enabled" -Type DWord -Value 0

# Optional: Disable convenience PIN sign-in
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "AllowDomainPINLogon" -Type DWord -Value 0
