---
description: IBC-backed smart token with 1:1 backing and two required approvals (backing + unbacking)
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Smart Token

IBC-backed smart token with 1:1 backing and two required approvals (backing + unbacking)

## When to use this skill

Required standards: ["Smart Token"]

- MUST include cosmosCoinBackedPath in invariants with conversion sideA/sideB
- MUST configure at least one alias path (decimals must match IBC denom decimals)
- MUST create TWO required collection approvals (backing + unbacking). Transferable approval is COMMON but OPTIONAL:
  1. Backing approval (REQUIRED): fromListId = backing address, allowBackedMinting: true, mustPrioritize: true
  2. Transferable approval (OPTIONAL — include for wrapped assets, omit for vaults/escrows): fromListId = "!Mint", toListId = "All"
  3. Unbacking approval (REQUIRED): toListId = backing address, allowBackedMinting: true, mustPrioritize: true

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "smart-token"`.
- **CLI**: `bitbadges-cli sdk skills smart-token`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/smart-token

## Category

`token-type`

