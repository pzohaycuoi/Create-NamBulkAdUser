$scriptDir = $PSScriptRoot
. "$($scriptDir)\..\common\New-Log.ps1"

function Reference-DataAndLocation {

  param (

    [Parameter(Mandatory)]
    [System.Object]
    $InputData,

    [Parameter(Mandatory)]
    [System.Object]
    $ReferenceData

  )

  New-Log -Level "INFO" -Message "Getting information based on input data"

  # if InputData has location data then refer to the LocatationData and return the object with LocationData
  # else return only InputData
  $getRefDataInput = $ReferenceData | Where-Object { $_.Location -eq "$($InputData.Location)" }

  if (-not ($null -eq $getRefDataInput)) {

    $finalizedObject = [PSCustomObject]@{

      FirstName     = $InputData.FirstName
      LastName      = $InputData.LastName
      Title         = $InputData.Title
      Department    = $InputData.Department
      Manager       = $InputData.Manager
      Location      = $InputData.Location
      StreetAddress = $getRefDataInput.StreetAddress
      City          = $getRefDataInput.City
      State         = $getRefDataInput.State
      PostalCode    = $getRefDataInput.PostalCode
      Country       = $getRefDataInput.Country
      OuPath        = $getRefDataInput.OuPath

    }

    New-Log -Level "INFO" -Message "Completed get information based on input data "

    return $finalizedObject  

  }
  else {

    $FirstName = $InputData.FirstName
    $LastName = $InputData.LastName
    $Title = $InputData.Title
    $Department = $InputData.Department
    $Manager = $InputData.Manager
    $Location = $InputData.Location
    $Result = "FAIL"
    
    $finalizedObject = [PSCustomObject]@{

      FirstName  = $FirstName
      LastName   = $LastName
      Title      = $Title
      Department = $Department
      Manager    = $Manager
      Location   = $Location
      Result     = $Result

    }

    New-Log -Level "ERROR" -Message "Location field is not valid, aborting"
    New-Log -Level "ERROR" -Message "Create AD user failed, FirstName: $($FirstName)"
    New-Log -Level "ERROR" -Message "Create AD user failed, LastName: $($LastName)"
    New-Log -Level "ERROR" -Message "Create AD user failed, Title: $($Title)"
    New-Log -Level "ERROR" -Message "Create AD user failed, Department: $($Department)"
    New-Log -Level "ERROR" -Message "Create AD user failed, Manager: $($Manager)"
    New-Log -Level "ERROR" -Message "Create AD user failed, Location: $($Location)"
    New-Log -Level "ERROR" -Message "Create AD user failed, Result: $($Result)"

    return $finalizedObject  

  } # end if (-not ($null -eq $InputData.Location))

} # end function Reference-DataAndLocation