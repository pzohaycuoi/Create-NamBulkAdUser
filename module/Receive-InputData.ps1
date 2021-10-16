function Receive-InputData {

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
  
  # Put input data into an object, passing this into other module
  $inputData = @{    
    FirstName = $FirstName
    LastName = $LastName
    Title = $Title
    Department = $Department
    Manager = $Department
    Location = $Location
  }

  return $inputData

}