$scriptDir = $PSScriptRoot
. "$($scriptDir)\..\common\New-Log.ps1"

function Receive-InputData {

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

  New-Log -Level "INFO" -Message "Convert input to Object"
  
  # Put input data into an object, passing this into other module
  $inputData = [PsCustomObject]@{  

    FirstName = $FirstName
    LastName = $LastName
    Title = $Title
    Department = $Department
    Manager = $Manager
    Location = $Location

  }

  return $inputData

} # end function Receive-InputData