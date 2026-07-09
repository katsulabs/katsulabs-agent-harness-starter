---
name: md
description: Create standalone Markdown (.md) deliverables in outputs. Reconstructed from Fable 5 system prompt file_creation_advice and artifact_usage_criteria (full SKILL.md not publicly archived).
source: CL4R1T4S system-prompt.md (file_creation_advice, artifact_usage_criteria, examples)
---

# Markdown (.md) file creation

Use when the user asks for a blog post, article, report, guide, or other standalone written content as a **file** — not inline chat prose.

**Example (from leaked prompt):** "Write a blog post about AI trends" → create an actual `.md` file in `/mnt/user-data/outputs`, don't just output text in chat.

## File vs inline

Standalone artifact (→ file): blog post, article, story, essay, social post — even if short or casual ("write me a quick 200-word blog post lol").

Inline (→ chat only): strategy, summary, outline, brainstorm, explanation ("I need a strategy for X", "quick summary of Y").

When in doubt between markdown and docx: prefer markdown unless the user explicitly wants Word or a formal client deliverable.

## Artifact criteria

Use a `.md` artifact when:

- Content is for use outside the conversation (reports, articles, blog posts)
- Long-form creative writing
- Standalone text-heavy document >20 lines or >1500 characters
- User asked to save, download, or share a file

Do **not** create markdown files for:

- Web search responses or research summaries (stay conversational)
- Short prose or lists the user will read in chat
- Anything the user explicitly asked to keep short

## Output path

- Short (<100 lines): create in one step, save to `/mnt/user-data/outputs/`
- Long (>100 lines): outline first, build section by section, copy final version to `/mnt/user-data/outputs/`

## Formatting note

Markdown file creation only — conversational answers should NOT use report-style headers; use natural prose per tone guidelines.
