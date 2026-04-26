---
description: Simple fungible token with fixed or unlimited supply and configurable mint/transfer approvals
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Fungible Token

Simple fungible token with fixed or unlimited supply and configurable mint/transfer approvals

## When to use this skill

Required standards: ["Fungible Tokens"]

- validTokenIds: MUST be exactly [{ "start": "1", "end": "1" }] (single token ID)
- All tokens share the same token ID (1), making them interchangeable
- Amount field in transfers determines quantity
- Token metadata must reference token ID 1
- Ownership times typically forever: [{ "start": "1", "end": "18446744073709551615" }]

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "fungible-token"`.
- **CLI**: `bitbadges-cli sdk skills fungible-token`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/fungible-token

## Category

`token-type`

