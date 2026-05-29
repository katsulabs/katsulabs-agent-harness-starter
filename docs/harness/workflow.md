# 하네스 워크플로

## 원칙

- `main`에 기능 커밋 금지
- 기능당 worktree 1개
- PR 전 테스트 게이트 통과
- 머지는 no-ff
- 목표 기반 실행: 작업을 검증 가능한 성공 기준으로 전환한다 (상세: `reference-baseline.md` → 에이전트 행동 원칙)

## 일일 흐름

1. 최신 `main` 기준으로 worktree 생성
2. 구현 및 테스트
3. PR 생성 및 CI 확인
4. 승인 후 `main`에 no-ff 머지

## Hook 실패 대체 런북

Hook이 비활성/실패하면 수동으로 단계 전환합니다.

1. 태그를 유지해 다음 Sub-agent를 메인이 직접 분배
2. 직전 산출물(DTO, migration, 테스트 결과) 전달
3. QA 전환 전 backend/frontend 테스트 재확인
4. PR 본문에 fallback 사용 사유 기록

## 운영 지표(KPI)

- PR Lead Time
- CI Red Rate
- Reopen Rate
- Handoff Failure
