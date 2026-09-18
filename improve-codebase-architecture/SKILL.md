---
name: improve-codebase-architecture
description: Identify codebase deepening opportunities and compare concrete architectural improvements. Use for an architecture assessment or a requested candidate exploration.
---

# Improve Codebase Architecture

Find architectural friction that affects real changes: scattered ownership, callers learning internal details, or bugs that cannot be exercised through useful interfaces. Use [Codebase Design](../codebase-design/SKILL.md) for architectural vocabulary while preserving the project's established terms.

## Explore and recommend

Start with the user's named area. Otherwise use recent change history to find a useful scope before widening the investigation. Read relevant domain decisions when present. Work directly; use an independent reviewer only when authorized and needed.

Ground each candidate in files and observed behavior. Explain what hurts, what responsibility should move, which interface becomes simpler, how behavior would be verified, and the main tradeoff. A small forwarding module may earn its place through a public, platform, or security contract; do not infer needless indirection from its size alone.

Recommend the strongest supported candidate and distinguish weaker hypotheses. Surface a recorded-decision conflict only when evidence warrants revisiting it.

## Presentation and next action

Use the requested format. When a visual report is requested or would materially clarify multiple candidates, follow [HTML-REPORT.md](HTML-REPORT.md). During a read-only assessment, return findings and inline diagrams; create a report file only when requested or otherwise authorized.

Do not turn an assessment into implementation. Conversely, when the user already selected the improvement and authorized implementation, proceed without requiring another candidate-selection round.

Use [Grilling](../grilling/SKILL.md) when the user asks to interview or stress-test a candidate. Preserve its read-only boundary: summarize decisions in the conversation instead of writing domain records during the interview. When saving decisions is requested, follow [Domain Modeling](../domain-modeling/SKILL.md) and prefer the project's existing documentation.

For a requested comparison of alternative interfaces, consult [Design It Twice](../codebase-design/DESIGN-IT-TWICE.md). Alternative exploration does not require parallel agents.
