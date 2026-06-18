---
name: pr-quality-gate
description: PR이 하네스 하드 게이트와 체크리스트를 충족하는지 검증한다. PR 생성 직전 또는 QA 리뷰 시 사용한다.
---

# PR 품질 게이트 검증

PR이 `.github/PULL_REQUEST_TEMPLATE.md`의 하드 게이트와 하네스 운영 규칙을 모두 충족하는지 확인하는 스킬입니다.

## 사용 시점

- PR을 생성하기 직전
- QA 에이전트가 PR을 검수할 때
- 머지 전 최종 확인 시

## 검증 절차

### 1단계: 브랜치 규칙 검증

현재 브랜치가 `main`이 아닌지 확인합니다. 기능 커밋은 반드시 별도 브랜치에서 진행해야 합니다.

브랜치 이름 규칙:
- 티켓 작업: `feature/TB-{id}-{short-name}`
- Cloud Agent: `cursor/<name>-<suffix>`

### 2단계: 커밋 이력 확인

```bash
git log main..HEAD --oneline
```

커밋이 비어 있으면 변경 사항이 없으므로 PR을 생성하지 않습니다.

### 3단계: PR 본문 필수 섹션 확인

| 필수 섹션 | 확인 항목 |
|-----------|-----------|
| **요약** | 변경 내용과 이유가 기술되어 있는가 |
| **검증 계획** | 문서 링크/규칙 형식/브랜치 규칙 항목이 체크되어 있는가 |
| **하네스 하드 게이트** | 하드 게이트 항목이 모두 응답되어 있는가 |

### 4단계: 하드 게이트 체크리스트 검증

**검증 계획:**
- [ ] 문서 링크/참조가 유효함
- [ ] `.cursor/rules/*.mdc` 형식이 유효함
- [ ] `main`에 기능 커밋 없음

**하네스 하드 게이트:**
- [ ] 티켓 ID와 범위가 명시됨
- [ ] 역할 경계 준수 (Contract/BE/FE/QA)
- [ ] 브랜치 네이밍 규칙 준수
- [ ] Hook fallback 사용 시 사유 기록 (해당 없으면 N/A)

### 5단계: diff와 PR 설명 일치 확인

```bash
git diff main..HEAD --stat
```

diff에 포함된 파일이 요약에서 언급한 변경 범위와 일치해야 합니다.

### 6단계: 역할 경계 검증

| 에이전트 | 허용 범위 |
|----------|-----------|
| Contract | `docs/**`, `.cursor/rules/**`, `.github/**` |
| Backend | `docs/**`, `.cursor/rules/**` |
| Frontend | `docs/**`, `.github/**` |
| QA | 테스트/PR 템플릿 |
| Main | `docs/**` 중심 |

## 결과 판정

| 결과 | 판정 |
|------|------|
| 모든 게이트 통과 | PR 생성/머지 가능 |
| 필수 섹션 누락 | PR 본문 보완 후 재시도 |
| 역할 경계 위반 | 변경 범위 조정 필요 |
| diff와 설명 불일치 | 요약 보완 또는 불필요한 변경 제거 |

## 빠른 체크 명령

```bash
git branch --show-current
git log main..HEAD --oneline
git diff main..HEAD --name-only
git diff main..HEAD --stat
```
