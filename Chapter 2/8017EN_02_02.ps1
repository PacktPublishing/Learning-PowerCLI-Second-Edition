New-VIProperty -Name Path -ObjectType Folder -Value {
  # $FolderView contains the view of the current folder object
  $FolderView = $Args[0].Extensiondata

  # $Server is the name of the vCenter server
  $Server = $Args[0].Uid.Split(“:”)[0].Split(“@”)[1] 

  # We build the path from the right to the left
  # Start with the folder name
  $Path = $FolderView.Name

  # While we are not in the root folder
  while ($FolderView.Parent){
    # Get the parent folder
    $FolderView = Get-View -Id $FolderView.Parent -Server $Server

    # Extend the path with the name of the parent folder
    $Path = $FolderView.Name + "\" + $Path
  }

  # Return the path
  $Path 
} -Force # Create the property even if a property with this name exists