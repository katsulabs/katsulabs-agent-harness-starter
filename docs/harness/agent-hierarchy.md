# 에이전트 계층

메인 오케스트레이터가 티켓과 worktree를 관리하고 Sub-agent가 구현합니다.

## 역할

| Agent | 역할 | 수정 범위 |
|-------|------|-----------|
| Main | 분해, worktree, 분배 | `docs/**` 중심 |
| Contract | 요구사항/용어 계약 고정 | `docs/**`, `.cursor/rules/**`, `.github/**` |
| Backend | 운영/아키텍처 문서 | `docs/**`, `.cursor/rules/**` |
| Frontend | 사용자 가이드/PR 템플릿 | `docs/**`, `.github/**` |
| QA | 문서 품질 게이트 + PR 검증 | `.cursor/skills/**`, PR 템플릿 |

## 분배 태그

- `[TB-xxx][Contract]`
- `[TB-xxx][Backend]`
- `[TB-xxx][Frontend]`
- `[TB-xxx][QA]`

## 병렬 정책

병렬은 아래 조건을 모두 만족할 때만 허용합니다.

- 서로 다른 worktree/브랜치
- 수정 경로 비중첩 (예: `docs/harness/**` vs `.github/**`)
- 계약(용어/범위)이 고정됨

하나라도 불명확하면 순차(Contract → Backend → Frontend → QA)로 진행합니다.
