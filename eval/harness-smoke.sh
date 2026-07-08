#!/usr/bin/env bash
# 하네스 자체 스모크 eval (macOS / Linux / Git Bash)
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
REPORT_DIR="$ROOT/eval/reports"
mkdir -p "$REPORT_DIR"

failures=()
fail() { failures+=("$1"); }
pass_n=0
total_n=0

record() {
  local name="$1" rc="$2" detail="$3"
  total_n=$((total_n + 1))
  if [[ $rc -eq 0 ]]; then
    pass_n=$((pass_n + 1))
  else
    fail "$detail"
  fi
}

bash ./scripts/validate-harness.sh; record 'validate-harness' $? 'validate-harness 실패'
bash ./scripts/validate-handoff.sh; record 'validate-handoff' $? 'validate-handoff 실패'
bash ./scripts/run-agent-eval.sh; record 'agent-eval' $? 'agent-eval 실패'

bash ./scripts/run-agent-llm-eval.sh; record 'agent-llm-eval' $? 'agent-llm-eval 실패'

for f in eval/agent-smoke.checklist.md docs/harness/handoff-schema.md docs/harness/mcp-setup.md \
  scripts/validate-handoff.sh scripts/run-agent-eval.sh scripts/run-agent-llm-eval.sh \
  scripts/dispatch-prompt.sh scripts/summarize-eval.sh \
  sample/package.json .cursor/skills/dispatch/SKILL.md; do
  if [[ -f "$f" ]]; then record "artifact:$f" 0 ok; else record "artifact:$f" 1 "MISSING: $f"; fi
done

if grep -q 'harness-smoke' scripts/run-eval.sh; then record 'run-eval-fallback' 0 ok; else record 'run-eval-fallback' 1 'run-eval harness-smoke 폴백 없음'; fi

for kw in '서브에이전트' 'Task' 'handoff-schema'; do
  if grep -qF "$kw" docs/harness/playbook.md; then record "playbook:$kw" 0 ok; else record "playbook:$kw" 1 "PLAYBOOK: $kw 누락"; fi
done

timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
status="PASS"
[[ ${#failures[@]} -eq 0 ]] || status="FAIL"
fail_n=${#failures[@]}

printf '%s\n' "{
  \"suite\": \"harness-smoke\",
  \"timestamp\": \"$timestamp\",
  \"status\": \"$status\",
  \"summary\": { \"pass\": $pass_n, \"fail\": $fail_n, \"total\": $total_n }
}" > "$REPORT_DIR/latest-harness-smoke.json"
cp "$REPORT_DIR/latest-harness-smoke.json" "$REPORT_DIR/harness-smoke-${timestamp//:/-}.json"

if [[ ${#failures[@]} -eq 0 ]]; then
  echo "PASS: harness-smoke -> eval/reports/latest-harness-smoke.json"
  exit 0
fi

echo "FAIL: harness-smoke (${#failures[@]} issues) -> eval/reports/latest-harness-smoke.json"
for f in "${failures[@]}"; do echo "  - $f"; done
exit 1
