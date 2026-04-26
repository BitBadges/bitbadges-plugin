---
description: Liquidity pool standard with the 'Liquidity Pools' protocol standard tag — used for tradable assets that can be swapped on a DEX
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Liquidity Pools

Liquidity pool standard with the "Liquidity Pools" protocol standard tag — used for tradable assets that can be swapped on a DEX

## When to use this skill

Required standards: ["Liquidity Pools"]

- MUST set invariants.disablePoolCreation: false
- MUST configure at least one alias path (required for liquidity pools to function)
- Merkle challenges are NOT compatible with liquidity pools
- Enables decentralized exchange (DEX) trading interfaces

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "liquidity-pools"`.
- **CLI**: `bitbadges-cli sdk skills liquidity-pools`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/liquidity-pools

## Category

`token-type`

