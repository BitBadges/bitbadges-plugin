---
description: Convert, validate, or derive BitBadges addresses — cosmos↔EVM conversion, IBC backing, wrapper, mint-escrow, alias address derivations.
---

# Address

BitBadges runs on a Cosmos chain with EVM compatibility, so addresses come in two formats and several derived forms. This skill anchors all six common operations so the user doesn't get them wrong.

## Conversion

```bash
bb account convert <address> --to <bb1|0x>
bb account validate <address>
```

`bb1...` ↔ `0x...` re-encodes the same address bytes. It does not prove that a wallet controls that address; key derivation and signing mode still matter. The CLI handles the encoding.

## Derived addresses

| Need | Command |
|---|---|
| Backing address for an IBC denom (smart-token deposits) | `bb account alias for-ibc-backing <denom>` |
| Wrapper address for a wrapped denom | `bb account alias for-wrapper <denom>` |
| Mint-escrow address for a collection | `bb account alias for-mint-escrow <collection-id>` |

These are protocol-controlled addresses with auto-set approvals. Don't try to write to them directly — use the corresponding flow (IBC backing, mint, etc.).

## Failure modes

- "Address is not bech32-valid" — likely a typo or wrong prefix; bb1 = BitBadges, cosmos1 = generic Cosmos.
- Derived addresses are computed locally. Derivation does not prove that a collection, backing pool, or wrapper exists; query its current state separately.

## Don't

- Don't compute address derivations by hand. The CLI is the source of truth.
- Don't confuse `bb1...` with `cosmos1...` — they are different chains.
