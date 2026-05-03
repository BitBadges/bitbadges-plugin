---
description: Review a BitBadges transaction file or live collection for correctness, standards compliance, approval ordering, and UX issues before broadcasting.
---

# Review

Use this skill any time the user has built a BitBadges transaction or wants a second opinion on an existing on-chain collection.

## When to invoke

- The user has a `tx.json` or similar transaction file on disk and wants it reviewed.
- The user mentions a collection ID (e.g. "audit collection 142", "is collection 99 set up correctly?").
- After any `bb-create-*` skill produces a transaction — always review before broadcasting.

## What to do

**Transaction file review (input is a path):**

```bash
bitbadges-cli check @<path-to-tx.json> --depth review
```

Or run the full pass (validate + review + metadata, the default depth):

```bash
bitbadges-cli check @<path-to-tx.json>
```

The CLI accepts `@file.json` syntax for path inputs. JSON output includes parsed warnings, errors, and suggestions.

**Live collection review (input is a numeric ID or a collection ID string):**

Call the `review_collection` MCP tool with `collectionId: "<id>"`. Falls back to `bitbadges-cli api tokens get-collection <id>` + manual inspection if MCP isn't available.

## What good output looks like

- Standards compliance (Smart Token, Subscription, Tradable, etc. — required fields present, no contradictions).
- Approval ordering — `mustPrioritize: true` on the right approvals; no shadowing.
- Permissions — not over-restricted; `canArchiveCollection` and similar irreversible flags reviewed.
- Metadata — placeholders are unset before broadcast; alias paths sane.
- Foot-guns — `fromListId: "Mint"` on smart tokens, reused reserved symbols (USDC/ATOM/BADGE), missing unbacking approvals, wrong decimals on alias paths.

## Failure modes

- Input is a directory or stdin — the CLI accepts `-` for stdin and `@dir/file.json` for paths; if both fail, ask the user for the actual file path.
- `BITBADGES_API_KEY` not set when reviewing a live collection — surface this clearly and route to `/bitbadges:setup`.

## Don't

- Don't broadcast after review without explicit user confirmation. Review is read-only.
- Don't auto-fix what the review surfaces — ask the user what to address. Per BitBadges convention, throws beat silent coercions.
