---
description: Mint approval patterns including public mint, whitelist mint, creator-only mint, payment-gated mint, and escrow payouts
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Minting

Mint approval patterns including public mint, whitelist mint, creator-only mint, payment-gated mint, and escrow payouts

## When to use this skill

Required fields for all minting approvals:
- fromListId: "Mint"
- overridesFromOutgoingApprovals: true (REQUIRED for ALL Mint approvals)
- autoApproveAllIncomingTransfers: true in defaultBalances (for public-mint collections)
- predeterminedBalances vs approvalAmounts: incompatible — use one or the other
- orderCalculationMethod: MUST have exactly ONE method set to true (default: useOverallNumTransfers)
- coinTransfers override flags: false for standard payments, true for escrow payouts
- Mint escrow: overrideFromWithApproverAddress: true + overrideToWithInitiator: true (pays the minter from the escrow address)

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "minting"`.
- **CLI**: `bitbadges-cli sdk skills minting`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/minting

## Category

`approval`

