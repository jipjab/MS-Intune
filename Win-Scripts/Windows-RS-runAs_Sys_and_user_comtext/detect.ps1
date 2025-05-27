

# 1. First, check if the HKLM keys already exist (to avoid unnecessary remediation)
#    Si les 2 clès ci-dessous existent alors la correction a deja ete faite, peut-etre manueleument ou par un autre script.
#    - HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\SharePointOnPremPrioritization
#    - HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\SharePointOnPremFrontDoorUrl
# 2. Now we start checking if "Accounts" exists in HKCU by listing all user SIDs on the system
# 3. Loop through each user SID and check for the OneDrive users key
#    3.a. Load the user's registry hive if not already loaded
#    3.b. Check for OneDrive users key
#    3.c. Unload hive if we loaded it (for users who are not logged in)



# 1. First, check if the HKLM keys already exist (to avoid unnecessary remediation)
$spPrioritizationPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\SharePointOnPremPrioritization"
$spFrontDoorPath = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\SharePointOnPremFrontDoorUrl"

if ((Test-Path -Path $spPrioritizationPath) -or (Test-Path -Path $spFrontDoorPath)) {
    Write-Host "SharePoint policy keys already exist in HKLM. No remediation needed."
    exit 1 # No remediation needed
}

# 2. Now we start checking if "Accounts" exists in HKCU by listing all user SIDs on the system
$userSIDs = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" | 
            Where-Object { $_.PSChildName -match 'S-1-5-21-\d+-\d+-\d+-\d+$' } | 
            Select-Object -ExpandProperty PSChildName

$oneDriveUserKeyFound = $false

# 3. Loop through each user SID and check for the OneDrive users key
foreach ($sid in $userSIDs) {
    $userHive = "HKU:\$sid"
    
    # 3.a. Load the user's registry hive if not already loaded. Necessary to access HKU keys for users who are not logged on the machine.
    # When a user logs into Windows, the system automatically loads their personal registry settings (stored in the NTUSER.DAT file) into the HKEY_USERS section of the registry under their unique Security Identifier (SID). 
    # This makes their settings accessible while they're logged in.
    if (-not (Test-Path $userHive)) {
        try {
            # Use reg load to temporarily mount the hive
            $userProfilePath = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$sid").ProfileImagePath
            $userRegPath = Join-Path $userProfilePath "NTUSER.DAT"
            
            if (Test-Path $userRegPath) {
                # Create HKU drive if it doesn't exist
                if (-not (Get-PSDrive -Name HKU -ErrorAction SilentlyContinue)) {
                    New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
                }
                
                # Load the hive
                $null = & reg load "HKU\$sid" $userRegPath
                $hiveLoaded = $true
            }
        } catch {
            Write-Host "Could not load registry hive for SID $sid : $_"
            continue
        }
    }
    
    # 3.b. Check for OneDrive users key
    $oneDrivePath = "HKU:\$sid\SOFTWARE\Microsoft\OneDrive\Accounts\"
    if (Test-Path -Path $oneDrivePath) {
        $oneDriveUserKeyFound = $true
        Write-Host "Accounts registry found."
        
        # Unload hive if we loaded it
        if ($hiveLoaded) {
            try {
                # Force garbage collection and release file handles
                [gc]::Collect()
                [gc]::WaitForPendingFinalizers()
                
                # Unload the hive
                $null = & reg unload "HKU\$sid"
            } catch {
                Write-Host "Could not unload registry hive for SID $sid : $_"
            }
        }
        
        break
    }
    
    # 3.c. Unload hive if we loaded it
    if ($hiveLoaded) {
        try {
            # Force garbage collection and release file handles
            [gc]::Collect()
            [gc]::WaitForPendingFinalizers()
            
            # Unload the hive
            $null = & reg unload "HKU\$sid"
        } catch {
            Write-Host "Could not unload registry hive for SID $sid : $_"
        }
    }
}

if ($oneDriveUserKeyFound) {
    # At least one user has the OneDrive key, no remediation needed
    Write-Host "OneDrive Account registry key found for a user. Remediation needed."
    exit 1
} else {
    # No users have the OneDrive key, remediation needed
    Write-Host "OneDrive Account registry key not found for any user. Remediation NOT needed."
    exit 0
}