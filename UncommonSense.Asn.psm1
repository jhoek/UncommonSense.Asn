function Get-AsnFundPrice
{
    param
    (
    )

    $DutchCulture = [cultureinfo]::new('nl-NL')

    $Content = Invoke-WebRequest https://www.asnbank.nl/beleggen/koersen.html `
    | Select-Object -ExpandProperty Content `
    | hxnormalize -x -l 1000 -i 0

    $Dates = $Content
    | pup '.fundrates thead tr text{}' --plain
    | ForEach-Object { $_.Trim() }
    | Where-Object { $_ }
    | Select-Object -Skip 1
    | ForEach-Object { [DateTime]::ParseExact($_, 'dd-MM-yyyy', $DutchCulture) }

    $Cells = $Content
    | pup '.fundrates tbody tr td text{}' --plain

    0..($Cells.Length - 1) | ForEach-Object {
        $CurrentIndex = $_

        switch ($true)
        {
            ($CurrentIndex % 4 -eq 0)
            {
                $CurrentFundProperties = [Ordered]@{}
                $CurrentFundProperties.PSTypeName = 'UncommonSense.Asn.FundPrice'
                $CurrentFundProperties.Fund = $Cells[$CurrentIndex]
                break
            }

            ($CurrentIndex % 4 -eq 1)
            {
                $CurrentFundProperties.Date = $Dates[0]
                $CurrentFundProperties.Price = [decimal]::Parse($Cells[$CurrentIndex], $DutchCulture)
                [PSCustomObject]$CurrentFundProperties
                break
            }

            ($CurrentIndex % 4 -eq 2)
            {
                $CurrentFundProperties.Date = $Dates[1]
                $CurrentFundProperties.Price = [decimal]::Parse($Cells[$CurrentIndex], $DutchCulture)
                [PSCustomObject]$CurrentFundProperties
                break
            }

            ($CurrentIndex % 4 -eq 3)
            {
                $CurrentFundProperties.Date = $Dates[2]
                $CurrentFundProperties.Price = [decimal]::Parse($Cells[$CurrentIndex], $DutchCulture)
                [PSCustomObject]$CurrentFundProperties
                break
            }
        }
    }
}

Get-AsnFundPrice