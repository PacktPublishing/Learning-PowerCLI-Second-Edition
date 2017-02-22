# Disabling host monitoring
$Cluster = Get-Cluster -Name Cluster02
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.dasConfig = New-Object VMware.Vim.ClusterDasConfigInfo
$spec.dasConfig.hostMonitoring = "disabled"
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)