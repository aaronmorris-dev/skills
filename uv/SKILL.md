---
name: uv
description: Run standalone Python scripts or manage dependencies in uv-based projects.
---

Prefer the repository's existing runtime and package manager. Use uv for standalone scripts and new Python work unless the user specifies another tool; do not migrate an existing project or build backend implicitly. Ad-hoc dependencies use a tool/cache environment; `uv add` changes the project's manifest and lockfile. Disclose installation effects before running them.

## Quick Reference

```bash
uv run script.py                   # Run a script
uv run --with requests script.py   # Run with ad-hoc dependency
uv run python -m ast foo.py >/dev/null  # Verify syntax without writing __pycache__
uv add requests                    # Add dependency to project
uv init --script foo.py            # Create script with inline metadata
```

## Inline Script Dependencies

```python
# /// script
# requires-python = ">=3.12"
# dependencies = ["requests"]
# ///
```

See [scripts.md](scripts.md) for full details on running scripts, locking, and reproducibility.

## Build Backend

For new pure Python packages without an established backend, consider `uv_build`. Preserve an existing backend unless migration is requested. This example's version range is illustrative; use the project's supported version or verify a current range when creating a package:

```toml
[build-system]
requires = ["uv_build>=0.9.28,<0.10.0"]
build-backend = "uv_build"
```

See [build.md](build.md) for project structure, namespaces, and file inclusion.
