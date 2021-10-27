param (

  [Parameter(Mandatory)]
  [string]$FirstName,

  [Parameter(Mandatory)]
  [string]$LastName,

  [Parameter(Mandatory)]
  [string]$Title,

  [Parameter(Mandatory)]
  [string]$Department,

  [Parameter(Mandatory)]
  [string]$Manager,

  [Parameter(Mandatory)]
  [string]$Location

)

# Current path where the script run
$scriptDir = $PSScriptRoot
$modulePath = "$($scriptDir)\module\"
$commonPath = "$($scriptDir)\common\"
$moduleList = Get-ChildItem -Path $modulePath | Where-Object { $_.name -like "*.ps1" }
$commonModuleList = Get-ChildItem -Path $commonPath | Where-Object { $_.name -like "*.ps1" }

# foreach module in that folder, import it
foreach ($module in $moduleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# foreach module in that folder, import it
foreach ($module in $commonModuleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# try importing ActiveDirectory module
$importAdModuleStat = Import-AdModule
if ($true -eq $importAdModuleStat) {
  
  $inputObject = Receive-InputData `
    -FirstName $FirstName `
    -LastName $LastName `
    -Title $Title `
    -Department $Department `
    -Manager $Manager `
    -Location $Location

  $importLocationData = Import-LocationData
  if (-not ($false -eq $importLocation)) {

    $refedObject = Reference-DataAndLocation -InputData $inputObject -ReferenceData $importLocationData
    $refedObject
    
  } else {

    break

  }

}
else {
  
  break

}