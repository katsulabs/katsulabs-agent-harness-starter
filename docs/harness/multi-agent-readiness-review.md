# 멀티에이전트 협업 적합성 검토 — katsulabs-agent-harness-starter

- **작성일**: 2026-07-17
- **대상**: 현재 하네스 구조 (`.cursor/`, `docs/harness/`, `scripts/`)
- **검토 방법**: 저장소 정적 분석 (오케스트레이터 규칙·dispatch·worktree·handoff 스키마·validate 스크립트·hooks·playbook 전수 확인)

> **이력 문서 (초기 진단).** 아래 "미지원/부분 지원" 판정은 2026-07-17 시점 스냅샷이며, **현재 상태가 아니다.** 판정된 갭은 이후 해소됨:
> - #1 동시 실행 안전 → TB-021 (PR #11) · #2 협업 채널 → TB-022 (PR #13) · #3 오케스트레이션 → TB-023 (PR #15) · 개념 반영 → TB-024 (PR #17)
> - 현재 개념 요약: [introduction.md](./introduction.md) 멀티에이전트 섹션 · 상태 채널: [status-schema.md](./status-schema.md)

---

## 0. 요청 프롬프트 (원문)

> 현재 이 하네스(harness) 구조가 멀티에이전트 협업에 적합한지 검토해줘. 다음을 구체적으로 확인해줘:
>
> 1. **동시 실행 안전성**: 여러 터미널에서 Cursor와 이 하네스를 동시에 여러 인스턴스로 돌릴 때, 파일 쓰기 충돌·상태 파일 경쟁(race condition)·락(lock) 부재로 인한 데이터 손상 가능성이 있는가? CLAUDE.md·설정 파일·계획 추적 파일(plan tracking) 등이 인스턴스 간 공유될 때 덮어쓰기 문제가 없는가?
> 2. **에이전트 간 협업 메커니즘**: 각 에이전트가 작업 상태·완료 여부·산출물을 서로 인지하고 인계할 수 있는 공유 채널(공유 파일, 브랜치, 큐, 메시지 저장소 등)이 존재하는가? 아니면 각 인스턴스가 완전히 격리되어 서로의 진행 상황을 모르는가?
> 3. **작업 분할·조정**: 하나의 큰 작업을 여러 에이전트에게 분배하고 결과를 병합하는 오케스트레이션 레이어가 있는가? 없다면 무엇이 필요한가?
> 4. **격리 vs 공유 경계**: 어떤 리소스(git worktree, 워킹 디렉토리, 브랜치, 임시 파일 경로)를 인스턴스별로 분리해야 충돌 없이 병렬 작업이 가능한지 구체적 경계를 제시해줘.
>
> 각 항목에 대해 "현재 지원됨 / 부분 지원 / 미지원"으로 판정하고, 미지원·부분 지원 항목은 멀티에이전트 친화적으로 만들기 위한 최소 변경안을 제시해줘. 추측이 필요한 부분은 [VERIFY] 표시하고 확인 방법을 알려줘.

---

## 핵심 전제: 이 하네스가 상정하는 "멀티에이전트"

이 하네스는 **단일 오케스트레이터 + 인-세션 Task 서브에이전트** 모델이다 (`.cursor/rules/orchestrator.mdc`, `docs/harness/playbook.md:28-42`). 즉 하나의 Cursor 세션에서 Main이 역할별 Task를 디스패치하고, 서브에이전트는 종료 시 결과를 **메인 컨텍스트로 구두 전달**한다 ("종료 시 산출물 경로·검증 결과를 메인에 전달").

질문의 시나리오 — **여러 터미널에서 독립 Cursor 인스턴스를 동시에** — 는 이 하네스가 설계상 상정한 모델이 **아니다**. 조율은 전적으로 *규약(convention)* 과 *git* 에 의존하며, 프로세스 간 런타임 조율 계층이 없다. 저장소 전체 grep 결과 `flock`/`lock`/`mutex`/`queue`/락파일이 **0건**이다 (유일 히트는 `fable5/system-prompt.md`의 무관한 문구).

---

## 1. 동시 실행 안전성 — **미지원** (worktree 엄격 준수 시 부분 지원)

**근거**
- 락 / 원자적 쓰기 / 경쟁 방지 장치가 **전무**. 조율은 순수 규약.
- **공유 가변 상태 파일** 충돌 위험:
  - `docs/harness/todo.md` — **최대 경쟁 지점.** 단일 마크다운 테이블 티켓 보드. 모든 인스턴스가 편집 → last-write-wins 손실 / 머지 충돌. 병합 전략 없음.
  - `AGENTS.md`, `docs/harness/playbook.md`, `.cursor/rules/*.mdc` — 읽기 위주지만 Editor 역할 편집 시 경쟁.
  - `eval/reports/latest-agent-eval.json`, `latest-agent-llm-eval.json` — **고정 파일명** 덮어쓰기 (`scripts/run-agent-eval.sh:73`). 같은 체크아웃에서 두 인스턴스가 돌리면 무조건 클로버 (gitignore라 머지 문제는 없으나 로컬 데이터 손상).
- `.git/index`, `HEAD` — **같은 워킹트리**에서 두 인스턴스가 커밋/브랜치 조작 시 경쟁. 단 git 자체 `index.lock`이 있어 **손상 대신 에러로 실패** (요란한 실패, 조용한 손상 아님).

**이미 존재하는 부분 보호**
- worktree-per-ticket 규약 (`.cursor/skills/worktree-setup/SKILL.md`, `playbook.md:24-26`)을 **엄격 준수 시** 각 티켓이 별도 체크아웃 → 워킹트리 파일 물리적 분리.
- git은 기본적으로 **같은 브랜치를 두 worktree에 체크아웃하는 것을 거부** (내장 브랜치 레벨 락). 각 worktree는 자체 index 보유 → worktree 간 동시 커밋 안전.

**최소 변경안**
1. `todo.md` 경쟁 제거 (택1):
   - **(권장·최소)** "todo.md는 각 티켓의 **자기 브랜치에서만** 편집, 머지 시점에만 통합. 남의 티켓 행 금지"를 `playbook.md`/`AGENTS.md`에 명문화 + 게이트로 강제.
   - (구조적) `docs/harness/tickets/TB-{id}.md`로 분리 후 `todo.md`를 생성물(read-only 인덱스)로 전환.
2. `eval/reports` 산출물을 **티켓/브랜치별 경로**로: `eval/reports/TB-{id}/latest-*.json` (`REPORT_DIR`에 브랜치 티켓 추가).
3. `playbook.md`에 하드 규칙: **"1 워킹트리 = 1 인스턴스. 동시 병렬은 반드시 worktree-per-ticket."**

**[VERIFY]** Cursor **Task** 서브에이전트가 부모 세션과 파일시스템 공유·직렬화되는지 vs 진짜 동시 OS 프로세스인지. → 확인법: 두 Task에 같은 파일로 `sleep` 후 append 시키고 인터리빙 관찰. 직렬화라면 인-세션 파일 경쟁은 애초에 없음 (이 항목 위험은 *다중 인스턴스* 한정).

---

## 2. 에이전트 간 협업 메커니즘 — **부분 지원**

**존재하는 공유 채널**
- **Contract 핸드오프 파일**: `docs/harness/handoffs/TB-{id}-handoff.md` — 고정 스키마(`docs/harness/handoff-schema.md`) + 린터(`scripts/validate-handoff.*`) + frontmatter `status: ready|blocked`, `breaking:`. 유일하게 **명시적·기계검증 가능한 인계 채널** (Contract → Backend/Frontend 단방향).
- **todo.md 상태 컬럼** = 티켓 보드.
- **git 브랜치 / PR** = 통합 채널.

**한계**
- 인-세션 조율 전제. 라이브 진행 상황("에이전트 X가 지금 Y 작업 중")을 알리는 **하트비트·클레임·완료 시그널 없음**. 독립 인스턴스는 **커밋된 파일**(핸드오프·todo·브랜치)만 볼 수 있고 진행 중 상태는 못 봄.
- 완료 통보가 "메인에 구두 전달"(`playbook.md:37`)이라 **프로세스 간 소실**.
- 핸드오프는 Contract→BE/FE **단방향**만 스키마화. BE↔FE, QA→역할 역보고는 자유 텍스트.

**최소 변경안**
- 티켓별 **커밋되는 상태 파일** 도입: `docs/harness/handoffs/TB-{id}-status.md`(또는 `.json`). 각 역할이 종료 시 `role / status(done|blocked) / artifacts[] / verified(run-eval 결과)`를 **append**. "구두 전달"을 이 파일로 대체 → 인스턴스 간 비동기 인지 가능. append-only라 머지 안전.
- `validate-harness -Pr`에 "모든 역할 status=done" 체크 추가로 게이트화.

---

## 3. 작업 분할·조정 오케스트레이션 — **부분 지원**

**존재하는 것**
- 조율 *규약*: `orchestrator.mdc`(Main 역할, alwaysApply) + `dispatch` 스킬 + `scripts/dispatch-prompt.sh`(역할별 프롬프트 텍스트 생성) + 시퀀스 Contract→BE/FE→QA.
- `scripts/verify-dispatch.sh`가 PR 전 브랜치 규약 게이트.

**한계 — 진짜 오케스트레이션 레이어 없음**
- `dispatch-prompt.sh`는 **텍스트 프롬프트만 출력**. 사람이 Task에 붙여넣음. 작업 **자동 분할·할당·완료추적·결과병합** 코드 없음.
- 결과 **병합은 QA/Main 수동**. 자동 aggregation·스케줄러·워크큐 없음.
- 즉 "오케스트레이션"은 프롬프트-드리븐 스캐폴딩이지 프로그래매틱 조정자가 아님.

**최소 변경안**
- **매니페스트 기반 조정**(최소): `scripts/dispatch-plan.sh TB-xxx`가 (a) 전 역할 프롬프트 + 순서, (b) `TB-{id}-status.md` 스켈레톤을 한 번에 생성.
- **수집 게이트**: `scripts/collect-handoff.sh TB-xxx` — 각 역할 status=done + run-eval PASS 확인 후에만 QA/PR 허용. #2 상태 파일과 결합하면 "분배→추적→병합 관문" 최소 루프 완성.
- 다중 인스턴스 큐가 진짜 필요하면 그때 파일 기반 lease 큐(`docs/harness/queue/` 클레임 파일)로 확장. 스타터엔 과함.

---

## 4. 격리 vs 공유 경계 (구체적 경계)

### 인스턴스/티켓별로 반드시 격리 (write-isolated)

| 리소스 | 경계 | 현재 상태 |
|--------|------|-----------|
| 워킹트리 | `../.worktrees/TB-{id}-{name}` | ✅ 규약 존재, `.gitignore` 등록됨 |
| 브랜치 | `feature/TB-{id}-{name}` (티켓당 1개) | ✅ + git이 동일 브랜치 이중 체크아웃 거부(내장 락) |
| git index/HEAD | worktree마다 자체 index | ✅ (git 기본 동작) |
| eval 산출물 | `eval/reports/latest-*.json` 고정명 | ❌ **클로버 위험** → 티켓별 경로로 |
| 임시/스크래치 | 세션별 디렉토리 | ⚠️ 규정 없음 → 명문화 필요 |
| `.cursor/mcp.json` | 로컬·머신별(gitignored) | ✅ |

### 워킹트리 내 역할 병렬 (Backend ∥ Frontend)
- 쓰기 분할 근거 = **역할 glob 비중첩**: Backend(`modules/**,backend/**,server/**,api/**`) vs Frontend(`frontend/**,client/**,apps/web/**`) 미중첩 (`playbook.md:11-13`).
- **단, 규약일 뿐 강제되지 않음** — Backend 에이전트가 `frontend/**`를 건드리는 걸 막는 장치 없음 (`playbook.md:39`).

### 공유 (직렬화 또는 머지-친화 필수)

| 리소스 | 성격 | 처리 |
|--------|------|------|
| `docs/harness/todo.md` | 티켓 보드 | ⚠️ **최대 경쟁** → 자기 브랜치 편집 한정 or 파일 분리 (#1) |
| `AGENTS.md`/`playbook`/`rules` | 설정, 읽기 위주 | Editor 역할이 자기 티켓 브랜치에서만 편집 |
| 핸드오프 파일 | 티켓별 경로 | ✅ 이미 분리 |
| `.git` object/refs | 공유 저장소 | git-safe, 머지 시점 통합 |

**결론 경계 원칙**: *워킹트리·브랜치·eval산출물·스크래치 = 티켓별 격리*, *todo.md·공유설정 = 자기 브랜치에서만 편집 후 머지 통합*, *역할 glob = 워킹트리 내 쓰기 파티션(단 미강제)*.

**[VERIFY]** 각 git worktree가 독립 `index.lock`을 가져 동시 커밋이 안전한지. → 확인법: `git worktree add` 2개 생성 후 양쪽 동시 커밋, 손상 없이 성공하는지 관찰.

---

## 종합 판정표

| 항목 | 판정 | 핵심 갭 | 최소 변경 |
|------|------|---------|-----------|
| 1. 동시 실행 안전성 | **미지원** (worktree 엄수 시 부분) | 락 전무, todo.md·eval산출물 클로버 | "1워킹트리=1인스턴스" 명문화, todo.md 브랜치-한정 편집, eval 산출물 티켓별 경로 |
| 2. 협업 메커니즘 | **부분 지원** | 핸드오프는 있으나 라이브 상태·완료 시그널 프로세스 간 소실 | 커밋되는 `TB-{id}-status.md`로 "구두 전달" 대체 |
| 3. 오케스트레이션 | **부분 지원** | 프롬프트 생성만, 자동 분배·추적·병합 없음 | `dispatch-plan` + `collect-handoff` 게이트 |
| 4. 격리/공유 경계 | **부분 지원** | 경계 존재하나 대부분 미강제·미명문화 | 위 경계표 강제 + eval 경로 격리 |

**한 줄 요약**: 이 하네스는 *단일 세션 내 순차/병렬 서브에이전트 규약*으로는 잘 짜여 있으나(역할 glob·핸드오프 스키마·검증 게이트), **다중 독립 인스턴스 동시 실행**에는 락·공유 상태 채널·프로그래매틱 조정자가 없어 미지원이다. 저렴하고 효과 큰 3가지: **① worktree-per-ticket을 유일 병렬 모드로 강제, ② todo.md/eval 산출물 공유 경쟁 제거, ③ 커밋되는 티켓 상태 파일 도입.**
