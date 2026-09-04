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
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.0/trustbeat-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "c8ac73166f7827bfe36b4732b6acf8c3de80aa84a9309c4f3c05a07c84fbb937"
    end

    on_intel do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.0/trustbeat-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "8b403f1ed13b3e1d058f06c53857d10f351d8877a6400f69c31480cfab830bf5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.0/trustbeat-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5a2436643b3e8af1b4faa7502b8bff8e3d927841bc33008d0172b70ddd73f037"
    end

    on_intel do
      url "https://github.com/TrustBeat/trustbeat-cli/releases/download/v0.2.0/trustbeat-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d5d32791e89c82cce78e95ad905abc1b916016ed142fa8122ab83bfde1935f19"
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
