Get-ChildItem -Path HKLM:\Software\Classes -ErrorAction SilentlyContinue |
Where-Object {$_.PSChildName -match '^\w+\.\w+$' –and (Get-Itemproperty "$($_.PSPath)\CLSID" -ErrorAction SilentlyContinue)} |
Format-Table -Property PSChildName