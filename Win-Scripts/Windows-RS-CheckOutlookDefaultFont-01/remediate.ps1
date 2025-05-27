$outlookKeyPath = "HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings"
$fontName = "Bebas Neue"

try {
    Set-ItemProperty -Path $outlookKeyPath -Name "ComposeFontSimple" -Value $fontName
    Set-ItemProperty -Path $outlookKeyPath -Name "ComposeFontComplex" -Value $fontName
    Write-Output "Default font for new emails set to $fontName."
    Exit 0
} catch {
    Write-Output "Error setting default font: $_"
    Exit 1
}
