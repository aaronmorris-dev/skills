---
name: api-design
description: Design or review REST API contracts, including resources, responses, pagination, and compatibility.
---

# API Design

Use the project's existing public contract and framework conventions first. Identify the affected callers and requested behavior before changing resource names, envelopes, status codes, or versioning. A preferred style is not a reason to migrate an established API.

## Contract decisions

- Model resource ownership and operations clearly. Prefer resource nouns; explicit action endpoints are appropriate when an operation does not fit CRUD.
- Match methods and response codes to the operation. Define retry and idempotence behavior for writes that callers may repeat.
- Keep success and error shapes consistent with adjacent endpoints. Give callers stable error codes and actionable validation details without exposing internals.
- For collections, select pagination using actual navigation, ordering, and scale requirements. Cursor pagination needs a stable ordering and tie-breaker; offset pagination may fit page navigation. Define limits and concurrent-update behavior.
- Specify supported filters and ordering without creating a general query language unless the current use case requires it.
- Apply the existing authentication and resource-authorization boundary. Assess validation, sensitive fields, and abuse controls for the exposed operation rather than prescribing a generic rate tier.
- Identify compatibility consequences for current callers. Follow the repository's versioning and deprecation policy; do not invent a universal version count or sunset period.

## Scope and verification

For design or review, describe the affected contract, representative request/response behavior, tradeoffs, and unresolved decisions. Do not implement when asked only to assess.

For implementation, reuse existing routing, validation, authorization, and serialization facilities. Verify the changed operation and relevant failure paths, and update the API documentation or schema required by the project. Do not add a response envelope, dependency, framework sample, or unrelated endpoint machinery solely to satisfy a checklist.
