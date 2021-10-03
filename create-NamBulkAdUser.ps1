# try importing AD module
function ImportAdModule {
  # Try to import Active Directory module
  try {
    if ( -not (Get-Module -Name ActiveDirectory) ) {
      # try to import the Module
      Import-Module -name ActiveDirectory -ErrorAction stop
      $null = Get-Module -Name ActiveDirectory -ErrorAction stop  # Query if the AD PSdrive is loaded
    }
  }
  catch [System.IO.FileNotFoundException] {
    Write-Output $_.exception
    throw "AD module not found"
  }
  catch {
    throw $_.exception
  }
}

# import location informartion csv file
function ImportLoctionData {
  param (
    # path to location csv file
    [Parameter(Mandatory)]
    [String]
    $FilePath
  )

  # Check if path exist
  if (Test-Path -Path $FilePath) {
    # Check if file extension is .csv
    if ([IO.Path]::GetExtension($FilePath) -eq ".csv") {
      # Import Csv file
      try {
        $importCsv = Import-Csv -path $FilePath -ErrorAction Stop
      }
      catch {
        Write-Output $_.exception
        throw "Unable to import csv file"
      }  
    }
    else {
      throw "File type is not CSV"
    }
  }
  else {
    throw "File not found"
  }

  Return $importCsv

}

function CreateAdUser {
  param (
    [Parameter()]
    [TypeName]
    $ParameterName
  )
}