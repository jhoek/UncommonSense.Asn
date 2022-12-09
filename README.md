# UncommonSense.Asn

PowerShell module for ASN Bank investments funds

## Index

| Command | Synopsis |
| ------- | -------- |
| [Get-AsnFundPrice](#Get-AsnFundPrice) | Get-AsnFundPrice |
| [Convert-HtmlNode](#Convert-HtmlNode) | Convert-HtmlNode [-Property] <IDictionary> -InputObject <HtmlNode[]> [-Mode <ConvertHtmlNodeCmdlet+QueryMode>] [-TypeName <string[]>] [-SkipTrim] [-SkipRemoveLineBreaks] [-SkipFlattenWhitespace] [<CommonParameters>] |
| [ConvertTo-HtmlDocument](#ConvertTo-HtmlDocument) | ConvertTo-HtmlDocument [-Uri] <string[]> [<CommonParameters>]  ConvertTo-HtmlDocument -Text <string[]> [<CommonParameters>] |
| [Select-HtmlNode](#Select-HtmlNode) | Select-HtmlNode -InputObject <HtmlNode[]> -XPath <string> [-All] [<CommonParameters>]  Select-HtmlNode -InputObject <HtmlNode[]> -CssSelector <string> [-All] [<CommonParameters>] |

<a name="Get-AsnFundPrice"></a>
## Get-AsnFundPrice
### Synopsis
Get-AsnFundPrice
### Syntax
```powershell
Get-AsnFundPrice
```
### Parameters
<a name="Convert-HtmlNode"></a>
## Convert-HtmlNode
### Synopsis
Convert-HtmlNode [-Property] <IDictionary> -InputObject <HtmlNode[]> [-Mode <ConvertHtmlNodeCmdlet+QueryMode>] [-TypeName <string[]>] [-SkipTrim] [-SkipRemoveLineBreaks] [-SkipFlattenWhitespace] [<CommonParameters>]
### Syntax
```powershell
Convert-HtmlNode [-Property] <IDictionary> -InputObject <HtmlNode[]> [-Mode <ConvertHtmlNodeCmdlet+QueryMode>] [-TypeName <string[]>] [-SkipTrim] [-SkipRemoveLineBreaks] [-SkipFlattenWhitespace] [<CommonParameters>]
```
### Parameters
#### InputObject &lt;HtmlNode[]&gt;
    
    Required?                    true
    Position?                    Named
    Accept pipeline input?       true (ByValue, ByPropertyName)
    Parameter set name           (All)
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### Mode &lt;ConvertHtmlNodeCmdlet+QueryMode&gt;
    
    Required?                    false
    Position?                    Named
    Accept pipeline input?       false
    Parameter set name           (All)
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### Property &lt;IDictionary&gt;
    
    Required?                    true
    Position?                    0
    Accept pipeline input?       false
    Parameter set name           (All)
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### SkipFlattenWhitespace
    
    Required?                    false
    Position?                    Named
    Accept pipeline input?       false
    Parameter set name           (All)
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### SkipRemoveLineBreaks
    
    Required?                    false
    Position?                    Named
    Accept pipeline input?       false
    Parameter set name           (All)
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### SkipTrim
    
    Required?                    false
    Position?                    Named
    Accept pipeline input?       false
    Parameter set name           (All)
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### TypeName &lt;string[]&gt;
    
    Required?                    false
    Position?                    Named
    Accept pipeline input?       false
    Parameter set name           (All)
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
<a name="ConvertTo-HtmlDocument"></a>
## ConvertTo-HtmlDocument
### Synopsis
ConvertTo-HtmlDocument [-Uri] <string[]> [<CommonParameters>]

ConvertTo-HtmlDocument -Text <string[]> [<CommonParameters>]
### Syntax
```powershell
ConvertTo-HtmlDocument [-Uri] <string[]> [<CommonParameters>]

ConvertTo-HtmlDocument -Text <string[]> [<CommonParameters>]
```
### Output Type(s)

- HtmlAgilityPack.HtmlDocument

### Parameters
#### Text &lt;string[]&gt;
    
    Required?                    true
    Position?                    Named
    Accept pipeline input?       true (ByValue)
    Parameter set name           Text
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### Uri &lt;string[]&gt;
    
    Required?                    true
    Position?                    0
    Accept pipeline input?       false
    Parameter set name           Uri
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
<a name="Select-HtmlNode"></a>
## Select-HtmlNode
### Synopsis
Select-HtmlNode -InputObject <HtmlNode[]> -XPath <string> [-All] [<CommonParameters>]

Select-HtmlNode -InputObject <HtmlNode[]> -CssSelector <string> [-All] [<CommonParameters>]
### Syntax
```powershell
Select-HtmlNode -InputObject <HtmlNode[]> -XPath <string> [-All] [<CommonParameters>]

Select-HtmlNode -InputObject <HtmlNode[]> -CssSelector <string> [-All] [<CommonParameters>]
```
### Output Type(s)

- HtmlAgilityPack.HtmlNode

### Parameters
#### All
    
    Required?                    false
    Position?                    Named
    Accept pipeline input?       false
    Parameter set name           (All)
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### CssSelector &lt;string&gt;
    
    Required?                    true
    Position?                    Named
    Accept pipeline input?       false
    Parameter set name           CssSelector
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
#### InputObject &lt;HtmlNode[]&gt;
    
    Required?                    true
    Position?                    Named
    Accept pipeline input?       true (ByValue, ByPropertyName)
    Parameter set name           (All)
    Aliases                      DocumentNode
    Dynamic?                     false
    Accept wildcard characters?  false
#### XPath &lt;string&gt;
    
    Required?                    true
    Position?                    Named
    Accept pipeline input?       false
    Parameter set name           XPath
    Aliases                      None
    Dynamic?                     false
    Accept wildcard characters?  false
<div style='font-size:small; color: #ccc'>Generated 09-12-2022 09:24</div>
