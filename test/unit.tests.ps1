# Current path where the script run
$scriptDir = $PSScriptRoot

# module folder path
$modulePath = "$($scriptDir)\..\module\"

# get all the powershell module in the module folder
$moduleList = Get-ChildItem -Path $modulePath | Where-Object { $_.name -like "*.ps1" }

# foreach module in that folder, import it
foreach ($module in $moduleList) {

    . "$($module.FullName)"

} # end foreach ($module in $moduleList)

Describe "Load Active Directory Module" {

    It "Import Active Directory module" {

        Import-AdModule | Should Be $true

    }

}

Describe "Loading location csv" {

    It "Loading locttion csv" {

        $dataPath = "$($scriptDir)\..\data\location.csv"

        $loadCsvFunc = Import-LocationData -FilePath $dataPath | ConvertTo-Json
        $loadCsvFile = Import-Csv -path $dataPath | ConvertTo-Json
        $loadCsvFunc | Should Be $loadCsvFile

    }

}