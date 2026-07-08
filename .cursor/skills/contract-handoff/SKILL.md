---
name: contract-handoff
description: Contract 핸드오프 작성·검증. API/DTO 고정 후 Backend/Frontend 디스패치 전에 실행.
disable-model-invocation: true
---

# Contract Handoff

1. `docs/harness/handoff-schema.md` 형식으로 작성
2. 저장: `docs/harness/handoffs/TB-{id}-handoff.md` (또는 PR 본문)
3. `pwsh scripts/validate-handoff.ps1` PASS
4. `breaking: true`이면 QA·Frontend에 명시 알림
5. Backend/Frontend 디스패치 (스킬 `dispatch`)

예시: `docs/harness/examples/contract-handoff.md`
