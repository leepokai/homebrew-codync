# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.15.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "90395b38b38ceae0dd79ca58d875249df186442347851d4f36fa51dac700f393"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "af7d0a0914fc56c03a20667a6f1db71bfaf38dfcefd85b79dbd8d70c24e6285d"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "e6e1930a35bee7165c01056bd1816762defaa8b518a6390b4106bd9aeddb1358"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "b98eb89ac80f4c969a733d184b3dc4d2d988c39647d64e39ca52431edfcf3198"
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
