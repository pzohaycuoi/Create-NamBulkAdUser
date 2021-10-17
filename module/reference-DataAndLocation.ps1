function Reference-DataAndLocation {

  param (

      [Parameter(Mandatory)]
      [System.Object]
      $InputData,

      [Parameter(Mandatory)]
      [System.Object]
      $ReferenceData

  )
  
  $getRefDataInput = $ReferenceData | Where-Object {$_.Location -eq "$($InputData.Location)"}

  $finalizedObject = [PSCustomObject]@{

    FirstName = $InputData.FirstName
    LastName = $InputData.LastName
    Title = $InputData.Title
    Department = $InputData.Department
    Manager = $InputData.Manager
    Location = $InputData.Location
    StreetAddress = $getRefDataInput.StreetAddress
    City = $getRefDataInput.City
    State = $getRefDataInput.State
    PostalCode = $getRefDataInput.PostalCode
    Country = $getRefDataInput.Country
    OuPath = $getRefDataInput.OuPath

  }

  return $finalizedObject

}