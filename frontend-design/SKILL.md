---
name: frontend-design
description: Design or implement frontend pages and components with a coherent visual direction suited to the product.
---

# Frontend Design

Create a deliberate visual hierarchy and usable interactions for the actual audience. Match the requested mode: a design review yields findings; an implementation request yields working UI.

For an existing product, preserve its design system, framework, components, typography, and interaction conventions unless a redesign is requested. A small UI fix does not authorize a new aesthetic.

For new or explicitly redesigned surfaces, choose a coherent direction from the purpose, content, and any supplied references. Make the result distinctive through layout, typography, color, and useful detail rather than adding decorative effects indiscriminately.

## Design choices

- Establish readable typography, spacing, contrast, and content hierarchy. Use existing or appropriate system fonts when they fit; no font family or palette is categorically forbidden.
- Use composition and density appropriate to the task. A dashboard, article, and landing page need different treatment.
- Use color and visual detail to communicate grouping, state, or character. Decoration should support the content.
- Add motion only when it aids feedback or the intended experience. Respect reduced-motion preferences and avoid interactions that depend on hover alone.
- Use the existing component and icon libraries before adding dependencies. Preserve keyboard, focus, labeling, and native control behavior.
- Implement relevant empty, loading, failure, and success states without inventing unrelated product features.

For implementation, inspect the affected UI at relevant viewport sizes and exercise the changed interactions with available tools. Report concrete limitations when a rendered result cannot be observed. For HTML/template semantics, use [HTML](../html/SKILL.md) when relevant.
