---
name: backend-test-gate
description: Backend 변경 후 해당 영역 테스트·run-eval 실행. server/backend/api 경로 수정 시.
disable-model-invocation: true
---

# Backend Test Gate

1. 범위: `modules/**`, `backend/**`, `server/**`, `api/**`
2. `pwsh scripts/run-eval.ps1` (프로젝트 테스트 또는 sample/harness-smoke)
3. Contract 핸드오프와 DTO·API 동기화 확인
4. PR `## 테스트 게이트`에 Backend 결과 기록

규칙: `.cursor/rules/backend.mdc`
