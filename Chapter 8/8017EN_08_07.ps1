# Creating a Hosts DRS Group
$Cluster = Get-Cluster -Name Cluster01
$VMHost = Get-VMHost -Name 192.168.0.133 -Location $Cluster
$DRSGroupName = 'Cluster01 192.168.0.133 Hosts DRS Group'
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.groupSpec = New-Object VMware.Vim.ClusterGroupSpec[] (1)
$spec.groupSpec[0] = New-Object VMware.Vim.ClusterGroupSpec
$spec.groupSpec[0].operation = "add"
$spec.groupSpec[0].info = New-Object VMware.Vim.ClusterHostGroup
$spec.groupSpec[0].info.name = $DRSGroupName
$spec.groupSpec[0].info.host += $VMHost.ExtensionData.MoRef
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)