# Define a list of accounts to exclude
$excludedUsers = @('locadm', 'Administrator', 'Guest')

# Get all active local user accounts
$localUsers = Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount=True AND Disabled=False"

# Initialize a flag to indicate if remediation is needed
$remediationNeeded = $false

# Iterate over each user account
foreach ($user in $localUsers) {
    # Check if the username is not in the excluded list
    if ($excludedUsers -notcontains $user.Name) {
        Write-Host "Found non-excluded active user: $($user.Name)"
        $remediationNeeded = $true
    }
}

# Exit with code 1 if remediation is needed, otherwise 0
if ($remediationNeeded) {
    exit 1
} else {
    exit 0
}
