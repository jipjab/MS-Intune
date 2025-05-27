$PackageName = "PowerPoint-template"

$Path_KYOS_Logs = "$ENV:LOCALAPPDATA\_MEM"
Start-Transcript -Path "$Path_KYOS_Logs\Log\$PackageName-uninstall.log" -Force

Remove-Item -Path "$env:APPDATA\Microsoft\Templates\Blank.potm" -Force
Remove-Item -Path "$Path_KYOS_Logs\Validation\$PackageName" -Force

Stop-Transcript