---
description: One-time setup for the BitBadges plugin — checks prerequisites, configures the API key, and optionally installs the chain binary.
argument-hint: (no arguments)
---

# /bitbadges:setup

Run this once after installing the plugin. It does four things:

1. **Checks the chain binary.** If `bitbadgeschaind` is on PATH, prints the version. If not, prints the install one-liner (`curl -fsSL https://install.bitbadges.io | sh`) and asks for explicit consent before running it.
2. **Checks the JS CLI.** If `bitbadges-cli` is reachable (or `npx bitbadges --version` works), reports OK. If not, suggests the same one-liner.
3. **Reads existing API key.** If `~/.bitbadges/config.json` already has an `apiKey`, uses that — no prompt. The CLI config is canonical; the plugin reads from it.
4. **Otherwise prompts for API key** and writes it via `bitbadges-cli config set apiKey <KEY>` so both the CLI and the plugin pick it up. Sources: get an API key at https://bitbadges.io/developer.

5. **Migration check.** If the user previously ran `claude mcp add bitbadges-builder ...` manually (user scope), that registration coexists with the plugin's `.mcp.json` entry and produces duplicate MCP servers. Detect it (`claude mcp list | grep bitbadges-builder`) and offer to run `claude mcp remove bitbadges-builder` to clean up.

## Behavior summary for Claude

When the user runs `/bitbadges:setup`:

- Run `${CLAUDE_PLUGIN_ROOT}/scripts/doctor.sh --json` to enumerate the current state.
- Walk the four checks above in order.
- For each missing prerequisite, **show** the command but do not run it without an explicit "yes" from the user. Never auto-pipe `curl ... | sh`.
- End with a one-line summary: "Ready to go" or "X step(s) skipped — re-run /bitbadges:setup when you want to address them".

Do not store the API key in the plugin's `userConfig` keychain — write it to the CLI config (`bitbadges-cli config set apiKey <key>`) so it works for everything: CLI, MCP, plugin, manual scripts.
