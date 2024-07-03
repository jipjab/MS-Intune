## Scripts and Naming template:
* OS - Status - Type - Description - Version
* OS - Status - RS - Description - Version(Folder name containing both the detect and the remediation script)
    Detect-Function
    Remediate-Function
    all necessary sources such us png files,...
* OS - Status - PS - Description - Version (Folder name containing both the detect and the remediation script)
    all necessary sources such us png files,...
## Definitions:
* PS = Platform Script
* RS = Remediation Script
* TEST = script in Test
* UAT = script used during User Acceptance Testing
* PROD = script in production
## Exemple of a remediation script:
* Windows - PRD-RS-RemoveClassicTeams-01:
    Detect-ClassicTeams
    Remediate-ClassicTeam