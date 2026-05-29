---
name: doc-consistency
description: 문서 전체의 용어, 표기법, 섹션 구조가 일관되는지 검증한다. 문서 변경 후 또는 용어/인터페이스 정의가 바뀐 후에 사용한다.
---

# 문서 일관성 검증

프로젝트 문서 전체에서 용어, 표기법, 섹션 구조, 역할 경계 설명이 일관되는지 확인하는 스킬이다.

## 사용 시점

- Contract 에이전트가 용어나 인터페이스 정의를 변경한 후
- 문서를 추가하거나 대폭 수정한 후
- QA 에이전트가 문서 품질 게이트를 검수할 때

## 검증 절차

### 1단계: 역할 용어 일관성 확인

프로젝트에서 사용하는 역할 명칭이 모든 문서에서 동일하게 쓰이는지 확인한다.

표준 역할 명칭:
- `Main` (오케스트레이터)
- `Contract`
- `Backend`
- `Frontend`
- `QA`

```bash
echo "=== 역할 용어 사용 현황 ==="
for term in "Main" "Contract" "Backend" "Frontend" "QA"; do
  echo "--- $term ---"
  rg -n "$term" --glob '*.md' --glob '*.mdc' --glob '!.git/**' .
done
```

확인 포인트:
- 대소문자가 일관되는가 (예: `backend` vs `Backend`)
- 동의어가 혼용되지 않는가 (예: `Main` vs `Orchestrator` vs `오케스트레이터`)
- 역할 열거 순서가 일관되는가 (권장: Contract → Backend → Frontend → QA)

### 2단계: 표기법 통일 확인

기술 용어의 표기법이 문서 전체에서 통일되는지 확인한다.

```bash
echo "=== 주요 용어 표기 현황 ==="
for term in "worktree" "work tree" "no-ff" "no ff" "DoD" "Dod" "Flyway" "flyway"; do
  count=$(rg -c "$term" --glob '*.md' --glob '*.mdc' --glob '!.git/**' . 2>/dev/null | wc -l)
  [ "$count" -gt 0 ] && echo "$term: $count개 파일에서 사용"
done
```

표준 표기법:
| 올바른 표기 | 잘못된 표기 |
|------------|------------|
| `worktree` | `work tree`, `work-tree` |
| `no-ff` | `no ff`, `noff` |
| `DoD` | `Dod`, `dod`, `DOD` |
| `PR` | `pr`, `Pull Request` (문맥에 따라) |

### 3단계: 섹션 구조 일관성 확인

`docs/harness/` 내 문서들이 일관된 섹션 구조를 유지하는지 확인한다.

```bash
echo "=== 각 문서의 최상위 섹션 ==="
for f in docs/harness/*.md; do
  echo "--- $f ---"
  rg '^## ' "$f"
done
```

확인 포인트:
- 제목 체계(heading hierarchy)가 `#` → `##` → `###` 순서를 지키는가
- `#`(h1)은 파일당 1개만 있는가
- 빈 섹션(제목만 있고 내용 없는 섹션)이 없는가

### 4단계: 교차 참조 일관성 확인

한 문서에서 다른 문서를 언급할 때 파일명이 정확하고 존재하는지 확인한다.

```bash
echo "=== 백틱 내 파일 참조 ==="
rg -n '`[a-zA-Z][\w\-./]+\.(md|mdc)`' --glob '*.md' --glob '*.mdc' --glob '!.git/**' .
```

### 5단계: 에이전트 역할 경계 설명 일관성

각 에이전트의 범위 설명이 `agent-hierarchy.md`와 개별 `.mdc` 규칙 간에 일치하는지 확인한다.

`agent-hierarchy.md`의 역할 테이블과 각 `.mdc` 파일의 `## 범위` 섹션을 비교한다.

## 결과 판정

| 결과 | 판정 |
|------|------|
| 용어와 구조 모두 일관 | ✅ 통과 |
| 용어 불일치 발견 | ❌ 표준 표기로 통일 |
| 섹션 구조 깨짐 | ⚠️ heading hierarchy 수정 |
| 역할 경계 설명 불일치 | ❌ 기준 문서와 규칙 파일 동기화 |

## 주의사항

- 용어를 변경할 때는 반드시 모든 관련 문서를 함께 갱신한다 (Contract 에이전트 규칙).
- 새 용어를 도입하면 `reference-baseline.md`에 표준 표기를 기록한다.
- 불확실한 용어 정의가 있으면 Contract/Main에 확인 후 진행한다 (Backend 에이전트 규칙).
