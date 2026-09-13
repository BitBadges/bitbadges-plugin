---
description: Build any kind of BitBadges token (smart-token, fungible, NFT, subscription, vault, claim, quest, auction, payment, prediction-market, ...). Discover the right type via the CLI, load canonical instructions from the SDK, construct with the CLI presets, using MCP as an optional adapter.
---

# Build a BitBadges token

Use this skill any time the user wants to create a BitBadges collection or token of any kind. **Don't make up token-type-specific knowledge from training data** — the SDK changes constantly. Instead, discover and load the canonical instructions, then use the CLI preset that matches the task.

The plugin does not redefine token types here. They live in the SDK and are surfaced through the CLI's `skills` command, the MCP's `get_skill_instructions` tool, and the Gitbook pages. This skill teaches Claude to use those.

## Step 1 — Discover the available token type

```sh
bb dev skills              # list every available skill (id, name, category, description)
bb dev skills <id>         # load the canonical instructions for one skill
```

If the user describes their goal but doesn't name a token type, list the catalog first and pick by category. Categories: `token-type`, `standard`, `approval`, `feature`, `advanced`.

Web reference: every skill is also rendered at `https://docs.bitbadges.io/agents/skills/<id>` — fetch with WebFetch if a CLI run isn't viable.

## Step 2 — Load the canonical instructions

The instructions are the source of truth — required fields, approval ordering, foot-guns, reference collection IDs. Load them, don't reconstruct them:

- **CLI (primary):** `bb dev skills <id>`. Read the JSON envelope: `data` contains the skill.
- **MCP (optional):** call `get_skill_instructions` with `{"skillId": "<skill-id>"}`.
- **Web docs:** `https://docs.bitbadges.io/agents/skills/<id>`

## Step 3 — Construct the transaction

Start with `bb build --help`, then `bb build <preset> --help`. Use the shipped preset rather than reconstructing approvals. For invoices and payment links, inspect `bb build payment-request-v2 --schema` and `--list-examples`, then load the matching `--example`. Keep integer base-unit amounts as decimal strings; resolve asset decimals before conversion. Do not use floating-point arithmetic for payments.

Save the build envelope to a file, inspect its warnings and review metadata, and reuse that exact artifact for checks and signing. The CLI also exposes native Cosmos chain commands; use `bb <module> --help` and `bb tx <module> --help` for installed command discovery. MCP is optional. Use its per-field session tools only when a preset cannot express the requested design; give independent builds distinct session IDs.

If you need an address derivation, dial the `address` skill. If you need claim setup on top of an approval, dial `claim`.

## Step 4 — Validate, review, simulate

Before the user even thinks about broadcasting:

1. `bb check tx.json` — fix errors and assess warnings; preserve the review result.
2. `bb explain tx.json` — verify the actual recipients, amounts, timing, manager powers, and approval limits against the request.
3. `bb simulate tx.json --creator <signer>` with the selected network — inspect gas and balance changes. If simulation is unsupported for this message, report that limitation; do not label it simulated.

A successful build or check does not prove a transaction will succeed against current chain state. Never claim refunds, cancellation, escrow, proration, or fee ceilings unless the selected standard and execution path enforce them.

Only then route to the `broadcast` skill, which has its own hard rails.

## Going deeper

The CLI's `dev docs` command surfaces the full Gitbook docs from your terminal. Use it when a skill instruction references a concept you need to look up:

```sh
bb dev docs all                # dump the entire docs corpus
bb dev docs <slug>             # specific page, e.g. learn/approvals
```

You also have full access to the public docs at `https://docs.bitbadges.io` if you need to fetch a page directly. Fetch only what you need; don't dump entire sections into the context for fun.

## Don't

- Don't manufacture token-type knowledge from training data — load from the SDK every time. The schema and required fields change.
- Do not invent fields or silently switch standards to make an unsupported lifecycle feature appear supported.
- Don't skip validate / review / simulate before routing to `broadcast`.
- Don't broadcast for the user — that's the `broadcast` skill's job and it requires authority for the exact transaction or a previously granted policy that covers it.
