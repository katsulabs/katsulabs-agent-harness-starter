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
- `todo.md`는 **자기 티켓 브랜치에서만** 편집. 남 티켓 행 수정 금지 · 통합은 머지 시점에만.

## Worktree

스킬: `worktree-setup` · 경로: `../.worktrees/TB-{id}-{name}` · `.gitignore` 등록

**동시 실행 규칙**: 1 워킹트리 = 1 인스턴스. 여러 인스턴스를 동시에 돌릴 때는 **반드시 티켓별 worktree**로 분리(같은 체크아웃 공유 금지 — `.git/index`·`todo.md`·`eval/reports` 경쟁). eval 산출물은 브랜치 티켓 기준 `eval/reports/TB-{id}/`로 자동 격리된다.

## 서브에이전트 디스패치

규약만으로 멀티에이전트를 운영한다. Cursor **Task** 도구(또는 동급 서브에이전트)로 역할별 분리.

| 단계 | 동작 |
|------|------|
| 1 | `[TB-xxx][Role]` 태그 + 범위(globs) + DoD를 프롬프트에 명시 |
| 2 | Contract 먼저 · Backend/Frontend 병렬 가능 · QA 마지막 |
| 3 | 산출물: Contract는 `handoff-schema.md` 형식 핸드오프 |
| 4 | 서브에이전트 종료 시 산출물 경로·검증 결과를 메인에 전달 |

병렬 티켓은 worktree 1개/티켓. 한 worktree 내 Backend·Frontend만 병렬 디스패치.

프롬프트 생성: `dispatch-prompt` · **PR 전 검증:** `verify-dispatch` (브랜치 `feature/TB-{id}-*`)  
명령 예시: [examples/multi-agent-dispatch.md](./examples/multi-agent-dispatch.md)

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

## Eval

상세: [eval-guide.md](./eval-guide.md) · PR 요약: `summarize-eval`

## 레이어

개요·다이어그램: [introduction.md](./introduction.md) (3세대 상세는 여기만)

## 샘플

- 문서: `examples/sample-ticket.md`
- 코드: `examples/sample-ticket-code.md` · multi-agent: `examples/multi-agent-dispatch.md`
- 핸드오프: `examples/contract-handoff.md` · 스키마: `handoff-schema.md`

## 실패 시

| 실패 | 조치 |
|------|------|
| validate-harness | `playbook.md` · 링크·mdc·필수 파일 |
| validate-handoff | `handoff-schema.md` |
| verify-dispatch | `feature/TB-{id}-*` 브랜치 |
| validate-todo-sync | `todo.md`에 티켓 등록 |
| validate-commit-msg | 커밋 메시지에 `TB-{id}` |
| run-eval | `first-ticket.md` · `presets/` |

채택: `TEMPLATE.md` · 첫 티켓: `first-ticket.md` · 용어: `glossary.md`

## Hook fallback

태그 유지 → 산출물 전달 → validate+eval 재실행 → PR에 사유 기록

## 토큰 효율

`todo.md`+변경 파일만 로드 · Rules 최소 · Skills는 PR/worktree 시만 · 수술적 diff

## 표기

`worktree` · `no-ff` · `DoD` · `PR`
