#!/usr/bin/env bash
set -euo pipefail

# Keep diagnostics and JSON encoding in the installed CLI.
if [ "${1:-}" = "--json" ]; then
  shift
fi
if command -v bitbadges-cli >/dev/null 2>&1; then
  exec bitbadges-cli doctor "$@"
fi
printf '%s\n' '{"ok":false,"data":null,"warnings":[],"error":{"code":"cli_not_installed","message":"Install the BitBadges CLI and ensure bitbadges-cli is on PATH."},"hint":"Run /bitbadges:setup."}'
exit 1
