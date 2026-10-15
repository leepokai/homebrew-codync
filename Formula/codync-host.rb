# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.17.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "e33b6e00089bd2edc52416cc6dc069eb0e933f657829be39cd690b623eccd59f"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "6d64c93559f1c29d2a6be508f8ff7b6a48d4f9eb08fb2b44f9a482518428a631"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "c0d4165fbd03cf91790b90ad0fa3d7c2bbcacb3c9f233a7f4ce52145aceca013"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "3c5346d2e8365620d29adbcabc2c9271c31a14dc69f9224d47d1a597c4f6cef2"
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
