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

## GitHub 운영

### Private 무료 플랜 (현재)

branch protection **미지원**. 대체 게이트:

- 로컬: `install-githooks.ps1` (pre-commit)
- CI: `harness-gate` workflow (`main`·`feature/**` push, PR)
- 흐름: feature 브랜치 → PR → merge (no-ff)

### Pro 또는 Public 저장소

1. Settings → Branches → `main` protection
2. Require status check: **`validate`**
3. Require PR before merge

```bash
gh api -X PUT repos/OWNER/REPO/branches/main/protection \
  --input - <<'EOF'
{
  "required_status_checks": { "strict": true, "contexts": ["validate"] },
  "enforce_admins": true,
  "required_pull_request_reviews": { "required_approving_review_count": 0 },
  "restrictions": null
}
EOF
```

## 커스터마이징

- 티켓 prefix · 브랜치 규칙 · `extending.md` 참고
