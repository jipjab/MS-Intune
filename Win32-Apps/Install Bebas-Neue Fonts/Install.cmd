if not exist "C:\ProgramData\InstallFonts" md "C:\ProgramData\InstallFonts"
robocopy . *.ttf C:\ProgramData\InstallFonts
xcopy Uninstall.ps1 C:\ProgramData\InstallFonts /Y
Powershell.exe -Executionpolicy bypass -File InstallFonts.ps1