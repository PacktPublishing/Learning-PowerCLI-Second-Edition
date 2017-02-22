# Enabling VM and application monitoring
$Cluster = Get-Cluster -Name Cluster02
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.dasConfig = New-Object VMware.Vim.ClusterDasConfigInfo
$spec.dasConfig.vmMonitoring = "vmAndAppMonitoring"
$spec.dasConfig.defaultVmSettings = New-Object VMware.Vim.ClusterDasVmSettings
$spec.dasConfig.defaultVmSettings.vmToolsMonitoringSettings = New-Object VMware.Vim.ClusterVmToolsMonitoringSettings
$spec.dasConfig.defaultVmSettings.vmToolsMonitoringSettings.enabled = $true
$spec.dasConfig.defaultVmSettings.vmToolsMonitoringSettings.vmMonitoring = "vmAndAppMonitoring"
$spec.dasConfig.defaultVmSettings.vmToolsMonitoringSettings.failureInterval = 60
$spec.dasConfig.defaultVmSettings.vmToolsMonitoringSettings.minUpTime = 240
$spec.dasConfig.defaultVmSettings.vmToolsMonitoringSettings.maxFailures = 3
$spec.dasConfig.defaultVmSettings.vmToolsMonitoringSettings.maxFailureWindow = 86400
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)