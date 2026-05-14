---
description: Quick health check — chain binary version, JS CLI version, API connectivity, MCP server reachability, network selection.
argument-hint: (no arguments)
---

# /bitbadges:status

A one-shot diagnostic. Runs `${CLAUDE_PLUGIN_ROOT}/scripts/doctor.sh` and reports:

- `bb` chain binary version (or "not installed").
- `bb` SDK version (resolved via `bb --version`).
- Active network (mainnet / testnet / local).
- API connectivity (`bb doctor`).
- API key configured (yes/no, masked).
- MCP server `bitbadges-builder` is reachable.

Output is human-readable by default; the underlying `bb doctor` always emits the universal `{ok, data, warnings, error}` envelope to stdout with the colored scorecard on stderr. Slash commands surface the human form.

## When to use

- After `/bitbadges:setup` to confirm everything's wired.
- When something stops working and you want to diagnose without running every command yourself.
- Before a long agent session as a smoke test.
