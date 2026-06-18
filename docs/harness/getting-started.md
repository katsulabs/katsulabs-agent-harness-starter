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

## GitHub 운영 (권장)

1. Settings → Branches → `main` protection
2. Require status check: **harness-gate**
3. Require PR before merge

## 커스터마이징

- 티켓 prefix · 브랜치 규칙 · `extending.md` 참고
