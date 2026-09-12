---
name: model-route
description: "Recommend and compare current AI models and providers for a task using models.dev data, including capabilities, context and output limits, modalities, tool use, reasoning, availability, and token costs. Use when the user asks which model, model tier, or provider to use; wants a cheaper or stronger fallback; or needs a model comparison constrained by budget, tokens, tools, or input type."
---

# Model Route

Recommend a specific model and provider from current catalog data rather than relying on memorized names or fixed tiers.

## Find candidates

Use `scripts/find-models.sh`. It transparently fetches or refreshes the cached models.dev catalog and returns compact JSON containing matching provider/model offerings.

```bash
scripts/find-models.sh --reasoning --tools --min-context 200000 --max-input-cost 5
scripts/find-models.sh --query claude --input-modality image --limit 5
scripts/find-models.sh --help
```

Filter on the task's hard requirements: reasoning, tools, structured output, modalities, minimum context/output tokens, provider, open weights, and maximum input/output cost. Use `--force-update` only when immediate freshness matters; the underlying cache otherwise refreshes hourly.

Treat missing fields as unknown, not zero or unsupported. Catalog presence does not prove the model is selectable in the user's client; confirm local availability when possible.

## Decide

1. Infer task requirements and failure cost. Ask one question only if a missing constraint materially changes the choice.
2. Find candidates satisfying hard requirements.
3. Prefer the cheapest adequate offering; pay for stronger reasoning when ambiguity, task length, or failure cost justifies it.
4. Require matching modalities and tool or structured-output support when the workflow depends on them.
5. Prefer dated IDs for reproducibility and `latest` aliases only when automatic upgrades are desired.
6. Separate model quality from provider choice: prices, limits, and features may differ by provider.
7. Do not invent quality, latency, availability, benchmark, or pricing claims absent from the results or another cited source.

## Respond

Return:

- **Recommendation:** exact model and provider
- **Confidence:** high, medium, or low
- **Why:** task fit tied to observed capabilities, limits, and cost
- **Tradeoff:** main compromise
- **Fallback:** exact alternative and when to use it

Include a compact comparison table only when candidates are genuinely close. State assumptions and unknown fields explicitly.
