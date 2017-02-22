Connect-VIServer -Server vcsa-01a.corp.local
$NSXManager = '192.168.110.15'
$Username = 'admin'
$Password = 'VMware1!'
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$Username`:$Password"))
$Headers = @{Authorization = "Basic $base64AuthInfo"}
$Uri = "https://$NSXManager/api/4.0/edges"
$xml = Invoke-RestMethod -Uri $Uri -Method Get -Headers $Headers
$xml.pagedEdgeList.edgePage.edgeSummary | Where-Object {$_.edgeType -eq 'gatewayServices'}