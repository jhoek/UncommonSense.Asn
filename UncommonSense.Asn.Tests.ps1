Describe UncommonSense.Asn {
    BeforeAll {
        Import-Module "$PSScriptRoot/UncommonSense.Asn.psd1" -Force
        $Result = Get-AsnFundPrice
    }

    It 'Returns at least twelve funds, with three dates for each' {
        $Funds = $Result | Group-Object Fund
        $Funds.Length | Should -BeGreaterOrEqual 12

        $Funds | ForEach-Object { $_.Group.Count | Should -BeGreaterOrEqual 3}
        $Funds | ForEach-Object { $_.Name | Should -Not -BeNullOrEmpty}
    }

    It 'Returns recent funds' {
        $Result.Date | Should -BeGreaterThan (Get-Date).AddDays(-7)
    }

    It 'Returns valid prices' {
        $Result.Price | Should -BeGreaterThan 0
    }
}