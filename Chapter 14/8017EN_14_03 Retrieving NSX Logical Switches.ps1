Connect-VIServer -Server vcsa-01a.corp.local
$NSXManager = '192.168.110.15'
$Username = 'admin'
$Password = 'VMware1!'
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$Username`:$Password"))
$Headers = @{Authorization = "Basic $base64AuthInfo"}
$Uri = "https://$NSXManager/api/2.0/vdn/scopes/vdnscope-1/virtualwires"
$xml = Invoke-RestMethod -Uri $Uri -Method Get -Headers $Headers
$xml.virtualWires.dataPage.virtualWire | Where-Object {$_.name -eq 'Prod_Logical_Switch'}