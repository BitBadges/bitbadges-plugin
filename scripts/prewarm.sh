#!/usr/bin/env bash
# Compatibility hook: inspect an installed CLI only; never install at startup.
if command -v bitbadges-cli >/dev/null 2>&1; then
  if [ -n "${DEBUG_BB_PREWARM:-}" ]; then
    bitbadges-cli --version >&2 || true
  else
    bitbadges-cli --version >/dev/null 2>&1 || true
  fi
fi
exit 0
