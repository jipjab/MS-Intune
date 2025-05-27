<#

Chercher la clefs "autoworkplacejoin" dans HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin

Si la clefs de Registre autoworkplacejoin sur 1, alors la supprimer et ajouter "BlockAADWorkplaceJoin" à la place
HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin: "BlockAADWorkplaceJoin"=dword:00000001

#>

# Supprimer les traces MAM avec le script powershell:
$EnrollmentsPath = "HKLM:\SOFTWARE\Microsoft\Enrollments\"
$Enrollments = Get-ChildItem -Path $EnrollmentsPath
$DiscoveryServerFullUrls = @("https://wip.mam.manage.microsoft.com/Enroll")
Foreach ($Enrollment in $Enrollments) {
      $EnrollmentObject = Get-ItemProperty Registry::$Enrollment
      if ($EnrollmentObject."DiscoveryServiceFullURL" -in $DiscoveryServerFullUrls ) {
            $EnrollmentPath = $EnrollmentsPath + $EnrollmentObject."PSChildName"
            Remove-Item -Path $EnrollmentPath -Recurse       }
}

# Puis en CMD
dsregcmd /leave /debug

# Puis synchro entra id connect et demander au user de reboot sont PC et de se reconnecter, le PC sera ensuite dans intune