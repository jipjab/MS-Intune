<#
.SYNOPSIS
    Install Symprex Signature

.NOTES
    Version: 1.3
    Author: Jean-Paul Mutuyimana

    copy SignAgent.exe to C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
#>

# Define paths

$sourceFile = "$($PSScriptRoot)\SignAgent.exe"
$destinationFolder = [Environment]::GetFolderPath("CommonStartup")
$destinationFile = Join-Path $destinationFolder "SignAgent.exe"

# Create the destination folder if it doesn't exist
if (-not (Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder -Force
}

# Move the file
Copy-Item -Path $sourceFile -Destination $destinationFile -Force