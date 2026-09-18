# Peekaboo background input

Resolve the installed CLI and obtain a fresh target observation as described in [SKILL.md](../SKILL.md) before applying these recipes.

## Background input and coordinates

Background `click` can invoke an element's AX action or focus a writable text field without activating its app. `--input-strategy actionOnly` selects the AX route; coordinate clicks can also use it by hit-testing a pressable AX element. Generic `action AXPress` and `action AXShowMenu` require `--foreground`; only generic `AXIncrement`/`AXDecrement` are background-safe. Prefer dedicated `click` for background activation.

Background typing/paste accept exact window routes even when the app has several windows. App/PID-only routes require a complete inventory with at most one eligible window. Prefer a fresh exact-window snapshot for `type`; it must identify the focused field in the intended internal key window. If needed, click the field, observe again, then type using the new snapshot. Exact routes revalidate process generation, window bounds, and focus. AX text edits need Accessibility; event fallback needs Event Synthesizing.

```bash
"$PB" type "text" --snapshot "$SNAPSHOT_ID" --json
"$PB" press Return --app TextEdit --window-id "$WINDOW_ID" --json
"$PB" paste "text" --app TextEdit --window-id "$WINDOW_ID" --json
```

`type` normally succeeds only for a confirmed change. It can return non-success after accepted dispatch, so read the outcome before retrying. Scripts doing their own follow-up observation may opt into `--accept-dispatched`; this does not confirm delivery. Raw background `press` needs an exact window selector or fresh exact-window snapshot; app/PID-only chords require `--foreground`. Default background-only Agent/MCP typing is stricter than the direct CLI: it requires a fresh exact non-dialog snapshot without competing selectors.

Background `scroll` requires `--on`; app/window flags alone do not establish an element target. Targetless scrolling, `--smooth`, and nonzero `--delay` need `--foreground`. Shared-cursor `move`, `drag`, targetless keyboard input, and `click --long-press` also require explicit foreground mode.

`click --at` uses logical points. Background coordinates are relative to the snapshot window even without target flags; add `--global` for global logical coordinates inside that window. Foreground coordinates are window-relative with target flags and global without them. Ordinary `see` produces logical1x images; do not divide their coordinates by a Retina scale. For `--retina`, crops, or resized previews, use the capture's coordinate metadata and `screen list` bounds/scale to map pixels to logical points.

```bash
"$PB" see --window-id "$WINDOW_ID" --no-elements --path /tmp/peekaboo-click.png --json
# Copy the returned snapshot ID before clicking window-local logical points.
"$PB" click --window-id "$WINDOW_ID" --at 20,40 --snapshot "$SNAPSHOT_ID" --json
```

Background coordinate clicks require a fresh screenshot snapshot with an exact process/window/bounds receipt; AX-only observations are insufficient. Moved, replaced, or unverifiable targets fail before dispatch. Background right/double/middle/triple clicks can use exact routed events, but completed dispatch remains effect-unverifiable. Observe before deciding whether another click is needed.
