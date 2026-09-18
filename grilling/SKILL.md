---
name: grilling
description: Interview the user to stress-test a plan, decision, or idea. Use when the user asks to be grilled or requests a design interview.
---

# Grilling

Build a shared understanding through dependent decisions. Ask only about choices whose prerequisites are settled; an answer may change which questions matter next.

## Rounds

Treat explicit instructions and prior answers as settled. Discover facts with relevant read-only tools instead of asking the user to supply them. Investigate unresolved facts while asking independent questions.

Ask a small batch of material questions within the available question tool's actual limit. Each should state the decision, consequence, and a recommended answer with its reason when supported. Without a question tool, number the questions clearly in chat. Do not ask a question that depends on an unanswered question in the same round.

Keep material choices about scope, behavior, acceptance, safety, data, compatibility, cost, or irreversible actions with the user. Skip speculative or safely reversible implementation details. Recompute the next questions from the answers rather than following a fixed questionnaire.

## Intensity and stopping

Honor the requested intensity and question limit. A light grill is one focused round followed by a summary. A full grill continues while material decisions remain. When intensity is unspecified, begin with one focused round; ask whether to go deeper only if consequential decisions remain.

Stay read-only during the interview: do not edit files, save specs, create issues, or implement code. Keep decision notes in the conversation. Stop when the requested limit is reached, material questions are resolved, investigation or a prototype is needed, or the user changes the task.

Summarize settled decisions, consequential assumptions, remaining questions, exclusions, and readiness for implementation or further investigation. If the user asks to build, save, or otherwise move on, follow that request within its scope; do not require a second confirmation merely to exit the interview.
