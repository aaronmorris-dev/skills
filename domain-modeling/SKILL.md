---
name: domain-modeling
description: Clarify domain terminology and record consequential domain decisions when the user asks to develop the model.
license: MIT
---

# Domain Modeling

Develop the project's shared language when terms or relationships are being decided. Merely reading established vocabulary does not require this workflow.

Use project terms and concrete scenarios to expose consequential ambiguity. Check relevant code or documentation before asking the user about discoverable facts. Surface contradictions that affect behavior; do not force a terminology interview over a harmless wording difference.

## Durable decisions

Prefer the project's existing glossary, domain documentation, or decision records. Record a decision when it is consequential, surprising without context, and the result of a real tradeoff. Keep the term or decision, alternatives considered, and reason; omit implementation trivia.

During a read-only discussion or Grilling session, keep the summary in the conversation. Write only when requested or within authorized implementation/documentation scope. If a record is warranted and no convention exists, choose a small project-local Markdown location and state it before writing. Do not introduce a notes service or an entire ADR system.

A request to “make a note” means a terse update to the applicable `AGENTS.md`. Keep unresolved alternatives distinct from accepted decisions, and preserve existing records.
