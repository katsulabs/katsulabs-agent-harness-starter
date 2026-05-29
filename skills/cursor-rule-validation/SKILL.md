---
name: cursor-rule-validation
description: .cursor/rules/*.mdc 파일의 형식, YAML front-matter, 필수 섹션이 올바른지 검증한다. 규칙 파일을 추가하거나 수정한 후에 사용한다.
---

# Cursor 규칙 파일 검증

`.cursor/rules/*.mdc` 파일이 Cursor가 인식할 수 있는 올바른 형식인지 확인하는 스킬이다.

## 사용 시점

- 새로운 `.mdc` 규칙 파일을 추가한 후
- 기존 규칙 파일의 front-matter를 수정한 후
- PR 제출 전 규칙 파일 정합성 확인 시

## 검증 절차

### 1단계: 파일 목록 확인

```bash
ls -la .cursor/rules/*.mdc
```

### 2단계: YAML front-matter 형식 검증

각 `.mdc` 파일이 `---`로 시작하는 YAML front-matter를 가지는지 확인한다.

```bash
for f in .cursor/rules/*.mdc; do
  first_line=$(head -1 "$f")
  if [ "$first_line" != "---" ]; then
    echo "FAIL: $f - YAML front-matter 누락"
  else
    echo "OK: $f"
  fi
done
```

### 3단계: 필수 front-matter 필드 검증

각 파일에 `description`과 `alwaysApply` 필드가 존재하는지 확인한다.

```bash
for f in .cursor/rules/*.mdc; do
  has_desc=$(rg -c '^description:' "$f" 2>/dev/null || echo "0")
  has_apply=$(rg -c '^alwaysApply:' "$f" 2>/dev/null || echo "0")
  issues=""
  [ "$has_desc" = "0" ] && issues="${issues} description 누락"
  [ "$has_apply" = "0" ] && issues="${issues} alwaysApply 누락"
  if [ -n "$issues" ]; then
    echo "WARN: $f -$issues"
  else
    echo "OK: $f"
  fi
done
```

### 4단계: alwaysApply 정책 확인

`alwaysApply: true`인 파일은 모든 컨텍스트에서 항상 적용된다. 의도하지 않은 전역 적용이 없는지 확인한다.

```bash
rg -l 'alwaysApply: true' .cursor/rules/
```

기대값:
- `orchestrator.mdc` — 전역 워크플로우 규칙 (alwaysApply: true)
- `karpathy-guidelines.mdc` — 전역 행동 가이드라인 (alwaysApply: true)
- 역할별 규칙(backend, contract, frontend, qa) — `alwaysApply: false`

### 5단계: globs 패턴 유효성 확인 (역할별 규칙)

`alwaysApply: false`인 파일은 `globs` 필드가 있어야 Cursor가 적절한 컨텍스트에서만 활성화한다.

```bash
for f in .cursor/rules/*.mdc; do
  is_always=$(rg -c 'alwaysApply: true' "$f" 2>/dev/null || echo "0")
  if [ "$is_always" = "0" ]; then
    has_globs=$(rg -c '^globs:' "$f" 2>/dev/null || echo "0")
    if [ "$has_globs" = "0" ]; then
      echo "WARN: $f - alwaysApply: false이지만 globs 없음"
    fi
  fi
done
```

### 6단계: 본문 구조 확인

Markdown 본문에 최소 하나의 `#` 제목이 있는지 확인한다.

```bash
for f in .cursor/rules/*.mdc; do
  has_heading=$(rg -c '^#' "$f" 2>/dev/null || echo "0")
  if [ "$has_heading" = "0" ]; then
    echo "WARN: $f - Markdown 제목 없음"
  fi
done
```

## 결과 판정

| 결과 | 판정 |
|------|------|
| 모든 파일 OK | ✅ 통과 |
| YAML front-matter 누락 | ❌ 즉시 수정 필요 (Cursor가 규칙을 인식하지 못함) |
| 필수 필드 누락 | ⚠️ description과 alwaysApply 추가 권장 |
| globs 누락 (조건부 규칙) | ⚠️ 의도적이면 무시, 아니면 globs 추가 |

## .mdc 파일 템플릿

```markdown
---
description: 규칙의 한 줄 설명
globs: "대상/경로/**/*.확장자"
alwaysApply: false
---

# 규칙 제목

## 섹션 1

- 규칙 내용
```
