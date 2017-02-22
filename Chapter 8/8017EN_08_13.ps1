# Updating IPMI info
$VMHost = Get-VMHost -Name 192.168.0.133
$ipmiInfo = New-Object VMware.Vim.HostIpmiInfo
$ipmiInfo.bmcIpAddress = "192.168.0.201"
$ipmiInfo.bmcMacAddress = "d4:85:64:52:1b:49"
$ipmiInfo.login = "IPMIuser"
$ipmiInfo.password = "IPMIpassword"
$VMHost.ExtensionData.UpdateIpmi($ipmiInfo)