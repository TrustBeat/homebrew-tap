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
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.1.1/trustbeat-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "257ff89802be6a1bc7f6290f18fb3cad0c1396c9f81bfbdf19767233c301617f"
    end

    on_intel do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.1.1/trustbeat-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "2200b5bf6b373ad981bf10b27939780307f29d7c9e321163640c5ef46259acc5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.1.1/trustbeat-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e078a0711d059d6b96500930621b61b7063a74fbe5290e8c0cea10c8bbb0459f"
    end

    on_intel do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.1.1/trustbeat-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "694d6014be3dfd6d38923f3a87755a1619db8d565a4598891687dc37f9566644"
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
