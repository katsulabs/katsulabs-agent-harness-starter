# katsulabs-agent-harness-starter

토큰 효율 + 운영 강제력 Cursor 멀티 에이전트 하네스.

## 포함

- `.cursor/rules` — orchestrator, editor, qa
- `scripts/validate-harness.ps1` — 자동 게이트
- `.github/workflows/harness-gate.yml` — CI
- `.cursor/hooks.json` — stop 시 validate
- `docs/harness/playbook.md` — 에이전트 단일 참조

## 시작

```bash
pwsh scripts/validate-harness.ps1
pwsh scripts/install-githooks.ps1
```

온보딩: `docs/harness/getting-started.md` · 확장: `docs/harness/extending.md` · Cloud: `AGENTS.md`
