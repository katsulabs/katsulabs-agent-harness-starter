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

## 서브에이전트 디스패치

규약만으로 멀티에이전트를 운영한다. Cursor **Task** 도구(또는 동급 서브에이전트)로 역할별 분리.

| 단계 | 동작 |
|------|------|
| 1 | `[TB-xxx][Role]` 태그 + 범위(globs) + DoD를 프롬프트에 명시 |
| 2 | Contract 먼저 · Backend/Frontend 병렬 가능 · QA 마지막 |
| 3 | 산출물: Contract는 `handoff-schema.md` 형식 핸드오프 |
| 4 | 서브에이전트 종료 시 산출물 경로·검증 결과를 메인에 전달 |

병렬 티켓은 worktree 1개/티켓. 한 worktree 내 Backend·Frontend만 병렬 디스패치.

프롬프트 생성: `pwsh scripts/dispatch-prompt.ps1 -Ticket TB-xxx -Role Backend` · 스킬 `dispatch`

## 샘플 앱 (TB-101)

`sample/` — api-spec + server 테스트 + client HTML. `run-eval`이 루트 러너 없을 때 `sample/npm test` 실행.

## 운영 게이트

쉘 설정: `setup-shell.md` · PowerShell **7.4+** (`pwsh`)

| 단계 | Windows (pwsh) | macOS / Linux / Git Bash |
|------|----------------|--------------------------|
| 하네스 | `pwsh scripts/validate-harness.ps1` | `./scripts/validate-harness.sh` |
| eval | `pwsh scripts/run-eval.ps1` | `./scripts/run-eval.sh` |
| PR | `validate-harness.ps1 -Pr` + 스킬 `pr-workflow` | `validate-harness.sh -Pr` + 스킬 `pr-workflow` |
| CI | `validate` + `test` jobs · 추가: `*-platforms` (OS matrix) |

branch protection: `validate`, `test` (권장)

## Eval 리포트

`harness-smoke`·`run-agent-eval` 실행 시 `eval/reports/latest-*.json` 생성. PR `## 검증 계획`에 `status` 요약 첨부.

| 스크립트 | 용도 |
|----------|------|
| `scripts/validate-handoff` | handoff frontmatter·섹션 린터 |
| `scripts/run-agent-eval` | agent-smoke 정적 프록시 (AS-01~04) |

수동 agent 회귀: `eval/agent-smoke.checklist.md` · LLM: `agent-llm-eval.md` · 자동 프록시: `run-agent-eval`

PR 요약: `pwsh scripts/summarize-eval.ps1` (또는 `.sh`)

LLM 회귀: `run-agent-llm-eval` → 세션 채점 → `-Validate` · 리포트 `latest-agent-llm-eval.json`

## 3세대 레이어

| 레이어 | 위치 |
|--------|------|
| Ambient | `AGENTS.md`, 이 playbook |
| Rules | `.cursor/rules/*.mdc` |
| Skills | `.cursor/skills/*` (PR, worktree, harness-gate, dispatch) |
| Runtime | hooks, scripts, CI |
| MCP | `.cursor/mcp.json` (example 참고) · 가이드: `mcp-setup.md` |

## 샘플

- 문서: `examples/sample-ticket.md`
- 코드: `examples/sample-ticket-code.md` · 핸드오프: `examples/contract-handoff.md` · 스키마: `handoff-schema.md`

## Hook fallback

태그 유지 → 산출물 전달 → validate+eval 재실행 → PR에 사유 기록

## 토큰 효율

`todo.md`+변경 파일만 로드 · Rules 최소 · Skills는 PR/worktree 시만 · 수술적 diff

## 표기

`worktree` · `no-ff` · `DoD` · `PR`
