---
name: pr-workflow
description: PR 생성 전 검증·본문·CI 확인 절차. PR 직전에만 실행한다.
disable-model-invocation: true
---

# PR Workflow

1. `validate-harness -Pr` (`.ps1` 또는 `.sh`)
2. `run-eval` (설정 시)
3. `summarize-eval` 출력을 PR `## 검증 계획`에 붙여넣기
4. (릴리스 전) `run-agent-llm-eval -Validate` PASS
5. `.github/PULL_REQUEST_TEMPLATE.md` 작성
6. `gh pr create` · `gh pr checks --watch`
7. CI `validate` + `test` green 확인 후 merge

PR 본문 예시: `docs/harness/examples/sample-pr.md`
