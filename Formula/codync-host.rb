# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.11.3"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "2439c21a0dfd1e0fed0328c81484fcdeb4052490bea63837417e890887901fbf"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "461814975e63ce9ead1ca2786cc823be49d07f1377ce0007a596db07ad74746e"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "9d417d93b63787d6d2668182456aed196ebca6535453ec265664ad8a62836b27"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "e63485790637f07e6bd7d38ea2f355fe37ae743ecfee902daa7b69f6b2172b60"
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
