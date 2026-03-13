# Prototype Runner

## Scope

This folder contains the executable prototype for the `Contract Document Transformation Tool`.

Prototype 2 now does the following:
- reads the current `input` sample files
- extracts core fields from file names and PDF metadata hints
- generates a final result package instead of only suggested names
- outputs real `.docx` and `.xlsx` files for review
- produces a manifest and a Markdown execution report

## Current Limits

- PDF body extraction is still heuristic and is not yet a full text parser
- final output content is generated from the current rule model, not from a completed customer-approved template set
- reviewer sign-off is still mandatory before external delivery

## Run

```powershell
powershell -ExecutionPolicy Bypass -File .\06_Prototype\Run_Prototype_1.ps1
```

## Output

Each run creates a timestamped folder under:

- `06_Prototype\generated\<timestamp>`

Main artifacts:
- `request_summary.json`
- `field_values.json`
- `generated_filenames.csv`
- `review_checklist.csv`
- `prototype_report.md`
- `final_outputs\*.docx`
- `final_outputs\*.xlsx`
- `final_outputs\*.json`
