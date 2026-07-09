---
name: data-analysis
description: Analyze tabular data and chart from CSV/spreadsheets. Reconstructed from Fable 5 system prompt examples plus xlsx skill pandas section (full SKILL.md not publicly archived).
source: CL4R1T4S system-prompt.md (examples) + anthropics/skills xlsx
---

# Data analysis

Use **before** touching a CSV or writing plotting code when the user asks to analyze tabular data (e.g. "Here's last quarter's sales CSV, chart revenue by region").

**Example (from leaked prompt):** immediately read this skill before touching the CSV or writing any plotting code.

## Workflow

1. Confirm input path (often `/mnt/user-data/uploads/` — see [file-reading/SKILL.md](../file-reading/SKILL.md))
2. Inspect schema: columns, dtypes, nulls, row count
3. Clean or reshape if needed
4. Analyze or visualize per user goal
5. Deliver: chart file, summary table, or updated spreadsheet in `/mnt/user-data/outputs/`

## Libraries (claude.ai sandbox)

- **pandas** for manipulation: `pip install pandas --break-system-packages` if needed
- **matplotlib**, **plotly**, or **chart.js** (in artifacts) for charts depending on deliverable type

## Spreadsheet deliverables

If the primary output must be an `.xlsx` file (not just a chart image), also read [xlsx/SKILL.md](../xlsx/SKILL.md) — it includes pandas analysis patterns and Excel output requirements.

## Deliverable type

| User wants | Output |
|------------|--------|
| Chart only | `.png` / `.svg` or React artifact with recharts |
| Updated data + chart | `.xlsx` via xlsx skill |
| Narrative analysis only | inline chat (no file) unless user asked to save |
