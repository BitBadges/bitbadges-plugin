---
description: Time-based subscription token with recurring payment approvals and auto-deletion on expiry
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Subscription

Time-based subscription token with recurring payment approvals and auto-deletion on expiry

## When to use this skill

Required standards: ["Subscriptions"]

- validTokenIds: MUST be exactly one token ID [{ "start": "1", "end": "1" }]
- Subscription faucet approval requirements:
  - fromListId: "Mint"
  - overridesFromOutgoingApprovals: true
  - coinTransfers: at least 1 entry, both override flags false
  - predeterminedBalances.incrementedBalances.durationFromTimestamp: MUST be non-zero (duration in ms)

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "subscription"`.
- **CLI**: `bitbadges-cli sdk skills subscription`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/subscription

## Category

`token-type`

