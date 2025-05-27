# Remediation Script (DriveRemediationScript.ps1)
$driveLetter = "I"
$networkPath = "\\10.0.20.240\WinEUR"
$username = "sierra-mees\Maintenance"
$password = "pass4MEES"

# Create a scheduled task to map the drive on user logon
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Command `"New-PSDrive -Name G -PSProvider FileSystem -Root '\\10.0.20.240\travail' -Persist -Credential (New-Object System.Management.Automation.PSCredential('$username', (ConvertTo-SecureString '$password' -AsPlainText -Force)))`""

$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Users"

$taskName = "MapNetworkDrive_G"
$description = "Map Network Drive G to \\10.0.20.240\travail"

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Description $description

# Map the drive immediately
New-PSDrive -Name G -PSProvider FileSystem -Root $networkPath -Credential (New-Object System.Management.Automation.PSCredential($username, (ConvertTo-SecureString $password -AsPlainText -Force))) -Persist