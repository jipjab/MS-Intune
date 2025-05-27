<#
.SYNOPSIS
    Unpin Windows Store

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 17/07/2024

    Author: Mutuyimana Jean-Paul (Kyos)

    Credit: Andrew Taylor
    source: https://github.com/andrew-s-taylor/public/tree/main/Unpin-Store
#>

$apps = ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items())
foreach ($app in $apps) {
$appname = $app.Name
if ($appname -like "*store*") {
$finalname = $app.Name
}
}

((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $finalname}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}