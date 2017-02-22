# Adding virtual machines to a DRS group
$Cluster = Get-Cluster -Name Cluster01
$GroupName = "Cluster01 VMs should run on host 192.168.0.133"
$VMs = Get-VM -Name VM2,VM4,VM7
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.groupSpec = New-Object VMware.Vim.ClusterGroupSpec[] (1)
$spec.groupSpec[0] = New-Object VMware.Vim.ClusterGroupSpec
$spec.groupSpec[0].operation = "edit"
$spec.groupSpec[0].info = $Cluster.ExtensionData.ConfigurationEx.Group |
  Where-Object {$_.Name -eq $GroupName} 
foreach ($VM in $VMs)
{
  $spec.groupSpec[0].info.vm += $VM.ExtensionData.MoRef
}
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)