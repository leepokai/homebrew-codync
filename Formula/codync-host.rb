# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.47.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "a91a5ea1ed3da790ac05b51ca6516f8f49618832ba79fb46c0dbbfda0744bd47"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "6c8bd73b79b65dfaef9236960fc773187b3be381b8c586cb0ec9f1bbea6fcae7"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "08aea13a50b351628fdd8ee3498c3c5ea04dcc0c263842b77c387da9e1471038"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "cf7ff88f8bb71a71f80432b3600bda2737482fd3cfafcd538348ca43d69ba3da"
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
