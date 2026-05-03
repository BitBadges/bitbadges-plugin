# Changelog

All notable changes to the BitBadges Claude Code plugin will be documented in this file.

## [Unreleased]

### Added
- Initial scaffolding: plugin manifest, MCP server registration, README, LICENSE.
- 8 skills, all hand-written as routing guides on top of the CLI / MCP / docs (no duplicated SDK content):
  - `build` — meta-guide for constructing any token type. Routes Claude to `bitbadges-cli skills <id>` for canonical instructions and the per-field MCP tools for construction.
  - `review`, `simulate`, `explain` — pre-broadcast safety net.
  - `query`, `address`, `claim` — runtime ops.
  - `broadcast` — hard-railed live broadcast.
- 2 slash commands: `/bitbadges:setup`, `/bitbadges:status`.
- `bitbadges-builder` subagent definition for focused builder loops.
- `scripts/doctor.sh` — diagnostic script powering both slash commands.
- `scripts/prewarm.sh` + `hooks/hooks.json` — `SessionStart` hook that pre-warms the npx cache so the first MCP-tool call doesn't pay 5–15s of npm download.

### Design

The plugin is intentionally **a thin harness, not a knowledge base**. Token-type-specific instructions live in the SDK at `bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts` and are surfaced to Claude on demand via `bitbadges-cli skills <id>`, the `get_skill_instructions` MCP tool, and the Gitbook pages at https://docs.bitbadges.io/x-tokenization/examples/skills/. The plugin's job is to teach Claude where to find them and how to compose them — not to ship 22 routing wrappers that just point at the same content.
