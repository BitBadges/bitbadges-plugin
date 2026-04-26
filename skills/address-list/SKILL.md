---
description: On-chain address list where membership = owning x1 of token ID 1. Manager can add/remove addresses.
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Address List

On-chain address list where membership = owning x1 of token ID 1. Manager can add/remove addresses.

## When to use this skill

Required standards: ["Address List"]

- validTokenIds: MUST be exactly [{ "start": "1", "end": "1" }]
- TWO collection approvals required with EXACT approvalIds (frontend depends on these):
  1. "manager-add": fromListId "Mint", toListId "All", initiatedByListId = creator. Mints token to add address.
  2. "manager-remove": fromListId "All", toListId burn address (bb1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqs7gvmv), initiatedByListId = creator. Burns token to remove address.
- BOTH approvals MUST have overridesFromOutgoingApprovals: true
- NO peer-to-peer transfer approval — only manager can modify the list

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "address-list"`.
- **CLI**: `bitbadges-cli sdk skills address-list`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/address-list

## Category

`token-type`

