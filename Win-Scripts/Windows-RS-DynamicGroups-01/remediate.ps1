# Authentificate with Graph API

$clientID = "9160904c-025a-4115-8372-cee760f3692e"
$clientSecret = "cht8Q~p-Onxkgvu_LCmlJ8f6B-VekYjxJNYzda2J"
$tenantID = "7c9bd769-5c9c-44c9-9083-717484c12b5f"

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