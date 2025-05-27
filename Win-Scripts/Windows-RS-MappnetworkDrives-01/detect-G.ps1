$driveLetter = "G:"
$networkPath = "\\10.0.20.240\travail"
$shortcutPath = "$env:USERPROFILE\Desktop\IT Network Drive.lnk"

if ((Test-Path $driveLetter) -and (Test-Path $shortcutPath)) {
    Write-Output "Compliant"
    Exit 0
} else {
    Write-Output "Not compliant"
    Exit 1
}
