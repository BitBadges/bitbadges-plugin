---
description: One-time setup for the BitBadges plugin — checks prerequisites, configures the API key, and optionally installs the chain binary.
argument-hint: (no arguments)
---

# /bitbadges:setup

Checks the prerequisites for the user's intended workflow. Run this once after installing the plugin. Offline construction needs the SDK CLI; remote queries may need an API key, and native Cosmos commands need the chain binary.

The CLI is the primary entrypoint. MCP launches the installed `bitbadges-builder` binary from the same SDK installation. The plugin does not download packages at startup.

For an isolated agent or smoke test, set `BITBADGES_CONFIG_DIR` to a fresh private directory before invoking the CLI or MCP. Both use that directory for local configuration and signing-request records. Do not inspect or copy another wallet's credentials to make a test pass. Offline build, schema, and skill discovery need no API key.

## What it does

1. **CLI check.** Check `bitbadges-cli` on PATH. Use `bb` when the combined CLI is installed; `bitbadges-cli` directly supports SDK commands when the chain wrapper is absent. Check `bitbadges-builder` separately if MCP is requested. Do not block a CLI-only workflow on a missing MCP binary or download a fallback at startup.
2. **Native chain commands.** Check `bitbadgeschaind version` when the task needs native Cosmos commands. If installation is needed, show `curl -fsSL https://install.bitbadges.io | sh` and obtain authorization before executing the remote installer. An absent chain binary does not block offline SDK construction.
3. **API key (remote operations only).** Reuse existing CLI configuration without printing it. If a requested remote operation needs a key, direct the user to https://bitbadges.io/developer and have them configure it locally using the CLI settings flow. Do not request secrets in chat or echo config contents. Offline construction and skill discovery do not require a key.
4. **Migration check (optional).** Inspect `claude mcp list` for a separate manual registration as well as the plugin server. A matching name alone is not proof of duplication. If a duplicate is confirmed, explain which registration would be removed and obtain authorization; inspect `claude mcp remove --help` to target its actual scope.

## Behavior summary for Claude

- Run `${CLAUDE_PLUGIN_ROOT}/scripts/doctor.sh --json` to enumerate current state.
- Walk steps 1–4 in order. Interpret individual CLI diagnostic checks; a missing remote API key does not prevent offline construction.
- Run read-only checks directly. For installation or configuration changes, honor existing authorization and ask only for changes outside it. Never ask the user to paste secrets into chat.
- End with workflow-specific readiness: for example, "Offline builds ready; configure an API key for remote queries." If something required is missing, give the exact next command. Do not report all workflows ready from binary presence alone.

Do not store the API key in the plugin's `userConfig` keychain — write it to the CLI config so it works for everything: CLI, MCP, plugin, manual scripts.
