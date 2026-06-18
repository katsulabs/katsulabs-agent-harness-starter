# Playbook

에이전트 운영 단일 참조 문서. **필요한 섹션만 읽는다.**

## 역할

| Agent | 역할 | 범위 |
|-------|------|------|
| Main | 분해, worktree, 분배 | `docs/**` |
| Editor | 문서·규칙·PR 템플릿 편집 | `docs/**`, `.cursor/**`, `.github/**` |
| QA | PR 게이트 검증 | `scripts/validate-harness.ps1`, CI |

태그: `[TB-xxx][Editor]`, `[TB-xxx][QA]`

## 워크플로

- `main` 직접 커밋 금지 · worktree 1개/기능 · no-ff 머지
- 흐름: worktree → 구현 → **validate-harness.ps1** → PR → CI green → 머지
- 병렬: 독립 브랜치 + 경로 비중첩 + 범위 고정. 불명확하면 Editor → QA 순차.

## 운영 게이트 (강제)

| 단계 | 명령 | 실패 시 |
|------|------|---------|
| 로컬 | `pwsh scripts/validate-harness.ps1` | 수정 후 재실행 |
| pre-commit | `.githooks/pre-commit` (설치: `install-githooks.ps1`) | 커밋 차단 |
| PR 직전 | `pwsh scripts/validate-harness.ps1 -Pr` | PR 생성 금지 |
| CI | `.github/workflows/harness-gate.yml` | 머지 금지 |

GitHub branch protection: `main`에 status check **`validate`** 필수 (Pro/Public만). Private Free는 `operations.md` 참고.

## 샘플 티켓

`docs/harness/examples/sample-ticket.md` · PR 본문: `examples/sample-pr.md`

## Hook fallback

1. 태그 유지, Main이 다음 에이전트 분배
2. 직전 산출물(범위 메모, 검증 결과) 전달
3. QA 전 validate-harness.ps1 재실행
4. PR에 fallback 사유 기록

## KPI (선택)

| 지표 | 수집 |
|------|------|
| PR Lead Time | GitHub Insights |
| Reopen Rate | reopened PR / 전체 PR |
| Handoff Failure | PR 코멘트 `#handoff-fail` |

## 토큰 효율 원칙

| 원칙 | 실행 |
|------|------|
| 최소 로드 | `todo.md` + 변경 파일만 읽기 |
| 단일 참조 | 상세는 이 playbook에만 유지 |
| 지연 검증 | 스크립트는 PR 직전만 |
| 수술적 변경 | 요청 범위 밖 diff 금지 |
| 규칙 슬림 | alwaysApply는 orchestrator만 |

## 표기

`worktree` · `no-ff` · `DoD` · `PR`
