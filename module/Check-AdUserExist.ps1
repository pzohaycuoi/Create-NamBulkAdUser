function Check-AdUserExist {

  param (
    [Parameter(Mandatory)]
    [string]
    $SamAccountName
  )
  
  try {

    # Check if the AD user exist
    
    $checkAduserExist = Get-ADUser -Identity $SamAccountName -ErrorAction Stop
    
    if (-not $checkAduserExist) {

      return $false

    } else {

      return $true
      
    } # end if (-not $checkAduserExist)

  }
  catch {
    
    Return $false

  } # end try

} # end function Check-AdUserExist