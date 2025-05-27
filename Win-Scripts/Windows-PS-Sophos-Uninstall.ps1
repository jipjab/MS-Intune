# Sophos Endpoint Agent Silent Uninstall Script
$SophosUninstallPath = "C:\Program Files\Sophos\Sophos Endpoint Agent\SophosUninstall.exe"

if (Test-Path $SophosUninstallPath) {
    Write-Output "Sophos Endpoint Agent found. Initiating silent uninstall..."
    Start-Process -FilePath $SophosUninstallPath -ArgumentList "--quiet" -Wait
    Write-Output "Uninstall process completed."
} else {
    Write-Output "Sophos Endpoint Agent not found on this device."
}
