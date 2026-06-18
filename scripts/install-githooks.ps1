#Requires -Version 5.1
<#
.SYNOPSIS
  git hooksPath를 .githooks로 설정
#>
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $root
git config core.hooksPath .githooks
Write-Host "Installed: core.hooksPath=.githooks"
Write-Host "Pre-commit runs: pwsh scripts/validate-harness.ps1"
