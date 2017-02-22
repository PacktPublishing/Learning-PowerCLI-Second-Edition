# Creating a Virtual Machines DRS Group
$Cluster = Get-Cluster -Name Cluster01
$VM = Get-VM -Name VM1 -Location $Cluster
$DRSGroupName = 'Cluster01 VMs should run on host 192.168.0.133'
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.groupSpec = New-Object VMware.Vim.ClusterGroupSpec[] (1)
$spec.groupSpec[0] = New-Object VMware.Vim.ClusterGroupSpec
$spec.groupSpec[0].operation = 'add'
$spec.groupSpec[0].info = New-Object VMware.Vim.ClusterVmGroup
$spec.groupSpec[0].info.name = $DRSGroupName
$spec.groupSpec[0].info.vm += $VM.ExtensionData.MoRef
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)