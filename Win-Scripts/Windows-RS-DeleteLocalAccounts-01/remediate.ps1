# Define a list of accounts to exclude
$excludedUsers = @('locadm', 'Administrator', 'Guest')

# Get all active local user accounts
$localUsers = Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount=True AND Disabled=False"

# Iterate over each user account
foreach ($user in $localUsers) {
    # Check if the username is not in the excluded list
    if ($excludedUsers -notcontains $user.Name) {
        # Delete the user account
        try {
            Remove-LocalUser -Name $user.Name -ErrorAction Stop
            Write-Host "Deleted active user: $($user.Name)"
        } catch {
            Write-Host "Failed to delete user: $($user.Name). Error: $($_.Exception.Message)"
        }
    }
}
