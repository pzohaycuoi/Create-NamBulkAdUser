function Check-AdUserExist {

  param (
    [Parameter(Mandatory)]
    [string]
    $SamAccountName
  )
  
  try {

    # Check if the AD user exist
    
    $checkAduserExist = Get-ADUser -Identity $SamAccountName -ErrorAction Stop
    
    if (-not ($null -eq $checkAduserExist)) {

      return $true

    } else {

      return $false
      
    } # end if (-not $checkAduserExist)

  }
  catch {
    
    Return $false

  } # end try

} # end function Check-AdUserExist