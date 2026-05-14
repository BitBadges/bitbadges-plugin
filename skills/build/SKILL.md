---
description: Build any kind of BitBadges token (smart-token, fungible, NFT, subscription, vault, claim, quest, auction, payment, crowdfund, prediction-market, ...). Discover the right type via the CLI, load canonical instructions from the SDK, construct via per-field MCP tools.
---

# Build a BitBadges token

Use this skill any time the user wants to create a BitBadges collection or token of any kind. **Don't make up token-type-specific knowledge from training data** — the SDK changes constantly. Instead, discover and load the canonical instructions, then construct via the per-field MCP tools.

The plugin does not redefine token types here. They live in the SDK and are surfaced through the CLI's `skills` command, the MCP's `get_skill_instructions` tool, and the Gitbook pages. This skill teaches Claude to use those.

## Step 1 — Discover the available token type

```sh
bb dev skills              # list every available skill (id, name, category, description)
bb dev skills <id>         # load the canonical instructions for one skill
```

If the user describes their goal but doesn't name a token type, list the catalog first and pick by category. Categories: `token-type`, `standard`, `approval`, `feature`, `advanced`.

Web reference: every skill is also rendered at `https://docs.bitbadges.io/x-tokenization/examples/skills/<id>` — fetch with WebFetch if a CLI run isn't viable.

## Step 2 — Load the canonical instructions

The instructions are the source of truth — required fields, approval ordering, foot-guns, reference collection IDs. Load them, don't reconstruct them:

- **MCP (preferred in Claude Code):** call `get_skill_instructions` with `id: "<skill-id>"`.
- **CLI:** `bb dev skills <id>`
- **Web docs:** `https://docs.bitbadges.io/x-tokenization/examples/skills/<id>`

## Step 3 — Construct the transaction

Use the MCP per-field session tools. Each call sets one field on a session-scoped transaction so you can build incrementally and inspect along the way:

`set_standards`, `set_invariants`, `add_alias_path`, `add_approval`, `set_permissions`, `set_valid_token_ids`, `set_collection_metadata`, … (full list via the MCP server's `tools/list`).

If you need an address derivation, dial the `address` skill. If you need claim setup on top of an approval, dial `claim`.

## Step 4 — Validate, review, simulate

Before the user even thinks about broadcasting:

1. `validate_transaction` (MCP) — fix every error.
2. `review_collection` (MCP) — opinionated audit. Surface every warning explicitly.
3. `simulate_transaction` (MCP) — see what would happen on-chain. Show the user the simulator output.

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
- Don't construct the JSON by hand when MCP per-field tools exist for it. They validate as they go.
- Don't skip validate / review / simulate before routing to `broadcast`.
- Don't broadcast for the user — that's the `broadcast` skill's job and it requires explicit user confirmation in the same turn.
