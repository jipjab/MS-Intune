$outlookKeyPath = "HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings"
$fontName = "Bebas Neue"

try {
    $composeFontSimple = Get-ItemProperty -Path $outlookKeyPath -Name "ComposeFontSimple" -ErrorAction Stop | Select-Object -ExpandProperty ComposeFontSimple
    
    if ($composeFontSimple -eq $fontName) {
        Write-Output "Default font for new emails is already set to $fontName."
        Exit 0
    } else {
        Write-Output "Default font for new emails is not set to $fontName."
        Exit 1
    }
} catch {
    Write-Output "Error checking default font: $_"
    Exit 1
}
