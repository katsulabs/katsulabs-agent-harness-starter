# 운영 메모

## 잔여 설정 체크리스트

| 항목 | 상태 | 비고 |
|------|------|------|
| `gh auth login` | 완료 | katsulabs |
| `install-githooks.ps1` | 완료 | pre-commit 활성 |
| CI harness-gate | 완료 | status check: `validate` |
| branch protection | **보류** | Private Free 플랜 제한 |

## Private Free 대체 게이트

1. **pre-commit** — `pwsh scripts/validate-harness.ps1`
2. **CI** — push/PR 시 자동 실행
3. **PR 흐름** — main 직접 push 금지 (팀 규율)

## branch protection 활성화 조건

저장소를 **Public**으로 전환하거나 **GitHub Pro** 이상이면:

```bash
gh api -X PUT repos/katsulabs/katsulabs-agent-harness-starter/branches/main/protection \
  -f required_status_checks='{"strict":true,"contexts":["validate"]}' \
  -f enforce_admins=true \
  -f required_pull_request_reviews='{"required_approving_review_count":0}' \
  -F restrictions=
```

## CI 확인

```bash
gh run list --workflow harness-gate
gh run watch
```
