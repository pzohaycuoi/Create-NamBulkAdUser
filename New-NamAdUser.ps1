function New-NamAdUser {

  param (

    [Parameter(Mandatory)]
    [string]$FirstName,

    [Parameter(Mandatory)]
    [string]$LastName,

    [Parameter(Mandatory)]
    [string]$Title,

    [AllowEmptyString()]
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


  $importAdModuleStat = Import-AdModule

  if ($true -eq $importAdModuleStat) {

    $importLocationData = Import-LocationData

    if (-not ($false -eq $importLocation)) {

      $inputObject = Receive-InputData `
        -FirstName $FirstName `
        -LastName $LastName `
        -Title $Title `
        -Department $Department `
        -Manager $Manager `
        -Location $Location

      $refedObject = Reference-DataAndLocation -InputData $inputObject -ReferenceData $importLocationData

      if (-not ($refedObject.Result -eq "FAIL")) {
      
        $createAdUser = Create-AdUser -InputData $refedObject
        
        return $createAdUser

      }
      else {

        return $refedObject

      } # end if (-not ($refedObject.Result -eq "FAIL"))

    }
    else {

      break

    } # end if (-not ($false -eq $importLocation))

  }
  else {
  
    break

  } # end if ($true -eq $importAdModuleStat)
  
} # end function New-NamAdUser