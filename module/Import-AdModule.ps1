function Import-AdModule {
  
  param ()
  
  # try importing AD module
  # Try to import Active Directory module
  try {

    if (-not (Get-Module -Name ActiveDirectory)) {

      # try to import the Module
      Import-Module -name ActiveDirectory -ErrorAction stop
      $null = Get-Module -Name ActiveDirectory -ErrorAction stop  # Query if the AD PSdrive is loaded

      return $true

    }
    else {
      
      return $true

    } # end if (-not (Get-Module -Name ActiveDirectory))

  }
  catch [System.IO.FileNotFoundException] {

    Write-Output $_.exception
    throw $_.exception

  } # end try

} # end function Import-AdModule