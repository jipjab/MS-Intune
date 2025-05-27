# Authentificate with Graph API

$clientID = "<Your-Client-ID-Here>"  # Replace with your actual client ID
$clientSecret = "<Your-Client-Secret-Here>"  # Replace with your actual client secret
$tenantID = "<Your-Tenant-ID-Here>"  # Replace with your actual tenant ID

# Assemble the token URL
$tokenUrl = "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token"
$tokenBody = @{
    client_id     = $clientID
    client_secret = $clientSecret
    scope         = "https://graph.microsoft.com/.default"
    grant_type    = "client_credentials"
}

$tokenResponse = Invoke-RestMethod -Method Post -Uri $tokenUrl -Body $tokenBody -ContentType "application/x-www-form-urlencoded"
$accessToken = $tokenResponse.access_token

$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type"  = "application/json"
}

# Get the Entra device ID
$entraDeviceId = ((Get-ChildItem "Cert:\LocalMachine\My" | Where-Object {$_.Issuer -match "MS-Organization-Access"} | Select-Object Subject).Subject).TrimStart("CN=")
$entraId = (Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/beta/devices?`$filter=deviceid eq '$entraDeviceId'" -Headers $headers).value.id

$body = @"
{
    "extensionAttributes":{
        "extensionAttribute7":"NO Sophos EAgent"
    }
}
"@

# Make patch request
Invoke-RestMethod -Method Patch -Uri "https://graph.microsoft.com/beta/devices/$($entraId)" -Headers $headers -Body $body

Write-Output "extensionAttribute7 set to Firefox for $($entraId)"