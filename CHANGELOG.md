# Changelog

All notable changes to the BitBadges Claude Code plugin will be documented in this file.

## [Unreleased]

### Added
- Initial scaffolding: plugin manifest, MCP server registration, README, LICENSE.
- 22 generated SKILL.md files (one per SDK `SKILL_INSTRUCTIONS` id), produced by the SDK's `gen-llm-mirrors` generator. Source of truth stays in `bitbadgesjs-sdk/src/builder/resources/skillInstructions.ts`.
- 7 hand-written operational skills: `review`, `simulate`, `explain`, `query`, `address`, `claim`, `broadcast`.
- 2 slash commands: `/bitbadges:setup`, `/bitbadges:status`.
- `bitbadges-builder` subagent definition for focused builder loops.
- `scripts/doctor.sh` — diagnostic script powering both slash commands.
- `scripts/prewarm.sh` + `hooks/hooks.json` — `SessionStart` hook that pre-warms the npx cache so the first MCP-tool call doesn't pay 5–15s of npm download.
