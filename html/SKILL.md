---
name: html
description: Write or review semantic HTML and template markup, including forms, landmarks, and native controls.
---

# HTML

Choose elements by content and interaction. Prefer the smallest accurate structure; neither extra wrappers nor more specialized tags automatically improve semantics.

## Markup choices

- Use links for navigation and buttons for actions. Prefer native controls before rebuilding their keyboard and interaction behavior.
- Associate controls with labels; placeholders are not labels. Use names, input types, and grouping appropriate to the form.
- Keep headings and landmarks meaningful for the page or view. Do not add a section or landmark to every layout container.
- Use lists when membership or order is meaningful. Repeated cards may be a list, standalone articles, or plain containers; decide from their content rather than the visual repetition.
- Use informative image alternatives for content and empty alternatives for decoration. Provide dimensions where known.
- Add ARIA only for semantics native HTML cannot express. Preserve useful accessibility behavior during cleanup.
- Remove wrappers only after checking their layout, styling, scripting, and accessibility role. Use classes when they have a concrete job.

## Template safety

Treat Svelte and other templates as their actual language. Preserve directives, bindings, keys, event attributes, special elements, and component boundaries. Framework event syntax is not a plain inline JavaScript handler.

Do not replace components with native tags without checking their behavior and the requested scope. Apply document-shell rules such as doctype, language, title, charset, and viewport only to full documents or the framework's designated head mechanism.

## Completion

Match the requested change or review. For edits, use relevant compiler/accessibility checks and inspect the affected interaction when available. Do not rewrite valid markup merely to satisfy a style preference or introduce unrelated CSS or state changes.
