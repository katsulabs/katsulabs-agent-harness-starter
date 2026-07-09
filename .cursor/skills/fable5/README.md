# Fable 5 leaked reference archive

Local archive of the **Claude Fable 5** system prompt and related **claude.ai** skills from public leak/research repositories. For study and harness design reference only — not an active Cursor skill bundle.

## Completeness

| Path | Status | Source |
|------|--------|--------|
| `system-prompt.md` | Full (~120 KB) | [elder-plinius/CL4R1T4S](https://github.com/elder-plinius/CL4R1T4S/blob/main/ANTHROPIC/CLAUDE-FABLE-5.md) |
| `skills/public/docx/` | Full | [anthropics/skills](https://github.com/anthropics/skills) |
| `skills/public/pdf/` | Full + `reference.md`, `forms.md` | anthropics/skills |
| `skills/public/pptx/` | Full + `editing.md`, `pptxgenjs.md` | anthropics/skills |
| `skills/public/xlsx/` | Full | anthropics/skills |
| `skills/public/frontend-design/` | Full | anthropics/skills |
| `skills/public/product-self-knowledge/` | Full (~66 lines) | [bbeierle12/skill-mcp-claude](https://github.com/bbeierle12/skill-mcp-claude) (matches claude.ai container structure per [anthropics/claude-code#35910](https://github.com/anthropics/claude-code/issues/35910)) |
| `skills/public/file-reading/` | Reconstructed | Leaked `available_skills` + `file_handling_rules` in `system-prompt.md` |
| `skills/public/pdf-reading/` | Reconstructed | Leaked trigger + [pdf/reference.md](skills/public/pdf/reference.md) |
| `skills/public/md/` | Reconstructed | `file_creation_advice` + `artifact_usage_criteria` in `system-prompt.md` |
| `skills/public/data-analysis/` | Reconstructed | Prompt examples + [xlsx/SKILL.md](skills/public/xlsx/SKILL.md) pandas section |
| `skills/examples/skill-creator/` | Full | anthropics/skills |

**Reconstructed** = no public full `SKILL.md` leak; content assembled from the system prompt and closest public skills.

## Important

- **Not auto-loaded by Cursor.** Sibling folders under `.cursor/skills/` (e.g. `dispatch/`) are project skills; this `fable5/` tree is a reference library.
- **claude.ai only.** The leaked prompt targets the consumer chat interface, not Claude Code, Cursor, or the raw API.
- **Provenance.** Anthropic has not confirmed the system prompt. Use with appropriate skepticism.

## Original paths (claude.ai)

Leaked prompt maps skills to `/mnt/skills/public/<name>/SKILL.md` on Anthropic's Code Execution sandbox.
