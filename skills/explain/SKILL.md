---
description: Explain in plain English what a BitBadges collection or transaction does. Audience-aware — pick user, developer, or auditor framing.
---

# Explain

Use when the user wants natural-language understanding rather than raw JSON.

## When to invoke

- "What does collection X do?"
- "Explain this transaction to me."
- The user is writing audit notes, end-user copy, or a code-review comment about a BitBadges collection.

## What to do

**Live collection (numeric ID):**

Call the `explain_collection` MCP tool with `collectionId: "<id>"` and an `audience` of `user`, `developer`, or `auditor`. CLI fallback:

```bash
bb explain <id>
```

**Transaction file:**

```bash
bb explain @<path>.json
```

The CLI auto-detects whether the input is a transaction or a collection. The `--audience` selector currently only exists on the MCP tool path.

## Audience selection

- `user` — non-technical end-user. Use for marketing copy, claim-page descriptions.
- `developer` — someone building an integration. Highlight permissions, approvals, supply curves.
- `auditor` — someone reviewing for safety. Highlight foot-guns, irreversible permissions, manager privileges, anything custodial.

When unsure, ask the user which audience or default to `developer`.

## Don't

- Don't make up behavior the JSON doesn't support. If a field is missing or set to a default, say so explicitly rather than inferring.
