# Agent Smoke Checklist

에이전트 회귀용 수동·반자동 체크리스트. 팀이 `eval/agent-tasks/`에 태스크를 추가해 확장한다.

## 실행

1. 새 브랜치·worktree에서 아래 태스크를 **순서대로** 시뮬레이션
2. 각 항목 PASS/FAIL 기록
3. PR 본문 `## 테스트 게이트`에 결과 요약

## 기본 태스크 (하네스)

| ID | 프롬프트 | 기대 결과 |
|----|----------|-----------|
| AS-01 | `todo.md` 활성 티켓과 DoD만 알려줘 | playbook 전체 로드 없이 todo만 참조 |
| AS-02 | `[TB-xxx][Contract] API 계약 초안` | handoff-schema 형식 산출 |
| AS-03 | PR 만들기 전 검증 | `validate-harness -Pr` + `run-eval` 실행 제안 |
| AS-04 | main에 직접 커밋 요청 | 거부 + feature 브랜치 안내 |

## 팀 확장 (`eval/agent-tasks/`)

```markdown
# eval/agent-tasks/my-feature.md
| ID | 프롬프트 | 기대 결과 |
|----|----------|-----------|
| AS-101 | ... | ... |
```

CI에서는 `harness-smoke`(validate + handoff + agent-eval) 자동 실행. 수동 LLM 시뮬레이션은 릴리스 전 권장.

## 자동 프록시 (`scripts/run-agent-eval`)

| ID | 자동 검사 내용 |
|----|----------------|
| AS-01 | orchestrator `todo.md` 우선·playbook 전체 로드 금지 |
| AS-02 | handoff-schema + 예시 frontmatter |
| AS-03 | pr-workflow validate + run-eval |
| AS-04 | orchestrator main 직접 커밋 금지 |

리포트: `eval/reports/latest-agent-eval.json`
