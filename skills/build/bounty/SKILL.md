---
description: Escrow-based bounty with verifier arbitration. Submitter escrows coins, verifier accepts (pays recipient) or denies (refunds submitter). Expires if no decision.
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Bounty

Escrow-based bounty with verifier arbitration. Submitter escrows coins, verifier accepts (pays recipient) or denies (refunds submitter). Expires if no decision.

## When to use this skill

Required standards: ["Bounty"]

- 1 token ID (vehicle for approval engine — minted directly to burn)
- 3 collection-level approvals: accept, deny, expire
- Each approval: Mint → burn 1x token ID 1, triggers coinTransfer as side effect
- Verifier decides outcome via MsgCastVote
- Escrow pre-funded at creation via mintEscrowCoinsToTransfer
- Fixed bounty amount, no amount scaling

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "bounty"`.
- **CLI**: `bitbadges-cli sdk skills bounty`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/bounty

## Category

`token-type`

