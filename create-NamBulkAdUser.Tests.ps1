BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}
    
Describe "Load Active Directory Module" {
    It "Import Active Directory module" {
        ImportAdModule
        $getAdModule = Get-Module -Name ActiveDirectory
        $getAdModule.name | Should -Be "ActiveDirectory"
    }
}

Describe "Loading location csv" {
    It "Loading locttion csv" {
        $loadCsvFunc = ImportLoctionData -FilePath .\cac.csv | `
            ConvertTo-Json
        $loadCsvFile = Import-Csv -path .\cac.csv | `
            ConvertTo-Json
        $loadCsvFunc | Should -be $loadCsvFile
    }
}