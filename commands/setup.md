---
description: One-time setup for the BitBadges plugin — checks prerequisites, configures the API key, and optionally installs the chain binary.
argument-hint: (no arguments)
---

# /bitbadges:setup

Verifies that the BitBadges chain binary + CLI are installed (these are the canonical entrypoint — the plugin is a convenience layer on top) and that an API key is configured. Run this once after installing the plugin.

The CLI is the primary entrypoint. MCP launches the installed `bitbadges-builder` binary from the same SDK installation. The plugin does not download packages at startup.

## What it does

1. **Chain binary check (required).** If `bitbadgeschaind` is on PATH, print the version. If not, print the install one-liner (`curl -fsSL https://install.bitbadges.io | sh`) and ask for explicit consent before running it. Never auto-pipe `curl ... | sh` — show the command, wait for "yes".
2. **CLI check (required).** Check `bitbadges-cli` and `bitbadges-builder` independently on PATH. The installer provides both. Do not silently install an unpinned fallback package. The chain binary is needed for native Cosmos commands; offline SDK construction does not require it.
3. **API key (remote operations only).** Reuse existing CLI configuration without printing it. If a requested remote operation needs a key, direct the user to https://bitbadges.io/developer and have them configure it locally using the CLI settings flow. Do not request secrets in chat or echo config contents. Offline construction and skill discovery do not require a key.
4. **Migration check (optional).** If the user previously ran `claude mcp add bitbadges-builder ...` manually (user scope), that registration coexists with the plugin's `.mcp.json` entry and produces duplicate MCP servers. Detect it (`claude mcp list | grep bitbadges-builder`) and offer to run `claude mcp remove bitbadges-builder` to clean up.

## Behavior summary for Claude

- Run `${CLAUDE_PLUGIN_ROOT}/scripts/doctor.sh --json` to enumerate current state.
- Walk steps 1–4 in order. Interpret individual CLI diagnostic checks; a missing remote API key does not prevent offline construction.
- For each missing prerequisite, **show** the command but do not run it without explicit "yes" from the user.
- End with a one-line summary: "Ready to go" or "X step(s) skipped — re-run /bitbadges:setup when you want to address them".

Do not store the API key in the plugin's `userConfig` keychain — write it to the CLI config so it works for everything: CLI, MCP, plugin, manual scripts.
