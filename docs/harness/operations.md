# 운영 메모

## 설정 체크리스트

| 항목 | 상태 |
|------|------|
| `gh auth login` | 완료 |
| `install-githooks.ps1` | 완료 |
| CI harness-gate | 완료 (`validate`) |
| 저장소 Public | 완료 |
| branch protection (`main`) | **완료** |

## branch protection (`main`)

- **Status check**: `validate` (strict)
- **PR required**: 예 (승인 0명)
- **enforce_admins**: 예
- **force push**: 차단

`main`에 직접 push 불가. feature 브랜치 → PR → CI green → merge.

## 재설정 명령

```bash
gh api -X PUT repos/katsulabs/katsulabs-agent-harness-starter/branches/main/protection \
  --input .tmp-branch-protection.json
```

```json
{
  "required_status_checks": { "strict": true, "contexts": ["validate"] },
  "enforce_admins": true,
  "required_pull_request_reviews": { "required_approving_review_count": 0 },
  "restrictions": null
}
```

## CI 확인

```bash
gh run list --workflow harness-gate
gh pr checks
```
