#!/usr/bin/env bash
# BitBadges plugin doctor — environment diagnostics for /bitbadges:setup and /bitbadges:status.
#
# Usage:
#   ./doctor.sh           Human-readable output
#   ./doctor.sh --json    Machine-readable JSON
#
# Exits 0 if all critical checks pass, 1 otherwise. "Critical" = JS CLI reachable
# and API key present. The chain binary is optional — most CC workflows don't
# need it.

set -e

OUTPUT_JSON=0
if [ "${1:-}" = "--json" ]; then
  OUTPUT_JSON=1
fi

# --- Detection ---

chaind_path=""
chaind_version=""
if command -v bitbadgeschaind >/dev/null 2>&1; then
  chaind_path="$(command -v bitbadgeschaind)"
  chaind_version="$(bitbadgeschaind version 2>&1 | head -1 || echo unknown)"
fi

cli_path=""
cli_version=""
if command -v bitbadges-cli >/dev/null 2>&1; then
  cli_path="$(command -v bitbadges-cli)"
  cli_version="$(bitbadges-cli --version 2>/dev/null || echo unknown)"
elif command -v npx >/dev/null 2>&1; then
  # The plugin uses npx -y -p bitbadges; check that path works too.
  cli_version="$(npx -y -p bitbadges bitbadges --version 2>/dev/null | tail -1 || echo unreachable)"
  if [ "$cli_version" != "unreachable" ]; then
    cli_path="(via npx)"
  fi
fi

api_key_set="no"
api_key_source=""
if [ -f "$HOME/.bitbadges/config.json" ]; then
  if grep -q '"apiKey"' "$HOME/.bitbadges/config.json" 2>/dev/null; then
    api_key_set="yes"
    api_key_source="$HOME/.bitbadges/config.json"
  fi
fi
if [ -n "${BITBADGES_API_KEY:-}" ]; then
  api_key_set="yes"
  api_key_source="${api_key_source:+$api_key_source + }BITBADGES_API_KEY env"
fi

# Network: env var beats CLI config beats default.
network="${BITBADGES_NETWORK:-}"
if [ -z "$network" ] && [ -f "$HOME/.bitbadges/config.json" ]; then
  network="$(grep -oE '"network":[[:space:]]*"[^"]*"' "$HOME/.bitbadges/config.json" 2>/dev/null | sed 's/.*"\([^"]*\)"/\1/' | head -1)"
fi
network="${network:-mainnet}"

# API connectivity (only attempt if we have a CLI path).
api_status="skipped (no CLI)"
if [ -n "$cli_path" ] && [ "$api_key_set" = "yes" ]; then
  if [ "$cli_path" = "(via npx)" ]; then
    api_status="$(npx -y -p bitbadges bitbadges sdk status 2>&1 | tail -1 || echo error)"
  else
    api_status="$(bitbadges-cli sdk status 2>&1 | tail -1 || echo error)"
  fi
fi

# Critical = CLI reachable + API key set.
critical_ok="yes"
[ -z "$cli_path" ] && critical_ok="no"
[ "$api_key_set" = "no" ] && critical_ok="no"

# --- Output ---

if [ "$OUTPUT_JSON" -eq 1 ]; then
  cat <<EOF
{
  "chain_binary": { "installed": $([ -n "$chaind_path" ] && echo true || echo false), "path": "${chaind_path}", "version": "${chaind_version}" },
  "cli": { "installed": $([ -n "$cli_path" ] && echo true || echo false), "path": "${cli_path}", "version": "${cli_version}" },
  "api_key": { "set": $([ "$api_key_set" = "yes" ] && echo true || echo false), "source": "${api_key_source}" },
  "network": "${network}",
  "api_status": "${api_status}",
  "critical_ok": $([ "$critical_ok" = "yes" ] && echo true || echo false)
}
EOF
else
  echo "BitBadges plugin status"
  echo "----------------------"
  if [ -n "$chaind_path" ]; then
    echo "  chain binary  : $chaind_version"
    echo "                  ($chaind_path)"
  else
    echo "  chain binary  : not installed (run /bitbadges:setup if you need to broadcast locally)"
  fi
  if [ -n "$cli_path" ]; then
    echo "  CLI           : $cli_version"
    if [ "$cli_path" != "(via npx)" ]; then
      echo "                  ($cli_path)"
    else
      echo "                  (via npx, no global install)"
    fi
  else
    echo "  CLI           : unreachable (run /bitbadges:setup)"
  fi
  echo "  API key       : $api_key_set${api_key_source:+ ($api_key_source)}"
  echo "  network       : $network"
  echo "  API status    : $api_status"
  echo ""
  if [ "$critical_ok" = "yes" ]; then
    echo "Ready to go."
    exit 0
  else
    echo "Some critical checks failed. Run /bitbadges:setup."
    exit 1
  fi
fi
