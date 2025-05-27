# Detection Script (DriveDetectionScript.ps1)
$driveLetter = "T"
$networkPath = "\\10.0.20.240\echanges"

# Check if the drive is mapped
$mappedDrive = Get-PSDrive -Name $driveLetter -ErrorAction SilentlyContinue

if ($mappedDrive -and $mappedDrive.DisplayRoot -eq $networkPath) {
    # Drive exists and is mapped to the correct path
    Write-Output "Compliant"
    exit 0
} else {
    # Drive is not mapped or mapped incorrectly
    Write-Output "Non-Compliant"
    exit 1
}

