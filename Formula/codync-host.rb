# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.13.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "7c59d120f81b5bd582ec1340cbf775d390a2fb434d8d47d7104887e4a2e9d621"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "0a0d642f2119f4b5362f5330c78c92dac5c512970643884c36c35bcbe46251c9"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "39449983897d520f00c62ceaf911cbd435fc04a317cfef23cacfa59eb6e133b3"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "422d342f1369f0a9ebf3943ff2e5a8b5aba0382809d10d211daae289d3b320a4"
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
