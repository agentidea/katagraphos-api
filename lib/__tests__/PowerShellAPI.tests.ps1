import-module $PSScriptRoot/../psRestAPI.psm1

Describe "Test the PowerShell REST API" {
    It "Should be true" {
        SayHello | Should -BeExactly 'hello from powershell'
    }
}
