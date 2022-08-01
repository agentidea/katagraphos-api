import-module $PSScriptRoot/../service/psRestAPI.psm1

Describe "Test the PowerShell REST API" {

    It "Should return the correct version" {
        GetVersion | Should -BeExactly '1.0.0'
    }
}
