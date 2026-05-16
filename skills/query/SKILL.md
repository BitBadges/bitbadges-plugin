---
description: Query BitBadges collections, balances, accounts, claims, addresses, standards (auctions / payment-requests / intents / smart-tokens / ...), and any of the 106+ API routes. Discovers routes via --help-json instead of guessing.
---

# Query

Use this skill any time the user wants on-chain or off-chain BitBadges data — collection details, balances, account profiles, claim status, transfer history, or any other API route.

## Discovery first, then query

LLMs frequently hallucinate route paths. The CLI exposes the full API tree as JSON — always discover, then query.

```bash
bb api --help-json
bb api <group> --help-json     # e.g. tokens, accounts, claims, addresses
```

The `--help-json` output is the source of truth for routes and parameters. Read it before calling a route you're not 100% sure exists.

## Common queries

| Need | Command |
|---|---|
| Collection details | `bb api tokens get-collection <id>` |
| Balances for an address | `bb api tokens get-balance <collection-id> <address>` |
| Account profile | `bb api accounts get-account <address>` |
| Claim status | `bb api claims get-claim <claim-id>` |
| Address list contents | `bb api address-lists get-list <list-id>` |

Or use the MCP fast-paths: `query_collection`, `query_balance`, `verify_ownership`.

## Standards shortcuts (preferred over raw API)

For every BitBadges standard the CLI exposes a typed list / show / status surface that's friendlier than the raw indexer routes. Reach for these BEFORE `api ...` when the user asks about a standard by name:

```bash
bb auctions list                       # browse active auctions
bb auctions show 42                    # one auction
bb auctions status 42                  # bidding | accepting | sold | expired

bb pay-requests list --mine bb1...     # payment requests TO me
bb intents list --pay-denom uusdc      # intent-exchange offers
bb prediction-markets list --open      # active prediction markets
bb credit-tokens show <id>             # one credit-token collection
bb smart-tokens status <id>            # one smart token
bb subscriptions status <id> <addr>    # subscription tier status
bb swap assets / chains / balances     # cross-chain swap surface
bb dynamic-stores list-values <id>     # on-chain key→bool map
```

Every standard supports `--mine <addr>` (or equivalent) to scope to a specific user. Add `--testnet` / `--local` for non-mainnet. Output is structured JSON. The full surface lives at the docs Standards Commands reference.

## Networks

Add `--testnet` to any command to hit testnet. Add `--local` for `http://localhost:3001`. Default is mainnet.

## Failure modes

- 401/403 — `BITBADGES_API_KEY` not set or wrong network. Route to `/bitbadges:setup`.
- 404 on a collection ID — confirm the ID and network with the user (a testnet collection won't appear on mainnet).
- Pagination — many routes paginate; check the response for `nextCursor` and ask the user if they want subsequent pages.

## Don't

- Don't invent route paths. If `--help-json` doesn't list it, it doesn't exist.
- Don't dump full unfiltered API responses on the user — summarize, then offer the raw JSON if they want it.
