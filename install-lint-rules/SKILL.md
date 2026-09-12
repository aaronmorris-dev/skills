---
name: install-lint-rules
description: Install or update the shared Oxlint, Ruff, yamllint, or markdownlint-cli2
  policy in a project. Use when adding centralized lint rules, copying lint
  configuration, or refreshing an existing project from ~/.config/lint.
---

# Install lint rules

Inspect the target's manifests, lockfiles, existing lint configuration,
repository instructions, and normal checks before changing files. Use the
current directory unless the user names another target.

Central policy defaults to `${XDG_CONFIG_HOME:-$HOME/.config}/lint` and can be
overridden with `LINT_CONFIG_ROOT`. Target projects receive copies; they must
not depend on the central checkout at runtime.

## Commands

```bash
scripts/oxlint-install.sh [target] [--force] [--effect|--no-effect]
scripts/ruff-install.sh [target] [--force]
scripts/yamllint-install.sh [target] [--force]
scripts/markdownlint-install.sh [target] [--force]
```

The scripts install exact dependencies using the detected Bun/npm/pnpm/Yarn
manager or `uv`. If a required manifest is absent or detection is ambiguous,
ask before proceeding; never initialize an ecosystem silently.

## Existing configuration

Scripts preserve existing configuration and print `merge_required`, followed
by the authoritative central source path. Read both files and merge the policy
semantically:

- Preserve repository ignores, overrides, plugins, and stricter local rules.
- Add or update the central rules, including removals documented by the source.
- For Ruff in `pyproject.toml`, map root `ruff.toml` keys into `[tool.ruff]` and
  nested tables into `[tool.ruff.*]`.
- For `.oxlintrc.json`, translate the TypeScript config object into JSON and
  retain the copied `plugins` paths.
- Add Effect rules only when `effect` is a direct dependency or the user asks.

Before replacing an existing config, ask **Merge or force replace?** Use
`--force` only after explicit replacement approval. Never replace an entire
`pyproject.toml`; merge its Ruff tables instead.

## Project commands and checks

Register a tool-specific lint command in the project's existing task system.
Add a top-level `lint` or `format:check` command only when absent and
unambiguous. Do not change CI or Git hooks unless requested.

Run the installed linter, then the repository's normal lint, typecheck, tests,
and build. Report copied files, package-manager changes, preserved local
configuration, enabled Effect rules, and check results.
