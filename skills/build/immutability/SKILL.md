---
description: Lock collection permissions to make properties permanently immutable or permanently permitted
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Transferability & Update Rules

Lock collection permissions to make properties permanently immutable or permanently permitted

## When to use this skill

Controls whether collection properties can be changed after creation.

- Two states: FROZEN (permanentlyForbiddenTimes: FOREVER) or NEUTRAL (empty [])
- NEUTRAL [] = manager can update now AND can freeze it later. Use this for editable fields.
- FROZEN = permanent and irreversible. Use for fields that should never change.
- AVOID permanentlyPermittedTimes — it permanently prevents locking. Almost never needed.
- canUpdateCollectionApprovals: controls transfer rule mutability
  - SECURITY: If manager can update Mint approvals, they can mint unlimited tokens

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "immutability"`.
- **CLI**: `bitbadges-cli sdk skills immutability`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/immutability

## Category

`advanced`

