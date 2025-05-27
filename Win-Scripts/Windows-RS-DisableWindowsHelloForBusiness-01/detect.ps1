$ngcPath = "C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc"
if (Test-Path $ngcPath) {
    Write-Output "Windows Hello for Business container exists."
    exit 1
} else {
    Write-Output "No Windows Hello for Business container found."
    exit 0
}
