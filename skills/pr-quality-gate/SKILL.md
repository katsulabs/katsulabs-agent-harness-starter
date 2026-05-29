---
name: pr-quality-gate
description: PR이 하네스 하드 게이트와 체크리스트를 충족하는지 검증한다. PR 생성 직전 또는 QA 리뷰 시 사용한다.
---

# PR 품질 게이트 검증

PR이 `.github/PULL_REQUEST_TEMPLATE.md`의 하드 게이트와 하네스 운영 규칙을 모두 충족하는지 확인하는 스킬이다.

## 사용 시점

- PR을 생성하기 직전
- QA 에이전트가 PR을 검수할 때
- 머지 전 최종 확인 시

## 검증 절차

### 1단계: 브랜치 규칙 검증

현재 브랜치가 `main`이 아닌지 확인한다. 기능 커밋은 반드시 별도 브랜치에서 진행해야 한다.

```bash
current=$(git branch --show-current)
if [ "$current" = "main" ]; then
  echo "FAIL: main 브랜치에서 직접 커밋하고 있음"
else
  echo "OK: 브랜치 $current"
fi
```

브랜치 이름이 규칙에 맞는지 확인한다:
- 티켓 작업: `feature/TB-{id}-{short-name}`
- Cloud Agent: `cursor/<name>-<suffix>`

### 2단계: 커밋 이력 확인

PR에 포함된 커밋이 main에 직접 푸시되지 않았는지 확인한다.

```bash
git log main..HEAD --oneline
```

커밋이 비어 있으면 변경 사항이 없는 것이므로 PR을 생성하지 않는다.

### 3단계: PR 본문 필수 섹션 확인

PR 본문에 아래 섹션이 모두 포함되어야 한다 (`.github/PULL_REQUEST_TEMPLATE.md` 기준):

| 필수 섹션 | 확인 항목 |
|-----------|-----------|
| **Summary** | 변경 내용과 이유가 기술되어 있는가 |
| **Test Plan** | 테스트 게이트 항목이 체크되어 있는가 |
| **Harness Hard Gates** | 하드 게이트 항목이 모두 응답되어 있는가 |

### 4단계: 하드 게이트 체크리스트 검증

아래 항목을 하나씩 확인한다:

**Test Plan:**
- [ ] backend test gate passed — 백엔드 테스트 게이트 통과 여부
- [ ] frontend test gate passed — 프론트엔드 테스트 게이트 통과 여부
- [ ] no direct feature commit to `main` — main 직접 커밋 없음

**Harness Hard Gates:**
- [ ] ticket id and scope are documented — 티켓 ID와 범위가 명시됨
- [ ] role boundary is respected — 역할 경계(Contract/BE/FE/QA) 준수
- [ ] worktree branch naming rule is followed — 브랜치 네이밍 규칙 준수
- [ ] DB/Flyway change includes rollback or compatibility note — DB 변경 시 호환성 메모 (해당 없으면 N/A)
- [ ] hook fallback used? — Hook fallback 사용 시 사유 기록 (해당 없으면 N/A)

### 5단계: diff와 PR 설명 일치 확인

실제 diff 범위가 PR 본문의 Summary와 일치하는지 확인한다.

```bash
git diff main..HEAD --stat
```

diff에 포함된 파일이 Summary에서 언급한 변경 범위와 일치해야 한다.
Summary에 없는 파일이 diff에 포함되어 있으면 **수술적 변경** 원칙 위반 가능성이 있다.

### 6단계: 역할 경계 검증

변경된 파일이 해당 에이전트의 허용 범위 내인지 확인한다.

| 에이전트 | 허용 범위 |
|----------|-----------|
| Contract | `docs/**`, `.cursor/rules/**`, `.github/**` |
| Backend | `docs/**`, `.cursor/rules/**` |
| Frontend | `docs/**`, `.github/**` |
| QA | 테스트/PR 템플릿 |
| Main | `docs/**` 중심 |

```bash
git diff main..HEAD --name-only
```

## 결과 판정

| 결과 | 판정 |
|------|------|
| 모든 게이트 통과 | ✅ PR 생성/머지 가능 |
| 필수 섹션 누락 | ❌ PR 본문 보완 후 재시도 |
| 역할 경계 위반 | ❌ 변경 범위 조정 필요 |
| diff와 설명 불일치 | ⚠️ Summary 보완 또는 불필요한 변경 제거 |

## 빠른 체크 명령

전체 게이트를 한 번에 확인하는 축약 절차:

```bash
echo "1. 브랜치:" && git branch --show-current
echo "2. 커밋:" && git log main..HEAD --oneline
echo "3. 변경 파일:" && git diff main..HEAD --name-only
echo "4. diff 통계:" && git diff main..HEAD --stat
```
