# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.40.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "4c2e3f58440a27f6f5f0fd8842c096f162903322b6d482eababb4f33003265e3"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "e25654d5bbbcdba0e7049088e5628a1d0a7f081e4640e55bbef526e62ed59f1d"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "0959c6278f0eda39165ff2b7fd0f703f913052864b987078d468848f0f227f74"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "9143641f1782e452a5f8d99e7bba7946562b326a8386e1c08238ee05b68989dc"
    end
  end

  def install
    bin.install "codync-host"
    # Linux: the Remote screen helper (needs the system's GStreamer and xdg-desktop-portal).
    bin.install "codync-screen" if OS.linux?
    # Linux: the computer-use driver bots act through (MIT, cua-driver.LICENSE).
    bin.install "cua-driver" if OS.linux?
  end

  def caveats
    <<~EOS
      Start the host in the background and pair your iPhone:
        codync-host install
        codync-host pair
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codync-host --version")
  end
end
