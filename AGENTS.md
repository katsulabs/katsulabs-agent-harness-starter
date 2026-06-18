# AGENTS.md

문서 전용 하네스. git + pwsh 필요.

## 검증

```bash
pwsh scripts/validate-harness.ps1
pwsh scripts/validate-harness.ps1 -Pr   # PR 직전
pwsh scripts/install-githooks.ps1         # pre-commit
```

## 참조

- `docs/harness/playbook.md` — 운영 (에이전트 단일 참조)
- `docs/harness/extending.md` — 코드 프로젝트 확장

## 브랜치

`feature/TB-{id}-{short-name}` · main 직접 커밋 금지 · no-ff
