#!/usr/bin/env bash
# eval JSON 리포트를 PR용 Markdown 요약으로 출력
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="$ROOT/eval/reports"

read_field() {
  local file="$1" field="$2"
  [[ -f "$file" ]] || return 1
  grep -o "\"$field\": *\"[^\"]*\"" "$file" | head -1 | sed 's/.*: *"\([^"]*\)"/\1/'
}

echo '## Eval 요약'
echo

smoke="$REPORT_DIR/latest-harness-smoke.json"
agent="$REPORT_DIR/latest-agent-eval.json"

if [[ -f "$smoke" ]]; then
  st=$(read_field "$smoke" status || echo '?')
  ts=$(read_field "$smoke" timestamp || echo '?')
  echo "- harness-smoke: **$st** ($ts)"
else
  echo '- harness-smoke: _(리포트 없음 — run-eval 실행)_'
fi

if [[ -f "$agent" ]]; then
  st=$(read_field "$agent" status || echo '?')
  ts=$(read_field "$agent" timestamp || echo '?')
  echo "- agent-eval: **$st** ($ts)"
else
  echo '- agent-eval: _(리포트 없음 — run-agent-eval 실행)_'
fi

echo
echo '_생성: `./scripts/summarize-eval.sh`_'
