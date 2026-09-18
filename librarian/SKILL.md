---
name: librarian
description: Cache or refresh a remote repository when local source inspection is needed.
---

# Librarian

Use an existing relevant checkout first. A repository URL alone is not a reason to clone or update it when the requested fact can be read directly. Respect read-only requests and explicit limits on fetching or changing checkouts.

For reusable reference-source inspection, the helper maintains `~/.cache/checkouts/<host>/<org>/<repo>`. This is a user-level cache, separate from personal projects in `~/Projects` and open-source working checkouts in `~/Development`. Disclose a new cache checkout or refresh before running it; do not update a user-managed checkout just to answer a question.

## Helpers

Resolve these scripts relative to this skill directory and pass their absolute paths from another working directory:

```bash
scripts/checkout.sh <repo> --path-only
scripts/catalog.sh
```

The checkout helper accepts HTTPS/SSH repository references and `owner/repo` shorthand, which defaults to GitHub. It partially clones missing repositories, fetches stale cached repositories (normally after five minutes), and attempts a fast-forward only when clean with an upstream. Inspect its result rather than assuming refresh succeeded.

`LIBRARIAN_CACHE_ROOT` overrides the cache location. Use `--force-update` only when immediate freshness is necessary. For historical material or offline work, inspect the existing checkout without invoking a refresh.

Keep task edits outside the shared cache. Use a task-owned worktree or working checkout when implementation is authorized. A cache helper does not authorize pushes, branch changes in a user checkout, or unrelated repository mutations.
