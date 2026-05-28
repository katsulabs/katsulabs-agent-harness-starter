# 에이전트 계층

메인 오케스트레이터가 티켓과 worktree를 관리하고 Sub-agent가 구현합니다.

## 역할

| Agent | 역할 | 수정 범위 |
|-------|------|-----------|
| Main | 분해, worktree, 분배 | `docs/**` 중심 |
| Contract | DB/API 계약 고정 | `db/migration`, API DTO |
| Backend | 비즈니스 로직 + API 테스트 | `modules/**` |
| Frontend | UI + Vitest | `frontend/**` |
| QA | 회귀 테스트 + PR 검증 | 테스트/PR 템플릿 |

## 분배 태그

- `[TB-xxx][Contract]`
- `[TB-xxx][Backend]`
- `[TB-xxx][Frontend]`
- `[TB-xxx][QA]`

## 병렬 정책

병렬은 아래 조건을 모두 만족할 때만 허용합니다.

- 서로 다른 worktree/브랜치
- 수정 경로 비중첩 (`modules/**` vs `frontend/**`)
- Flyway 충돌 없음
- DTO 변경 범위가 고정되었거나 optional/fallback 합의 완료
