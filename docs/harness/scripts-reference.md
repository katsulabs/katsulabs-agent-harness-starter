# 스크립트 참조

일상은 `AGENTS.md` **Daily / PR** 만으로 충분. 전체 목록·용도.

| 스크립트 | 시점 | 용도 |
|----------|------|------|
| `validate-harness` | 커밋·CI | 문서·규칙·필수 파일 |
| `validate-harness -Pr` | PR 직전 | + dispatch · todo · commit-msg |
| `run-eval` | 티켓·CI | 앱/sample 테스트 + harness-smoke |
| `validate-handoff` | handoff 변경 | frontmatter·섹션 |
| `validate-staged-handoff` | pre-commit | staged handoff만 |
| `dispatch-prompt` | 티켓 착수 | 서브에이전트 프롬프트 |
| `verify-dispatch` | PR | `feature/TB-{id}-*` 브랜치 |
| `validate-todo-sync` | PR | 브랜치 ↔ todo.md |
| `validate-commit-msg -Pr` | PR | 커밋에 TB-{id} |
| `validate-pr-body` | PR (선택) | 본문 필수 섹션 |
| `summarize-eval` | PR | eval Markdown 요약 |
| `run-agent-eval` | harness-smoke | 정적 agent 프록시 |
| `run-agent-llm-eval` | 릴리스 전 | LLM 세션 템플릿·채점 |
| `score-agent-llm` | 릴리스 전 | 응답 패턴 채점 |
| `cost-summary` | PR (선택) | duration 집계 |
| `install-githooks` | 채택 1회 | pre-commit |

`.ps1` / `.sh` 쌍 동일. 쉘: `setup-shell.md`
