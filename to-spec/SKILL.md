---
name: to-spec
description: Synthesize an existing discussion into an actionable specification. Use when asked to turn agreed context into a spec or tracker issue.
---

# To Spec

Synthesize the current discussion; do not reopen settled decisions or start a design interview. Inspect only project context needed to ground the spec. Distinguish agreed decisions, supported assumptions, and unresolved questions.

## Content

Scale the specification to the feature. Include the problem and desired behavior, relevant user scenarios, acceptance criteria, agreed implementation and testing decisions, and explicit exclusions. Include open questions only when they affect execution.

Prefer existing interfaces and test conventions. Identify observable behavior to verify without forcing a single test seam or teaching generic testing principles. Include paths or short decision-rich snippets when they make the work easier to locate or specify; verify them rather than inventing a future file layout.

Do not inflate the document with exhaustive user stories or require confirmation of testing details that are already established. If a material decision is still missing, expose it clearly; ask only when it prevents delivering the requested spec. Use Grilling only if the user requests further interviewing.

## Destination

Return the spec in the conversation by default. When asked to save it, use the project's existing specification or notes location, or a clearly named project-local Markdown file. State a new location before writing. No external notes tool is required.

Publish to the issue tracker only when the user requests publication or explicitly invokes this skill to create an issue. Resolve the repository, tracker, and applicable labels from project context. Do not assume a `ready-for-agent` label or require a setup command. If the destination is unclear, prepare the complete draft before asking where to publish it.

For an authorized tracker write, use the relevant tracker workflow and identity checks. Report the actual resulting issue link; a draft is not a published issue.
