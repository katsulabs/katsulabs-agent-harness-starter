# katsulabs-agent-harness-starter

Cursor에게 **누가·무엇을·어떤 순서로·어떤 검증 후** 일할지 알려 주고, 스크립트·CI로 강제하는 **3세대 에이전트 운영 하네스**.

앱 스타터가 아님 · 에이전트 플랫폼도 아님.

---

## 학습 순서 (여기서 시작)

| # | 문서 | 내용 |
|---|------|------|
| 0 | **이 README** | 30초 오리엔테이션 |
| 1 | [introduction.md](docs/harness/introduction.md) | 하네스가 뭔지 · 3세대 레이어 |
| 2 | [evolution.md](docs/harness/evolution.md) | 1·2·3세대 정의 |
| 3 | [how-to-use.md](docs/harness/how-to-use.md) | 경로 A(템플릿) vs B(빈 폴더) |
| 4a | [TEMPLATE.md](docs/harness/TEMPLATE.md) | **경로 A** — clone/템플릿 채택 |
| 4b | [bootstrap-prompts.md](docs/harness/bootstrap-prompts.md) | **경로 B** — 빈 폴더 생성 프롬프트 |
| 5 | [first-ticket.md](docs/harness/first-ticket.md) | 첫 티켓 30분 |
| 6 | [AGENTS.md](AGENTS.md) → [playbook.md](docs/harness/playbook.md) | 계약 · 운영 (playbook은 필요 섹션만) |

전체 허브: [getting-started.md](docs/harness/getting-started.md) · 문서 목록: [docs/harness/README.md](docs/harness/README.md)

**보통은 경로 A** (이 저장소를 template/clone). Bootstrap은 빈 폴더에서만.

---

## 멀티에이전트

여러 인스턴스·서브에이전트를 병렬로 운영할 때의 안전·인계·조정 장치가 내장되어 있다.

| 관심사 | 장치 |
|--------|------|
| 동시 실행 안전 | 티켓별 worktree 격리 · eval 산출물 `eval/reports/TB-{id}/` |
| 협업 인계 | 커밋되는 상태 채널 `TB-{id}-status.md` (`validate-status`) |
| 작업 조정 | `dispatch-plan` → 역할 병렬 → `collect-handoff` (PR 전 게이트) |

상세: [introduction.md](docs/harness/introduction.md) 멀티에이전트 섹션 · [status-schema.md](docs/harness/status-schema.md)

---

## Day 1 검증

**PowerShell 7.4+** (`pwsh`):

```powershell
pwsh scripts/validate-harness.ps1
pwsh scripts/install-githooks.ps1
pwsh scripts/run-eval.ps1
```

**macOS / Linux / Git Bash**:

```bash
./scripts/validate-harness.sh
./scripts/install-githooks.sh
./scripts/run-eval.sh
```

쉘: [setup-shell.md](docs/harness/setup-shell.md)
