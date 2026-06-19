---
name: harness-gate
description: PR 직전 하네스 품질 게이트(링크·규칙·일관성·PR)를 검증한다.
disable-model-invocation: true
---

# Harness Gate

**자동:** `validate-harness -Pr` (`pwsh scripts/validate-harness.ps1 -Pr` 또는 `./scripts/validate-harness.sh -Pr`)

**수동 (통과 후):** PR 본문·diff 일치 · Hook fallback 사유

**연계:** `run-eval` · 스킬 `pr-workflow` · 쉘: `docs/harness/setup-shell.md`
