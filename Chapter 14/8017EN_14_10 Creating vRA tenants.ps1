$vRAServer = 'vra-01a.corp.local'
$Username = 'administrator@vsphere.local'
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

$Tenant = 'research'
$Uri = "https://$vRAServer/identity/api/tenants/$Tenant"
$Body = @"
{ "@type" : "Tenant",
 "id" : "research",
 "urlName" : "research",
 "name" : "Research",
 "description" : "Tenant for all researchers",
 "contactEmail" : "admin@blackmilktea.com",
 "defaultTenant" : false
}
"@

$Tenant = Invoke-RestMethod -Uri $Uri -Method PUT -Body $Body -Headers $Headers
$Tenant