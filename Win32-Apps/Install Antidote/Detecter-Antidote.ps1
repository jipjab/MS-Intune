trap [System.Management.Automation.ValidationMetadataException] {
    Write-Error "Ce script doit être adapté avant d'être utilisé. Il doit inclure des numéros de version valide pour Antidote 11 et Connectix 11."
    Write-Error "Ces ajustements peuvent être faits en lançant Creer-PaquetIntune.ps1."
    break
}

enum InstallationType {
    ANTIDOTE_ML = 0
    ANTIDOTE_FR = 1
    ANTIDOTE_EN = 2
    CONNECTIX = 3
}

[ValidateNotNullOrEmpty()] [InstallationType]$Type = 'ANTIDOTE_FR'
if ($Type -ne [InstallationType]::CONNECTIX) {
    [ValidatePattern('^11\.\d\.\d{1,4}$')] [string]$AntidoteVersion = '11.6.277'
} else {
    Remove-Variable AntidoteVersion -WhatIf:$false -ErrorAction Ignore
}
[ValidatePattern('^11\.\d\.\d{1,4}$')] [string]$ConnectixVersion = '11.6.277'

$Products = @(
    [PSCustomObject]@{
        Name       = 'Antidote 11'
        Code       = '{2643823D-D15F-4046-8388-401756A5C921}'
        Version    = [System.Version]$AntidoteVersion
        IsRequired = $Type -ne [InstallationType]::CONNECTIX
    },
    [PSCustomObject]@{
        Name       = 'Antidote 11 - Module Français'
        Code       = '{2643823D-D15F-4046-8388-401756A5C922}'
        Version    = [System.Version]$AntidoteVersion
        IsRequired = $Type -in [InstallationType]::ANTIDOTE_FR, [InstallationType]::ANTIDOTE_ML
    },
    [PSCustomObject]@{
        Name       = 'Antidote 11 - English Module'
        Code       = '{2643823D-D15F-4046-8388-401756A5C923}'
        Version    = [System.Version]$AntidoteVersion
        IsRequired = $Type -in [InstallationType]::ANTIDOTE_EN, [InstallationType]::ANTIDOTE_ML
    },
    [PSCustomObject]@{
        Name       = 'Antidote - Connectix 11'
        Code       = '{2643823D-D15F-4046-8388-401756A5C924}'
        Version    = [System.Version]$ConnectixVersion
        IsRequired = $true
    }
)

$Installer = New-Object -ComObject WindowsInstaller.Installer

foreach ($Product in $Products) {
    if (-not $Product.IsRequired -or $null -eq $Product.Version) {
        continue
    }

    $InstalledProducts = $Installer.ProductsEx($Product.Code, '', 7)
    if ( $InstalledProducts.Count() -eq 0 ) {
        exit 1
    }

    if ( [System.Version]$InstalledProducts[0].InstallProperty('VersionString') -lt $Product.Version) {
        exit 1
    }
}
Write-Host 'Install OK'
exit 0
