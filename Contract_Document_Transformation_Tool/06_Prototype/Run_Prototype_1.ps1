$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.IO.Compression.FileSystem

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptRoot

function Write-Utf8File {
    param(
        [string]$Path,
        [string]$Content
    )

    $directory = Split-Path -Parent $Path
    if ($directory -and -not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $Content, $utf8NoBom)
}

function Get-JsonConfig {
    param([string]$Path)
    Get-Content -Raw -Path $Path | ConvertFrom-Json
}

function Get-SafeFileName {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return "TBD"
    }

    $clean = $Value -replace '[\\/:*?"<>|]', '_'
    $clean = $clean -replace '\s+', ' '
    return $clean.Trim()
}

function Get-ShortLabel {
    param(
        [string]$Value,
        [int]$MaxLength = 32
    )

    $safe = Get-SafeFileName $Value
    if ($safe.Length -le $MaxLength) {
        return $safe
    }

    return $safe.Substring(0, $MaxLength)
}

function Escape-XmlText {
    param([string]$Value)

    if ($null -eq $Value) {
        return ""
    }

    return [System.Security.SecurityElement]::Escape([string]$Value)
}

function Convert-HexUnicodeString {
    param([string]$HexValue)

    if ([string]::IsNullOrWhiteSpace($HexValue)) {
        return ""
    }

    $normalized = ($HexValue -replace '\s+', '')
    if ($normalized.StartsWith("FEFF")) {
        $normalized = $normalized.Substring(4)
    }

    if (($normalized.Length % 2) -ne 0) {
        return ""
    }

    $bytes = New-Object byte[] ($normalized.Length / 2)
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $bytes[$i] = [Convert]::ToByte($normalized.Substring($i * 2, 2), 16)
    }

    return [System.Text.Encoding]::BigEndianUnicode.GetString($bytes)
}

function Get-PdfMetadataHints {
    param([string]$Path)

    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)

    $hexMatches = [regex]::Matches($ascii, '/(Title|Creator|Producer|Author)\s*<([^>]+)>')
    $hexValues = @{}
    foreach ($match in $hexMatches) {
        $key = $match.Groups[1].Value
        $value = Convert-HexUnicodeString $match.Groups[2].Value
        if (-not [string]::IsNullOrWhiteSpace($value) -and -not $hexValues.ContainsKey($key)) {
            $hexValues[$key] = $value
        }
    }

    $asciiMatches = [regex]::Matches($ascii, '[ -~]{10,}')
    $asciiValues = @()
    foreach ($match in $asciiMatches) {
        $value = $match.Value.Trim()
        if ($value -and $asciiValues -notcontains $value) {
            $asciiValues += $value
        }
    }

    [pscustomobject]@{
        title = if ($hexValues.ContainsKey("Title")) { $hexValues["Title"] } else { "" }
        creator = if ($hexValues.ContainsKey("Creator")) { $hexValues["Creator"] } else { "" }
        producer = if ($hexValues.ContainsKey("Producer")) { $hexValues["Producer"] } else { "" }
        author = if ($hexValues.ContainsKey("Author")) { $hexValues["Author"] } else { "" }
        ascii_snippets = $asciiValues | Select-Object -First 12
    }
}

function Get-PeriodLabel {
    param(
        [string]$ProjectTitle,
        [string]$DefaultValue
    )

    if ($ProjectTitle -match '(20[0-9]{2}[^ ]*)') {
        return $matches[1]
    }

    return $DefaultValue
}

function Get-InputMetadata {
    param([System.IO.FileInfo[]]$Files)

    $fullwidthSpace = [char]0x3000
    $towardsKeyword = ([string][char]0x5411) + ([char]0x3051)

    $orderedFiles = $Files | Sort-Object Name
    $fileNames = $orderedFiles.Name
    $joinedNames = $fileNames -join " "

    $estimateNo = "TBD_NO"
    if ($joinedNames -match '(26Q[0-9]+)') {
        $estimateNo = $matches[1]
    }

    $docTypes = @()
    foreach ($name in $fileNames) {
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($name)
        $docTypePattern = '^([^_' + [regex]::Escape([string]$fullwidthSpace) + ' ]+)'
        if ($baseName -match $docTypePattern) {
            $docTypes += $matches[1]
        }
    }
    $docTypes = $docTypes | Select-Object -Unique

    $estimateFile = $orderedFiles | Where-Object { $_.BaseName -match '26Q[0-9]+' } | Select-Object -First 1
    $orderFile = $orderedFiles | Where-Object { $_.BaseName -notmatch '26Q[0-9]+' } | Select-Object -First 1

    $rawTitle = ""
    if ($estimateFile) {
        $estimateParts = $estimateFile.BaseName -split '_'
        if ($estimateParts.Count -ge 3) {
            $rawTitle = $estimateParts[2]
        }
    }

    if ([string]::IsNullOrWhiteSpace($rawTitle) -and $orderFile) {
        $orderParts = $orderFile.BaseName -split "[$fullwidthSpace ]+"
        if ($orderParts.Count -ge 2) {
            $rawTitle = ($orderParts[1..($orderParts.Count - 1)] -join " ")
        }
    }

    if ([string]::IsNullOrWhiteSpace($rawTitle) -and $orderFile -and $orderFile.BaseName -match '^[^_]+_(.+)$') {
        $rawTitle = $matches[1]
    }

    if ([string]::IsNullOrWhiteSpace($rawTitle) -and $orderedFiles.Count -gt 0) {
        $rawTitle = $orderedFiles[0].BaseName
    }

    if ($rawTitle -match '^[^_ ]+[ _](26Q[0-9]+)[ _](.+)$') {
        $rawTitle = $matches[2]
    }

    $projectTitle = ($rawTitle -replace '_', ' ').Trim()
    $customerName = "TBD_CUSTOMER"
    $projectScope = $projectTitle

    $towardsPattern = '^(?<customer>.+?)' + [regex]::Escape($towardsKeyword) + '(?<scope>.+)$'
    if ($projectTitle -match $towardsPattern) {
        $customerName = $matches['customer'].Trim()
        $projectScope = $matches['scope'].Trim()
    }

    $systemName = $projectScope
    if ($projectScope -match '^([^ ]+)') {
        $systemName = $matches[1].Trim()
    }

    $estimateHints = if ($estimateFile) { Get-PdfMetadataHints -Path $estimateFile.FullName } else { $null }
    $orderHints = if ($orderFile) { Get-PdfMetadataHints -Path $orderFile.FullName } else { $null }

    [pscustomobject]@{
        customer_name = $customerName
        request_or_estimate_no = $estimateNo
        input_document_types = $docTypes
        project_title = $projectTitle
        project_scope = $projectScope
        system_name = $systemName
        period_label = Get-PeriodLabel -ProjectTitle $projectTitle -DefaultValue "TBD_PERIOD"
        estimate_pdf_title_hint = if ($estimateHints) { $estimateHints.title } else { "" }
        order_pdf_title_hint = if ($orderHints) { $orderHints.title } else { "" }
        estimate_ascii_snippets = if ($estimateHints) { $estimateHints.ascii_snippets } else { @() }
        order_ascii_snippets = if ($orderHints) { $orderHints.ascii_snippets } else { @() }
    }
}

function New-GeneratedFileNames {
    param([pscustomobject]$Metadata)

    $requestNo = Get-ShortLabel -Value $Metadata.request_or_estimate_no -MaxLength 20
    $customer = Get-ShortLabel -Value $Metadata.customer_name -MaxLength 24
    $system = Get-ShortLabel -Value $Metadata.system_name -MaxLength 24

    @(
        [pscustomobject]@{
            OutputCategory = "final_summary_docx"
            SuggestedFileName = "${requestNo}_contract_summary_${customer}_${system}.docx"
        }
        [pscustomobject]@{
            OutputCategory = "transformation_workbook_xlsx"
            SuggestedFileName = "${requestNo}_contract_workbook_${customer}_${system}.xlsx"
        }
        [pscustomobject]@{
            OutputCategory = "review_workbook_xlsx"
            SuggestedFileName = "${requestNo}_review_workbook_${customer}_${system}.xlsx"
        }
        [pscustomobject]@{
            OutputCategory = "result_manifest_json"
            SuggestedFileName = "${requestNo}_result_manifest.json"
        }
    )
}

function Get-ExcelColumnName {
    param([int]$ColumnNumber)

    $name = ""
    $number = $ColumnNumber
    while ($number -gt 0) {
        $remainder = ($number - 1) % 26
        $name = [char](65 + $remainder) + $name
        $number = [math]::Floor(($number - 1) / 26)
    }

    return $name
}

function New-WorksheetXml {
    param([object[][]]$Rows)

    $xmlRows = New-Object System.Collections.Generic.List[string]
    for ($r = 0; $r -lt $Rows.Count; $r++) {
        $rowIndex = $r + 1
        $cells = New-Object System.Collections.Generic.List[string]
        $currentRow = $Rows[$r]
        for ($c = 0; $c -lt $currentRow.Count; $c++) {
            $columnRef = Get-ExcelColumnName ($c + 1)
            $cellRef = "$columnRef$rowIndex"
            $value = ""
            if ($null -ne $currentRow[$c]) {
                $value = [string]$currentRow[$c]
            }
            $escapedValue = Escape-XmlText $value
            $cells.Add("<c r=""$cellRef"" t=""inlineStr""><is><t xml:space=""preserve"">$escapedValue</t></is></c>")
        }
        $xmlRows.Add("<row r=""$rowIndex"">$($cells -join '')</row>")
    }

    return @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <sheetData>
    $($xmlRows -join "`n    ")
  </sheetData>
</worksheet>
"@
}

function New-XlsxWorkbook {
    param(
        [string]$OutputPath,
        [hashtable]$Sheets
    )

    $tempDir = Join-Path ([System.IO.Path]::GetDirectoryName($OutputPath)) ([System.IO.Path]::GetFileNameWithoutExtension($OutputPath) + "_xlsx")
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }

    New-Item -ItemType Directory -Path $tempDir | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir '_rels') | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir 'xl') | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir 'xl\_rels') | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir 'xl\worksheets') | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir 'docProps') | Out-Null

    $sheetEntries = @()
    $sheetRels = @()
    $sheetContentTypes = @()
    $sheetIndex = 1
    foreach ($sheetName in $Sheets.Keys) {
        $sheetFileName = "sheet$sheetIndex.xml"
        $sheetPath = Join-Path $tempDir "xl\worksheets\$sheetFileName"
        Write-Utf8File -Path $sheetPath -Content (New-WorksheetXml -Rows $Sheets[$sheetName])

        $escapedSheetName = Escape-XmlText $sheetName
        $sheetEntries += "<sheet name=""$escapedSheetName"" sheetId=""$sheetIndex"" r:id=""rId$sheetIndex""/>"
        $sheetRels += "<Relationship Id=""rId$sheetIndex"" Type=""http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet"" Target=""worksheets/$sheetFileName""/>"
        $sheetContentTypes += "<Override PartName=""/xl/worksheets/$sheetFileName"" ContentType=""application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml""/>"
        $sheetIndex++
    }

    Write-Utf8File -Path (Join-Path $tempDir '[Content_Types].xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
  <Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
  <Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
  $($sheetContentTypes -join "`n  ")
</Types>
"@

    Write-Utf8File -Path (Join-Path $tempDir '_rels\.rels') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>
  <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>
</Relationships>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'xl\workbook.xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheets>
    $($sheetEntries -join "`n    ")
  </sheets>
</workbook>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'xl\_rels\workbook.xml.rels') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  $($sheetRels -join "`n  ")
  <Relationship Id="rId99" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
</Relationships>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'xl\styles.xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <fonts count="1">
    <font>
      <sz val="11"/>
      <name val="Calibri"/>
    </font>
  </fonts>
  <fills count="1">
    <fill><patternFill patternType="none"/></fill>
  </fills>
  <borders count="1">
    <border><left/><right/><top/><bottom/><diagonal/></border>
  </borders>
  <cellStyleXfs count="1">
    <xf numFmtId="0" fontId="0" fillId="0" borderId="0"/>
  </cellStyleXfs>
  <cellXfs count="1">
    <xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>
  </cellXfs>
  <cellStyles count="1">
    <cellStyle name="Normal" xfId="0" builtinId="0"/>
  </cellStyles>
</styleSheet>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'docProps\core.xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dc:title>Contract Transformation Workbook</dc:title>
  <dc:creator>Codex Prototype</dc:creator>
  <cp:lastModifiedBy>Codex Prototype</cp:lastModifiedBy>
  <dcterms:created xsi:type="dcterms:W3CDTF">$(Get-Date -Format s)Z</dcterms:created>
  <dcterms:modified xsi:type="dcterms:W3CDTF">$(Get-Date -Format s)Z</dcterms:modified>
</cp:coreProperties>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'docProps\app.xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <Application>Codex Prototype</Application>
</Properties>
"@

    if (Test-Path $OutputPath) {
        Remove-Item -Path $OutputPath -Force
    }
    [System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $OutputPath)
    Remove-Item -Path $tempDir -Recurse -Force
}

function New-DocxDocument {
    param(
        [string]$OutputPath,
        [string]$Title,
        [string[]]$Paragraphs
    )

    $tempDir = Join-Path ([System.IO.Path]::GetDirectoryName($OutputPath)) ([System.IO.Path]::GetFileNameWithoutExtension($OutputPath) + "_docx")
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }

    New-Item -ItemType Directory -Path $tempDir | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir '_rels') | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir 'docProps') | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir 'word') | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $tempDir 'word\_rels') | Out-Null

    $allParagraphs = @($Title) + $Paragraphs
    $paragraphXml = foreach ($paragraph in $allParagraphs) {
        $escaped = Escape-XmlText $paragraph
        "<w:p><w:r><w:t xml:space=""preserve"">$escaped</w:t></w:r></w:p>"
    }

    Write-Utf8File -Path (Join-Path $tempDir '[Content_Types].xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
  <Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
  <Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
</Types>
"@

    Write-Utf8File -Path (Join-Path $tempDir '_rels\.rels') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>
  <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>
</Relationships>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'word\document.xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" mc:Ignorable="w14 wp14">
  <w:body>
    $($paragraphXml -join "`n    ")
    <w:sectPr>
      <w:pgSz w:w="11906" w:h="16838"/>
      <w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440" w:header="708" w:footer="708" w:gutter="0"/>
    </w:sectPr>
  </w:body>
</w:document>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'word\styles.xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:style w:type="paragraph" w:default="1" w:styleId="Normal">
    <w:name w:val="Normal"/>
  </w:style>
</w:styles>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'word\_rels\document.xml.rels') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"/>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'docProps\core.xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dc:title>$(Escape-XmlText $Title)</dc:title>
  <dc:creator>Codex Prototype</dc:creator>
  <cp:lastModifiedBy>Codex Prototype</cp:lastModifiedBy>
  <dcterms:created xsi:type="dcterms:W3CDTF">$(Get-Date -Format s)Z</dcterms:created>
  <dcterms:modified xsi:type="dcterms:W3CDTF">$(Get-Date -Format s)Z</dcterms:modified>
</cp:coreProperties>
"@

    Write-Utf8File -Path (Join-Path $tempDir 'docProps\app.xml') -Content @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <Application>Codex Prototype</Application>
</Properties>
"@

    if (Test-Path $OutputPath) {
        Remove-Item -Path $OutputPath -Force
    }
    [System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $OutputPath)
    Remove-Item -Path $tempDir -Recurse -Force
}

function New-TransformationReport {
    param(
        [string]$OutputPath,
        [string]$RunTimestamp,
        [System.IO.FileInfo[]]$InputFiles,
        [System.IO.FileInfo[]]$ReferenceFiles,
        [pscustomobject]$Metadata,
        [object[]]$GeneratedNames,
        [string[]]$FinalOutputNames
    )

    $inputList = ($InputFiles | ForEach-Object { "- $($_.Name)" }) -join "`n"
    $referenceList = ($ReferenceFiles | ForEach-Object { "- $($_.Name)" }) -join "`n"
    $generatedList = ($GeneratedNames | ForEach-Object { "- [$($_.OutputCategory)] $($_.SuggestedFileName)" }) -join "`n"
    $finalList = ($FinalOutputNames | ForEach-Object { "- $_" }) -join "`n"
    $estimateHints = ($Metadata.estimate_ascii_snippets | Select-Object -First 5) -join "; "
    $orderHints = ($Metadata.order_ascii_snippets | Select-Object -First 5) -join "; "

$content = @"
# Transformation Report

## Run Timestamp

Value: $RunTimestamp

## Input Files

$inputList

## Reference Output Files

$referenceList

## Extracted Metadata

- Customer: $($Metadata.customer_name)
- Project Title: $($Metadata.project_title)
- Project Scope: $($Metadata.project_scope)
- System Name: $($Metadata.system_name)
- Estimate No: $($Metadata.request_or_estimate_no)
- Period Label: $($Metadata.period_label)
- Input Document Types: $((($Metadata.input_document_types) -join ', '))
- Estimate PDF Title Hint: $($Metadata.estimate_pdf_title_hint)
- Order PDF Title Hint: $($Metadata.order_pdf_title_hint)

## Final Output Files

$finalList

## Generated Naming Plan

$generatedList

## Extraction Notes

- PDF body extraction is still heuristic. This run uses filename extraction plus embedded PDF metadata hints.
- Estimate PDF hints: $estimateHints
- Order PDF hints: $orderHints
- Review workbook must still be signed off by reviewer before external use.
"@

    Write-Utf8File -Path $OutputPath -Content $content
}

$config = Get-JsonConfig -Path (Join-Path $scriptRoot 'config\prototype_settings.json')

$inputDir = Join-Path $projectRoot $config.input_dir
$referenceOutputDir = Join-Path $projectRoot $config.reference_output_dir
$reviewTemplate = Join-Path $projectRoot $config.review_checklist_template
$generatedRoot = Join-Path $projectRoot $config.output_dir

if (-not (Test-Path $generatedRoot)) {
    New-Item -ItemType Directory -Path $generatedRoot | Out-Null
}

$runTimestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$runDir = Join-Path $generatedRoot $runTimestamp
New-Item -ItemType Directory -Path $runDir | Out-Null
$finalOutputDir = Join-Path $runDir 'final_outputs'
New-Item -ItemType Directory -Path $finalOutputDir | Out-Null

$inputFiles = Get-ChildItem -Path $inputDir -File | Where-Object { $_.Extension -ne '.md' }
$referenceFiles = Get-ChildItem -Path $referenceOutputDir -File | Where-Object { $_.Extension -ne '.md' }

$metadata = Get-InputMetadata -Files $inputFiles
if ($metadata.period_label -eq "TBD_PERIOD") {
    $metadata.period_label = $config.default_period_label
}

$fieldValues = [ordered]@{
    run_timestamp = $runTimestamp
    customer_name = $metadata.customer_name
    project_title = $metadata.project_title
    project_scope = $metadata.project_scope
    system_name = $metadata.system_name
    request_or_estimate_no = $metadata.request_or_estimate_no
    input_document_types = $metadata.input_document_types
    period_label = $metadata.period_label
    document_category = $config.default_document_category
    template_version = $config.default_template_version
    rule_version = $config.default_rule_version
    input_file_count = $inputFiles.Count
    reference_output_file_count = $referenceFiles.Count
    estimate_pdf_title_hint = $metadata.estimate_pdf_title_hint
    order_pdf_title_hint = $metadata.order_pdf_title_hint
}

$generatedNames = New-GeneratedFileNames -Metadata $metadata
$generatedNameMap = @{}
foreach ($generatedName in $generatedNames) {
    $generatedNameMap[$generatedName.OutputCategory] = $generatedName.SuggestedFileName
}

$summary = [ordered]@{
    project_name = $config.project_name
    run_timestamp = $runTimestamp
    input_files = $inputFiles.Name
    reference_output_files = $referenceFiles.Name
    extracted_metadata = $fieldValues
}

$reviewRows = Import-Csv -Path $reviewTemplate
$reviewRowsForSheet = @(@("CheckID", "Category", "CheckPoint", "Severity", "ReviewerRequired", "Notes"))
foreach ($row in $reviewRows) {
    $reviewRowsForSheet += ,@($row.CheckID, $row.Category, $row.CheckPoint, $row.Severity, $row.ReviewerRequired, $row.Notes)
}

$sourceRows = @(@("FileName", "Extension", "Length", "LastWriteTime"))
foreach ($file in $inputFiles) {
    $sourceRows += ,@($file.Name, $file.Extension, $file.Length, $file.LastWriteTime.ToString("s"))
}

$fieldRows = @(@("FieldName", "FieldValue"))
foreach ($key in $fieldValues.Keys) {
    $value = $fieldValues[$key]
    if ($value -is [System.Array]) {
        $value = ($value -join " | ")
    }
    $fieldRows += ,@($key, $value)
}

$generatedRows = @(@("OutputCategory", "SuggestedFileName"))
foreach ($generatedName in $generatedNames) {
    $generatedRows += ,@($generatedName.OutputCategory, $generatedName.SuggestedFileName)
}

$reviewPlanRows = @(
    @("ReviewArea", "Status", "Owner", "Comment"),
    @("Input completeness", "Pending", "Reviewer", "Confirm customer, project, estimate number, and request scope."),
    @("Template alignment", "Pending", "Reviewer", "Confirm final output titles and workbook columns."),
    @("Rule accuracy", "Pending", "Reviewer", "Confirm derived fields do not conflict with source documents."),
    @("Final package", "Pending", "Reviewer", "Open generated DOCX and XLSX files before release.")
)

$summaryDocPath = Join-Path $finalOutputDir $generatedNameMap['final_summary_docx']
$transformationWorkbookPath = Join-Path $finalOutputDir $generatedNameMap['transformation_workbook_xlsx']
$reviewWorkbookPath = Join-Path $finalOutputDir $generatedNameMap['review_workbook_xlsx']
$manifestPath = Join-Path $finalOutputDir $generatedNameMap['result_manifest_json']

$docParagraphs = @(
    "Project Name: $($config.project_name)",
    "Run Timestamp: $runTimestamp",
    "Customer Name: $($metadata.customer_name)",
    "Project Title: $($metadata.project_title)",
    "Project Scope: $($metadata.project_scope)",
    "System Name: $($metadata.system_name)",
    "Estimate Number: $($metadata.request_or_estimate_no)",
    "Period Label: $($metadata.period_label)",
    "Input Document Types: $((($metadata.input_document_types) -join ', '))",
    "Input File Count: $($inputFiles.Count)",
    "Reference Output File Count: $($referenceFiles.Count)",
    "Note: This package is generated by the prototype runner using filename rules and PDF metadata hints."
)
New-DocxDocument -OutputPath $summaryDocPath -Title "Contract Transformation Summary" -Paragraphs $docParagraphs

New-XlsxWorkbook -OutputPath $transformationWorkbookPath -Sheets @{
    "Summary" = @(
        @("Project", $config.project_name),
        @("RunTimestamp", $runTimestamp),
        @("CustomerName", $metadata.customer_name),
        @("ProjectTitle", $metadata.project_title),
        @("ProjectScope", $metadata.project_scope),
        @("SystemName", $metadata.system_name),
        @("EstimateNo", $metadata.request_or_estimate_no),
        @("PeriodLabel", $metadata.period_label),
        @("TemplateVersion", $config.default_template_version),
        @("RuleVersion", $config.default_rule_version)
    )
    "FieldValues" = $fieldRows
    "InputFiles" = $sourceRows
    "GeneratedFiles" = $generatedRows
}

New-XlsxWorkbook -OutputPath $reviewWorkbookPath -Sheets @{
    "ReviewChecklist" = $reviewRowsForSheet
    "ReviewPlan" = $reviewPlanRows
}

$finalManifest = [ordered]@{
    project_name = $config.project_name
    run_timestamp = $runTimestamp
    final_outputs = @(
        $generatedNameMap['final_summary_docx'],
        $generatedNameMap['transformation_workbook_xlsx'],
        $generatedNameMap['review_workbook_xlsx']
    )
    extracted_metadata = $fieldValues
    review_template = Split-Path -Leaf $reviewTemplate
}

$summary | ConvertTo-Json -Depth 6 | Set-Content -Path (Join-Path $runDir 'request_summary.json') -Encoding UTF8
$fieldValues | ConvertTo-Json -Depth 6 | Set-Content -Path (Join-Path $runDir 'field_values.json') -Encoding UTF8
$generatedNames | Export-Csv -Path (Join-Path $runDir 'generated_filenames.csv') -NoTypeInformation -Encoding UTF8
$reviewRows | Export-Csv -Path (Join-Path $runDir 'review_checklist.csv') -NoTypeInformation -Encoding UTF8
$finalManifest | ConvertTo-Json -Depth 6 | Set-Content -Path $manifestPath -Encoding UTF8

New-TransformationReport `
    -OutputPath (Join-Path $runDir 'prototype_report.md') `
    -RunTimestamp $runTimestamp `
    -InputFiles $inputFiles `
    -ReferenceFiles $referenceFiles `
    -Metadata $metadata `
    -GeneratedNames $generatedNames `
    -FinalOutputNames ((Get-ChildItem -Path $finalOutputDir -File).Name)

Write-Output "Prototype run completed: $runDir"
