---
name: file-reading
description: Router for uploaded files when content is not in context. Leaked trigger text plus file-handling rules extracted from the Fable 5 system prompt (full SKILL.md body not publicly archived).
source: CL4R1T4S system-prompt.md (available_skills + file_handling_rules)
---

# File reading (upload router)

Use this skill when a file has been uploaded but its content is NOT in your context — only its path at `/mnt/user-data/uploads/` is listed in an `uploaded_files` block. This skill is a router: it tells you which tool to use for each file type (pdf, docx, xlsx, csv, json, images, archives, ebooks) so you read the right amount the right way instead of blindly running `cat` on a binary.

**Triggers:** any mention of `/mnt/user-data/uploads/`, an `uploaded_files` section, a `file_path` tag, or a user asking about an uploaded file you have not yet read.

**Do NOT use** if the file content is already visible in your context inside a `documents` block — you already have it.

## File locations (from system prompt)

1. **User uploads:** every file in context is also on disk at `/mnt/user-data/uploads`. `view /mnt/user-data/uploads` to list.
2. **Claude's work:** `/home/claude` — scratchpad; users cannot see this directory.
3. **Final outputs:** `/mnt/user-data/outputs` — only final deliverables.

## In-context vs computer read

Some upload types also appear in the context window as text (md, txt, html, csv) or image (png, pdf) that Claude can see natively. Types not in-context must be read via the computer (`view` or `bash`).

- **Use the computer:** user uploads an image and asks to convert it to grayscale.
- **Don't:** user uploads an image of text and asks to transcribe it, since Claude can already see the image.

## Type → skill / tool routing

| Type | Next step |
|------|-----------|
| PDF (read/extract) | Read [pdf-reading/SKILL.md](../pdf-reading/SKILL.md) |
| PDF (create/edit/fill) | Read [pdf/SKILL.md](../pdf/SKILL.md) |
| Word (.docx) | Read [docx/SKILL.md](../docx/SKILL.md) |
| Spreadsheet (.xlsx, .csv, .tsv) | Read [xlsx/SKILL.md](../xlsx/SKILL.md) or [data-analysis/SKILL.md](../data-analysis/SKILL.md) for charts |
| Presentation (.pptx) | Read [pptx/SKILL.md](../pptx/SKILL.md) |
| Markdown output | Read [md/SKILL.md](../md/SKILL.md) |

## Example decisions

- "Summarize this attached file" → in-conversation → use provided content, do NOT use `view`
- User path only under `uploaded_files` → route by extension using the table above before reading
