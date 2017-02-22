$Spec = New-Object VMware.Vim.VirtualMachineConfigSpec
$Spec.Tools = New-Object VMware.Vim.ToolsConfigInfo
$Spec.Tools.ToolsUpgradePolicy = "UpgradeAtPowerCycle"
Get-VM | ForEach-Object {$_.ExtensionData.ReconfigVM_Task($Spec)}