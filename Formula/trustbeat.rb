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
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.2/trustbeat-0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "b511afe5a1e93b169f426977b435018b6a83b6dd7e41bb29fb7d78d29371cb53"
    end

    on_intel do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.2/trustbeat-0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "4860f1834491bc87a148be42072c167bff90f4fec35093a67c85c9790ee6dd95"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.2/trustbeat-0.2.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9e05405ae6d9f25fcda29a457559a96e353cd6206c9520e90e58d535d81484d3"
    end

    on_intel do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.2/trustbeat-0.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e365d6ce4b740310fbb89a4cd7a7e2262b9b50384c0ee5c55994e3bf74936f66"
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
