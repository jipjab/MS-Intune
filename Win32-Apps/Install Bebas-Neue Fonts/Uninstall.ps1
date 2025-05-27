$FontstoInstall = Get-ChildItem -Path C:\ProgramData\FontsToInstall\ | Where-Object Name -Like "*.ttf"

foreach ($FontFile in $FontstoInstall){

    Remove-Item -Path C:\Windows\Fonts\$FontFile -Force
}