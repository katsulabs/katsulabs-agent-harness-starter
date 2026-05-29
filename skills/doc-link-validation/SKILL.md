---
name: doc-link-validation
description: 프로젝트 내 모든 Markdown 문서의 내부 링크와 참조가 유효한지 검증한다. 문서를 추가/이동/삭제한 후, 또는 PR 제출 전에 사용한다.
---

# 문서 링크 검증

Markdown 문서 내부의 상대 링크, 앵커, 파일 참조가 모두 유효한지 확인하는 스킬이다.

## 사용 시점

- 문서 파일을 추가, 이동, 삭제, 이름 변경한 후
- PR 제출 전 품질 게이트 통과 확인 시
- QA 에이전트가 링크 정합성을 검증할 때

## 검증 절차

### 1단계: 대상 파일 수집

프로젝트 내 모든 Markdown 파일을 수집한다 (`.git` 제외).

```bash
find . -name '*.md' -not -path './.git/*'
```

### 2단계: 상대 링크 추출 및 검증

각 파일에서 `[텍스트](./경로)` 형식의 상대 링크를 추출하고, 대상 파일이 존재하는지 확인한다.

```bash
for f in $(find . -name '*.md' -not -path './.git/*'); do
  dir=$(dirname "$f")
  rg -oP '\[.*?\]\((\./[^)]+)\)' "$f" | while read -r match; do
    target=$(echo "$match" | rg -oP '\(\./([^)#]+)' | tr -d '(')
    target="${target#./}"
    if [ ! -f "$dir/$target" ]; then
      echo "BROKEN: $f -> $target"
    fi
  done
done
```

### 3단계: 규칙 파일 내 참조 검증

`.cursor/rules/*.mdc` 파일에서 백틱 내의 파일 경로 참조를 확인한다.

```bash
for f in .cursor/rules/*.mdc; do
  rg -oP '`([a-zA-Z][\w\-./]+\.(md|mdc))`' "$f" | while read -r ref; do
    path=$(echo "$ref" | tr -d '`')
    if [ ! -f "$path" ] && [ ! -f ".cursor/rules/$path" ] && [ ! -f "docs/harness/$path" ]; then
      echo "UNRESOLVED: $f -> $path"
    fi
  done
done
```

### 4단계: 결과 판정

| 결과 | 판정 |
|------|------|
| BROKEN 또는 UNRESOLVED 없음 | ✅ 통과 |
| BROKEN 발견 | ❌ 깨진 링크를 수정하거나 대상 파일을 생성/복원 |
| UNRESOLVED 발견 | ⚠️ 참조 경로를 확인하고 필요 시 수정 |

## 주의사항

- 외부 URL(`http://`, `https://`)은 이 스킬의 범위 밖이다.
- 앵커 링크(`#섹션명`)는 대상 파일 내 해당 제목이 존재하는지까지 확인하면 가장 좋지만, 최소한 파일 존재 여부는 확인한다.
- 문서 이동 시에는 기존 경로에서 참조하던 모든 파일을 함께 갱신한다.
