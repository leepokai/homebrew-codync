# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.33.4"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "8ccb5b7e765f49d32de30bbbbe06a3cc5e61c8a7be3611bf4c1584c049e4a63c"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "661c97305090de6ff63c7bee161505818793e1bf2a3caa6a73b358612a7a34ab"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "2e8f49f3bd39e2affeb739e94f1e1caeaaefec1f68d57d5381e662c6bdf5d0e1"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "3e1885ad83c8cc2964462111da83615f070f5afbd0334c015d1727586d8cd972"
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
