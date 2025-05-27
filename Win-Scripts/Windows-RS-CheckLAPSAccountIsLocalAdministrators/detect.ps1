# Detection Script for local admin Account
$username = "admin-loc"
$adminGroupSid = "S-1-5-32-544"

try {
    # Check if user exists
    $userExists = (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) -ne $null
    
    if (-not $userExists) {
        Write-Output "User $username does not exist"
        exit 1
    }

    # Check if user is in Administrators group
    $userInGroup = Get-LocalGroupMember -SID $adminGroupSid | Where-Object { $_.Name -like "*$username*" }
    
    if (-not $userInGroup) {
        Write-Output "User $username is not in Administrators group"
        exit 1
    }

    # If user exists and is in Administrators group
    Write-Output "User $username exists and is a member of Administrators group"
    exit 0
}
catch {
    Write-Error "Detection script encountered an error: $_"
    exit 1
}