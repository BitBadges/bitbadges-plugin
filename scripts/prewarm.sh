#!/usr/bin/env bash
# Pre-warm the npx cache for the bitbadges package so the first MCP-tool
# call doesn't pay 5–15s of npm download. Runs from a SessionStart hook.
#
# This is best-effort: if npx isn't on PATH or the network is offline,
# we exit 0 silently — the cold start is at most "first MCP call is slow",
# not "plugin broken".
#
# Output is suppressed unless DEBUG_BB_PREWARM is set, since SessionStart
# hooks shouldn't chatter.

if ! command -v npx >/dev/null 2>&1; then
  exit 0
fi

if [ -n "${DEBUG_BB_PREWARM:-}" ]; then
  npx -y -p bitbadges bitbadges --version
else
  npx -y -p bitbadges bitbadges --version >/dev/null 2>&1 || true
fi

exit 0
