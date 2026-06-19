---
name: pr-workflow
description: PR 생성 전 검증·본문·CI 확인 절차. PR 직전에만 실행한다.
disable-model-invocation: true
---

# PR Workflow

1. `validate-harness -Pr` (`.ps1` 또는 `.sh`)
2. `run-eval` (설정 시)
3. `.github/PULL_REQUEST_TEMPLATE.md` 작성
4. `gh pr create` · `gh pr checks --watch`
5. CI `validate` + `test` green 확인 후 merge

PR 본문 예시: `docs/harness/examples/sample-pr.md`
