# 샘플 티켓 TB-101 (코드)

| 필드 | 값 |
|------|-----|
| ID | TB-101 |
| 기능 | 사용자 목록 API + 목록 UI |
| DoD | Contract 고정 → BE/FE 구현 → 테스트 → PR |

## 1. Contract

```
[TB-101][Contract] UserList API 계약 고정
```

- 산출: `api-spec/users.yaml`, DTO 스키마
- 핸드오프 메모: `examples/contract-handoff.md` 형식
- 검증: `validate-harness` (`.ps1` 또는 `.sh`)

## 2. Backend (Contract 완료 후)

```
[TB-101][Backend] GET /api/users 구현
```

- 범위: `server/**` (팀 경로에 맞게)
- 검증: `run-eval`

## 3. Frontend (Contract 완료 후, BE와 병렬 가능)

```
[TB-101][Frontend] 사용자 목록 페이지
```

- 범위: `client/**`
- 검증: `run-eval`

## 4. QA

```
[TB-101][QA] PR 생성
```

- `validate-harness -Pr` + `run-eval`
- CI green → merge
