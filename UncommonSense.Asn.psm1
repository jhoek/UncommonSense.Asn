<#
#!/usr/bin/pwsh
function Format-Value($Date, $Value, $PreviousValue)
{
    switch ($true)
    {
        ($PreviousValue -eq 0 -or $Value -eq $PreviousValue) { return "$($Date): &euro;$Value" }
        ($Value -gt $PreviousValue) { return "$($Date): <font color='#090'>&euro;$Value &#x25B2; &euro; $($Value - $PreviousValue)</font>"; break }
        ($Value -lt $PreviousValue) { return "$($Date): <font color='#900'>&euro;$Value &#x25BC; &euro; $($Value - $PreviousValue)</font>" }
    }
}

$Content = Invoke-WebRequest -Uri 'https://www.asnbank.nl/beleggen/koersen.html' | Select-Object -ExpandProperty Content
$Headings = $Content | pup '.fundrates thead tr text{}' --plain | ForEach-Object { $_.Trim() } | Where-Object { $_ }
$Row = $Content | pup '.fundrates tr:nth-of-type(4) text{}' --plain | ForEach-Object { $_.Trim() } | Where-Object { $_ }

$Dates = $Headings[1..3]
$Rates = $Row[1..3] | ForEach-Object { [decimal]::Parse($_, [cultureinfo]::GetCultureInfo('nl-NL')) }
$FundName = $Row[0]

$Message = 0..1 |
    ForEach-Object `
        -Process { Format-Value $Dates[$_] $Rates[$_] $Rates[$_ + 1] }`
        -End { Format-Value $Dates[2] $Rates[2] 0 }

Send-PushoverNotification `
    -ApplicationToken a635f2bxdynw7z839eb49o7dn1312c `
    -Recipient u65ckN1X5uHueh7abnWukQ2owNdhAp `
    -Title $FundName `
    -Message ($Message -join "`n") `
    -Html
 #>

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