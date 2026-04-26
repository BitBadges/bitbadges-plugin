---
description: Require weighted quorum voting from multiple parties before transfers can proceed (multi-sig, governance, etc.)
---

<!-- GENERATED FILE — do not edit by hand. Source: bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts. Regenerate with `bun run gen-llm-mirrors`. -->

# Multi-Sig / Voting

Require weighted quorum voting from multiple parties before transfers can proceed (multi-sig, governance, etc.)

## When to use this skill

Enables multi-signature-like approval via votingChallenges[] in approvalCriteria.

- Each voter has an address and a weight
- quorumThreshold: percentage (0-100) of total possible weight that must vote "yes"
- Voters cast votes via MsgCastVote with yesWeight (0-100%)
- Non-voting voters count as 0% yes; threshold is % of ALL voters' total weight, not just those who voted
- Votes can be updated (re-casting overwrites previous vote)
- proposalId: unique identifier — changing it resets the vote tracker

## Get the full instructions

The canonical instructions for this skill live in the BitBadges SDK and are loaded on demand. Use one of these to fetch them:

- **MCP tool (preferred in Claude Code)**: call `get_skill_instructions` with `id: "multi-sig-voting"`.
- **CLI**: `bitbadges-cli sdk skills multi-sig-voting`
- **Web docs**: https://docs.bitbadges.io/x-tokenization/examples/skills/multi-sig-voting

## Category

`approval`

