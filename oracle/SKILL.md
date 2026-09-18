---
name: oracle
description: Consult a second model through the Oracle CLI with a selected prompt and files.
---

# Oracle

Bundle a specific question and the smallest sufficient file set for an advisory model. The caller owns the decision, implementation, and verification.

Use [Oracle Advisor](../oracle-advisor/SKILL.md) when explicit transport selection or model/effort provenance is part of the request. This skill's usual route is the authorized browser workflow; preserve any explicit API, model, or effort choice. Use the installed CLI's help and configured public model identifiers rather than assuming a fixed default.

## Prepare and run

Inspect `oracle --help` for installed capabilities. If missing, report the required setup rather than silently installing it. A one-off package runner still downloads and caches executable dependencies at user scope.

Choose files that contain the relevant contracts and evidence. Preview with `--dry-run summary --files-report`; inspect the exact rendered payload when selected content or its destination needs checking. Include the question, relevant context, constraints, evidence already gathered, and desired answer. Do not force a project briefing length or an arbitrary file count.

Use an explicitly permitted engine so credentials do not silently select a different transport. A configured or signed-in service is not by itself authorization to send private context. Verify content and destination under the applicable disclosure rules. Never include secrets.

```bash
oracle --dry-run summary --files-report --prompt '<question>' --file '<selected-path>'
oracle --render --prompt '<question>' --file '<selected-path>'
```

Substitute verified values before execution. For an authorized consultation, add the installed CLI's explicit engine and model options. Render mode only prepares a bundle; it is not a completed consultation. Clipboard copying is optional and must serve the task.

Do not open raw CDP or WebSocket connections to the user's Chrome. Use a permitted tool-managed route. If Oracle's available browser attachment would violate that boundary, use an already-authorized API/render route or report the limitation.

## Files and sessions

Consult [files-and-sessions.md](references/files-and-sessions.md) when selecting globs, handling attachments, or resuming a detached run. After a timeout, inspect the existing session before retrying; do not create a duplicate paid run merely because the CLI detached.

Report the advice, material uncertainty, and session reference needed to continue. Verify accepted advice against relevant project evidence; a second model's agreement is not proof that a change works.
