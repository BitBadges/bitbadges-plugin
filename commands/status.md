---
description: Quick health check — chain binary version, JS CLI version, API connectivity, MCP server reachability, network selection.
argument-hint: (no arguments)
---

# /bitbadges:status

A one-shot diagnostic. Run `${CLAUDE_PLUGIN_ROOT}/scripts/doctor.sh --json`. It delegates to the installed CLI, preserving its JSON envelope and exit status. Interpret individual checks for SDK version, config validity, API connectivity, MCP binary presence and session integrity. Remote API connectivity is not required for offline construction.

Check `bb --version` and `bitbadgeschaind version` separately when native chain commands are needed. Binary presence does not prove an MCP connection is healthy; use the client's tool discovery to verify a live connection.

Output is human-readable by default; the underlying `bb doctor` always emits the universal `{ok, data, warnings, error}` envelope to stdout with the colored scorecard on stderr. Slash commands surface the human form.

## When to use

- After `/bitbadges:setup` to confirm everything's wired.
- When something stops working and you want to diagnose without running every command yourself.
- Before a long agent session as a smoke test.
