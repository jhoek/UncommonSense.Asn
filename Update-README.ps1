Import-Module (Join-Path -Path $PSScriptRoot -ChildPath UncommonSense.Asn.psd1) -Force

Get-Command -Module UncommonSense.Asn |
    Convert-HelpToMarkDown `
        -Title 'UncommonSense.Asn' `
        -PrefacePath ./PREFACE.md `
        -Description 'PowerShell module for ASN Bank investments funds' |
    Out-File -FilePath (Join-Path -Path $PSScriptRoot -ChildPath README.md) -Encoding utf8