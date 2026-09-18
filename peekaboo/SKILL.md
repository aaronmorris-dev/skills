---
name: peekaboo
description: Inspect or automate macOS apps with Peekaboo, including fallback when an approved primary tool cannot handle the task.
---

# Peekaboo

Use native Peekaboo commands for macOS apps, windows, menus, dialogs, browser chrome, and pixels. Prefer existing browser tooling for page content, DOM, forms, console, and network; Peekaboo's `browser` command is available when that integration is configured. Stay within the user's authorized task and verify the resulting UI.

## CLI and host

Use the installed signed CLI; building or installing Peekaboo is a separate task. Honor an explicit binary override. Check `peekaboo --version` and relevant live help when syntax is uncertain. For host selection, permission diagnosis, SSH capture, or startup problems, read [hosts-and-recovery.md](references/hosts-and-recovery.md). Do not run every host diagnostic before an ordinary action on an established target.

## Observe, target, act, verify

1. Resolve the target with `app list` and `window list`; prefer exact PID/window IDs over broad app names or titles.
2. Observe with pixels, Accessibility, or both. Ordinary `see` does not activate the target; `--web-focus` explicitly permits a focus action and is not a read-only retry.
3. Copy opaque element and snapshot IDs from that observation. Prefer an element click, `set-value` for an intended value replacement, or a suitable state-only AX action over coordinate input.
4. Use background delivery with an exact target. Add `--foreground` when shared-desktop interaction is authorized and needed; do not silently promote a refused background command.
5. Read the canonical outcome and verify the intended change with a fresh `see`, `verify`, or other readback. A successful dispatch alone does not prove the app changed.

```bash
PB="${PEEKABOO_BIN:-$(command -v peekaboo)}"
"$PB" app list --include-hidden --include-background --json
"$PB" window list --app Safari --json

# Read clipboard contents only when relevant to the authorized task.
"$PB" clipboard get --json

# Pixels only; an exact window also publishes a coordinate receipt.
"$PB" see --window-id "$WINDOW_ID" --no-elements --path /tmp/peekaboo-window.png --json

# Pixels and element IDs, with an annotated artifact.
"$PB" see --window-id "$WINDOW_ID" --annotate --path /tmp/peekaboo-elements.png --json

# AX text and IDs without screenshot capture.
"$PB" see --window-id "$WINDOW_ID" --tree --no-screenshot --json

# Use IDs from the applicable fresh observation, not all examples in sequence.
"$PB" click --on "$ELEMENT_ID" --snapshot "$SNAPSHOT_ID" --json
"$PB" scroll --direction down --on "$ELEMENT_ID" --snapshot "$SNAPSHOT_ID" --json
```

After a mutation changes the UI, capture again before using IDs for another action. `requires_fresh_observation: true` consumes the snapshot for mutation. Partial, indeterminate, and unverified results may already have changed the app; never repeat input blindly. Inspect image contents to verify capture and visual results. `sips -g pixelWidth -g pixelHeight <path>` checks dimensions only.

## Specialized operations

Use the [command reference](references/cli-command-reference.md) when choosing a command family or interpreting its JSON outcome. Confirm exact options with installed help.

Before typing, pasting, coordinate input, or background event delivery, read [background-input.md](references/background-input.md) for exact targeting, focus, snapshot freshness, and coordinate rules. Do not promote a refused background action to foreground without authority.

Use [hosts-and-recovery.md](references/hosts-and-recovery.md) when host ownership, permissions, or capture output is uncertain. Narrow capture to the relevant window where possible and inspect its full contents before any authorized upload.

This skill does not authorize raw CDP/WebSocket attachment to the user's Chrome, unrelated clipboard reads, permission changes, or sending private captures to external services.
