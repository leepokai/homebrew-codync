# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.12.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "b26045dd7b165977c4a81aabec2e23640b2574141ca7a6c5ce72714b58ded7b2"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "7609131e8cf84c78c81f9719482a1736246b554006c7f12e8e0468de6cff585c"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "7246b55cda89bb3acde77459b2bc930a6a20f9a2fda3750996f7fe23e821f1a9"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "a0ebbe738459bd2df0b476eb68ae62f56db2cd096c8a23ad6e9453a436c104e8"
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
