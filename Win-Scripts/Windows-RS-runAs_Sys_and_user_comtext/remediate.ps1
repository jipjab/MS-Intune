$policiesPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"

# Create the registry keys in HKLM
Write-Host "Creating required registry keys in HKLM..."

# Ensure the Policies\Microsoft path exists in HKLM
if (-not (Test-Path -Path $policiesPath)) {
    try {
        New-Item -Path $policiesPath -Force | Out-Null
        Write-Host "Created Microsoft Policies registry path in HKLM."
    } catch {
        Write-Error "Failed to create Microsoft Policies registry path in HKLM: $_"
        exit 1
    }
}

# Create the first registry key: SharePointOnPremPrioritization in HKLM
try {
    New-ItemProperty -Path $policiesPath -Name "SharePointOnPremPrioritization" `
        -PropertyType String -Value "https://intranet.foj.ch" -Force | Out-Null
    Write-Host "Created SharePointOnPremPrioritization registry key in HKLM."
} catch {
    Write-Error "Failed to create SharePointOnPremPrioritization registry key in HKLM: $_"
    exit 1
}

# Create the second registry key: SharePointOnPremFrontDoorUrl in HKLM
try {
    New-ItemProperty -Path $policiesPath -Name "SharePointOnPremFrontDoorUrl" `
        -PropertyType DWord -Value 1 -Force | Out-Null
    Write-Host "Created SharePointOnPremFrontDoorUrl registry key in HKLM."
} catch {
    Write-Error "Failed to create SharePointOnPremFrontDoorUrl registry key in HKLM: $_"
    exit 1
}

Write-Host "Registry keys created successfully in HKLM."
exit 0 # Exit successfully