Describe "Load Active Directory Module" {
    It "Import Active Directory module" {
        .\Import-Ad-Module.ps1 | Should -Be $true
    }
}

Describe "Loading location csv" {
    It "Loading locttion csv" {
        $loadCsvFunc = .\Import-Location-Data.ps1 -FilePath .\cac.csv | ConvertTo-Json
        $loadCsvFile = Import-Csv -path .\cac.csv | ConvertTo-Json
        $loadCsvFunc | Should -be $loadCsvFile
    }
}