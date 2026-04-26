---
description: Non-fungible token collection with unique token IDs, metadata URIs, and badge-based ownership
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# NFT Collection

Non-fungible token collection with unique token IDs, metadata URIs, and badge-based ownership

## When to use this skill

Required standards: ["NFTs"]
- For tradable NFTs: ["NFTs", "NFTMarketplace", "NFTPricingDenom:ubadge"]

- validTokenIds: set to the range of unique token IDs (e.g. [{ "start": "1", "end": "100" }])
- Each token ID represents a unique NFT; amount in transfers is typically "1"
- Use {id} placeholder in tokenMetadata URI for per-token metadata (e.g. "ipfs://QmHash/{id}")
- Mint approvals MUST have overridesFromOutgoingApprovals: true
- Ownership times are usually forever for NFTs

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "nft-collection"`.
- **CLI**: `bitbadges-cli sdk skills nft-collection`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/nft-collection

## Category

`token-type`

