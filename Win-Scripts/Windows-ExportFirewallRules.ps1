# Get all firewall rules
$allRules = Get-NetFirewallRule

# Filter out default Windows rules
$customRules = $allRules | Where-Object {
    $_.DisplayName -notlike "@FirewallAPI.dll*" -and
    $_.DisplayName -notlike "Core Networking*" -and
    $_.DisplayName -notlike "Windows Defender*" -and
    $_.DisplayName -notlike "Microsoft Store*" -and
    $_.DisplayName -notlike "Cortana*" -and
    $_.DisplayName -notlike "Windows Remote Management*"
}

# Create an array to store simplified rule details
$exportRules = @()

foreach ($rule in $customRules) {
    # Get associated filters
    $portFilter = $rule | Get-NetFirewallPortFilter
    $addressFilter = $rule | Get-NetFirewallAddressFilter
    $applicationFilter = $rule | Get-NetFirewallApplicationFilter

    # Create custom object with Intune-relevant properties
    $ruleDetails = [PSCustomObject]@{
        DisplayName = $rule.DisplayName
        Description = $rule.Description
        Direction = $rule.Direction
        Action = if ($rule.Action -eq "Allow") {"Allowed"} else {"Blocked"}
        Profile = $rule.Profile
        LocalPorts = if ($portFilter.LocalPort) {$portFilter.LocalPort -join ','} else {"Any"}
        RemotePorts = if ($portFilter.RemotePort) {$portFilter.RemotePort -join ','} else {"Any"}
        Protocol = switch ($portFilter.Protocol) {
            "TCP" {"TCP"}
            "UDP" {"UDP"}
            "Any" {"Any"}
            default {"Any"}
        }
        LocalAddresses = if ($addressFilter.LocalAddress -eq "*") {"Any"} else {$addressFilter.LocalAddress -join ','}
        RemoteAddresses = if ($addressFilter.RemoteAddress -eq "*") {"Any"} else {$addressFilter.RemoteAddress -join ','}
        ApplicationPath = $applicationFilter.Program
        ApplicationPackageFamilyName = $applicationFilter.Package
        Service = $applicationFilter.ServiceName
    }

    $exportRules += $ruleDetails
}

# Export to CSV format for easy viewing and manual entry
$exportRules | Export-Csv -Path "IntuneFirewallRules.csv" -NoTypeInformation

# Display summary
Write-Host "Exported $($exportRules.Count) custom firewall rules to IntuneFirewallRules.csv"
Write-Host "You can now use this CSV as a reference to create rules in Intune Endpoint Security > Firewall policy"