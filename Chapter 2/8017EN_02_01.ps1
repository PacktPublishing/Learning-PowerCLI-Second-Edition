New-VIProperty -Name vCenterServer -ObjectType VirtualMachine -Value {
  $Args[0].Uid.Split(“:”)[0].Split(“@”)[1]
} –Force