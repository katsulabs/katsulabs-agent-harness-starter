# 확장 가이드

문서 하네스를 코드 프로젝트로 확장할 때 참조한다.

## 언제 확장하는가

- `modules/**`, `frontend/**` 등 소스 코드가 생길 때
- DB migration, API DTO 계약이 필요할 때

## 역할 확장 (토큰 예산 유지)

| 단계 | 역할 | globs (조건부만) |
|------|------|------------------|
| 1 | Editor (유지) | `docs/**`, `.cursor/**` |
| 2 | +Contract | `db/**`, `**/dto/**`, `openapi.*` |
| 3 | +Backend | `modules/**`, `backend/**` |
| 4 | +Frontend | `frontend/**`, `src/**` |
| 5 | QA (유지) | `.github/**` |

**원칙:** alwaysApply 규칙 추가 금지. 역할마다 **좁은 globs**만 사용.

## 검증 확장

`scripts/validate-harness.ps1`에 프로젝트 게이트를 추가한다.

```powershell
# 예: backend 테스트
if (Test-Path 'package.json') { npm test }
if (Test-Path 'pom.xml') { mvn test -q }
```

PR 템플릿에 테스트 게이트 체크박스를 추가한다.

## CI 확장

`.github/workflows/harness-gate.yml`에 테스트 job을 **별도 job**으로 추가 (실패 시 머지 차단).

## 마이그레이션 체크리스트

- [ ] playbook 역할 테이블 갱신
- [ ] editor globs에서 코드 경로 분리
- [ ] validate 스크립트에 테스트 단계 추가
- [ ] PR 템플릿에 테스트 항목 추가
- [ ] extending.md 내용을 팀 스택에 맞게 커스터마이즈

## 토큰 예산

확장 시에도 다음을 유지한다.

- playbook 단일 참조
- 검증 스크립트/CI로 강제, 스킬 문서는 슬림 유지
- 역할 규칙은 **필요한 것만** 추가 (5개 이상 비권장)
