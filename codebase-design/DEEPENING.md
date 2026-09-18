# Deepening

Use [the shared vocabulary](SKILL.md) to evaluate whether consolidating responsibilities would simplify callers and concentrate knowledge. Dependency type informs the approach; it does not by itself prove that a merge or new abstraction is useful.

## Dependencies and tests

For in-process computation, consider consolidating related logic behind the meaningful caller interface. Preserve useful standalone responsibilities.

For local dependencies with substitutes, reuse the project's established fixtures or adapters when they model the behavior under test. A convenient fake is not evidence that it reproduces production semantics.

For owned remote services or third-party APIs, inspect the existing public contract and client first. Keep transport concerns at the existing integration boundary; introduce a port or adapter only for a demonstrated isolation or substitution need. Do not recreate client validation, lifecycle, retries, or caching without a concrete gap.

Keep internal seams private when callers do not need them. The number of adapters is evidence of variation, not a universal design rule.

## Preserve useful coverage

Exercise observable behavior through the resulting interface. Replace tests coupled to an obsolete structure when the replacement protects their meaningful scenarios. Preserve focused tests that still protect distinct behavior, algorithms, or failure modes; delete redundant or obsolete tests after checking coverage.

Define the behavior and compatibility to preserve before moving responsibilities. Verify the affected path after the change rather than judging success from a smaller file or test count.
