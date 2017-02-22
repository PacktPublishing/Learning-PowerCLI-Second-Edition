# Disabling Distributed Power Management
$Cluster = Get-Cluster -Name Cluster01
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.dpmConfig = New-Object VMware.Vim.ClusterDpmConfigInfo
$spec.dpmConfig.enabled = $false
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)