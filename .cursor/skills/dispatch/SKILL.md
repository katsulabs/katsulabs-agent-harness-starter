---
name: dispatch
description: TB 티켓·역할별 서브에이전트 디스패치 프롬프트 생성. 구현 착수·병렬 역할 분리 시 실행.
disable-model-invocation: true
---

# Dispatch

## 생성

```powershell
pwsh scripts/dispatch-prompt.ps1 -Ticket TB-101 -Role Contract
```

```bash
./scripts/dispatch-prompt.sh TB-101 Backend
```

## 사용

1. 출력 프롬프트를 Cursor **Task** 서브에이전트에 붙여넣기
2. Contract → Backend/Frontend(병렬) → QA 순서
3. PR 전 `verify-dispatch` — 브랜치 `feature/TB-{id}-*` 필수
4. 종료 시 `docs/harness/handoffs/TB-{id}-status.md`에 자기 역할 status·산출물·검증 결과 append (스키마: `status-schema.md`, 검증: `validate-status`)

스크립트: `scripts/dispatch-prompt.ps1` / `.sh` · 규약: `playbook.md` 서브에이전트 섹션  
예시: `docs/harness/examples/multi-agent-dispatch.md`
