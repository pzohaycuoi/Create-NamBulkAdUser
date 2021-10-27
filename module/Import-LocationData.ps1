$scriptDir = $PSScriptRoot
$defaultDataPath = "$($scriptDir)\..\Data\Location.csv"

function Import-LocationData {
  
  # import location informartion csv file
  param (

    # path to location csv file
    [Parameter()]
    [string]$FilePath = $defaultDataPath
    
  )

  # Check if path exist
  if (Test-Path -Path $FilePath) {

    # Check if file extension is .csv
    if ([IO.Path]::GetExtension($FilePath) -eq ".csv") {

      # Import Csv file
      try {

        $importCsv = Import-Csv -path $FilePath -ErrorAction Stop
        Return $importCsv

      }
      catch {

        throw $_.exception

      } # end try

    }
    else {

      return $false

    } # end if ([IO.Path]::GetExtension($FilePath) -eq ".csv")

  }
  else {

    return $false
  
  }  # end if (Test-Path -Path $FilePath)

} # end function Import-LocationData