# Network Drive Mapping Script
# Maps network drives only if they don't already exist

# Network drive configuration
$drives = @{
    "S" = "\\10.0.20.250\Backup GED"
    "T" = "\\10.0.20.250\ri"
    "U" = "\\10.0.20.250\Echanges"
    "V" = "\\10.0.20.250\Suivi_equipements_2021"
}

# Credentials
$username = "compte-ser-smb"
$password = ConvertTo-SecureString "J4ffdaB0ss1122!" -AsPlainText -Force
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