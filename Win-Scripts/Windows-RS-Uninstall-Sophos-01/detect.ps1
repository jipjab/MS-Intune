# Detect if "Sophos Endpoint Agent" is installed

$installed = Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -eq "Sophos Endpoint Agent"
}

if ($installed) {
    Write-Output "Sophos Endpoint Agent is installed."
    exit 1
} else {
    Write-Output "Sophos Endpoint Agent is not installed."
    exit 0
}
