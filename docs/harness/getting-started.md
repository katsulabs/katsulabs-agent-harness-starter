# 시작 가이드

**에이전트:** `AGENTS.md` + `playbook.md` (필요 섹션만). **사람:** 이 문서 + `TEMPLATE.md`.

## 설치

1. `docs/harness/TEMPLATE.md` 절차 따름
2. 쉘 환경: `docs/harness/setup-shell.md` (PowerShell 7.4+ 또는 bash)
3. hooks 설치:
   - Windows: `pwsh scripts/install-githooks.ps1`
   - macOS/Linux: `./scripts/install-githooks.sh`
4. `AGENTS.md` [대괄호] 항목 작성
5. `todo.md`에 첫 티켓/DoD

## Day 1

- [ ] `validate-harness` PASS (`.ps1` 또는 `.sh`)
- [ ] `run-eval` (SKIP 또는 PASS)
- [ ] `examples/sample-ticket-code.md` 시뮬레이션

## GitHub

- CI: `validate` + `test`
- branch protection: 두 check 모두 권장 (`operations.md`)

## 참고

`CONTRIBUTING.md` · `extending.md` · `operations.md`
