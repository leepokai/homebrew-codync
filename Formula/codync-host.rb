# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.26.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "f88d56ec982c937e0d8899a7bc5d9f1988ca2e7432987d55f875c4ad67578f21"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "6b6cbf9f3fdd9c74192ae426f9620359867b2a7b38727ce642c7a64f918083ef"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "daa728a7d215ff924f82c29ed309819cc3934c2baf9072aeec5f0b1f63e8d035"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "be6b039239cf4c50c8f27a7488cf3eff629f59c5efcbd45910edae11e997dcf5"
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
