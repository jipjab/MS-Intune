

# Get all local users
$users = Get-LocalUser

# Loop through each user
foreach ($user in $users) {
    # Check if the user is not "locadm"
    if ($user.Name -ne "locadm") {
        try {
            # Delete the user
            Remove-LocalUser -Name $user.Name
            Write-Host "Deleted user: $($user.Name)"
        } catch {
            Write-Host "Failed to delete user: $($user.Name). Error: $($_.Exception.Message)"
        }
    } else {
        Write-Host "Skipping user: $($user.Name)"
    }
}
