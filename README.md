# BitBadges Plugin for Claude Code

A Claude Code plugin that auto-wires the BitBadges builder MCP server and ships curated skills for token creation, review, simulation, and on-chain queries.

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

- **MCP tools** — `bitbadges-builder` registered automatically (no separate `claude mcp add` step).
- **~29 skills** — token creation (smart-token, fungible, NFT, subscription, vault, claim, quest, auction, …), review, simulate, explain, query, address, broadcast.
- **2 slash commands** — `/bitbadges:setup` and `/bitbadges:status`.
- **`bitbadges-builder` subagent** for focused builder loops.
- **SessionStart pre-warm** so the first MCP-tool call doesn't pay npx download latency.

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
