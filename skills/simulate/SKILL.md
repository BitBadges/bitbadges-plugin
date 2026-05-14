---
description: Dry-run a BitBadges transaction without broadcasting. Returns parsed events, balance diffs per address, and any errors that would surface on-chain.
---

# Simulate

Always prefer simulate-first over broadcast-and-see. Use this skill before any `bb-broadcast` invocation, and any time the user wants to know "what would happen if I sent this tx".

## When to invoke

- The user is about to broadcast a transaction.
- The user asks "what does this tx do" or "will this work".
- After `bb-review` flags concerns and the user wants to see runtime behavior.

## What to do

**Via MCP (preferred in Claude Code):**

Call the `simulate_transaction` MCP tool with the transaction object.

**Via CLI:**

```bash
bb simulate @<path-to-tx.json>
```

Or pipe a transaction via stdin:

```bash
cat tx.json | bb simulate -
```

## What good output looks like

- A list of resulting events (token mints, transfers, approvals consumed).
- Per-address balance diffs (before / after).
- Any errors that the chain would have raised, surfaced as plain English.

## Failure modes

- Missing `creator` address on the transaction — the simulator can't run without one. Prompt the user to add it.
- `BITBADGES_API_KEY` not set — route to `/bitbadges:setup`.
- Transaction references a nonexistent collection — surface the ID that wasn't found.

## Don't

- Don't claim a simulation result equals the broadcast result. Edge cases (block timing, races, fee spikes) can still bite.
- Don't simulate then broadcast in one step without explicit user confirmation between the two.
