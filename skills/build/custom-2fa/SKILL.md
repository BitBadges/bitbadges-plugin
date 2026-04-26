---
description: Two-factor authentication for transfers using a secondary approval address
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Custom 2FA

Two-factor authentication for transfers using a secondary approval address

## When to use this skill

Required standards: ["Custom-2FA"]

- autoDeletionOptions.allowPurgeIfExpired: MUST be true
- Approval name MUST contain "Custom 2FA"
- Use time-dependent ownershipTimes in MsgTransferTokens (not forever)
- Calculate timestamps: current time + expiration duration (milliseconds since epoch)
- Tokens automatically expire and can be purged after expiration

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "custom-2fa"`.
- **CLI**: `bitbadges-cli sdk skills custom-2fa`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/custom-2fa

## Category

`token-type`

