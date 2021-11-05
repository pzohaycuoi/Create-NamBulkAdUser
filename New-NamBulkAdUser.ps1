param (

  [Parameter(Mandatory)]
  [string]$FilePath

)

. .\New-NamAdUser.ps1
. .\common\New-Log.ps1

$logFile = New-Item -Path ".\log" -Name "log-$(get-date -Format ddMMyyyy-hhmmss).txt" -Force
$resultFile = New-Item -Path ".\result" -Name "result-$(get-date -Format ddMMyyyy-hhmmss).csv" -Force

Start-Transcript -Path $logFile.FullName


# Check if path exist
if (Test-Path -Path $FilePath) {

  # Check if file extension is .csv
  if ([IO.Path]::GetExtension($FilePath) -eq ".csv") {

    # Import Csv file
    try {

      $importCsv = Import-Csv -path $FilePath -ErrorAction Stop

      New-Log -Level "INFO" -Message "Import Input Csv file success"

    }
    catch {

      New-Log -Level "ERROR" -Message $_.Exception

      Break

    } # end try

  }
  else {

    New-Log -Level "ERROR" -Message "File type is not csv,"

    Break

  } # end if ([IO.Path]::GetExtension($FilePath) -eq ".csv")

}
else {

  New-Log -Level "ERROR" -Message "Path to file not exist, aborting"

  Break
  
}  # end if (Test-Path -Path $FilePath)


foreach ($row in $importCsv) {
  
  if ($null -eq $row.PREFERED_NAME) {

    $FirstName = $row.FIRST_NAME  

  }
  else {
    
    $FirstName = $row.PREFERED_NAME

  }
  
  $LastName = $row.LAST_NAME
  $Title = $row.JOB_NAME
  $Department = $row.Department
  $Manager = $row."Supervisor AD Account"
  $Location = $row."location code"
  
  $newAdUser = New-NamAdUser -FirstName $FirstName `
    -LastName $LastName `
    -Title $Title `
    -Department $Department `
    -Manager $Manager `
    -Location $Location

  $adUserInfo = [PSCustomObject]@{
    FirstName      = $newAdUser.FirstName
    LastName       = $newAdUser.LastName
    Name           = $newAdUser.Name
    SamAccountName = $newAdUser.SamAccountName
    Title          = $newAdUser.Title
    Department     = $newAdUser.Department
    Manager        = $newAdUser.Manager
    StreetAddress  = $newAdUser.StreetAddress
    City           = $newAdUser.City
    State          = $newAdUser.State
    PostalCode     = $newAdUser.PostalCode
    Country        = $newAdUser.Country
    OuPath         = $newAdUser.OuPath
    Result         = $newAdUser.Result
  }

  $adUserInfo | Export-Csv -Path $resultFile.FullName -NoTypeInformation -Append -Force
  $adUserInfo

} # end foreach ($row in $importCsv)


Stop-Transcript