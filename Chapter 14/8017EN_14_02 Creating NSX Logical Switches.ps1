Connect-VIServer -Server vcsa-01a.corp.local
$NSXManager = '192.168.110.15'
$Username = 'admin'
$Password = 'VMware1!'
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$Username`:$Password"))
$Headers = @{Authorization = "Basic $base64AuthInfo"}
$Uri = "https://$NSXManager/api/2.0/vdn/scopes"
$xml = Invoke-RestMethod -Uri $Uri -Method Get -Headers $Headers
$xml.vdnScopes.vdnScope.objectId
$Uri = "https://$NSXManager/api/2.0/vdn/scopes/vdnscope-1/virtualwires"
$Body = @'
<virtualWireCreateSpec>
  <name>Prod_Logical_Switch</name>
  <tenantId>virtual wire tenant</tenantId>
  <controlPlaneMode>UNICAST_MODE</controlPlaneMode>
  <guestVlanAllowed>false</guestVlanAllowed>
</virtualWireCreateSpec>
'@
Invoke-RestMethod -Uri $Uri -Method Post -Body $Body -ContentType 'application/xml' -Headers $Headers