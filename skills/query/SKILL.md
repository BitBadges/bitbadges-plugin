---
description: Query BitBadges collections, balances, accounts, claims, addresses, standards (auctions / payment-requests / intents / smart-tokens / ...), and any of the 106+ API routes. Discovers routes via bb api --search instead of guessing.
---

# Query

Use this skill any time the user wants on-chain or off-chain BitBadges data — collection details, balances, account profiles, claim status, transfer history, or any other API route.

## Discovery first, then query

LLMs frequently hallucinate route paths. The CLI lists every installed API route, so always discover, then query.

```bash
bb api --search <keyword>      # matching routes as a small JSON list, e.g. balance, claim, list
bb api <group> --help          # every route in one group: tokens, accounts, claims, stores, ...
bb api <group> <route> --help  # arguments and options for one route
```

The installed CLI is the source of truth for routes and parameters. Check it before calling a route you're not 100% sure exists. Avoid `--help-json` for route discovery: it prints the entire CLI command tree (hundreds of KB), even when you put a group name in front of it.

## Common queries

| Need | Command |
|---|---|
| Collection details | `bb api tokens get-collection <id>` |
| Balances for an address | `bb api tokens get-balance-by-address <collection-id> <address>` |
| Account profile | `bb account profile --address <address>` |
| Claim status | `bb api claims get-claim <claim-id>` |
| Address list contents | Discover the installed address-list route with `bb api --search list`; do not infer a route from a standard name. |

Or use the MCP fast-paths: `query_collection`, `query_balance`, `verify_ownership`.

## Standards shortcuts (preferred over raw API)

Use the standard-specific commands before raw API routes. Available verbs and filters differ by standard; inspect that command's help:

```bash
bb auctions list                       # browse active auctions
bb auctions show 42                    # one auction
bb auctions status 42                  # bidding | accepting | sold | expired

bb pay-requests list --mine bb1...     # payment requests TO me
bb intents list --pay-denom ubadge    # intent-exchange offers using the native BADGE denom
bb prediction-markets list --open      # active prediction markets
bb credit-tokens show <id>             # one credit-token collection
bb smart-tokens status <id>            # one smart token
bb subscriptions status <id> --address <addr> # subscription tier status
bb swap assets                        # discover cross-chain assets
bb dynamic-stores list-values <id>     # on-chain key→bool map
```

Use the address filter shown by the installed command; do not assume `--mine` exists everywhere. Add the supported `--testnet` / `--local` flag for non-mainnet queries. Output is structured JSON.

## Networks

Add `--testnet` to any command to hit testnet. Add `--local` for `http://localhost:3001`. Default is mainnet.

## Failure modes

- 401/403 — `BITBADGES_API_KEY` not set or wrong network. Route to `/bitbadges:setup`.
- 404 on a collection ID — confirm the ID and network with the user (a testnet collection won't appear on mainnet).
- Pagination — follow the route's documented bookmark/cursor and `hasMore` fields. Preserve the same filters and network across pages; do not claim a complete result after reading only the first page.

## Don't

- Don't invent route paths. If `bb api --search` and `bb api <group> --help` don't list it, it doesn't exist.
- Don't dump full unfiltered API responses on the user — summarize, then offer the raw JSON if they want it.
