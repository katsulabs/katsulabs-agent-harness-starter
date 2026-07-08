# 시작 (허브)

**읽기 순서** — 역할별로 **한 문서만** 먼저 연다.

| 순서 | 문서 | 대상 |
|------|------|------|
| 1 | [introduction.md](./introduction.md) | **개요** — 이 하네스가 뭔지 |
| 2 | [TEMPLATE.md](./TEMPLATE.md) | 채택 담당 — 프로젝트에 붙이기 |
| 3 | [first-ticket.md](./first-ticket.md) | 첫 연습 (30분) |
| 4 | [AGENTS.md](../../AGENTS.md) | 에이전트 — 명령·계약 |
| 5 | [playbook.md](./playbook.md) | 에이전트 — 운영 (필요 섹션만) |

## Day 1 체크 (3줄)

```powershell
pwsh scripts/validate-harness.ps1
pwsh scripts/install-githooks.ps1
pwsh scripts/run-eval.ps1
```

GitHub: CI `validate` + `test` · [operations.md](./operations.md)

## 더 보기

[eval-guide.md](./eval-guide.md) · [glossary.md](./glossary.md) · [scripts-reference.md](./scripts-reference.md) · [extending.md](./extending.md)
