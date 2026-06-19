# Playbook

에이전트 운영 단일 참조. **필요한 섹션만 읽는다.** 계약: `AGENTS.md`

## 역할

| Agent | 역할 | 범위 |
|-------|------|------|
| Main | 분해, worktree, 분배 | `docs/**` |
| Editor | 문서·규칙·PR | `docs/**`, `.cursor/**`, `.github/**` |
| Contract | API·DB·DTO 계약 | `db/**`, `**/dto/**`, `**/openapi.*`, `contracts/**`, `api-spec/**` |
| Backend | 서버·API·로직 | `modules/**`, `backend/**`, `server/**`, `api/**` |
| Frontend | UI·클라이언트 | `frontend/**`, `client/**`, `apps/web/**` |
| QA | PR·eval 게이트 | `validate-harness`, `run-eval`, CI |

태그: `[TB-xxx][Editor|Contract|Backend|Frontend|QA]`

## 워크플로

- `main` 직접 커밋 금지 · worktree 1개/기능 · no-ff
- 흐름: worktree → 구현 → validate → run-eval → PR → CI → 머지
- 순차: Contract → Backend/Frontend(병렬 가능) → QA. 불명확하면 순차.

## Worktree

스킬: `worktree-setup` · 경로: `../.worktrees/TB-{id}-{name}` · `.gitignore` 등록

## 운영 게이트

쉘 설정: `setup-shell.md` · PowerShell **7.4+** (`pwsh`)

| 단계 | Windows (pwsh) | macOS / Linux / Git Bash |
|------|----------------|--------------------------|
| 하네스 | `pwsh scripts/validate-harness.ps1` | `./scripts/validate-harness.sh` |
| eval | `pwsh scripts/run-eval.ps1` | `./scripts/run-eval.sh` |
| PR | `validate-harness.ps1 -Pr` + 스킬 `pr-workflow` | `validate-harness.sh -Pr` + 스킬 `pr-workflow` |
| CI | `validate` + `test` jobs (OS matrix) |

branch protection: `validate`, `test` (권장)

## 3세대 레이어

| 레이어 | 위치 |
|--------|------|
| Ambient | `AGENTS.md`, 이 playbook |
| Rules | `.cursor/rules/*.mdc` |
| Skills | `.cursor/skills/*` (PR, worktree, harness-gate) |
| Runtime | hooks, scripts, CI |
| MCP | `.cursor/mcp.json` (example 참고) |

## 샘플

- 문서: `examples/sample-ticket.md`
- 코드: `examples/sample-ticket-code.md` · 핸드오프: `examples/contract-handoff.md`

## Hook fallback

태그 유지 → 산출물 전달 → validate+eval 재실행 → PR에 사유 기록

## 토큰 효율

`todo.md`+변경 파일만 로드 · Rules 최소 · Skills는 PR/worktree 시만 · 수술적 diff

## 표기

`worktree` · `no-ff` · `DoD` · `PR`
