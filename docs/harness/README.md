# 하네스 엔지니어링

프로젝트의 Agent 협업 규칙과 운영 문서 모음입니다.

| 문서 | 내용 |
|------|------|
| [agent-hierarchy.md](./agent-hierarchy.md) | 역할 분리, 분배, 병렬 기준 |
| [workflow.md](./workflow.md) | worktree, PR, Hook fallback |
| [getting-started.md](./getting-started.md) | 새 프로젝트 적용 가이드 |
| [todo.md](./todo.md) | 티켓/DoD/보류 항목 |

## 검증 스킬

문서 품질 게이트는 `.cursor/skills/`에 정의되어 있습니다.

| 스킬 | 설명 |
|------|------|
| doc-link-validation | 문서 링크/참조 유효성 |
| cursor-rule-validation | `.mdc` 규칙 형식 |
| doc-consistency | 용어/구조 일관성 |
| pr-quality-gate | PR 하드 게이트 |

## Cursor 규칙 형식

`.cursor/rules/*.mdc` 파일만 규칙으로 적용됩니다.
