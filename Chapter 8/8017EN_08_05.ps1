# Use datastores from the specified list and complement automatically if needed for datastore heartbeating
$Cluster = Get-Cluster -Name Cluster01
$Datastore1 = Get-Datastore -Name Datastore1
$Datastore2 = Get-Datastore -Name Datastore2
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.dasConfig = New-Object VMware.Vim.ClusterDasConfigInfo
$spec.dasConfig.heartbeatDatastore = New-Object VMware.Vim.ManagedObjectReference[] (2)
$spec.dasConfig.heartbeatDatastore[0] = New-Object VMware.Vim.ManagedObjectReference
$spec.dasConfig.heartbeatDatastore[0].type = "Datastore"
$spec.dasConfig.heartbeatDatastore[0].Value = $Datastore1.ExtensionData.MoRef.Value
$spec.dasConfig.heartbeatDatastore[1] = New-Object VMware.Vim.ManagedObjectReference
$spec.dasConfig.heartbeatDatastore[1].type = "Datastore"
$spec.dasConfig.heartbeatDatastore[1].Value = $Datastore2.ExtensionData.MoRef.Value
$spec.dasConfig.hBDatastoreCandidatePolicy = "allFeasibleDsWithUserPreference"
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)