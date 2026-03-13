$ErrorActionPreference = "Stop"

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptRoot

function Get-JsonConfig {
    param([string]$Path)
    Get-Content -Raw -Path $Path | ConvertFrom-Json
}

function Get-JapaneseSafeName {
    param([string]$Value)
    if ([string]::IsNullOrWhiteSpace($Value)) { return "TBD" }
    $clean = $Value -replace '[\\/:*?"<>|]', '_'
    return $clean.Trim()
}

function Get-InputMetadata {
    param([System.IO.FileInfo[]]$Files)

    $fileNames = $Files.Name

    $estimateNo = "TBD_NO"
    $joined = ($fileNames -join " ")
    if ($joined -match '(26Q[0-9]+)') {
        $estimateNo = $matches[1]
    }

    $docTypes = @()
    foreach ($name in $fileNames) {
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($name)
        $prefix = ($baseName -split '[_　 ]')[0]
        if (-not [string]::IsNullOrWhiteSpace($prefix)) {
            $docTypes += $prefix
        }
    }
    $docTypes = $docTypes | Select-Object -Unique

    $primaryBase = [System.IO.Path]::GetFileNameWithoutExtension($Files[0].Name)
    $secondaryBase = if ($Files.Count -gt 1) { [System.IO.Path]::GetFileNameWithoutExtension($Files[1].Name) } else { $primaryBase }

    $customerName = "TBD_CUSTOMER"
    $projectTitle = "TBD_PROJECT"

    $secondaryParts = $secondaryBase -split '_'
    if ($secondaryParts.Count -ge 3) {
        $projectTitle = $secondaryParts[2]
    } elseif ($secondaryParts.Count -ge 2) {
        $projectTitle = $secondaryParts[-1]
    } else {
        $projectTitle = $secondaryBase
    }

    $customerProjectParts = $projectTitle -split ' '
    if ($customerProjectParts.Count -ge 1) {
        $customerName = $customerProjectParts[0]
    }

    [pscustomobject]@{
        customer_name = $customerName
        request_or_estimate_no = $estimateNo
        input_document_types = $docTypes
        project_title = $projectTitle
    }
}

function New-GeneratedFileNames {
    param(
        [pscustomobject]$Metadata,
        [string]$PeriodLabel
    )

    $customer = Get-JapaneseSafeName $Metadata.customer_name
    $project = Get-JapaneseSafeName $Metadata.project_title

    @(
        [pscustomobject]@{
            OutputCategory = "document"
            SuggestedFileName = "${PeriodLabel}_INTERNAL_DOC_${customer}_${project}.docx"
        }
        [pscustomobject]@{
            OutputCategory = "spreadsheet"
            SuggestedFileName = "${customer}_${project}_${PeriodLabel}.xlsx"
        }
        [pscustomobject]@{
            OutputCategory = "review_sheet"
            SuggestedFileName = "CHECK_${customer}_${PeriodLabel}.xlsx"
        }
    )
}

function New-PrototypeReport {
    param(
        [string]$TemplatePath,
        [string]$OutputPath,
        [string]$RunTimestamp,
        [System.IO.FileInfo[]]$InputFiles,
        [pscustomobject]$Metadata,
        [object[]]$GeneratedNames
    )

    $template = Get-Content -Raw -Path $TemplatePath
    $inputBlock = ($InputFiles | ForEach-Object { "- $($_.Name)" }) -join "`n"
    $filenameBlock = ($GeneratedNames | ForEach-Object { "- [$($_.OutputCategory)] $($_.SuggestedFileName)" }) -join "`n"
    $docTypeText = (($Metadata.input_document_types | ForEach-Object { $_ }) -join ", ")

    $content = $template
    $content = $content.Replace('{{run_timestamp}}', $RunTimestamp)
    $content = $content.Replace('{{input_files}}', $inputBlock)
    $content = $content.Replace('{{customer_name}}', $Metadata.customer_name)
    $content = $content.Replace('{{project_title}}', $Metadata.project_title)
    $content = $content.Replace('{{request_or_estimate_no}}', $Metadata.request_or_estimate_no)
    $content = $content.Replace('{{input_document_types}}', $docTypeText)
    $content = $content.Replace('{{generated_filenames}}', $filenameBlock)

    Set-Content -Path $OutputPath -Value $content -Encoding UTF8
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

$inputFiles = Get-ChildItem -Path $inputDir -File | Where-Object { $_.Extension -ne '.md' }
$referenceFiles = Get-ChildItem -Path $referenceOutputDir -File | Where-Object { $_.Extension -ne '.md' }

$metadata = Get-InputMetadata -Files $inputFiles

$fieldValues = [ordered]@{
    run_timestamp = $runTimestamp
    customer_name = $metadata.customer_name
    project_title = $metadata.project_title
    request_or_estimate_no = $metadata.request_or_estimate_no
    input_document_types = $metadata.input_document_types
    period_label = $config.default_period_label
    document_category = $config.default_document_category
    template_version = $config.default_template_version
    rule_version = $config.default_rule_version
    input_file_count = $inputFiles.Count
    reference_output_file_count = $referenceFiles.Count
}

$generatedNames = New-GeneratedFileNames -Metadata $metadata -PeriodLabel $config.default_period_label

$summary = [ordered]@{
    project_name = $config.project_name
    run_timestamp = $runTimestamp
    input_files = $inputFiles.Name
    reference_output_files = $referenceFiles.Name
    extracted_metadata = $fieldValues
}

$summary | ConvertTo-Json -Depth 6 | Set-Content -Path (Join-Path $runDir 'request_summary.json') -Encoding UTF8
$fieldValues | ConvertTo-Json -Depth 6 | Set-Content -Path (Join-Path $runDir 'field_values.json') -Encoding UTF8
$generatedNames | Export-Csv -Path (Join-Path $runDir 'generated_filenames.csv') -NoTypeInformation -Encoding UTF8
Copy-Item -Path $reviewTemplate -Destination (Join-Path $runDir 'review_checklist.csv')

New-PrototypeReport `
    -TemplatePath (Join-Path $scriptRoot 'templates\prototype_report_template.md') `
    -OutputPath (Join-Path $runDir 'prototype_report.md') `
    -RunTimestamp $runTimestamp `
    -InputFiles $inputFiles `
    -Metadata $metadata `
    -GeneratedNames $generatedNames

Write-Output "Prototype run completed: $runDir"
