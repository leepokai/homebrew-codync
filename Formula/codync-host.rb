# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.34.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "d9a16230257ffe70071d6a792ff5dc366d0801c64c878b8370d0c83bbb45f1c8"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "3b5325ba9849d4f76d820461d098aaf9cf9c965fa2c8fe10eff7820b1d159865"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "fe6b2f67df7d23582fd8892d5fe41e5e609262ecde82c7eac67071aff5869814"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "d951e1cbbf562abc9e8de7f74bc5f33db6d94c44506e923a1173ce4eaaa06695"
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
