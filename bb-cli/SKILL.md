---
name: bb-cli
description: Inspect or manage BB state with the bb CLI.
---

# BB CLI

Use BB's actual state to resolve the target project, host, environment, and task. Inspect context with `bb status --json` when those choices are not already established. A status request does not authorize changes to tasks or environments.

Use `bb --version`, `bb help [command]`, or `bb <group> --help` for installed syntax. Use JSON when output controls later actions. A standalone CLI targets `http://127.0.0.1:38886`; set `BB_SERVER_URL` and `BB_HOST_DAEMON_PORT` only for an intentional alternative.

## Read the relevant reference

- [Command index](references/command-index.md): find a core command path; use live help for current flags.
- [Configuration](references/configuration.md): settings, instructions, skills, clients, and setup scripts.
- [Creation and lifecycle](references/thread-creation.md): create/fork tasks, provision environments or machines, and inspect their lifecycle.
- [Task operations](references/thread-operation.md): messages, queues, panes, terminals, and result inspection.
- [Recovery](references/failure-recovery.md): failed/interrupted tasks and plan or goal recovery.
- [Browser](references/browser.md): approved browser discovery, targeting, ownership, and credentials.
- [Theme commands](references/theme-commands.md) and [theming](references/theming.md): palette operations and theme CSS respectively.
- [Plugins](references/plugins.md): discovery, installation, development, and configuration.
- [App settings](references/app-settings.md): setting keys and effects.

Read only the selected topic. Plugin-specific behavior belongs in the owning plugin's guidance; discover commands with `bb plugin list` or `bb plugin run <id> --help`.

## Targeting and completion

Resolve names and IDs before mutation. Pass the project when a command could cross projects, and select a host/environment when its default is uncertain. Keep paths on their owning machine. Query models on the machine that will execute the task.

Stay within the requested action and existing authority. Explain persistent project, user, or machine effects before installation or configuration. A discovered command does not authorize sending messages, enrolling a machine, changing permissions, or deleting source.

Confirm the command result and affected state. Return the stable ID or URL the user needs. For launcher failures, see the recovery reference rather than assuming successful dispatch means a running service.
