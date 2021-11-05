$scriptDir = $PSScriptRoot
. "$($scriptDir)\Check-AdUserExist.ps1"
. "$($scriptDir)\..\common\New-Log.ps1"

function Create-AdUser {

  # create ad user function
  param (

    [Parameter(Mandatory)]
    [System.Object]
    $InputData
  
  )

  $FirstName = $InputData.FirstName
  $LastName = $InputData.LastName
  $Title = $InputData.Title
  $Department = $InputData.Department
  $Manager = $InputData.Manager
  $StreetAddress = $InputData.StreetAddress
  $City = $InputData.City
  $State = $InputData.State
  $PostalCode = $InputData.PostalCode
  $Country = $InputData.Country
  $OuPath = $InputData.OuPath
  $password = "Welcome2021!@#$" | ConvertTo-SecureString -AsPlainText -Force

  # required parameters base on input data for new-aduser command
  $Name = "$($FirstName), $($LastName)"
  $samAccountName = "$($FirstName[0])$($LastName)"

  # Check if user exist yet
  if ($false -eq (Check-AdUserExist -SamAccountName $samAccountName)) {

    New-Log -Level "INFO" -Message "User with SamAccountName $($samAccountName) is not exist yet, checking Name"

  }
  else {

    New-Log -Level "WARN" -Message "User with SamAccountName $($samAccountName) is exist, finding new samAccountName"

    # if user with samAccountName exist then add number into samAccountName until $null
    $countSam = 0

    do {

      $countSam++
      $newSamAccountName = "$($samAccountName)$($countSam)"

    } until ($false -eq (Check-AdUserExist -SamAccountName $newSamAccountName))

    $samAccountName = $newSamAccountName

    New-Log -Level "INFO" -Message "User with samAccountName $($samAccountName) is not exist yet, checking Name"

  } # end if ($true -eq (Check-AdUserExist -SamAccountName $samAccountName))

  if ($null -eq (Get-ADUser -Filter {name -like $Name} -Properties name)) {

    New-Log -Level "INFO" -Message "User with Name $($Name) is not exist yet, creating"

  }
  else {

    New-Log -Level "WARN" -Message "User with Name $($Name) is exist, finding new Name"

    # if user with samAccountName exist then add number into samAccountName until $null
    $countName = 0

    do {

      $countName++
      $newName = "$($Name)$($countName)"

    } until ($null -eq (Get-ADUser -Filter {name -like $newName} -Properties name))

    $Name = $newName

    New-Log -Level "INFO" -Message "User with Name $($Name) is not exist yet, creating"

  } # end if ($true -eq (Check-AdUserExist -SamAccountName $samAccountName))

  $adUserInfo = [PSCustomObject]@{
    FirstName = $FirstName
    LastName = $LastName
    Name = $Name
    SamAccountName = $SamAccountName
    Title = $Title
    Department = $Department
    Manager = $Manager
    StreetAddress = $StreetAddress
    City = $City
    State = $State
    PostalCode = $PostalCode
    Country = $Country
    OuPath = $OuPath
  }

  # check if manager's exist
  if (($false -eq (Check-AdUserExist -SamAccountName $Manager)) -or ("" -eq (Check-AdUserExist -SamAccountName $Manager))) {
    
    New-Log -Level "WARN" -Message "Manager with SamAccountName $($Manager) is not exist, creating user $($samAccountName) without Manager"

    try {

      New-ADUser  -Name $Name `
        -DisplayName $Name `
        -GivenName $FirstName `
        -Surname $LastName `
        -SamAccountName $samAccountName `
        -UserPrincipalName $samAccountName `
        -Title $Title `
        -Department $Department `
        -StreetAddress $StreetAddress `
        -City $City `
        -State $State `
        -PostalCode $Postalcode `
        -Country $Country `
        -Path $OuPath `
        -AccountPassword $password `
        -ChangePasswordAtLogon $true `
        -ErrorAction Stop  

        Set-ADUser -Identity $samAccountName `
        -Enabled $true
      
      New-Log -Level "INFO" -Message "User $($samAccountName) is successfully created"
      New-Log -Level "INFO" -Message "User $($samAccountName), full name: $($Name)"
      New-Log -Level "INFO" -Message "User $($samAccountName), display name: $($Name)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Given name: $($FirstName)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Sur name: $($LastName)"
      New-Log -Level "INFO" -Message "User $($samAccountName), SamAccountName: $($SamAccountName)"
      New-Log -Level "INFO" -Message "User $($samAccountName), UserPrincipalName: $($SamAccountName)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Title: $($Title)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Department: $($Department)"
      New-Log -Level "INFO" -Message "User $($samAccountName), StreetAddress: $($StreetAddress)"
      New-Log -Level "INFO" -Message "User $($samAccountName), City: $($City)"
      New-Log -Level "INFO" -Message "User $($samAccountName), State: $($State)"
      New-Log -Level "INFO" -Message "User $($samAccountName), PostalCode: $($PostalCode)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Country: $($Country)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Path: $($OuPath)"

      $adUserInfo | Add-Member -MemberType NoteProperty -Name "Result" -Value "SUCCESS"

      return $adUserInfo

    }
    catch {
  
      New-Log -Level "ERROR" -Message $_.Exception

      $adUserInfo | Add-Member -MemberType NoteProperty -Name "Result" -Value "FAIL"

      return $false

    } # end try

  }
  else {
    
    try {

      New-ADUser -Name $Name `
        -DisplayName $Name `
        -GivenName $FirstName `
        -Surname $LastName `
        -SamAccountName $samAccountName `
        -UserPrincipalName $samAccountName `
        -Title $Title `
        -Department $Department `
        -Manager $Manager `
        -StreetAddress $StreetAddress `
        -City $City `
        -State $State `
        -PostalCode $Postalcode `
        -Country $Country `
        -Path $OuPath `
        -AccountPassword $password `
        -ChangePasswordAtLogon $true `
        -ErrorAction Stop  

      Set-ADUser -Identity $samAccountName `
        -Enabled $true

      New-Log -Level "INFO" -Message "User $($samAccountName) is successfully created"
      New-Log -Level "INFO" -Message "User $($samAccountName), full name: $($Name)"
      New-Log -Level "INFO" -Message "User $($samAccountName), display name: $($Name)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Given name: $($FirstName)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Sur name: $($LastName)"
      New-Log -Level "INFO" -Message "User $($samAccountName), SamAccountName: $($SamAccountName)"
      New-Log -Level "INFO" -Message "User $($samAccountName), UserPrincipalName: $($SamAccountName)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Title: $($Title)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Department: $($Department)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Manager: $($Manager)"
      New-Log -Level "INFO" -Message "User $($samAccountName), StreetAddress: $($StreetAddress)"
      New-Log -Level "INFO" -Message "User $($samAccountName), City: $($City)"
      New-Log -Level "INFO" -Message "User $($samAccountName), State: $($State)"
      New-Log -Level "INFO" -Message "User $($samAccountName), PostalCode: $($PostalCode)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Country: $($Country)"
      New-Log -Level "INFO" -Message "User $($samAccountName), Path: $($OuPath)"

      $adUserInfo | Add-Member -MemberType NoteProperty -Name "Result" -Value "SUCCESS"

      return $adUserInfo

    }
    catch {

      New-Log -Level "ERROR" -Message $_.Exception

      $adUserInfo | Add-Member -MemberType NoteProperty -Name "Result" -Value "FAIL"
  
      return $adUserInfo
  
    } # end try

  } # end if ($false -eq (Check-AdUserExist -SamAccountName $Manager))
  
} # end function Create-BulkAdUser