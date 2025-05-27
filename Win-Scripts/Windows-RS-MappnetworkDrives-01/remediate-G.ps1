$driveLetter = "G:"
$networkPath = "\\10.0.20.240\travail"
$username = "sierra-mees\Maintenance"
$password = "pass4MEES"

# Map the network drive
New-PSDrive -Name $driveLetter.TrimEnd(':') -PSProvider FileSystem -Root $networkPath -Persist -Credential (New-Object System.Management.Automation.PSCredential ($username, (ConvertTo-SecureString $password -AsPlainText -Force)))

# Create desktop shortcut
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\IT Network Drive.lnk")
$Shortcut.TargetPath = $driveLetter
$Shortcut.Save()
