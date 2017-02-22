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

$Uri = "https://$vRAServer/catalog-service/api/consumer/resources"
$Response = Invoke-RestMethod -Uri $Uri -Method GET -Headers $Headers
$Response.content | Where-Object {$_.name -like 'CentOS 6.6*'}