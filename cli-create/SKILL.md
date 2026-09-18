---
name: cli-create
description: Design or review a command-line interface's arguments, output, errors, and configuration.
---

# Create CLI

Design the command's observable contract for its actual human and script users. Preserve the project's parser, naming, output, and compatibility conventions. A small flag change does not require a new CLI specification.

Resolve the command's purpose and material unknowns from context first. Ask only about decisions that change the interface; do not run a standard interview before every change.

## Useful defaults

- Primary data goes to stdout; diagnostics go to stderr. Machine output must remain parseable.
- Make help and errors explain the next useful action. Reuse conventional flags where they fit.
- Prompt only in an interactive context; provide a noninteractive route when automation is a requirement.
- Choose confirmation, dry-run, or explicit destructive flags according to the actual operation's consequences.
- Define input sources, config precedence, exit behavior, and retry/idempotence behavior where callers depend on them.
- Preserve established script contracts. Do not introduce aliases, output modes, or configuration layers for hypothetical users.

For a substantial CLI design, consult relevant sections of [the CLI guidelines](references/cli-guidelines.md), such as Output, Arguments and flags, Interactivity, or Configuration. This is a reference rubric, not a mandatory full read or product checklist.

Match the deliverable to the request: a review gives actionable findings; an interface design gives the affected command syntax, semantics, and useful examples; implementation changes the requested behavior and verifies it. Do not substitute a full spec for an authorized implementation.
