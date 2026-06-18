#!/usr/bin/env pwsh
# Cursor stop hook: harness-gate 안내
$input = [Console]::In.ReadToEnd() | ConvertFrom-Json
$root = if ($input.workspace_roots) { $input.workspace_roots[0] } else { (Get-Location).Path }
$validate = Join-Path $root 'scripts/validate-harness.ps1'
if (Test-Path $validate) {
    $r = & pwsh -NoProfile -File $validate 2>&1
    if ($LASTEXITCODE -ne 0) {
        @{
            followup_message = "harness-gate FAIL. PR 전에 수정 후 `pwsh scripts/validate-harness.ps1` 재실행."
        } | ConvertTo-Json -Compress
    }
}
