# Enabling Distributed Power Management
$Cluster = Get-Cluster -Name Cluster01
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.dpmConfig = New-Object VMware.Vim.ClusterDpmConfigInfo
$spec.dpmConfig.enabled = $true
$spec.dpmConfig.defaultDpmBehavior = "manual"
$spec.dpmConfig.hostPowerActionRate = 3
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)