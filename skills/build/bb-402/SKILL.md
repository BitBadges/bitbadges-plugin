---
description: Token-gated access protocol where ownership of specific badges grants API/resource access
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# BB-402 Token-Gated Access

Token-gated access protocol where ownership of specific badges grants API/resource access

## When to use this skill

Protocol for token-gated access to APIs/resources using HTTP 402 Payment Required.

- Flow: client requests resource -> server returns 402 + required badge criteria -> client proves ownership -> server validates via BitBadges API
- ownershipRequirements: use $and for "must have all", $or for "must have any"
- mustOwnAmounts: { start: 1, end: 1 } = must own at least 1
- mustOwnAmounts: { start: 0, end: 0 } = must NOT own (exclusion)
- Tiered access: different token IDs = different access levels
- Time-bounded access: combine ownershipTimes with subscription tokens

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "bb-402"`.
- **CLI**: `bitbadges-cli sdk skills bb-402`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/bb-402

## Category

`feature`

