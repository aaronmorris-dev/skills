# Prompt examples

### Bounded implementation with missing project details

**Draft**

> Add profile editing to the app.

**Optimized prompt**

```text
Add profile editing to the existing app.

Inspect the current profile data, account permissions, and related UI before making changes. Reuse the project's existing conventions. If the editable fields are not established, ask which fields users should be allowed to change.

Implement editing for those fields, including validation and clear save, loading, and failure states. Enforce the existing account permissions. Keep unrelated account features outside scope.

Verify a successful update and the relevant invalid-input and permission cases. Report the behavior delivered and any verification limitations.
```

### Research without browsing

**Draft**

> Tell me which option is best.

**Optimized prompt**

```text
Compare the options described in the attached documents for [intended use].

Evaluate them against [decision criteria], giving priority to [most important constraint]. Use the supplied evidence and distinguish documented facts from your inferences. Identify missing information that could change the recommendation.

Return a concise comparison and a recommendation with its main tradeoff. If the evidence does not support choosing one option, explain what must be established before deciding.
```

### Preserve diagnosis-only intent

**Draft**

> Why does checkout sometimes fail? Don't change anything.

**Optimized prompt**

```text
Investigate intermittent checkout failures without modifying code or configuration.

Use the supplied logs and relevant checkout implementation to identify the failing stage. Separate observed evidence from hypotheses, and explain which causes the evidence supports or rules out.

Return the most likely cause, supporting references, remaining uncertainty, and the smallest diagnostic check that would resolve it. Do not implement a fix.
```
