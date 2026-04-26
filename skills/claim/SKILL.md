---
description: Build or audit a BitBadges claim — code-gated, password-gated, whitelist, open, or token-gated. Use when the user wants users to redeem something on a claim page.
---

# Claim

A BitBadges "claim" is a redemption page where users (gated however the manager chooses) can claim tokens, perform a transfer, or trigger a payment. This skill handles building new claims and auditing existing ones.

## Build

Use the `build_claim` MCP tool with the desired plugins (gating modes) and approval target. CLI fallback for offline preview:

```bash
bitbadges-cli builder claim build --plugins <p1>,<p2> --target <approval-id>
```

## Common gating modes (plugins)

| Mode | Plugin id | Use when |
|---|---|---|
| Whitelist (address list) | `whitelist` | Specific addresses pre-approved |
| Password | `password` | Single shared secret |
| Codes | `codes` | One-time-use codes (good for events) |
| Open | (none) | Anyone can claim |
| Token-gated | `must-own-tokens` | Holders of another collection only |

## Audit existing

```bash
bitbadges-cli api claims get-claim <claim-id>
```

Then review for: overlapping plugins (e.g. password + open), expired time windows, max-uses set or unset, and whether the underlying approval still has supply.

## Failure modes

- Mismatched plugin ids — the CLI / MCP will reject; confirm against `bitbadges-cli api --help-json` if unsure.
- Gating mode that doesn't compose with the chosen approval (e.g. open claim against a 1-use approval).

## Don't

- Don't build a claim against an approval that doesn't exist yet — the approval has to be created first via the underlying token-creation skill.
- Don't share password/codes back to the user as plain log lines — call them out as sensitive.
