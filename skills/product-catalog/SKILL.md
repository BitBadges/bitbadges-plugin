---
description: Multi-product storefront with per-product pricing, supply limits, and optional burn-on-purchase. Each product is a separate token ID.
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Products

Multi-product storefront with per-product pricing, supply limits, and optional burn-on-purchase. Each product is a separate token ID.

## When to use this skill

Required standards: ["Products"]

- N token IDs (one per product), starting at 1
- N+1 approvals: 1 purchase approval per product + 1 optional burn approval
- Each purchase approval: fromListId="Mint", toListId="All" (or burn address if burn-on-purchase), 1 coinTransfer paying the store address
- Payment goes directly to store address (NOT to escrow) — overrideFromWithApproverAddress: false
- Each product has independent price, supply limit (maxNumTransfers), and burn-on-purchase toggle
- predeterminedBalances.incrementedBalances.startBalances: 1x of that product's token ID

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "product-catalog"`.
- **CLI**: `bitbadges-cli sdk skills product-catalog`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/product-catalog

## Category

`token-type`

