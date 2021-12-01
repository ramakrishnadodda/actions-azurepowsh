$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Write-Host "Setting up"
$json = $env:INPUT_CREDS | ConvertFrom-Json
$clientPassword = ConvertTo-SecureString $json.clientSecret -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($json.clientId, $clientPassword)

Write-Host "Installing Az module (this might take few minutes)"
Install-Module -Name Az -Force

Write-Host "Logging into Azure"
Login-AzAccount -Credential $credentials -ServicePrincipal -TenantId $json.tenantId | Out-Null

Write-Host "Selecting correct subscription"
Select-AzSubscription -SubscriptionId $json.subscriptionId | Out-Null

return "Successfully logged in!"
