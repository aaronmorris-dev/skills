---
name: github
description: Inspect or manage GitHub issues, pull requests, and CI with the gh CLI.
---

# GitHub Skill

Use the `gh` CLI to interact with GitHub. Always specify `--repo owner/repo` when not in a git directory, or use URLs directly.

## Writes and message bodies

A URL authorizes investigation, not a remote mutation. Use the applicable working agreement for commit, push, landing, shipping, and release authority and identity checks. Confirm the target repository and actual authenticated writer before a write; do not print credentials.

For multiline PR or issue text, prepare a temporary file with a quoted heredoc, inspect it, and pass `--body-file`. Do not embed user prose, backticks, or shell expressions in a double-quoted command argument. Sanitize public content for secrets and internal identifiers. Verify the resulting state and return its link.

## Pull Requests

Check CI status on a PR:
```bash
gh pr checks 55 --repo owner/repo
```

List recent workflow runs:
```bash
gh run list --repo owner/repo --limit 10
```

View a run and see which steps failed:
```bash
gh run view <run-id> --repo owner/repo
```

View logs for failed steps only:
```bash
gh run view <run-id> --repo owner/repo --log-failed
```

## API for Advanced Queries

The `gh api` command is useful for accessing data not available through other subcommands.

Get PR with specific fields:
```bash
gh api repos/owner/repo/pulls/55 --jq '.title, .state, .user.login'
```

## JSON Output

Most commands support `--json` for structured output.  You can use `--jq` to filter:

```bash
gh issue list --repo owner/repo --json number,title --jq '.[] | "\(.number): \(.title)"'
```
