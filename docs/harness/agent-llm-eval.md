# Agent LLM Eval (수동)

정적 프록시(`run-agent-eval`)는 **규약 존재**만 검사한다. **에이전트 행동** 회귀는 LLM 세션으로 수행한다.

## 절차

1. `pwsh scripts/run-agent-llm-eval.ps1` — 세션 템플릿 생성
2. `eval/agent-tasks/harness-baseline.md` 태스크를 새 세션에서 실행
3. `eval/reports/agent-llm-session.md`에 PASS/FAIL 기록
4. `pwsh scripts/run-agent-llm-eval.ps1 -Validate` — 채점 · `latest-agent-llm-eval.json`
5. `summarize-eval`로 PR에 요약

## 자동 vs 수동

| 유형 | 스크립트 | 검사 대상 |
|------|----------|-----------|
| 정적 | `run-agent-eval` | rules·skills·handoff 파일 |
| LLM | 이 문서 + agent-tasks | 실제 에이전트 응답·도구 사용 |

릴리스 전·규칙 대变更 후 LLM eval 권장.
