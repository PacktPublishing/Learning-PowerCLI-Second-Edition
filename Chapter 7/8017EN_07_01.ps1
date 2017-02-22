# Define the variables
$HostName = '192.168.0.132'
$iSCSITarget = '192.168.0.135'
$VirtualSwitchName = 'vSwitch2'
$NicName = 'vmnic3'
$PortGroupName = 'iSCSI Port group 1'
$ChapType = 'Preferred'
$ChapUser = 'Cluster01User'
$ChapPassword = 'Cluster01Password'
$DatastoreName = 'Cluster01_iSCSI01'

# Retrieve the host to add the iSCSI datastore to
$VMHost = Get-VMHost -Name $HostName

# Enable software iSCSI support on the host
$VMHost | Get-VMHostStorage | Set-VMHostStorage -SoftwareIScsiEnabled:$true

# Create an iSCSI target
$VMHostHba = $VMHost | Get-VMHostHba -Type iSCSI
$VMHostHba |
New-IScsiHbaTarget -Address $iSCSITarget -ChapType $ChapType -ChapName $ChapUser -ChapPassword $ChapPassword

# Rescan all HBAs
$VMHost | Get-VMHostStorage -RescanAllHba

# Create a new virtual switch and a vmkernel port group
$vSwitch = New-VirtualSwitch -VMHost $VMHost -Name $VirtualSwitchName -Nic $NicName
$NetworkAdapter = New-VMHostNetworkAdapter -VirtualSwitch $vSwitch -PortGroup $PortGroupName

# Bind the vmkernel port group to the iSCSI HBA
$IscsiManager = Get-View -Id $vmhost.ExtensionData.Configmanager.IscsiManager
$IscsiManager.BindVnic($VMHostHba.Device, $NetworkAdapter.Name)

# Create the iSCSI datastore
$ScsiLun = $VMHost |
Get-ScsiLun |
Where-Object {$_.RuntimeName -like "$($VMHostHba.Device)*"}
New-Datastore -Vmfs -VMHost $VMHost -Name $DatastoreName -Path $ScsiLun.CanonicalName