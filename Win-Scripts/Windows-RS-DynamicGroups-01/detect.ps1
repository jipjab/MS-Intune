$installPath = "C:\Program Files\Sophos\Sophos Endpoint Agent"
$uninstallExe = Join-Path $installPath "SophosUninstall.exe"

if (Test-Path $uninstallExe) {
    Write-Output "Sophos Endpoint Agent détecté."
    exit 0  # Problème détecté, nécessite une remédiation
} else {
    Write-Output "Sophos Endpoint Agent non détecté."
    exit 1  # Aucun problème détecté
}
