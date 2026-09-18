---
name: staged-implementation
description: Sequence dependent implementation changes into coherent, verifiable stages. Use for migrations or broad work whose parts need an ordered rollout.
---

# Staged Implementation

A stage groups one coherent purpose with the checks and documentation that establish it. Use stages to manage dependencies, not to create extra approval gates. Handle small changes directly.

## Sequence the work

Establish the requested outcome and relevant project contracts, then choose the next stage by dependency order. Keep later stages brief until their details constrain current work. Keep shared interfaces and generated sources under one owner; update consumers in an order that leaves usable checkpoints. Introduce coexistence only for an actual compatibility or rollout contract.

Internal decomposition does not require presenting a plan for approval. During a planning-only request, return the proposed stages without implementing them or writing plan files unless requested.

## Execute through completion

Complete the active stage and check the behavior it changes before moving to its dependents. Use focused checks and any repository-required gates; do not automatically run the entire suite at every checkpoint. Fix failures attributable to the task and report unrelated failures separately.

A checkpoint records progress. Continue through every authorized stage needed for the requested outcome, even when stages could be reviewed or committed separately. Pause only for an explicit user review boundary, a material unresolved decision, missing authority or access, or a genuine blocker. An instruction to wait overrides the remaining workflow.

When an attempt fails, use new evidence to choose the next action. Do not repeat an unchanged attempt, but do not abandon useful independent work merely because one stage is blocked.

## Project-local continuity

Use a durable record only when the work needs continuity beyond the current context. Prefer the project's existing plan or notes convention; otherwise use a task-specific Markdown plan under an appropriate project directory, such as `docs/plans/<task>.md`. State a new location before creating it. No notes service or handoff skill is required.

Keep the record compact: requested outcome, settled contracts, stage status, relevant files, verification evidence, unresolved decisions, and next action. Update the same file rather than creating one note per checkpoint. In a read-only task, keep this state in the response unless the user authorizes saving it.

At completion, mark a durable project record complete. Remove only a task-created file explicitly designated as temporary when it no longer carries needed state; preserve existing notes and records. Deleting notes is not a prerequisite for completion. A request to “make a note” follows the applicable AGENTS.md convention.

## Delegation and finish

Work directly by default. If delegation is authorized and useful, assign bounded independent work with shared contracts, file ownership, and expected evidence. Do not require a worker/reviewer loop or an arbitrary number of agents.

Finish with the delivered outcome, relevant checks, and any incomplete stages or material limitations. Do not declare the overall request complete while requested work remains.
