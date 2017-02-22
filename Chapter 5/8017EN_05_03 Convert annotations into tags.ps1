#requires -version 4

foreach ($CustomAttribute in (Get-CustomAttribute)) {
  if (-not (Get-TagCategory -Name $CustomAttribute.Name -ErrorAction SilentlyContinue))
  {
    New-TagCategory -Name $CustomAttribute.Name -EntityType $CustomAttribute.TargetType -Cardinality Single
  }
}

Get-Inventory |
Get-Annotation -PipelineVariable Annotation |
Where-Object {$Annotation.Value} |
ForEach-Object {
  $Tag = Get-Tag -Name $Annotation.Value -Category $Annotation.Name -ErrorAction SilentlyContinue
  if (-not $Tag) {$Tag = New-Tag -Name $Annotation.Value -Category $Annotation.Name}
  if (-not (Get-TagAssignment -Category $Annotation.Name -Entity $Annotation.AnnotatedEntity | Where-Object {$_.Tag -eq $Tag}))
  {
    New-TagAssignment -Tag $Tag -Entity $Annotation.AnnotatedEntity
  }
}