# Homebrew formula for the TrustBeat CLI.
#
# This installs the prebuilt binary from the trustbeat-cli GitHub Release
# rather than building from source — the release artifacts are the ones the
# publish workflow anchors with a qualified timestamp, so what Homebrew
# installs is exactly what was timestamped.
#
# On a new release, bump `version` and replace all four sha256 values with the
# ones from that release's SHA256SUMS asset. Linux uses the -gnu builds, since
# Homebrew on Linux runs against glibc; the fully static musl build is on the
# Releases page for containers.
class Trustbeat < Formula
  desc "Anchor files to qualified eIDAS timestamps and verify proofs offline"
  homepage "https://trustbeat.eu/en"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.1/trustbeat-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "0b2c3f56ff6361cebe645e44faeae8f3504e0a700e4dbc625bd4cb282f5923c4"
    end

    on_intel do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.1/trustbeat-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "e22c5b32a28d073ecc5d755451943cc9e511a24da313e00b6a45b7a8c99f253c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.1/trustbeat-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "342d7211da4f3e56f0366a7b4da056158c43c6695add6dc4668dd0653d067b45"
    end

    on_intel do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.1/trustbeat-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "653eda1a021f3bcd47cc0ed025f0fab650ef82b78c09b78bd67aaab19c064125"
    end
  end

  def install
    bin.install "trustbeat"
    doc.install "README.md"
  end

  test do
    assert_match "trustbeat #{version}", shell_output("#{bin}/trustbeat --version")

    # `hash` is pure local SHA-256 — no network, no API key — so it is a real
    # end-to-end check of the installed binary rather than a smoke test.
    (testpath/"sample.txt").write "trustbeat"
    assert_match "09cd68cebed152f7ad16af79107c21f95b3588c05b6076a739edfaebf85346a5",
                 shell_output("#{bin}/trustbeat hash #{testpath}/sample.txt")

    # A malformed proof must be a usage error (exit 2), never a silent pass.
    (testpath/"bad.json").write "{"
    shell_output("#{bin}/trustbeat verify #{testpath}/bad.json", 2)
  end
end
