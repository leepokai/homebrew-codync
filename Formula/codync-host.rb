# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.23.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "692e73fde6404803a60e2a63f382ef6d83e52cc04596f5ae0d6d343bf402bc93"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f511c53c43bfb21123cc0afaa2edcafd023a1b453a11fd49d8e869dff99d04ef"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "e45f85ef6bc45e858dbb1d035877fe39c9896075781216fed3d7ecac9f1f6bdc"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "39755f83369fb75300d90958302edb38532ec7eeff685c670714405a6cbf1d53"
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
