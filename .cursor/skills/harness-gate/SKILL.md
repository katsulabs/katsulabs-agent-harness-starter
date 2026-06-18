---
name: harness-gate
description: PR 직전 하네스 품질 게이트(링크·규칙·일관성·PR)를 한 번에 검증한다.
disable-model-invocation: true
---

# Harness Gate

**자동:** `pwsh scripts/validate-harness.ps1 -Pr` (CI 동일)

**수동 확인 (스크립트 통과 후):**
- PR 본문: 요약 / 검증 계획 / 하드 게이트
- diff 범위와 요약 일치
- Hook fallback 사용 시 사유 기록

판정: 스크립트 PASS + 수동 항목 OK → PR 가능.
