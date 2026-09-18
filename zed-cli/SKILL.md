---
name: zed-cli
description: Show file or Git revision comparisons in Zed when the user requests a Zed diff.
---

# Zed CLI

Use the installed `zed` CLI to show the requested comparison. If unavailable, explain the limitation; adding a CLI to the user's PATH is a user-level setup change.

For two existing files:

```bash
zed --diff <file1> <file2>
```

For a Git comparison, verify the selected revision and path, extract it to a unique temporary directory, and open it against the current file. For example, from the repository root:

```bash
diff_dir=$(mktemp -d "${TMPDIR:-/tmp}/zed-diff.XXXXXX")
git show 'HEAD~1:path/to/file' > "$diff_dir/before"
# Run only after git show succeeds.
zed --diff "$diff_dir/before" path/to/file
```

Use `:path/to/file` for the staged version or the verified commit/ref for another revision. Keep temporary files until Zed has loaded them, and never overwrite a shared `/tmp/old` or `/tmp/staged`. Report which versions were compared.
