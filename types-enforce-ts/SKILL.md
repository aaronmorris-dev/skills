---
name: types-enforce-ts
description: Improve type safety while editing or reviewing TypeScript files.
---

# TypeScript Type Safety

Preserve requested runtime behavior and public contracts. Apply improvements within the affected code rather than using a type fix to rewrite unrelated logic.

- Reuse local types and generic helpers. Model real data flow with concrete types or `unknown` plus narrowing.
- Prefer signature-level typing, guards, and `satisfies` over casts at each use. Avoid `any`, double assertions, and blanket suppressions.
- Keep inference when it is clear. Add return annotations for exported contracts, overloads, recursion, conformance, or genuine clarification; omit obvious local annotations such as `: void`.
- Remove unnecessary casts and non-null assertions when the compiler can establish the invariant. Use `!` only when required and justified by project guidance.
- Do not introduce a local alias solely for narrowing if a direct guard and property access typecheck. Keep intermediate values when they clarify meaning, preserve evaluation semantics, or avoid repeated work.
- Avoid new abstractions, comments, or aliases that merely satisfy stylistic preferences.

Verify the affected types with the project's existing type checker. A passing type check does not by itself prove runtime behavior.
