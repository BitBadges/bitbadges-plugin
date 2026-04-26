---
description: Invoices, escrows, bounties, milestones, and multi-party agreements using coinTransfer-based approvals or IBC-backed smart token escrow
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Payment Protocol

Invoices, escrows, bounties, milestones, and multi-party agreements using coinTransfer-based approvals or IBC-backed smart token escrow

## When to use this skill

Build invoices, milestones, bounties, escrow agreements, or any payment flow.

Two approaches:
- **Approach 1 (coinTransfer-based)**: Simple one-shot payments. Each approval = one invoice/milestone with coinTransfers.
  - Standards: ["ListView:Milestones"] or ["ListView:Invoice Requests"] or ["ListView:Bounties"]
  - Each approval: fromListId "Mint", coinTransfers for payment, overridesFromOutgoingApprovals: true
  - ListView incompatible with: Subscriptions, Smart Tokens, Custom 2FA, Liquidity Pools, Tradable NFTs
- **Approach 2 (Escrow)**: Funds held in IBC-backed smart token until conditions are met.

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "payment-protocol"`.
- **CLI**: `bitbadges-cli sdk skills payment-protocol`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/payment-protocol

## Category

`token-type`

