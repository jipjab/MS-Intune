$AntidoteVersions = [ordered]@{
    'RX'                   = '{A474EA56-5DBD-4181-8230-806A4762EA7F}'
    'HD'                   = '{56CDB4FE-895F-4E0D-8BB4-9A8D4310898D}'
    '8'                    = '{09AAAB09-6DBA-4DD9-9865-54597D3FBCA8}'
    '9'                    = '{BFA17B4C-70D3-480F-8476-76197F614AB6}'
    '9 - Module Français'  = '{BFA17B4C-70D3-480F-8476-76197F614AB7}'
    '9 - English Module'   = '{BFA17B4C-70D3-480F-8476-76197F614AB8}'
    '10'                   = '{134E0741-C569-4E8C-A7FC-7F95B14CAAB1}'
    '10 - Module Français' = '{134E0741-C569-4E8C-A7FC-7F95B14CAAB2}'
    '10 - English Module'  = '{134E0741-C569-4E8C-A7FC-7F95B14CAAB3}'
    '10 - Connectix'       = '{134E0741-C569-4E8C-A7FC-7F95B14CAAB4}'
}

$Installer = New-Object -ComObject WindowsInstaller.Installer

foreach ($Version in $AntidoteVersions.GetEnumerator()) {
    $InstalledProducts = $Installer.ProductsEx($Version.Value, '', 7)
    if ( $InstalledProducts.Count() -gt 0 ) {
        Write-Host "Antidote $($Version.Key)"
        exit 0
    }
}

exit 1