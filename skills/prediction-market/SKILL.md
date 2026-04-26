---
description: Binary prediction market with YES/NO outcome tokens, liquidity pool trading, and vote-based settlement
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Prediction Market

Binary prediction market with YES/NO outcome tokens, liquidity pool trading, and vote-based settlement

## When to use this skill

Required standards: ["Prediction Market"]

- Binary prediction market: "Will X happen by Y?" Users deposit USDC to mint paired YES+NO tokens. Trade YES↔NO on a liquidity pool. Verifier settles by voting. Winner redeems 1:1.
- Token ID 1 = YES, Token ID 2 = NO (via alias paths with 6 decimals)
- mintEscrowAddress holds all deposited USDC
- invariants: \`noForcefulPostMintTransfers: true\` — locks non-mint approvals (redeem, settlement, transferable) from using \`overridesFromOutgoingApprovals\` or \`overridesToIncomingApprovals\`. Non-mint approvals rely on \`defaultBalances.autoApproveSelfInitiatedOutgoingTransfers: true\` for outgoing-side auth and on the burn destination for incoming-side auth
- All permissions frozen after creation
- 7 approvals: paired mint, freely transferable, pre-settlement redeem, yes-wins, no-wins, push-yes, push-no

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "prediction-market"`.
- **CLI**: `bitbadges-cli sdk skills prediction-market`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/prediction-market

## Category

`token-type`

