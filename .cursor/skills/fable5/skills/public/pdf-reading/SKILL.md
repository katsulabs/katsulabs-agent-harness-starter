---
name: pdf-reading
description: Read and inspect PDFs from disk. Leaked trigger text plus reading guidance from anthropics/skills pdf reference (full Fable pdf-reading SKILL.md not publicly archived).
source: CL4R1T4S available_skills + anthropics/skills pdf/reference.md
---

# PDF reading

Use this skill when you need to read, inspect, or extract content from PDF files — especially when file content is NOT in your context and you need to read it from disk. Covers content inventory, text extraction, page rasterization for visual inspection, embedded image/attachment/table/form-field extraction, and choosing the right reading strategy for different document types (text-heavy, scanned, slide-decks, forms, data-heavy).

**Do NOT use** for PDF creation, form filling, merging, splitting, watermarking, or encryption — use [pdf/SKILL.md](../pdf/SKILL.md) instead.

## Reading strategies by document type

| Document type | Approach |
|---------------|----------|
| Text-heavy | Text extraction first; sample pages before full parse |
| Scanned | OCR / rasterize pages for visual inspection |
| Slide-decks | Page inventory; extract text per slide |
| Forms | Field inventory; see [forms.md](../pdf/forms.md) |
| Data-heavy tables | Table extraction; validate row/column counts |

## Related references

- Full PDF manipulation skill: [pdf/SKILL.md](../pdf/SKILL.md)
- Detailed reading/manipulation reference: [reference.md](../pdf/reference.md)
- Form-specific workflows: [forms.md](../pdf/forms.md)

## When content is already in context

If the PDF is visible natively in the conversation (image/pdf in context), decide whether disk access is actually needed before calling computer tools.
