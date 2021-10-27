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

        $locationDataPath = "$($scriptDir)\..\data\location.csv"

        $loadCsvFunc = Import-LocationData -FilePath $locationDataPath | ConvertTo-Json
        $loadCsvFile = Import-Csv -path $locationDataPath | ConvertTo-Json
        $loadCsvFunc | Should Be $loadCsvFile

    }

}

Describe "Reference test from json" {

    It "Reference test from json" {

        $testCase = Get-Content "$($scriptDir)\..\test\Data\single-user-should-be.json" | ConvertFrom-Json | ConvertTo-Json

        $loadLocationData = Import-LocationData

        $testDataPath = "$($scriptDir)\..\test\Data\single-user.json"
        $loadTestData = Get-Content -Path $testDataPath | ConvertFrom-Json

        $referenceFinalizedData = Reference-DataAndLocation -InputData $loadTestData -ReferenceData $loadLocationData

        $referenceFinalizedData | ConvertTo-Json | Should Be $testCase

    }

}

Describe "testing combination of module expect Create-AdUser" {

    It "testing combination of module expect Create-AdUser" {

        $testCase = Get-Content "$($scriptDir)\..\test\Data\single-user-should-be.json" | ConvertFrom-Json | ConvertTo-Json

        # run the script
        "$($scriptDir)\..\main.ps1 -FirstName $($testCase.FirstName)"



    }

}