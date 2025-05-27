# Intune Remediation Script for locadm account

function Get-LocalizedAdministratorsGroupName {
    $sid = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $group = $sid.Translate([System.Security.Principal.NTAccount])
    return $group.Value.Split('\')[1]
}

$adminGroupName = Get-LocalizedAdministratorsGroupName
$accountName = "admin-loc"

try {
    $userExists = Get-LocalUser -Name $accountName -ErrorAction SilentlyContinue
    if (-not $userExists) {
        # Create the account with a random password
        $password = [System.Web.Security.Membership]::GeneratePassword(16, 3)
        $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
        New-LocalUser -Name $accountName -Password $securePassword -PasswordNeverExpires
        Write-Host "Created new local account: $accountName"
    }

    # Add the account to the Administrators group
    Add-LocalGroupMember -Group $adminGroupName -Member $accountName -ErrorAction SilentlyContinue
    Write-Host "Added $accountName to the $adminGroupName group"

    exit 0
}
catch {
    Write-Host "Error occurred: $_"
    exit 1
}
