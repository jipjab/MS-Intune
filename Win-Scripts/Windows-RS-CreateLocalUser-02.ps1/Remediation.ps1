# Remediation Script
$adminAccount = "admin-foj"
$adminGroupSID = "S-1-5-32-544" # Built-in Administrators group SID

try {
    # Get the actual group name based on the SID (works in any language)
    $adminGroup = Get-LocalGroup -SID $adminGroupSID
    
    # Check if the account exists locally
    $account = Get-LocalUser -Name $adminAccount -ErrorAction SilentlyContinue
    
    if (-not $account) {
        Write-Error "Account $adminAccount does not exist locally."
        exit 1
    }

    # Add the account to the administrators group
    Add-LocalGroupMember -Group $adminGroup.Name -Member $adminAccount -ErrorAction Stop
    Write-Host "Successfully added $adminAccount to local administrators group."
    exit 0
} catch {
    Write-Error "Failed to add $adminAccount to administrators group: $_"
    exit 1
}