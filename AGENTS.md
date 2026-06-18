# AGENTS.md

<!-- 프로젝트 채택 시 아래 [대괄호] 항목을 실제 값으로 교체 -->

## 프로젝트

- **이름**: [프로젝트명]
- **스택**: [예: Node/React, Spring/Vue, monorepo]
- **구조**: [예: backend=server/, frontend=client/]

## 에이전트 계약

| 항목 | 값 |
|------|-----|
| 운영 참조 | `docs/harness/playbook.md` (필요 섹션만) |
| 티켓 | `docs/harness/todo.md` |
| 브랜치 | `feature/TB-{id}-{short-name}` |
| 머지 | no-ff · main 직접 커밋 금지 |

## 역할·경로

| Agent | 경로 |
|-------|------|
| Editor | `docs/**`, `.cursor/**`, `.github/**` |
| Contract | `db/**`, `**/dto/**`, `**/openapi.*`, `contracts/**`, `api-spec/**` |
| Backend | `modules/**`, `backend/**`, `server/**`, `api/**` |
| Frontend | `frontend/**`, `client/**`, `apps/web/**` |

globs는 `.cursor/rules/*.mdc`와 동기화한다.

## 검증 (실행)

```bash
pwsh scripts/validate-harness.ps1       # 하네스
pwsh scripts/run-eval.ps1               # 프로젝트 테스트 (설정 시)
pwsh scripts/validate-harness.ps1 -Pr   # PR 직전
pwsh scripts/install-githooks.ps1       # pre-commit
```

## MCP (선택)

`.cursor/mcp.json.example` 참고. 이슈 트래커·CI·DB 등 팀 도구 연결.

## 금지

- 요청 범위 밖 diff
- main 직접 push
- 검증 없이 PR 생성
