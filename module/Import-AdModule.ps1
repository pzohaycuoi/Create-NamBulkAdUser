$scriptDir = $PSScriptRoot
. "$($scriptDir)\..\common\New-Log.ps1"

function Import-AdModule {

  param ()
  
  # try importing AD module
  # Try to import Active Directory module
  try {

    if (-not (Get-Module -Name ActiveDirectory)) {

      New-Log -Level "INFO" -Message "Active Directory module is not loaded, try importing"

      # try to import the Module
      Import-Module -name ActiveDirectory -ErrorAction stop -WarningAction SilentlyContinue
      $null = Get-Module -Name ActiveDirectory -ErrorAction stop  # Query if the AD PSdrive is loaded

      New-Log -Level "INFO" -Message "Import Active Directory module success"

      return $true

    } else {
      
      New-Log -Level "INFO" -Message "Active Directory module is already loaded"

      return $true

    } # end if (-not (Get-Module -Name ActiveDirectory))

  }
  catch {
    
    New-Log -Level "ERROR" -Message "Import Active Directory module failed, aborting"

    return $false

  } # end try

} # end function Import-AdModule