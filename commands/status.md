---
description: Quick health check — chain binary version, JS CLI version, API connectivity, MCP server reachability, network selection.
argument-hint: (no arguments)
---

# /bitbadges:status

A one-shot diagnostic. Runs `${CLAUDE_PLUGIN_ROOT}/scripts/doctor.sh` and reports:

- `bitbadgeschaind` version (or "not installed").
- `bitbadges-cli` version (resolved via `npx bitbadges --version`).
- Active network (mainnet / testnet / local).
- API connectivity (`bitbadges-cli sdk status`).
- API key configured (yes/no, masked).
- MCP server `bitbadges-builder` is reachable.

Output is human-readable by default. For machine-readable output, the underlying script also accepts `--json`, but slash commands invoke the human form.

## When to use

- After `/bitbadges:setup` to confirm everything's wired.
- When something stops working and you want to diagnose without running every command yourself.
- Before a long agent session as a smoke test.
