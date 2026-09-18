---
name: codebase-design
description: Design module interfaces that hide complexity and localize change. Use for interface, ownership, or testability decisions.
---

# Codebase Design

Design **deep modules**: a lot of behaviour behind a small interface, placed at a clean seam, testable through that interface. Use this language for architectural roles while preserving the project's established domain terms and framework names. The aim is leverage for callers, locality for maintainers, and testability for everyone.

## Glossary

Use these terms consistently when describing architectural roles. Do not rename established concepts such as an Effect service, UI component, HTTP API, or domain boundary. When one of those concepts plays a role in this model, state the mapping where it helps, for example: "the Payment service is the module; its public methods form the interface."

**Module** — anything with an interface and an implementation. Deliberately scale-agnostic: a function, class, package, or tier-spanning slice. A project may call the concrete concept a component or service; use **module** only when discussing its architectural role.

**Interface** — everything a caller must know to use the module correctly: the type signature, but also invariants, ordering constraints, error modes, required configuration, and performance characteristics. A framework API or type signature can be part of this wider interface without being renamed.

**Implementation** — what's inside a module, its body of code. Distinct from **Adapter**: a thing can be a small adapter with a large implementation (a Postgres repo) or a large adapter with a small implementation (an in-memory fake). Reach for "adapter" when the seam is the topic; "implementation" otherwise.

**Depth** — leverage at the interface: the amount of behaviour a caller (or test) can exercise per unit of interface they have to learn. A module is **deep** when a large amount of behaviour sits behind a small interface, **shallow** when the interface is nearly as complex as the implementation.

**Seam** _(Michael Feathers)_ — a place where you can alter behaviour without editing in that place; the _location_ at which a module's interface lives. Where to put the seam is its own design decision, distinct from what goes behind it. Keep **boundary** when it is an established domain term, such as a DDD bounded context; use **seam** for this architectural role.

**Adapter** — a concrete thing that satisfies an interface at a seam. Describes _role_ (what slot it fills), not substance (what's inside).

**Leverage** — what callers get from depth: more capability per unit of interface they learn. One implementation pays back across N call sites and M tests.

**Locality** — what maintainers get from depth: change, bugs, knowledge, and verification concentrate in one place rather than spreading across callers. Fix once, fixed everywhere.

## Design criteria

Depth is useful behavior behind a manageable caller contract, not a ratio of implementation lines to interface lines. Judge the knowledge imposed on callers and the locality of changes.

The deletion test is a question, not a verdict: if removing a module removes no useful responsibility, it may be a pass-through. If complexity spreads to callers, it is earning its place. Account for public, platform, security, and ownership contracts even when a wrapper is small.

Prefer testing observable behavior through a useful interface. Internal tests can still protect difficult algorithms or failure modes; do not reshape production interfaces solely to make tests convenient. Introduce dependency injection or adapters for an actual substitution, isolation, or ownership need, rather than a required adapter count.

Match the requested mode: explain or compare interfaces in a review; change them only when authorized. Preserve project terminology and established domain boundaries.

## Going deeper

- [DEEPENING.md](DEEPENING.md): consolidating responsibilities when dependency behavior and existing tests matter.
- [DESIGN-IT-TWICE.md](DESIGN-IT-TWICE.md): comparing meaningfully different interface designs when requested.
