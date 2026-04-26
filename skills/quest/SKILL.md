---
description: Quest/reward collection — users complete criteria and claim a badge + coin payout
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Quest

Quest/reward collection — users complete criteria and claim a badge + coin payout

## When to use this skill

Required standards: ["Quests"]

- Single token only: validTokenIds = [{start: "1", end: "1"}]
- Quest approval MUST be properly gated — typically via an off-chain claim (merkle challenge with claimConfig), but can also use on-chain criteria (mustOwnTokens, dynamicStoreChallenges, evmQueryChallenges, votingChallenges)
- Coin transfers with overrideFromWithApproverAddress: true + overrideToWithInitiator: true
- predeterminedBalances: amount 1, no increments, no recurring, no duration
- Escrow funded upfront via set_mint_escrow_coins (rewardAmount * maxClaims)
- invariants.noCustomOwnershipTimes: true

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "quest"`.
- **CLI**: `bitbadges-cli sdk skills quest`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/quest

## Category

`token-type`

