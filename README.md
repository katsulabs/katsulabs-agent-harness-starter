# katsulabs-agent-harness-starter

3세대 Agent Engineering 템플릿 — Rules + Skills + Runtime(eval/CI) + MCP 스켈레톤.

## 포함

- **Ambient**: `AGENTS.md`, `docs/harness/playbook.md`
- **Rules**: orchestrator, editor, contract, backend, frontend, qa
- **Skills**: harness-gate, pr-workflow, worktree-setup
- **Runtime**: `validate-harness` / `run-eval` (`.ps1` + `.sh`), CI, hooks
- **MCP**: `.cursor/mcp.json.example`

## 시작

**PowerShell 7.4+** (`pwsh`) — Windows 권장 · macOS도 사용 가능:

```powershell
pwsh scripts/validate-harness.ps1
pwsh scripts/install-githooks.ps1
```

**macOS / Linux / Git Bash**:

```bash
./scripts/validate-harness.sh
./scripts/install-githooks.sh
```

쉘 설정: `docs/harness/setup-shell.md` · 채택: `docs/harness/TEMPLATE.md` · 기여: `CONTRIBUTING.md`
