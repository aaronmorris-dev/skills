# Peekaboo hosts and recovery

## Select the CLI and execution host

Use the installed signed CLI for ordinary automation; building Peekaboo is a development task, not a prerequisite. Honor an explicit binary override and inspect its version:

```bash
PB="${PEEKABOO_BIN:-$(command -v peekaboo)}"
"$PB" --version
"$PB" bridge status --verbose --json
"$PB" permissions status --all-sources --json
```

The CLI ships separately from `Peekaboo.app`. Keep the release archive's CLI and accompanying compatibility dylibs together. The app's executable is a GUI host, not the CLI; current releases reject CLI-style arguments before Bridge startup. Using the same current signed CLI/app release avoids capability drift, but compatibility is negotiated by protocol and operation capabilities, not simple version equality.

Host selection depends on the operation. Ordinary automation prefers a healthy reusable daemon, then a capable GUI host, before starting a daemon. Capture, AX inspection, browser, and snapshot-state work first prefer and may start the current CLI build's daemon. An explicit snapshot routes to its unique live producer; explicit socket or local-only overrides remain authoritative. Do not stop hosts merely because several candidates exist.

When app-held permissions are needed, launch the GUI host and pin the same socket for permission checks and observation:

```bash
open -gj -a Peekaboo
GUI_SOCKET="$HOME/Library/Application Support/Peekaboo/bridge.sock"
"$PB" bridge status --bridge-socket "$GUI_SOCKET" --verbose --json
"$PB" permissions status --bridge-socket "$GUI_SOCKET" --json
"$PB" see --bridge-socket "$GUI_SOCKET" --no-elements --mode screen --path /tmp/peekaboo-screen.png --json
```

`open -gj` requests a background/hidden launch; first-run onboarding or missing-configuration prompts can still activate the app. Verify the reported host rather than assuming it was selected. The GUI app, daemon, and caller-local CLI have separate TCC contexts. Screen Recording is checked where capture runs, Accessibility where AX runs, and Event Synthesizing where events are sent. Both local and Bridge sources need not have identical grants.

## Troubleshooting and references

- Capture permissions belong to the executing host. Compare `permissions status --all-sources`, then pin the intended host for diagnostics and capture. Request only permissions needed for the selected operation; do not replace signed installs with ad-hoc builds against saved TCC/Keychain state.
- ScreenCaptureKit ownership checks use known potential host identities and ownership records, including Claude Desktop; another process linking the framework does not by itself block capture. If ownership cannot be established, explicit `see --capture-engine classic` (alias `cg`) avoids in-process ScreenCaptureKit on the selected host. `auto` has conditional fallback paths and is not guaranteed to fail whenever Claude is running. Classic still needs valid capture permission evidence on its executing host.
- Prefer Bridge capture from SSH or background launchd sessions. `--no-remote --capture-engine cg` is a caller-local diagnostic for a known active Aqua session; elsewhere it can return wallpaper-only or redacted pixels despite reporting success.
- If a concrete snapshot's producer is unavailable or an explicit host does not own it, observe again on the intended host. Do not substitute an unrelated snapshot or weaken the target merely to retry.
- Use `capture live` for change-aware capture and `capture video` to sample an existing video. Store task captures under an explicit temporary path and inspect/redact them before any authorized sharing.
- Discover current syntax with `<command> --help`, `learn`, `tools --json`, and `tools describe <name> --json` (MCP schema, not CLI flags). Timing options accept bare milliseconds or `ms`/`s`; prefer explicit suffixes.
- v4 uses noun inventories (`app list`, `window list`, `screen list`), `see`, `press`, `action`, and `click --at`; use live help when translating older examples.

Canonical references stay usable when this skill is linked into another repository or agent directory:

- [Command index](https://github.com/openclaw/Peekaboo/blob/main/docs/commands/README.md), especially [type](https://github.com/openclaw/Peekaboo/blob/main/docs/commands/type.md), [click](https://github.com/openclaw/Peekaboo/blob/main/docs/commands/click.md), and [scroll](https://github.com/openclaw/Peekaboo/blob/main/docs/commands/scroll.md).
- [Bridge host](https://github.com/openclaw/Peekaboo/blob/main/docs/bridge-host.md), [permissions](https://github.com/openclaw/Peekaboo/blob/main/docs/permissions.md), and [subprocess integration](https://github.com/openclaw/Peekaboo/blob/main/docs/integrations/subprocess.md).
- For Peekaboo development, read the checkout's [AGENTS.md](https://github.com/openclaw/Peekaboo/blob/main/AGENTS.md) and [building guide](https://github.com/openclaw/Peekaboo/blob/main/docs/building.md); follow their source-build and test workflow for code changes.
