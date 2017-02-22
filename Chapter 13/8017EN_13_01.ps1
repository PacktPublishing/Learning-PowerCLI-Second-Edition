$omApi = $global:DefaultOMServers[0].ExtensionData
$Report = New-Object -TypeName VMware.VimAutomation.VROps.Views.Report
$Report.ResourceId = (Get-OMResource -Name 'vSphere World').Id
$Report.ReportDefinitionId = ($omApi.GetReportDefinitions().Reportdefinition | Where-Object Name -eq 'Datastore Inventory - I/O Report').Id
$Report.TraversalSpec = $omApi.GetTraversalSpecs().Traversalspec | Where-Object {$_.Name -eq 'vSphere Hosts and Clusters'}
$omApi.CreateReport($Report)