<#
.SYNOPSIS
    Ajouter des applications par defaut

.NOTES
    Version: 1.0
    Author: Jean-Paul Mutuyimana
	Date : 06/08/2024

    Author: Mutuyimana Jean-Paul (Kyos)
#>

$associations_xml = @"
<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier=".htm" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".html" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".pdf" ProgId="AcroExch.Document.DC" ApplicationName="Adobe Acrobat Reader" />
  <Association Identifier="http" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier="https" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
</DefaultAssociations>
"@

$provisioning = ni "$($env:ProgramData)\provisioning" -ItemType Directory -Force

$associations_xml | Out-File "$($provisioning.FullName)\associations.xml" -Encoding utf8

dism /online /Import-DefaultAppAssociations:"$($provisioning.FullName)\associations.xml"