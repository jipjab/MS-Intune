# NumLock Activation Script
# Enables NumLock by default on Windows startup
# Deploy on USERS groupe. Does not work on devices groupe

# Registry path for NumLock settings
$registryPath = "HKCU:\Control Panel\Keyboard"

# Set NumLock to be on by default
Set-ItemProperty -Path $registryPath -Name "InitialKeyboardIndicators" -Value 2

# Create a startup script to ensure NumLock is on after login
$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$scriptPath = "$startupFolder\NumLockOn.bat"

# Create batch file to ensure NumLock is active
@"
@echo off
reg add "HKCU\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d 2 /f
powershell -Command "(New-Object -ComObject WScript.Shell).SendKeys('{NUMLOCK}')"
"@ | Out-File $scriptPath -Encoding ASCII

Write-Host "NumLock will now be activated by default on startup."