---
description: Sign and broadcast a BitBadges transaction. Pick the right path based on what wallet the user has — chain binary, throwaway burner, browser bridge, or programmatic signer. Defaults to dry-run; live must be explicitly requested.
---

# Broadcast

This is the only skill that touches money. Treat it as on-rails, not LLM-discovered.

## Pick a path

There are five signing paths. Choose based on what the user actually has — not what's most convenient for you.

| What the user has | Use |
|---|---|
| A bb1 key in `bb keys` and a CLI workflow | **`bb deploy --with-keyring --from <key>`** — the CLI prints the equivalent `bb tx ...` command, runs it, returns the response. Best for headless scripts. |
| Same but driving the chain binary directly | **Chain binary** — `bb tx ...` |
| Just a browser wallet (Keplr, MetaMask, Phantom) | **Browser bridge** — `bb deploy --browser` |
| Want zero wallet setup for a one-shot create-collection | **Burner** — `bb deploy --burner` |
| A programmatic signer (cosmjs / ethers / viem / hardware that takes raw bytes) | **`bb deploy --gen-payload`** — produces SignDoc bytes, user signs in their own code |

If the user can't tell you which they have, ask. Don't guess. The simulator and review steps are identical regardless of path.

## Useful flag on every `deploy` path: `--wait-for-indexer`

After broadcast succeeds, the indexer is eventually-consistent — querying the new collection / dynamic store immediately can 404 for a few seconds. Add `--wait-for-indexer [timeout-ms]` (default 30000) to any `deploy` invocation to poll until the entity appears, so the next step in an agent script can rely on it. The CLI returns a `waited: { entity, id, attempts, elapsedMs, ok }` field on the response envelope.

```bash
bb deploy --burner --msg-stdin --manager bb1... \
  --wait-for-indexer
```

Skip the flag when you don't need to query the entity immediately afterwards.

## Hard requirements (universal)

- The transaction has been **simulated and reviewed** in the same session.
- The user has explicitly confirmed mainnet broadcasts in the same turn.
- A `--dry-run` was shown first whenever the path supports it.

If any are missing, stop.

## Path 1 — Chain binary (`bb tx`)

For headless agents with a bb1 key in the keyring, or hardware-wallet flows.

```bash
# Default: dry-run
bb tx <module> <action> <args> --from <key> --dry-run

# Live broadcast — only after explicit user confirmation
bb tx <module> <action> <args> --from <key> -y
```

Network flags:
- Mainnet (default): no flag
- Testnet: `--node https://rpc-testnet.bitbadges.io --chain-id bitbadges-1-testnet`

## Path 1b — CLI keyring shortcut (`bb deploy --with-keyring --from <key>`)

Same outcome as Path 1, but you stay inside the build pipeline. The CLI inspects the msg JSON, prints the equivalent `bb tx ...` command (so users see exactly what's being signed), executes it, and returns the chain response. Best when you've already piped a `build` output and don't want to context-switch:

```bash
bb build vault --name … \
  | bb deploy --with-keyring --from mykey --msg-stdin \
      --keyring-backend test --manager bb1…
```

The msg is unrestricted — works for any tokenization msg, not just create-collection.

## Path 2 — Browser bridge (`bb deploy --browser`)

For users whose wallet only lives in a browser extension (Keplr, MetaMask, Phantom, WalletConnect). The CLI opens `/sign` on bitbadges.io, the user reviews + signs in their wallet, the tx hash comes back to the terminal.

```bash
# Standard sign + broadcast
bb deploy --browser --msg-file tx.json --manager bb1...

# Sign-only (return signed tx bytes, caller broadcasts on its own schedule)
bb deploy --browser --sign-only --msg-file tx.json --manager bb1...

# Compose with build in one step
bb build vault --name X --image Y --description Z --manager bb1... \
  --backing-coin BADGE --browser
```

The page validates a 6-digit PIN against what the CLI prints, blocks signing if the connected wallet's address doesn't match `--manager`, and reuses the dashboard's full review preview (Preview / Review Items / Transferability / Permissions / Details) for collection-creation msgs. The user can disconnect/reconnect a wallet inline if the wrong one was active.

For SSH-tunneled dev (laptop browser, server-side CLI): pin a port with `--port 4849` and forward it via `ssh -L 4849:localhost:4849`.

Auth (Full Access session) flow with the same bridge:

```bash
bb auth login --browser --address bb1...
```

Pubkey is captured from the wallet's signature response — no `--public-key` to manage.

## Path 3 — Burner (`bb deploy --burner`)

For agents and one-shot scripts that just want to ship a create-collection without bringing any wallet at all. CLI generates a throwaway signer, funds it from the faucet (or manually), broadcasts once, discards. CREATE-only.

```bash
bb deploy --burner --msg-file tx.json --manager bb1...
```

`--manager` (the bb1 the user actually controls) captures lasting collection ownership. The burner's only job is paying for one broadcast.

## Path 4 — `bb deploy --gen-payload` for programmatic signers

For custom EVM wallets, ethers/viem scripts, hardware wallets that take raw SignDoc bytes, custodial signers — anything that isn't the chain binary or a browser wallet.

```bash
# Cosmos signer (cosmjs / hardware wallet)
bb build vault ... --quiet \
  | bb deploy --gen-payload --from bb1... --gas 600000

# EVM-only signer (ethers / viem on the BitBadges EVM chain)
bb deploy --gen-payload --msg-file tx.json --from 0x... --gas 600000

# Both, in one envelope
bb deploy --gen-payload --msg-file tx.json --from bb1... --with-evm-tx --gas 600000
```

Output is a self-contained JSON envelope: `signDirect.{bodyBytes, authInfoBytes, signBytes}`, `legacyAmino.{...}`, `evmTx.{to, data, value, chainId, gasLimit}`, plus pre-resolved chain id, account number, sequence, public key, fee, memo, and the broadcast endpoint URL. The caller signs the bytes locally and assembles a TxRaw to POST.

For fresh accounts where the indexer doesn't have a public key yet, derive one with:

```bash
# Lookup-only path: indexer + chain LCD
bb dev gen-pub-key --address bb1...

# Recovery path: user signs a fixed canonical message, no mnemonic needed
bb dev gen-pub-key --print-message     # prints what to sign
bb dev gen-pub-key --address bb1... --signature <base64>
```

`bb dev gen-pub-key` never asks for a mnemonic or signing material — the user signs the canonical message in their own wallet (Keplr signArbitrary, hardware wallet, air-gapped script), and the CLI iterates the secp256k1 recovery candidates to find the one matching the address.

## Failure modes (path-specific)

**Chain binary:**
- "bb: command not found" — route to `/bitbadges:setup`.
- "key not found" — list available keys, ask which to use.
- "insufficient fees" / "out of gas" — let the binary auto-estimate (`--gas auto`) and retry, or have the user bump the cap.

**Browser bridge:**
- `ERR_CONNECTION_REFUSED` on the loopback redirect → SSH-tunneled dev, the random ephemeral port isn't reachable. Use `--port 4849` and forward it.
- `Failed to upload sign payload: 401` → `BITBADGES_API_KEY_LOCAL` not set.
- "Wallet mismatch" warning → user's connected wallet doesn't match `--manager` / `--expected-address`. Click the inline Disconnect, switch wallets.
- TxModal closes without afterTx firing → the post-broadcast poll likely failed; the bridge has a 1.5s grace fallback that returns to the terminal anyway. Tx may still have landed — confirm with `tx wait <hash>` or check the chain LCD.

**Burner:**
- "faucet refused" — non-local network without faucet enabled. Use `--fund manual` and prefund the burner address.
- "insufficient balance" — sweep dust out via `bb burner sweep <selector> --to <real-address>`.

**`bb deploy --gen-payload`:**
- "Missing public key" — fresh account; run `bb dev gen-pub-key` first or pass `--public-key` explicitly.
- "Indexer fetch failed" — pass `--no-fetch` with explicit `--account-number`, `--sequence`, `--public-key`.
- "Unsupported message type" — `bb deploy --gen-payload` covers every `tokenization.Msg*` type (the output of `bb build`). Other modules (IBC, gov, custom) need to be proto-encoded by the caller.

## Hard don'ts

- Don't broadcast to mainnet without explicit user confirmation in the same turn.
- Don't broadcast a transaction that hasn't been simulated.
- Don't loop a failing broadcast more than twice — stop and report rather than chewing through fees.
- Don't ask the user for a mnemonic or signing material. The browser bridge captures pubkeys from the wallet's response. `bb dev gen-pub-key` recovers them from a signed canonical message. Neither path needs the user to expose anything.
- Don't conflate the four paths. Picking the wrong one wastes time at best and wastes funds at worst.

## Reference

- Sign Bridge full reference: https://docs.bitbadges.io/for-developers/cli/sign-bridge.html
- Auth Commands: https://docs.bitbadges.io/for-developers/cli/auth-commands.html
- Deploy Commands: https://docs.bitbadges.io/for-developers/cli/deploy-commands.html
