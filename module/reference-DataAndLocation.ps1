function Reference-DataAndLocation {

  param (

    [Parameter(Mandatory)]
    [System.Object]
    $InputData,

    [Parameter(Mandatory)]
    [System.Object]
    $ReferenceData

  )

  # if InputData has location data then refer to the LocatationData and return the object with LocationData
  # else return only InputData

  if (-not ($null -eq $InputData.Location)) {
    
    $getRefDataInput = $ReferenceData | Where-Object { $_.Location -eq "$($InputData.Location)" }

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

    return $finalizedObject  

  } else {
    
    $finalizedObject = [PSCustomObject]@{

      FirstName     = $InputData.FirstName
      LastName      = $InputData.LastName
      Title         = $InputData.Title
      Department    = $InputData.Department
      Manager       = $InputData.Manager

    }

  } # end if (-not ($null -eq $InputData.Location))

} # end function Reference-DataAndLocation