---
description: Mint and distribute tokens to recipients at collection creation time using MsgTransferTokens
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Auto-Mint

Mint and distribute tokens to recipients at collection creation time using MsgTransferTokens

## When to use this skill

Post-creation minting — adds MsgTransferTokens messages to the transaction so tokens are distributed immediately after collection creation.

- Transaction can contain MsgUniversalUpdateCollection PLUS one or more MsgTransferTokens messages
- All transfer messages use collectionId: "0" to reference the just-created collection
- prioritizedApprovals MUST always be specified (use [] if none needed)
- from: "Mint" for minting new tokens, bb1... address for peer-to-peer transfers
- The signing user (creator) is the initiator — collection must have an approval allowing this
- All numbers as strings — "1" not 1

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "auto-mint"`.
- **CLI**: `bitbadges-cli sdk skills auto-mint`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/auto-mint

## Category

`feature`

