---
name: commit
description: Create task-scoped Git commits using the user's commit conventions.
---

# Commit

Use a concise Conventional Commit subject: `<type>(<optional-scope>): <summary>`. Keep the imperative summary within 72 characters and omit its trailing period. Follow repository conventions for meaningful scope and human contributor credit.

## Prepare the exact change

Inspect `git status -sb`, the worktree diff, and the staged diff. Stage only changes belonging to the requested task, respecting any named file limits. Missing file arguments do not authorize committing every change. Preserve unrelated staged work; ask only if ownership or overlapping changes cannot be resolved.

Before committing, verify effective author and committer identities with `git var GIT_AUTHOR_IDENT` and `git var GIT_COMMITTER_IDENT`, and verify the authenticated GitHub writer as required by the applicable working agreement. Use the configured review workflow and relevant checks required by the repository and user. Do not change identity, amend, or expand scope implicitly.

## Message and completion

A body is optional; explain a non-obvious reason or consequence when useful. Do not add agent attribution, generated-by footers, or sign-offs. Preserve human credit and repository-required release information. Use breaking-change metadata only when an actual public contract change and repository convention require it.

For a multiline message, write a temporary message file with a quoted heredoc, inspect it, and use `git commit --file <path>` so prose cannot be interpreted as shell code.

After committing, verify the commit and repository state. A commit request alone does not authorize a push. Continue with push, landing, or shipping only when that wider workflow was authorized; this skill does not introduce a stop before its remaining steps.
