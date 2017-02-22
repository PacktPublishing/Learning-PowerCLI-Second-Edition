$LicenseDataManager = Get-LicenseDataManager
foreach ($VMHost in (Get-Datacenter -Name 'New York' | Get-VMHost))
{
  $LicenseDataManager.ApplyAssociatedLicenseData($VMHost.Uid)
}