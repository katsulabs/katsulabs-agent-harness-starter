# 확장 가이드

코드 저장소에 하네스를 적용할 때 참조한다. **Backend/Frontend 규칙은 스타터에 포함**되어 있으며 globs만 팀 구조에 맞게 조정한다.

## 규칙 구성 (기본)

| 규칙 | globs | 용도 |
|------|-------|------|
| orchestrator | alwaysApply | 전역·분배 |
| editor | `docs/**`, `.cursor/**`, `.github/**` | 문서 |
| backend | `modules/**`, `backend/**`, `server/**`, `api/**` | 백엔드 코드 |
| frontend | `frontend/**`, `client/**`, `apps/web/**` | 프론트 코드 |
| qa | `.github/**` | PR 게이트 |

**토큰 원칙:** 코드 편집 시 해당 영역 규칙만 로드. Editor는 문서 전용.

## 추가 확장 (선택)

| 역할 | globs | 시점 |
|------|-------|------|
| Contract | `db/**`, `**/dto/**`, `openapi.*` | API/DB 계약 필요 시 |

## 검증 확장

`scripts/validate-harness.ps1`에 프로젝트 테스트를 추가한다.

```powershell
if (Test-Path 'package.json') { npm test }
if (Test-Path 'pom.xml') { mvn test -q }
```

PR 템플릿에 backend/frontend 테스트 체크박스를 추가한다.

## CI 확장

`harness-gate.yml`에 테스트 job을 별도 job으로 추가.

## 커스터마이징 체크리스트

- [ ] `backend.mdc` / `frontend.mdc` globs를 실제 경로에 맞게 수정
- [ ] playbook 역할 테이블 동기화
- [ ] validate 스크립트에 테스트 단계 추가
- [ ] PR 템플릿에 테스트 항목 추가
