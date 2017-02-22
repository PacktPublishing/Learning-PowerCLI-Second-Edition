# Removing a DRS group
$Cluster = Get-Cluster -Name Cluster01
$GroupName = "Cluster01 VMs should run on host 192.168.0.133"
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.groupSpec = New-Object VMware.Vim.ClusterGroupSpec[] (1)
$spec.groupSpec[0] = New-Object VMware.Vim.ClusterGroupSpec
$spec.groupSpec[0].operation = "remove"
$spec.groupSpec[0].removeKey = $GroupName
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)