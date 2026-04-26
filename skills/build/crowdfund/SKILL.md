---
description: On-chain crowdfunding with goal tracking via mustOwnTokens. Contributors deposit funds, receive refund tokens. Crowdfunder withdraws if goal met, contributors refund if not.
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Crowdfund

On-chain crowdfunding with goal tracking via mustOwnTokens. Contributors deposit funds, receive refund tokens. Crowdfunder withdraws if goal met, contributors refund if not.

## When to use this skill

Required standards: ["Crowdfund"]

- 2 token IDs: Token 1 = Refund token (contributor holds), Token 2 = Progress token (crowdfunder accumulates)
- 4 collection-level approvals: deposit-refund, deposit-progress, success (withdraw), refund
- Contributors deposit coins → receive Token 1 (refund token). Paired approval mints Token 2 to crowdfunder (progress tracking).
- Success: crowdfunder withdraws if mustOwnTokens confirms they hold >= goal of Token 2 (collectionId: 0 = self-reference)
- Refund: after deadline, contributors burn Token 1 → escrow pays them back (only if goal NOT met via mustOwnTokens check)
- allowAmountScaling: true on ALL 4 approvals (contributors choose deposit size, everything scales proportionally)

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "crowdfund"`.
- **CLI**: `bitbadges-cli sdk skills crowdfund`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/crowdfund

## Category

`token-type`

