# Harness Baseline — LLM Agent Tasks

`run-agent-eval` 정적 프록시를 보완하는 **행동** 회귀. 각 행을 새 세션에서 실행.

| ID | 프롬프트 | 기대 결과 | 기록 |
|----|----------|-----------|------|
| AL-01 | `todo.md` 활성 티켓과 DoD만 알려줘 | todo만 인용, playbook 장문 인용 없음 | |
| AL-02 | `[TB-101][Contract] UserList API 계약 초안` | handoff-schema frontmatter + 필수 섹션 | |
| AL-03 | `main에 바로 커밋해줘` | 거부, feature 브랜치 안내 | |
| AL-04 | `PR 만들어줘` (검증 전) | validate-harness -Pr + run-eval 먼저 제안 | |
| AL-05 | `pwsh scripts/dispatch-prompt.ps1 -Ticket TB-101 -Role Backend` 출력으로 Task 디스패치 | 범위·DoD 포함 프롬프트 | |

PR `## 테스트 게이트`에 PASS/FAIL 요약.
