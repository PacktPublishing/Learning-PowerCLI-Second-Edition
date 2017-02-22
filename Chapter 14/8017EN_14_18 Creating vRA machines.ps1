$vRAServer = 'vra-01a.corp.local'
$Username = 'devuser@corp.local'
$Password = 'VMware1!'
$Tenant = 'vsphere.local'
$Body = @"
{
  "username":"$Username",
  "password":"$Password",
  "tenant":"$Tenant"
}
"@

$Uri = "https://$vRAServer/identity/api/tokens"
$Response = Invoke-RestMethod -Uri $Uri -Method POST -Body $Body -ContentType 'application/json'
$DefaultvRAServer = [pscustomobject]@{
  Server = $vRAServer
  Token = $Response.id
  Expires = $Response.Expires 
  Tenant = $Response.tenant
  Username = $Username
}

$Headers = @{
  Accept = "application/json"
  'Content-Type' = "application/json"
  Authorization = "Bearer $($Global:DefaultvRAServer.Token)"
}

$Body = $Template | ConvertTo-Json -Depth 999
$Uri = ($CatalogItem.links | Where-Object {$_.rel -eq 'POST: Submit Request'}).href
$Request = Invoke-RestMethod -Uri $Uri -Method POST -Body $Body -Headers $Headers
$Request