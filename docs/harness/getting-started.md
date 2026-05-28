# 시작 가이드

이 문서는 `katsulabs-agent-harness-starter`를 새 프로젝트에 적용하는 빠른 가이드입니다.

## 1) 5분 설치

1. 새 프로젝트 루트에 아래 파일을 복사합니다.
   - `.cursor/rules/*`
   - `docs/harness/*`
   - `.github/PULL_REQUEST_TEMPLATE.md`
2. 팀 규칙에 맞게 브랜치 네이밍을 수정합니다.
   - 기본값: `feature/TB-{id}-{short-name}`
3. 테스트 게이트 명령을 프로젝트 스택에 맞게 교체합니다.
4. `docs/harness/todo.md`에 활성 티켓과 DoD를 입력합니다.

## 2) 첫 운영 세팅 (Day 1)

- `orchestrator.mdc`에서 분배 규칙과 태그를 확인합니다.
- `agent-hierarchy.md`에서 역할 경계(Contract/BE/FE/QA)를 합의합니다.
- `workflow.md`에서 Hook fallback 절차를 팀에 공유합니다.
- PR 템플릿 하드 게이트를 필수 체크로 운영합니다.

## 3) 첫 구현 요청 처리 표준

메인 오케스트레이터는 첫 턴에 아래를 수행합니다.

- [ ] 티켓/DoD 확인 (`docs/harness/todo.md`)
- [ ] worktree/브랜치 준비
- [ ] 태그 기반 Sub-agent 분배
- [ ] Hook 비활성 시 fallback 절차 전환

권장 태그:

- `[TB-xxx][Contract]`
- `[TB-xxx][Backend]`
- `[TB-xxx][Frontend]`
- `[TB-xxx][QA]`

## 4) 병렬 작업 기준

병렬 착수는 아래를 모두 만족할 때만 허용합니다.

- 수정 경로가 겹치지 않음 (`modules/**` vs `frontend/**`)
- Flyway 충돌 없음
- DTO 변경 범위 고정 또는 optional/fallback 합의
- 독립 브랜치/worktree 사용

하나라도 불명확하면 순차(Contract -> Backend -> Frontend -> QA)로 진행합니다.

## 5) 주간 운영 루틴

- 월: 활성 티켓과 DoD 정리
- 수: CI 실패 원인(테스트/계약/환경) 점검
- 금: KPI 리뷰
  - PR Lead Time
  - CI Red Rate
  - Reopen Rate
  - Handoff Failure

## 6) 커스터마이징 포인트

- 티켓 prefix (`TB-`)
- 브랜치 네이밍 규칙
- 테스트 게이트 명령
- 역할 경계 문구 (Contract/BE/FE/QA)
- PR Hard Gates 항목

## 7) 온보딩 체크리스트

- [ ] 팀원 전원이 `docs/harness/reference-baseline.md`를 읽음
- [ ] 샘플 티켓 1개를 분배로 시뮬레이션
- [ ] Hook fallback 수동 전환 리허설 1회
- [ ] 첫 주 KPI 수집 시작
