# BitBadges Plugin for Claude Code

A Claude Code plugin that auto-wires the BitBadges builder MCP server and teaches Claude how to leverage the BitBadges CLI + docs to build, review, simulate, and query tokens.

The plugin is a thin **harness on top of the CLI**. It does not redefine token types or duplicate skill content — every workflow ultimately routes to `bitbadges-cli` commands, the `bitbadges-builder` MCP, or the public docs at https://docs.bitbadges.io. Source of truth stays in the SDK; the plugin just makes Claude reach for the right tool at the right time.

## Prerequisites

The BitBadges chain binary + CLI are the canonical way to interact with BitBadges. Install them first:

```sh
curl -fsSL https://install.bitbadges.io | sh
```

This installs `bitbadgeschaind` (the chain binary) and `bitbadges-cli` (the JS CLI that exposes 104+ API routes plus the `bitbadges-builder` MCP server). This plugin is a Claude Code convenience layer on top of those — it does not replace them.

Get an API key at [bitbadges.io/developer](https://bitbadges.io/developer) and configure it once:

```sh
bitbadges-cli config set apiKey YOUR_KEY
```

## Install the plugin

After the prerequisites above:

```
/plugin marketplace add BitBadges/bitbadges-plugin
/plugin install bitbadges
```

Then run `/bitbadges:setup` once to verify everything is wired and `/bitbadges:status` whenever you want a health check.

## What the plugin adds

- **MCP tools** — `bitbadges-builder` registered automatically (no separate `claude mcp add` step). Exposes 50+ session-based per-field token construction tools, queries, validation, review, and simulation.
- **8 skills** — guides that route Claude to the right CLI command, MCP tool, or docs page for each common BitBadges workflow:
  - `build` — meta-guide for building any token type. Discovers via `bitbadges-cli sdk skills`, loads canonical instructions from the SDK, constructs via per-field MCP tools.
  - `review`, `simulate`, `explain` — pre-broadcast safety net. Wraps `bitbadges-cli sdk review`, MCP `simulate_transaction`, and `bitbadges-cli sdk interpret-collection`.
  - `query`, `address`, `claim` — runtime ops. Wraps the API routes, address derivations, and claim builder respectively.
  - `broadcast` — hard-railed signer. Dry-run by default, explicit confirmation for live.
- **2 slash commands** — `/bitbadges:setup` (one-time prereq check + API key wiring) and `/bitbadges:status` (health check).
- **`bitbadges-builder` subagent** for focused builder loops.
- **SessionStart pre-warm** so the first MCP-tool call doesn't pay npx download latency.

The skills don't duplicate token-type knowledge from the SDK. They tell Claude *where* to find that knowledge (CLI / MCP / Gitbook) and *how* to combine it. The full Gitbook docs at https://docs.bitbadges.io are also fair game — fetch what you need.

## Fallback behavior

If `bitbadges-cli` and `bitbadges-builder` aren't on your PATH (because you skipped the prerequisites), the plugin falls back to `npx -y -p bitbadges bitbadges-builder` for the MCP server. This works for read-only LLM workflows but is a degraded path — a globally installed CLI is faster, more reliable, and what `/bitbadges:setup` will recommend.

## API key

The plugin reads `~/.bitbadges/config.json` first if you've already configured the BitBadges CLI. Otherwise `/bitbadges:setup` prompts.

Get an API key at [bitbadges.io/developer](https://bitbadges.io/developer).

## Migration from manual MCP setup

If you previously ran:

```
claude mcp add bitbadges-builder -- npx -y -p bitbadges bitbadges-builder
```

Remove the user-scope entry before installing the plugin to avoid duplicate MCP servers:

```
claude mcp remove bitbadges-builder
```

`/bitbadges:setup` will detect duplicates and offer to clean up.

## What's where

- Skills inventory and detailed reference: [docs.bitbadges.io/for-developers/ai-agents/claude-code-plugin](https://docs.bitbadges.io/for-developers/ai-agents/claude-code-plugin)
- MCP server source: [bitbadgesjs/packages/bitbadgesjs-sdk/src/builder](https://github.com/BitBadges/bitbadgesjs/tree/main/packages/bitbadgesjs-sdk/src/builder)
- CLI source: [bitbadgesjs/packages/bitbadgesjs-sdk/src/cli](https://github.com/BitBadges/bitbadgesjs/tree/main/packages/bitbadgesjs-sdk/src/cli)
- Chain binary: [bitbadgeschain](https://github.com/BitBadges/bitbadgeschain)

## License

CC BY-NC-SA 4.0 — see [LICENSE](./LICENSE). Matches the parent `bitbadgesjs` and `bitbadgeschain` projects.
