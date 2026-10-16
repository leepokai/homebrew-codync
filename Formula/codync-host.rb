# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.17.3"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "aa81ecd17b6be5af3fce087a1e6ea70dfe092036a24d471c2a3fa09763f6c915"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "b0ea4f0290e944f8e6c16617689b1b16a89254fb62a358f826c7b806c9e14fd7"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "1aafba1c80026dff49af1efb81340f7e67bd04a1cc47dd2fedecada2a97b9add"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "9bcbb8c1b0261d1a505ab5d492097a4f83c6b14ec1c7815ab391815a81e8af4c"
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
