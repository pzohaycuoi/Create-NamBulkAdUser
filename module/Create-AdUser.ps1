$scriptDir = $PSScriptRoot
Import-Module "$($scriptDir)\Check-AdUserExist.ps1"

function Create-AdUser {

  # create ad user function
  param (

    [Parameter(Mandatory)]
    [string]$FirstName,

    [Parameter(Mandatory)]
    [string]$LastName,

    [Parameter(Mandatory)]
    [string]$OuPath,

    [Parameter(Mandatory)]
    [string]$Title,

    [Parameter(Mandatory)]
    [string]$Department,

    [Parameter(Mandatory)]
    [string]$Manager,

    [Parameter(Mandatory)]
    [string]$StreetAddress,

    [Parameter(Mandatory)]
    [string]$City,

    [Parameter(Mandatory)]
    [string]$State,

    [Parameter(Mandatory)]
    [string]$Postalcode,

    [Parameter(Mandatory)]
    [string]$Country
  
  )

  # required parameters base on input data for new-aduser command
  $Name = "$($FirstName) $($LastName)"
  $samAccountName = "$($FirstName[0])$($LastName)"

  # Check if user exist yet
  if ($false -eq (Check-AdUserExist -SamAccountName $samAccountName)) {

    Continue

  }
  else {
    
    # if user with samAccountName exist then add number into samAccountName until $null
    
    $i = 0

    do {

      $i++
      $newSamAccountName = "$($samAccountName)$($i)"

    } until ($false -eq (Check-AdUserExist -SamAccountName $newSamAccountName))

    $samAccountName = $newSamAccountName

  } # end if ($true -eq (Check-AdUserExist -SamAccountName $samAccountName))

  try {

    # create the user base on the information
    New-ADUser  -Name $Name `
      -GivenName $FirstName `
      -Surname $LastName `
      -SamAccountName $samAccountName `
      -Title $Title `
      -Department $Department `
      -Manager $Manager `
      -StreetAddress $StreetAddress `
      -City $City `
      -State $State `
      -PostalCode $Postalcode `
      -Country $Country `
      -ErrorAction Stop  

  }
  catch {

    throw $_.exception  

  } # end try
  
} # end function Create-BulkAdUser