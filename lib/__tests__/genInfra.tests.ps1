import-module ../service/katagraphosRestAPI.psm1
# import-module $PSScriptRoot/../config/global.psm1

Describe "Test REST APIs plumbing and generalized functions" {

    It "Should return the correct version" {
        GetVersion | Should -BeExactly '1.0.0'
    }
}


Describe "Test file related functions" {

    It "Should return the correct file name" {
        InvokeFileExtensionChecker 'joy'| Should -BeExactly 'joy.xlsx'
    }
}
