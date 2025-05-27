# Network Drive Mapping Script
# Maps network drives only if they don't already exist

# Network drive configuration
$drives = @{
    "G" = "\\10.0.20.240\travail"
    "I" = "\\10.0.20.240\WinEUR"
    "T" = "\\10.0.20.240\echanges"
}

# Credentials
$username = "sierra-mees\Maintenance"
$password = ConvertTo-SecureString "pass4MEES" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Map drives only if they don't exist
foreach ($drive in $drives.GetEnumerator()) {
    $driveLetter = $drive.Key
    $networkPath = $drive.Value

    # Check if drive is already mapped
    if (-not (Get-PSDrive -Name $driveLetter -ErrorAction SilentlyContinue)) {
        try {
            New-PSDrive -Name $driveLetter -PSProvider FileSystem -Root $networkPath -Credential $credential -Persist -Scope Global
            Write-Host "Mapped drive $driveLetter to $networkPath"
        }
        catch {
            Write-Host "Failed to map drive $driveLetter" -ForegroundColor Red
        }
    }
}