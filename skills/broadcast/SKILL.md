---
description: Sign and broadcast a BitBadges transaction. Requires the chain binary and a key. Defaults to dry-run; --live must be explicitly requested.
---

# Broadcast

This is the only skill that touches money. Treat it as on-rails, not LLM-discovered.

## Hard requirements

- `bitbadgeschaind` is installed locally (`bb-doctor` will tell you).
- A key is configured (`bitbadgeschaind keys list`).
- The transaction has been **simulated and reviewed** in the same session.

If any of those is missing, stop and route to `/bitbadges:setup` or the relevant skill.

## Default: dry-run

```bash
bitbadgeschaind tx <module> <action> <args> --from <key> --dry-run
```

Always dry-run first. Show the user the simulator output. Wait for explicit "yes, broadcast for real" before going live.

## Live broadcast (explicit user confirmation required)

```bash
bitbadgeschaind tx <module> <action> <args> --from <key> -y
```

Network flags:
- Mainnet (default): no flag
- Testnet: `--node https://rpc-testnet.bitbadges.io --chain-id bitbadges-1-testnet`

(Or use `bitbadges-cli`'s `--testnet` flag and the equivalent JSON-RPC route if not using the chain binary directly.)

## Failure modes

- "bitbadgeschaind: command not found" — route to `/bitbadges:setup`.
- "key not found" — list available keys and ask the user which one to use.
- "insufficient fees" — chain binary will print the required minimum; bump and retry.
- "out of gas" — let the binary auto-estimate (`--gas auto`) and retry, or have the user set a higher cap.

## Hard don'ts

- Don't broadcast to mainnet without explicit user confirmation in the same turn.
- Don't broadcast a transaction that hasn't been simulated.
- Don't loop a failing broadcast more than twice — stop and report rather than chewing through fees.
- Don't expose mnemonic, private key, or unsigned transaction body to the user as casual log output.
