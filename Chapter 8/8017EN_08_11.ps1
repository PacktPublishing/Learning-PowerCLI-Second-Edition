# Creating a Virtual Machines to Hosts DRS rule
$Cluster = Get-Cluster -Name Cluster01
$spec = New-Object VMware.Vim.ClusterConfigSpecEx
$spec.rulesSpec = New-Object VMware.Vim.ClusterRuleSpec[] (1)
$spec.rulesSpec[0] = New-Object VMware.Vim.ClusterRuleSpec
$spec.rulesSpec[0].operation = "add"
$spec.rulesSpec[0].info = New-Object VMware.Vim.ClusterVmHostRuleInfo
$spec.rulesSpec[0].info.enabled = $true
$spec.rulesSpec[0].info.name = "Cluster01 VM1 should run on host 192.168.0.133 DRS Rule"
$spec.rulesSpec[0].info.mandatory = $false
$spec.rulesSpec[0].info.userCreated = $true
$spec.rulesSpec[0].info.vmGroupName = "Cluster01 VMs should run on host 192.168.0.133"
$spec.rulesSpec[0].info.affineHostGroupName = "Cluster01 192.168.0.133 Hosts DRS Group"
$Cluster.ExtensionData.ReconfigureComputeResource_Task($spec, $true)