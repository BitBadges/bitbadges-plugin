# BitBadges Plugin for Claude Code

A Claude Code plugin that auto-wires the BitBadges builder MCP server and ships curated skills for token creation, review, simulation, and on-chain queries.

## Install

```
/plugin marketplace add BitBadges/bitbadges-plugin
/plugin install bitbadges
```

That's it. After install, you have:

- **MCP tools** — `bitbadges-builder` registered automatically (no `claude mcp add` step).
- **~29 skills** — token creation (smart-token, fungible, NFT, subscription, vault, claim, quest, auction, …), review, simulate, explain, query, address, broadcast.
- **2 slash commands** — `/bitbadges:setup` and `/bitbadges:status`.

The plugin uses `npx -y -p bitbadges bitbadges-builder` under the hood, so the latest published `bitbadges` npm package is fetched on first use. No separate install of the JS CLI is required.

## What you can do without setup

The MCP server alone covers the vast majority of CC workflows: build a token, review a transaction, simulate a broadcast, query a collection, derive an address. None of these need the chain binary.

## What needs `/bitbadges:setup`

Local key management and live transaction broadcasts use the `bitbadgeschaind` chain binary, which is a separate Go binary. Run:

```
/bitbadges:setup
```

This walks through installing `bitbadgeschaind` via `https://install.bitbadges.io` (with consent prompt — never auto-pipes to sh) and configures your API key.

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
