$ATVersions = [ordered]@{
    'v6.71.0'  = '{93154A3C-9BB7-49D7-A571-4EB6373FA602}'
    'v6.70.0'  = '{93154A3C-9BB7-49D7-A571-4EB6373FA601}'
    'v6.1.0'   = '{93154A3C-9BB7-49D7-A571-4EB6373FA600}'
    'v5.65.15' = '{92154A3C-9BB7-49D7-A571-4EB6373FA601}'
    'v5.65.13' = '{92154A3C-9BB7-49D7-A571-4EB6373FA5AD}'
    'v5.65.12' = '{FCA2FF70-4D86-42CE-AD8C-A54C706FE41C}'
}

$Installer = New-Object -ComObject WindowsInstaller.Installer

foreach ($Version in $ATVersions.GetEnumerator()) {
    $InstalledProducts = $Installer.ProductsEx($Version.Value, '', 7)
    if ( $InstalledProducts.Count() -gt 0 ) {
        Write-Host "AT $($Version.Key)"
        exit 0
    }
}

exit 1