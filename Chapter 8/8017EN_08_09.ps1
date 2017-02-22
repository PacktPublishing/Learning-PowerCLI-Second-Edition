# Removing virtual machines from a DRS group
$Cluster = Get-Cluster -Name Cluster01
$GroupName = "Cluster01 VMs should run on host 192.168.0.133"
$VMs = Get-VM -Name VM4,VM7
$VMsMorefs = $VMs | ForEach-Object {$_.ExtensionData.MoRef}
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.groupSpec = New-Object VMware.Vim.ClusterGroupSpec[] (1)
$spec.groupSpec[0] = New-Object VMware.Vim.ClusterGroupSpec
$spec.groupSpec[0].operation = "edit"
$spec.groupSpec[0].info = New-Object VMware.Vim.ClusterVmGroup
$spec.groupSpec[0].info.name = $GroupName
$spec.groupSpec[0].info.vm = $Cluster.ExtensionData.ConfigurationEx.Group |
  Where-Object {$_.Name -eq $GroupName} |
  Select-Object -ExpandProperty vm |
  Where-Object {$VMsMorefs -notcontains $_}
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)
