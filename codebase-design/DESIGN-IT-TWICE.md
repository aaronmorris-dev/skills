# Design It Twice

Use when the user wants alternative interfaces for a chosen architectural problem. Compare meaningfully different approaches rather than polishing several variants of the same design.

Establish the responsibility, real caller needs, constraints, and dependency behavior from the current project. Use the vocabulary in [SKILL.md](SKILL.md) and consult [DEEPENING.md](DEEPENING.md) when external dependencies affect the design.

Develop alternatives locally by default. If the user requests parallel exploration or an independent perspective is otherwise authorized and necessary, give each agent the same contract and a distinct design question. Respect the available concurrency limit; no minimum agent count is required.

Show each alternative's public contract, a representative caller, hidden responsibilities, dependency strategy, and tradeoff. Compare the knowledge imposed on callers, locality of changes, testability, and compatibility. Recommend one based on the present requirement, not hypothetical flexibility.

An interface comparison is read-only unless the user authorizes a prototype, saved design, or implementation. A user-selected option is settled input to the next requested action, not a reason for another approval round.
