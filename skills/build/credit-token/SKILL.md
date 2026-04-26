---
description: Increment-only, non-transferable credit token purchased with any ICS20 denom. Users pay X of a denom and receive Y tokens as credits/proof of payment. For a 1:1 backed token with on-chain transferability, use the Smart Token standard inste…
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Credit Token

Increment-only, non-transferable credit token purchased with any ICS20 denom. Users pay X of a denom and receive Y tokens as credits/proof of payment. For a 1:1 backed token with on-chain transferability, use the Smart Token standard instead.

## When to use this skill

Required standards: ["Credit Token"]

- Increment-only, non-transferable (soulbound) fungible token purchased with ICS20 denom
- validTokenIds: [{ "start": "1", "end": "1" }] (single token ID)
- ONE Mint approval with approvalId "credit-scaled" using allowAmountScaling (single scaled approval supersedes the legacy 8-10 tier approach; legacy tiers still supported for backward compat but deprecated)
- Lock canUpdateCollectionApprovals (empty array = frozen)
- defaultBalances: autoApproveAllIncomingTransfers: true, autoApproveSelfInitiatedOutgoingTransfers: true, autoApproveSelfInitiatedIncomingTransfers: true
- Credit-scaled approval: overridesFromOutgoingApprovals: true, mustPrioritize: true, coinTransfers[0].coins[0].amount = "1" (micro-payment unit)

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "credit-token"`.
- **CLI**: `bitbadges-cli sdk skills credit-token`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/credit-token

## Category

`token-type`

## Reference collections

- [Collection 23](https://bitbadges.io/collections/23)
