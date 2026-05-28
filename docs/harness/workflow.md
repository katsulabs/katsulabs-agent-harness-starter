# Harness Workflow

## Principles

- `main`에 기능 커밋 금지
- 기능당 worktree 1개
- PR 전 테스트 게이트 통과
- 머지는 no-ff

## Daily Flow

1. 최신 `main` 기준으로 worktree 생성
2. 구현 및 테스트
3. PR 생성 및 CI 확인
4. 승인 후 `main`에 no-ff 머지

## Hook Fallback Runbook

Hook이 비활성/실패하면 수동으로 단계 전환합니다.

1. 태그를 유지해 다음 Sub-agent를 메인이 직접 dispatch
2. 직전 산출물(DTO, migration, test result) 전달
3. QA 전환 전 backend/frontend 테스트 재확인
4. PR 본문에 fallback 사용 사유 기록

## KPI

- PR Lead Time
- CI Red Rate
- Reopen Rate
- Handoff Failure
