# Intune Detection Script for locadm account

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
        Write-Host "Account does not exist"
        exit 1
    }

    $groupMembers = net localgroup $adminGroupName | Where-Object {$_ -and $_ -notmatch "command completed successfully"} | Select-Object -Skip 4
    if ($groupMembers -contains $accountName) {
        Write-Host "Account exists and is in Administrators group"
        exit 0
    } else {
        Write-Host "Account exists but is not in Administrators group"
        exit 1
    }
}
catch {
    Write-Host "Error occurred: $_"
    exit 1
}
