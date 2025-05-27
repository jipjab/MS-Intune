# Detection Script
$adminAccount = "admin-foj"
$adminGroupSID = "S-1-5-32-544" # Built-in Administrators group SID

# Get the actual group name based on the SID (works in any language)
$adminGroup = Get-LocalGroup -SID $adminGroupSID

# Check if the account is a member of the local administrators group
$isAdmin = Get-LocalGroupMember -Group $adminGroup.Name | Where-Object {$_.Name -like "*\$adminAccount"}

if ($isAdmin) {
    Write-Host "Account $adminAccount is already a member of local administrators group."
    exit 0  # Compliant
} else {
    Write-Host "Account $adminAccount is NOT a member of local administrators group."
    exit 1  # Non-compliant
}