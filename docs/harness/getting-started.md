# 시작 가이드

**에이전트는 `playbook.md`만 참조한다.** 이 문서는 사람용 온보딩이다.

## 설치

1. 복사: `.cursor/**`, `docs/harness/**`, `scripts/**`, `.githooks/**`, `.github/**`
2. `pwsh scripts/install-githooks.ps1` — pre-commit 게이트 설치
3. `docs/harness/todo.md`에 티켓/DoD 입력

## Day 1

- [ ] `playbook.md` 읽기
- [ ] `pwsh scripts/validate-harness.ps1` 통과
- [ ] `examples/sample-ticket.md` 플로우 시뮬레이션

## GitHub 운영 (활성)

저장소 **Public** · `main` branch protection 적용됨.

| 규칙 | 값 |
|------|-----|
| Status check | `validate` |
| PR 필수 | 예 |
| 직접 push | 차단 |

흐름: `feature/TB-{id}-*` → PR → CI green → merge (no-ff)

## 커스터마이징

- 티켓 prefix · 브랜치 규칙 · `extending.md` 참고
