---
description: Build or audit a BitBadges claim — code-gated, password-gated, whitelist, open, or token-gated. Use when the user wants users to redeem something on a claim page.
---

# Claim

A BitBadges "claim" is a redemption page where users (gated however the manager chooses) can claim tokens, perform a transfer, or trigger a payment. This skill handles building new claims and auditing existing ones.

## Build

Discover the installed tool schema with `bb dev capabilities build_claim`, then call the claim builder through the CLI:

```bash
bb dev tools call build_claim --args-file claim-input.json
```

The optional MCP `build_claim` tool uses the same handler. This prepares an API document; it does not create the claim remotely. Required inputs are `claimType`, `name`, and a positive integer `maxUses`. Use the installed schema for optional action fields. Confirm any API write separately from building its proposal.

## Common gating modes (plugins)

| Mode | `claimType` | Use when |
|---|---|---|
| Whitelist (address list) | `whitelist-gated` | Specific addresses supplied in `whitelist` |
| Password | `password-gated` | Shared value supplied in `password` |
| Codes | `code-gated` | Generated one-time codes; optional `numCodes` |
| Open | `open` | Anyone can claim, subject to usage limits |

Token ownership requirements belong in the relevant approval or supported claim plugin configuration. `must-own-tokens` is not a supported `claimType`; load the claim/API instructions before composing custom gating.

## Audit existing

```bash
bb api claims get-claim <claim-id>
```

Then review for: overlapping plugins (e.g. password + open), expired time windows, max-uses set or unset, and whether the underlying approval still has supply.

## Failure modes

- Unsupported claim types — use the installed `build_claim` schema, not guessed plugin IDs.
- Gating mode that doesn't compose with the chosen approval (e.g. open claim against a 1-use approval).

## Don't

- A draft may be prepared before its collection exists. Before publishing, resolve real collection/approval identifiers and verify that the intended approval authorizes the claim action.
- Don't share password/codes back to the user as plain log lines — call them out as sensitive.
