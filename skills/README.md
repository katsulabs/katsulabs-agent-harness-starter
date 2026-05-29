# 검증 스킬

하네스 운영에서 기본적으로 필요한 검증 절차를 스킬로 정리한 모음이다.

## 스킬 목록

| 스킬 | 설명 | 사용 시점 |
|------|------|-----------|
| [doc-link-validation](./doc-link-validation/SKILL.md) | 문서 내부 링크/참조 유효성 검증 | 문서 추가/이동/삭제 후, PR 전 |
| [cursor-rule-validation](./cursor-rule-validation/SKILL.md) | `.mdc` 규칙 파일 형식/필수 필드 검증 | 규칙 파일 추가/수정 후 |
| [pr-quality-gate](./pr-quality-gate/SKILL.md) | PR 하드 게이트 및 체크리스트 충족 검증 | PR 생성 직전, QA 리뷰 시 |
| [doc-consistency](./doc-consistency/SKILL.md) | 용어/표기법/섹션 구조 일관성 검증 | 용어 변경 후, 대폭 수정 후 |
| [karpathy-review](./karpathy-review/SKILL.md) | Karpathy 4대 원칙 준수 리뷰 | PR 리뷰, 자기 점검, 산출물 인수 시 |

## 사용 방법

각 스킬은 독립적으로 실행할 수 있다. QA 에이전트가 종합 검증 시에는 아래 순서를 권장한다:

1. **doc-link-validation** — 링크가 깨지면 다른 검증의 신뢰도가 떨어진다
2. **cursor-rule-validation** — 규칙 파일이 유효해야 에이전트 동작이 보장된다
3. **doc-consistency** — 용어/구조 일관성 확인
4. **karpathy-review** — 변경의 품질 원칙 준수 확인
5. **pr-quality-gate** — 최종 PR 하드 게이트 통과 확인

## 스킬 형식

각 스킬은 `skills/<name>/SKILL.md` 경로에 위치하며, YAML front-matter로 `name`과 `description`을 포함한다.
