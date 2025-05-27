# verifier la presence de "HKCU:\SOFTWARE\Microsoft\OneDrive\Accounts"
si la clés existe => No remediation
exit 1
si la clés n'existe pas => remediation
exit 0
# create "HKLM:SOFTWARE\Policies\Microsoft" - "SharePointOnPremPrioritization"
# create "HKLM:SOFTWARE\Policies\Microsoft" - "SharePointOnPremFrontDoorUrl"





Check si la reg existe et la clé
$regPath = "HKCU:\SOFTWARE\Microsoft\OneDrive\Accounts"
$regkeyexists = Test-Path -Path $regPath
if ($regkeyexists) {
    #Write-Host "Path is ok"
    $regentryexists = Get-ItemProperty -Path $regpath -Name LastUpdate -ErrorAction SilentlyContinue
    if ($regentryexists) {
		#Write-Host "Key Exist"
		exit 1
    }
    else{
		#Write-Host "Key don't exit"
		exit 0
    }
}
else{
	#Write-Host "Path is not ok"
	exit 0
}


#Créer la nouvelle Reg et créer les clés
New-Item -Path "HKLM:SOFTWARE\Policies\Microsoft" -Name OneDrive –Force

$regPath ="HKLM:SOFTWARE\Policies\Microsoft\OneDrive"
New-ItemProperty -Path $regPath -Name "SharePointOnPremFrontDoorUrl" -PropertyType String -Value "https://intranet.foj.ch"
New-ItemProperty -Path $regPath -Name "SharePointOnPremPrioritization" -PropertyType DWord -Value "00000001"




# Create the registry values
$regPath = "HKCU:\SOFTWARE\Microsoft\OneDrive\Accounts"
$Name = "SharePointOnPremFrontDoorUrl"
$Value = "https://intranet.foj.ch"

Try {
    $Registry = Get-ItemProperty -Path $regPath -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
    If ($Registry -eq $Value){
        Write-Output "Compliant"
        Exit 0
    } 
    Write-Warning "Not Compliant"
    Exit 1
} 
Catch {
    Write-Warning "Not Compliant"
    Exit 1
}
