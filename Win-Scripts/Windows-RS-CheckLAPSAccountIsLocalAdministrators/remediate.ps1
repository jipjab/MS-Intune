# Remediation Script for local admin Account Management
$username = "admin-loc"
$adminGroupSid = "S-1-5-32-544"

# Function to generate a random 16-character password
function Generate-RandomPassword {
    $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+'
    $password = -join ($chars | Get-Random -Count 16)
    return $password
}

try {
    # Create user if not exists
    $userExists = (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) -ne $null
    
    if (-not $userExists) {
        # Generate a random 16-character password
        $randomPassword = Generate-RandomPassword
        $securePassword = ConvertTo-SecureString -String $randomPassword -AsPlainText -Force
        
        # Create user with the random password
        New-LocalUser -Name $username -Password $securePassword -PasswordNeverExpires:$true -ErrorAction Stop
        
        Write-Output "User $username created successfully"
    }

    # Add user to Administrators group
    $userInGroup = Get-LocalGroupMember -SID $adminGroupSid | Where-Object { $_.Name -like "*$username*" }
    
    if (-not $userInGroup) {
        Add-LocalGroupMember -SID $adminGroupSid -Member $username -ErrorAction Stop
        Write-Output "User $username added to Administrators group"
    }

    exit 0
}
catch {
    Write-Error "Remediation script encountered an error: $_"
    exit 1
}