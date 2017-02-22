$spec = New-Object VMware.Vim.VirtualMachineConfigSpec
$spec.bootOptions = New-Object VMware.Vim.VirtualMachineBootOptions
$spec.bootOptions.enterBIOSSetup = $true
$vm = Get-VM -Name VM2
$vm.ExtensionData.ReconfigVM_Task($spec)