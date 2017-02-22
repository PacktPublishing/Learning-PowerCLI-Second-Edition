# Automatically select datastores accessible from the host for datastore heartbeating
$Cluster = Get-Cluster -Name Cluster01
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.dasConfig = New-Object VMware.Vim.ClusterDasConfigInfo
$spec.dasConfig.hBDatastoreCandidatePolicy = "allFeasibleDs"
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)