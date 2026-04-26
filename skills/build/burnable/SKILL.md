---
description: Allow token holders to burn tokens by sending them to the burn address, permanently removing them from circulation
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Burnable

Allow token holders to burn tokens by sending them to the burn address, permanently removing them from circulation

## When to use this skill

Allows holders to permanently destroy tokens by sending to burn address.

- Burn address: bb1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqs7gvmv (ETH null address in BitBadges format)
- Approval structure: fromListId: "!Mint", toListId: burn address
- overridesToIncomingApprovals: true (burn address has no user-level incoming approvals)
- approvalId: "burnable-approval" (standard ID used by frontend to detect burnability)
- All amounts/transfers set to "0" (unlimited)
- Additive: sits alongside other collection approvals

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "burnable"`.
- **CLI**: `bitbadges-cli sdk skills burnable`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/burnable

## Category

`approval`

