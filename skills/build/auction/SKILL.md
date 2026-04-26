---
description: Single-item auction with intent-based bidding. Seller mints NFT directly to the winning bidder during the accept window.
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Auction

Single-item auction with intent-based bidding. Seller mints NFT directly to the winning bidder during the accept window.

## When to use this skill

Required standards: ["Auction"]

- 1 token ID (the auctioned item)
- 2 collection-level approvals: mint-to-winner (combines mint + accept), burn (cleanup)
- Mint-to-winner: seller mints NFT directly to winning bidder during accept window (bidDeadline → bidDeadline + acceptWindow)
- No separate mint-at-creation step — token doesn't exist until seller accepts a bid
- Burn: anyone can burn token to burn address (permanent cleanup)
- Bidding via user-level outgoing approval intents (not collection approvals)

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "auction"`.
- **CLI**: `bitbadges-cli sdk skills auction`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/auction

## Category

`token-type`

