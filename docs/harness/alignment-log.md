# 하네스 정합 작업 로그

`.cursor/rules`와 `docs/harness` 간 불일치를 문서 전용 모델로 통일한 기록입니다.

## TB-001 — doc-harness-alignment

| 우선순위 | 항목 | 상태 | 변경 |
|----------|------|------|------|
| P0 | rules ↔ docs 정합 | 완료 | `agent-hierarchy.md`, PR 템플릿, `getting-started.md` 풀스택 잔재 제거 |
| P1 | 문서 품질 게이트 | 완료 | `reference-baseline.md`, `scripts/doc-quality-gate.sh` |
| P1 | worktree + Sub-agent | 완료 | `workflow.md` 레시피·분배 섹션 |
| P2 | Hook/CI 명확화 | 완료 | Hook=선택, 수동 handoff=기본; KPI 문서화 |
| P2 | Backend/Frontend 재정의 | 완료 | `agent-hierarchy.md` 문서 관점 명시 |
| P3 | Docs CI | 완료 | `.github/workflows/docs-quality-gate.yml` |
| — | 인수 테스트 런북 | 완료 | `acceptance-test.md` |

## 결정 사항

- **단일 모델:** 문서 전용 하네스 (`.mdc` 기준)
- **풀스택 확장:** `customization.md`로 분리, 본 스타터는 doc-only 유지
- **Hook:** 미포함; 수동 handoff가 기본 경로
- **역할명:** Backend/Frontend 유지, 문서 관점으로 재정의

## 검증

```bash
./scripts/doc-quality-gate.sh
```

브랜치: `feature/TB-001-doc-harness-alignment`
