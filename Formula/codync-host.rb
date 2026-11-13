# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.46.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "3258ea95e2d13281fc763a1e4703fd14f87cccc6b4a0105fc4bd7309946881dd"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "cdad908bf41d865d9bc5a9ca6a5f76dba8f71fa172fe9d3765c15d1587069f67"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "d4fbab5a68d030374a751bf08109a3c2ff05206b1aeb9aaa49bcef5c08c4fa75"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "3d1bf4a486d56280acfd78195a05f6b53271d3ad235fa81f1b88649a3175f43e"
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
