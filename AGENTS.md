# AGENTS.md

## Cursor Cloud specific instructions

### Project overview

This is a **documentation-only starter template** (`katsulabs-agent-harness-starter`) for Cursor-based multi-agent development workflows. It contains no source code, no build systems, no dependencies, and no runnable application services. The entire repository consists of Markdown (`.md`) and Cursor rule files (`.mdc`).

### Repository structure

- `.cursor/rules/*.mdc` — Agent role templates (orchestrator, contract, backend, frontend, qa)
- `docs/harness/` — Operational documentation (hierarchy, workflow, todo, getting-started, reference-baseline)
- `.github/PULL_REQUEST_TEMPLATE.md` — PR hard-gate checklist
- `README.md` — Root readme

### Development environment

- **Only dependency**: `git` (pre-installed in all Cloud Agent VMs).
- **No build/lint/test commands** exist yet — the repo is a scaffold. References to backend tests, frontend tests, Flyway migrations, and Vitest in the docs are placeholder conventions for future projects that adopt this template.
- **No update script is needed** beyond `git fetch`.

### Workflow conventions (from `.cursor/rules/orchestrator.mdc`)

- Never commit directly to `main` — always use feature branches.
- Branch naming: `feature/TB-{id}-{short-name}` (for ticket work) or `cursor/<name>-<suffix>` (for Cloud Agent branches).
- Merge strategy: `no-ff`.
- Before any implementation request, check `docs/harness/todo.md` for active tickets and DoD.

### Validation for documentation changes

Since the repo is docs-only, "testing" means verifying:
1. All internal Markdown links resolve to existing files.
2. Cursor rule files (`.mdc`) are syntactically valid (YAML front-matter + Markdown body).
3. PR description follows `.github/PULL_REQUEST_TEMPLATE.md` hard-gate checklist.
