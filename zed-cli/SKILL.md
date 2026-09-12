---
name: zed-cli
description: Zed CLI integration for viewing diffs and comparing files. Use when showing file changes, comparing revisions, or reviewing Git differences visually in Zed.
---

# Zed CLI Tools

Use the Zed CLI to view and compare files.

## Requirements

Ensure Zed is installed and the `zed` CLI is available in `PATH`.

On macOS, install the CLI from Zed's command palette with **Install CLI**. Linux installations include the CLI.

## Opening a Diff

Compare two files side by side:

```bash
zed --diff <file1> <file2>
```

## Git Diffs

Extract the older revision to a temporary file, then compare it with the current file.

### Compare With the Previous Commit

```bash
git show HEAD~1:path/to/file > /tmp/old
zed --diff /tmp/old path/to/file
```

### Compare With a Specific Commit

```bash
git show abc123:path/to/file > /tmp/old
zed --diff /tmp/old path/to/file
```

### Compare the Staged Version With the Working Tree

```bash
git show :path/to/file > /tmp/staged
zed --diff /tmp/staged path/to/file
```

## Gotchas

- Ensure the file exists in the selected Git revision.
- Ensure the compared revisions contain changes.
- Run `git log --oneline -5 -- path/to/file` to confirm the file has history.
- Use distinct temporary filenames when opening multiple comparisons concurrently.
