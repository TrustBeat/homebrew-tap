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

## Beyond the CLI

The CLI anchors files. The same qualified-timestamp infrastructure also backs:

| | |
|---|---|
| [Tamper-Evident Logs](https://trustbeat.eu/en/products/tamper-evident-logs) | Sealed log trails for NIS2 Article 21 |
| [AI Decision Anchoring](https://trustbeat.eu/en/products/ai-decision-anchoring) | Provable records of model decisions |
| [Audit Trail](https://trustbeat.eu/en/products/audit-trail) | Append-only, independently verifiable event history |
| [EU Digital Identity](https://trustbeat.eu/en/products/eu-digital-identity) | EUDI Wallet / eIDAS 2 credential verification |
| [Signature Verification](https://trustbeat.eu/en/verify-signature) | Full qualified-status assessment against the EU Trusted List |

Prefer a library? Python, TypeScript, Java, C# and Go SDKs:
**[trustbeat.eu/en/sdks](https://trustbeat.eu/en/sdks)**.

Free tier — 100 anchors a month, no card:
**[trustbeat.eu/en/pricing](https://trustbeat.eu/en/pricing)**.

## Source

The formulae are maintained in the TrustBeat monorepo and mirrored here — open
issues and pull requests against
[TrustBeat/trustbeat-cli](https://github.com/TrustBeat/trustbeat-cli).
