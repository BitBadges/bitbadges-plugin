---
description: One-time setup for the BitBadges plugin — checks prerequisites, configures the API key, and optionally installs the chain binary.
argument-hint: (no arguments)
---

# /bitbadges:setup

Verifies that the BitBadges chain binary + CLI are installed (these are the canonical entrypoint — the plugin is a convenience layer on top) and that an API key is configured. Run this once after installing the plugin.

The chain + CLI install is **the** entrypoint. The plugin's `npx`-based MCP fallback only exists as graceful degradation for users who haven't run the install one-liner yet.

## What it does

1. **Chain binary check (required).** If `bitbadgeschaind` is on PATH, print the version. If not, print the install one-liner (`curl -fsSL https://install.bitbadges.io | sh`) and ask for explicit consent before running it. Never auto-pipe `curl ... | sh` — show the command, wait for "yes".
2. **CLI check (required).** Same flow — if `bitbadges-cli` is on PATH, OK; otherwise the same one-liner installs both binaries together. The presence of `bitbadges-cli` globally also means the `bitbadges-builder` MCP bin is on PATH, which is faster and more reliable than the plugin's npx fallback.
3. **API key (required).** If `~/.bitbadges/config.json` already has an `apiKey`, use it — no prompt. The CLI config is canonical; both the CLI and the plugin read from there. Otherwise prompt for the key and write via `bb settings set apiKey <KEY>`. Source: https://bitbadges.io/developer.
4. **Migration check (optional).** If the user previously ran `claude mcp add bitbadges-builder ...` manually (user scope), that registration coexists with the plugin's `.mcp.json` entry and produces duplicate MCP servers. Detect it (`claude mcp list | grep bitbadges-builder`) and offer to run `claude mcp remove bitbadges-builder` to clean up.

## Behavior summary for Claude

- Run `${CLAUDE_PLUGIN_ROOT}/scripts/doctor.sh --json` to enumerate current state.
- Walk steps 1–4 in order. The chain binary + CLI install is the FIRST thing — don't skip it on the assumption "MCP via npx is good enough".
- For each missing prerequisite, **show** the command but do not run it without explicit "yes" from the user.
- End with a one-line summary: "Ready to go" or "X step(s) skipped — re-run /bitbadges:setup when you want to address them".

Do not store the API key in the plugin's `userConfig` keychain — write it to the CLI config so it works for everything: CLI, MCP, plugin, manual scripts.
