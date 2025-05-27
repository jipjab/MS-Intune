# Remediation script to uninstall Sophos Endpoint Agent if tamper protection is disabled

$SophosUninstallCli = "C:\Program Files\Sophos\Sophos Endpoint Agent\uninstallcli.exe"
$ExpectedAppName = "Sophos Endpoint Agent"

function Is-TamperProtectionEnabled {
    $regPath = "HKLM:\SOFTWARE\Sophos\Management\Policy\TamperProtection"
    $regValue = "Enabled"

    try {
        $value = Get-ItemProperty -Path $regPath -Name $regValue -ErrorAction Stop
        return $value.Enabled -eq 1
    } catch {
        # If key doesn't exist, assume not enabled
        return $false
    }
}

function Is-SophosInstalled {
    $installed = Get-WmiObject -Class Win32_Product | Where-Object {
        $_.Name -eq $ExpectedAppName
    }
    return $installed -ne $null
}

# Main logic
if (-not (Is-SophosInstalled)) {
    Write-Output "$ExpectedAppName is not installed."
    exit 0
}

if (Is-TamperProtectionEnabled) {
    Write-Error "Tamper Protection is enabled. Uninstallation cannot proceed."
    exit 1
}

if (Test-Path $SophosUninstallCli) {
    try {
        Start-Process -FilePath $SophosUninstallCli -ArgumentList "/quiet" -Wait -NoNewWindow
        Write-Output "Sophos Endpoint Agent uninstalled successfully."
        exit 0
    } catch {
        Write-Error "Failed to uninstall Sophos Endpoint Agent: $_"
        exit 1
    }
} else {
    Write-Error "Uninstall CLI not found at expected path: $SophosUninstallCli"
    exit 1
}
