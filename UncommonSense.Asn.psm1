function ConvertTo-DecimalOrNull
{
    param
    (
        [Parameter(Mandatory, Position = 0)]
        [string]$Value,

        [ValidateNotNull()]
        [CultureInfo]$FormatProvider = [cultureinfo]::GetCultureInfo('nl-NL')
    )

    [decimal]$Result = 0

    switch ([decimal]::TryParse($Value, [System.Globalization.NumberStyles]::Currency, $FormatProvider, [ref]$Result ))
    {
        $true { return $Result }
        $false { return $null }
    }
}

function Get-AsnFundPrice
{
    param
    (
    )

    $Document = ConvertTo-HtmlDocument -Uri https://www.asnbank.nl/beleggen/koersen.html

    $Dates = $Document
    | Select-HtmlNode -CssSelector '.fundrates thead tr th' -All
    | ForEach-Object { $_.InnerText.Trim() }
    | Where-Object { $_ }
    | Select-Object -Skip 1
    | ForEach-Object { [DateTime]::ParseExact($_, 'dd-MM-yyyy', $DutchCulture) }

    $Cells = $Document | Select-HtmlNode -CssSelector '.fundrates tbody tr td' -All

    0..($Cells.Length - 1) | ForEach-Object {
        $CurrentIndex = $_

        switch ($true)
        {
            ($CurrentIndex % 4 -eq 0)
            {
                $CurrentFundProperties = [Ordered]@{}
                $CurrentFundProperties.PSTypeName = 'UncommonSense.Asn.FundPrice'
                $CurrentFundProperties.Fund = [System.Web.HttpUtility]::HtmlDecode($Cells[$CurrentIndex].InnerText)
                break
            }

            ($CurrentIndex % 4 -eq 1)
            {
                $CurrentFundProperties.Date = $Dates[0]
                $CurrentFundProperties.Price = ConvertTo-DecimalOrNull -Value $Cells[$CurrentIndex].InnerText
                [PSCustomObject]$CurrentFundProperties
                break
            }

            ($CurrentIndex % 4 -eq 2)
            {
                $CurrentFundProperties.Date = $Dates[1]
                $CurrentFundProperties.Price = ConvertTo-DecimalOrNull -Value $Cells[$CurrentIndex].InnerText
                [PSCustomObject]$CurrentFundProperties
                break
            }

            ($CurrentIndex % 4 -eq 3)
            {
                $CurrentFundProperties.Date = $Dates[2]
                $CurrentFundProperties.Price = ConvertTo-DecimalOrNull -Value $Cells[$CurrentIndex].InnerText
                [PSCustomObject]$CurrentFundProperties
                break
            }
        }
    }
}