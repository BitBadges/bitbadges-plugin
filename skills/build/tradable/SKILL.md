---
description: NFT marketplace standard enabling peer-to-peer transfers with the 'NFTMarketplace' standard tag and NFTPricingDenom
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Tradable NFTs

NFT marketplace standard enabling peer-to-peer transfers with the "NFTMarketplace" standard tag and NFTPricingDenom

## When to use this skill

Required standards: ["NFTMarketplace", "NFTs", "NFTPricingDenom:ubadge"]

- MUST include all three standards together
- NFTPricingDenom format: "NFTPricingDenom:<denom>" (sets pricing denomination for orderbook)
- MUST include a free transfer approval: fromListId: "!Mint", toListId: "All", initiatedByListId: "All", approvalId: "transferable-approval"
- Enables orderbook/marketplace integration
- Typically used with NFT collections
- Note: Legacy names "Tradable" and "DefaultDisplayCurrency" are still accepted for existing collections

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "tradable"`.
- **CLI**: `bitbadges-cli sdk skills tradable`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/tradable

## Category

`standard`

