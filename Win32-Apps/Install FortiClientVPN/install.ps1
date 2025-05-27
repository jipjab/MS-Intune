$PackageName = "FortiClientVPN"
$ConfigPW = "Fip0i1211F0rt1" # insert your password here!

$Path_KyosIntune = "$Env:Programfiles\Kyos\EndpointManager"
Start-Transcript -Path "$Path_KyosIntune\Log\$PackageName-install.log" -Force

(Start-Process "msiexec.exe" -ArgumentList "/i FortiClientVPN.msi /passive /quiet INSTALLLEVEL=3 DESKTOPSHORTCUT=0 /NORESTART" -NoNewWindow -Wait -PassThru).ExitCode
Start-Sleep 5
Start-Process "C:\Program Files\Fortinet\FortiClient\FCConfig.exe" -ArgumentList "-m vpn -f FortiClientVPN.conf -o import -p $ConfigPW" -Wait

Stop-Transcript