# TrustBeat Homebrew tap

Homebrew formulae for [TrustBeat](https://trustbeat.eu/en) — digital trust
infrastructure for the EU.

```bash
brew install trustbeat/tap/trustbeat
```

Or tap once and install by name:

```bash
brew tap trustbeat/tap
brew install trustbeat
```

## What's here

| Formula | Description |
|---|---|
| `trustbeat` | CLI that anchors files to qualified eIDAS timestamps and verifies the proofs offline |

## Verifying what you installed

The formula installs the prebuilt binary from the
[trustbeat-cli release](https://github.com/TrustBeat/trustbeat-cli/releases),
and Homebrew checks its SHA-256 against the value pinned in the formula. Those
same artifacts are anchored with a qualified timestamp by the release workflow,
so the binary Homebrew puts on your machine is the one that was timestamped.

`trustbeat verify` itself never needs a network connection or an API key.

## Source

The formulae are maintained in the TrustBeat monorepo and mirrored here — open
issues and pull requests against
[TrustBeat/trustbeat-cli](https://github.com/TrustBeat/trustbeat-cli).
