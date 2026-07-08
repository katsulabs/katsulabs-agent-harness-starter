#Requires -Version 7.4
<#
.SYNOPSIS
  eval JSON 리포트를 PR용 Markdown 요약으로 출력.
#>
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$reportDir = Join-Path $root 'eval/reports'

function Read-Report([string]$name) {
    $path = Join-Path $reportDir $name
    if (-not (Test-Path $path)) { return $null }
    Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
}

function Format-ReportLine([string]$label, $report) {
    if (-not $report) {
        Write-Output "- ${label}: _(리포트 없음)_"
        return
    }
    $dur = if ($report.PSObject.Properties['duration_ms']) { " · $($report.duration_ms)ms" } else { '' }
    Write-Output "- ${label}: **$($report.status)** ($($report.timestamp)$dur)"
    if ($report.summary) {
        Write-Output "  - checks: $($report.summary.pass)/$($report.summary.total) pass"
    }
}

$smoke = Read-Report 'latest-harness-smoke.json'
$agent = Read-Report 'latest-agent-eval.json'
$llm = Read-Report 'latest-agent-llm-eval.json'
$session = Join-Path $reportDir 'agent-llm-session.md'

Write-Output '## Eval 요약'
Write-Output ''
Format-ReportLine 'harness-smoke' $smoke
Format-ReportLine 'agent-eval' $agent

if ($llm) {
    Format-ReportLine 'agent-llm-eval' $llm
} elseif (Test-Path $session) {
    Write-Output '- agent-llm-eval: _(세션 있음 — `-Validate`로 채점)_'
} else {
    Write-Output '- agent-llm-eval: _(미실행 — run-agent-llm-eval)_'
}

if ($agent -and $agent.checks) {
    $failed = @($agent.checks | Where-Object { $_.status -eq 'FAIL' })
    foreach ($f in $failed) { Write-Output "  - FAIL $($f.id): $($f.detail)" }
}

$costPath = Join-Path $reportDir 'latest-cost-summary.json'
if (Test-Path $costPath) {
    $cost = Get-Content $costPath -Raw | ConvertFrom-Json
    Write-Output "- cost-summary: **$($cost.total_duration_ms)ms** · cost_units=$($cost.cost_units)"
}

Write-Output ''
Write-Output '_생성: `pwsh scripts/summarize-eval.ps1`_'
