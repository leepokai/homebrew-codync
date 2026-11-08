# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.42.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "45479ddb9144cfb75230c13640c86a9d746cc0a8fdbf61978d9631bcad8afa63"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "4b4fea775855577b34b41816cf19f9a62a9488aea8aa7fc1e66440bba6adcb53"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "0434aa2a5c282e1ea40d2abbfcb32a79f26dcfcbbb001f90699cee6ad1422a5f"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "abca2fb6787b39dabf78a59c37e0fc4fde72f22395726d33fc8a1dbc34943ad1"
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
