# 시작 가이드

**에이전트:** `AGENTS.md` + `playbook.md` (필요 섹션만). **사람:** 이 문서 + `TEMPLATE.md`.

## 설치

1. `docs/harness/TEMPLATE.md` 절차 따름
2. `pwsh scripts/install-githooks.ps1`
3. `AGENTS.md` [대괄호] 항목 작성
4. `todo.md`에 첫 티켓/DoD

## Day 1

- [ ] `pwsh scripts/validate-harness.ps1` PASS
- [ ] `pwsh scripts/run-eval.ps1` (SKIP 또는 PASS)
- [ ] `examples/sample-ticket-code.md` 시뮬레이션

## GitHub

- CI: `validate` + `test`
- branch protection: 두 check 모두 권장 (`operations.md`)

## 참고

`CONTRIBUTING.md` · `extending.md` · `operations.md`
