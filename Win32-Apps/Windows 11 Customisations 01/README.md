Detection file: 
C:\ProgramData\Microsoft\KYOS
kyos_win11Settings.ps1.tag

(device.devicePhysicalIDs -any _ -contains "[ZTDId]") and (device.devicePhysicalIds -all _ -notContains "[OrderID]:UAT")

powershell -executionpolicy bypass -file install.ps1


UAT - Win11 Kyos Custom