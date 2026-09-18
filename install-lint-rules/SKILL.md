---
name: install-lint-rules
description: Install or update a project from the shared lint policy in ~/.config/lint.
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

Resolve script paths relative to this skill directory and use absolute paths when invoking them from a project. These commands modify the target project's configuration, manifests, and lockfiles and may populate package-manager caches; disclose those effects before execution.

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

Merge existing configuration by default within the requested policy update. Use
`--force` only when replacement was explicitly authorized; ask only if a real conflict cannot be resolved from project policy. Never replace an entire
`pyproject.toml`; merge its Ruff tables instead.

## Project commands and checks

Register a tool-specific lint command in the project's existing task system.
Add a top-level `lint` or `format:check` command only when absent and
unambiguous. Do not change CI or Git hooks unless requested.

Run the affected linter and repository-required checks. Add typecheck, tests, or build only when the configuration or dependency change makes them relevant. Report copied files, dependency changes, preserved local configuration, enabled Effect rules, and actual check results.
