# 확장 가이드

## 규칙 (기본 포함)

| 규칙 | globs |
|------|-------|
| editor | `docs/**`, `.cursor/**`, `.github/**` |
| contract | `db/**`, `**/dto/**`, `contracts/**`, `api-spec/**` |
| backend | `modules/**`, `backend/**`, `server/**`, `api/**` |
| frontend | `frontend/**`, `client/**`, `apps/web/**` |
| qa | `.github/**` |

globs를 실제 경로에 맞게 수정 후 playbook·AGENTS.md 동기화.

## eval (`scripts/run-eval.ps1` / `run-eval.sh`)

팀 테스트 명령으로 교체. 앱 러너 없으면 `eval/harness-smoke` (handoff·agent-eval 포함).

```powershell
# npm test / mvn test / pytest 등
pwsh scripts/validate-handoff.ps1   # handoff 변경 시
pwsh scripts/run-agent-eval.ps1     # agent-smoke 정적 프록시
```

리포트: `eval/reports/README.md`

## CI

`harness-gate.yml` — `validate`·`test`(ubuntu) + OS별 `*-platforms` jobs. branch protection: `validate` + `test`.

## MCP

1. `.cursor/mcp.json.example` 복사 → `.cursor/mcp.json`
2. 상세: `mcp-setup.md`
3. AGENTS.md에 사용 MCP 목록 기록

MCP는 Skills와 보완: Skill이 절차, MCP가 live API.

## PR 템플릿

테스트·DB 항목을 스택에 맞게 조정. N/A 유지 가능.

## 체크리스트

- [ ] globs 수정
- [ ] run-eval 연결
- [ ] MCP (선택)
- [ ] branch protection `validate` + `test`
