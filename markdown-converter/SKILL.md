---
name: markdown-converter
description: Convert documents, files, or supported URLs into Markdown using MarkItDown.
---

# Markdown Converter

Use the project's existing converter or installed MarkItDown when available. For a standalone conversion, `uvx markitdown` runs in a tool environment and may download/cache dependencies under the user account; it does not install them into the project. Disclose that effect before a first run.

## Convert locally

```bash
uvx markitdown input.pdf
uvx markitdown input.docx -o output.md
```

Inspect installed help for supported formats, optional dependencies, and flags. PDF, Office, HTML, tabular data, archives, and media support vary by installed extras and extraction backend. Do not promise OCR or transcription from a bare install.

Choose an output path that preserves the source and existing user files. For stdin, use the installed extension/type hint when detection is ambiguous. Avoid shell redirection over an existing output without authorization.

## Extraction quality and services

Inspect representative output, including headings, tables, and any difficult pages. Explain lost layout or missing content; Markdown extraction does not preserve every feature of the source.

Keep local conversion local. Azure Document Intelligence, transcription services, plugins, and URL fetches may send content or make network requests. Use them only when the requested workflow and content/destination authorization permit it. Poor local extraction does not authorize an external fallback.

Report the resulting file and material extraction limitations. Do not change the source, enable plugins, or install project dependencies just to broaden format support beyond the task.
