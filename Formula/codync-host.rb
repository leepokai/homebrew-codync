# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.41.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "e6c1f7588d2c2ff5be4027e5798d447231099736dd12673b69097b6eaf194c78"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "bc0a1009869fa4b8b06cdcc6e1372264f4ce20aff00bd750ec40f6bb50d809b1"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "62277e634e594024610e1061215d2110b013a76459d9a38a2d1dd07ab472e5dd"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "1a75df09d72a01128290a80b9e98dbe25861f1760bc0c8e95b5e37c6d3ac5a5d"
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
