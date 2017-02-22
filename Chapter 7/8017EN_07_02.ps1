Get-Datastore |
Where-Object {$_.GetType().Name -eq 'VmfsDatastoreImpl' -and $_.FileSystemVersion -lt 5} |
ForEach-Object {
  $Datastore = $_
  # Get the HostStorageSystem of the first host that the
  # datastore is connected to
  # The UpgradeVmfs() method of this object is used to
  # upgrade the datastore
  $HostStorageSystem = $Datastore |
    Get-VMHost | Select-Object -First 1 |
    Get-VMHostStorage | Get-View

  # Construct the path to the volume to upgrade
  # For example:
  # /vmfs/volumes/4e97fa06-7fa61558-937e-984be163eb88
  $Volume = '/' + $Datastore.ExtensionData.Info.Url.TrimStart('ds:/').TrimEnd('/')
        
  # Upgrade the datastore
  $HostStorageSystem.UpgradeVmfs($Volume)
}