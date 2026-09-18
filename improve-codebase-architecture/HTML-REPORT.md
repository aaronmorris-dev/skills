# Architecture report

Use this reference for an authorized visual architecture report. Prefer one project-local file in the existing reports or notes directory when the report should be retained; use a unique temporary directory for a disposable preview. State a new location before writing and return its absolute path.

Make the report usable offline with inline CSS and SVG or simple boxes and arrows. Do not load remote scripts merely to draw a diagram. If the project already supplies a local diagram renderer, reuse it when useful.

## Content and layout

Lead with the recommended improvement. For each supported candidate, show the relevant files, observed problem, proposed responsibility change, expected benefit, and tradeoff. Use before/after diagrams when they clarify ownership or flow. Label proposed structures distinctly from verified current behavior.

Use project terminology; explain architectural terms only where needed. Mark recommendation strength as strong, worth exploring, or speculative according to the evidence. Include relevant recorded decisions and unresolved questions.

Use semantic HTML, readable typography, responsive comparison panels, and text explanations for diagrams. Include enough prose to assess the recommendation; arbitrary bullet lengths, diagram counts, or visual variety are not requirements. Escape source-derived text before embedding it in markup.

Inspect the generated report through an available local preview when possible. Verify that names and relationships match the evidence, diagrams remain legible, and the file needs no network resources. Open it through the supported client workflow when requested or appropriate to presenting the authorized artifact.
