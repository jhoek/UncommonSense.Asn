function Get-AsnFundPrice
{
    param
    (
    )

    $DutchCulture = [cultureinfo]::new('nl-NL')
    $CurrentFundProperties = [Ordered]@{ }

    $Content = Invoke-WebRequest https://www.asnbank.nl/beleggen/koersen.html `
    | Select-Object -ExpandProperty Content `
    | hxnormalize -x -l 1000 -i 0

    $PriceDate = $Content `
    | hxselect -c -s '\n' 'h3:nth-of-type(1)' `
    | Select-String -Pattern '^Rendementen per .*? en koersen per (.*)$' `
    | Select-Object -ExpandProperty Matches `
    | Select-Object -ExpandProperty Groups `
    | Select-Object -Skip 1 `
    | Select-Object -ExpandProperty Value `
    | ForEach-Object { [DateTime]::ParseExact($_, 'd-M-yy', $DutchCulture) }

    $Content | hxextract table - `
    | hxremove -i 'tr:nth-of-type(1)' `
    | hxremove -i 'td:nth-of-type(3)' `
    | hxremove -i 'td:nth-of-type(3)' `
    | hxremove -i 'td:nth-of-type(3)' `
    | hxremove -i 'td:nth-of-type(3)' `
    | hxremove -i 'td:nth-of-type(3)' `
    | xml2 `
    | Where-Object { $_ -like '/table/tbody/tr/td/p*' } `
    | ForEach-Object {
        switch -regex ($_)
        {
            '^/table/tbody/tr/td/p/b=(.*)\s*$'
            {
                $CurrentFundProperties.PSTypeName = 'UncommonSense.Asn.FundPrice'
                $CurrentFundProperties.Date = $PriceDate
                $CurrentFundProperties.Fund = $Matches[1]
            }

            '/table/tbody/tr/td/p=€ (.*)\s*$'
            {
                $CurrentFundProperties.Price = [decimal]::Parse($Matches[1], $DutchCulture)
                [PSCustomObject]$CurrentFundProperties

                $CurrentFundProperties = [Ordered]@{ }
            }
        }
    }
}