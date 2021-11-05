$scriptDir = $PSScriptRoot
. "$($scriptDir)\..\common\New-Log.ps1"

$defaultDataPath = "$($scriptDir)\..\Data\Location.csv"

function Import-LocationData {
  
  # import location informartion csv file
  param (

    # path to location csv file
    [Parameter()]
    [string]$FilePath = $defaultDataPath
    
  )

  New-Log -Level "INFO" -Message "Checking if path to file exist"

  # Check if path exist
  if (Test-Path -Path $FilePath) {

    # Check if file extension is .csv
    if ([IO.Path]::GetExtension($FilePath) -eq ".csv") {

      # Import Csv file
      try {

        $importCsv = Import-Csv -path $FilePath -ErrorAction Stop

        New-Log -Level "INFO" -Message "Import Location Csv file success"

        Return $importCsv

      }
      catch {

        New-Log -Level "ERROR" -Message $_.Exception

        Return $false

      } # end try

    }
    else {

      New-Log -Level "ERROR" -Message "File type is not csv, aborting"

      return $false

    } # end if ([IO.Path]::GetExtension($FilePath) -eq ".csv")

  }
  else {

    New-Log -Level "ERROR" -Message "Path to file not exist, aborting"

    return $false
  
  }  # end if (Test-Path -Path $FilePath)

} # end function Import-LocationData