# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.13.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "7e4867e696e3a99fe4cddbe2fce7ef2e1fab802681943d91aee2d466b1e75445"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f31c7db1f12bc5e74bf1cc9719edbda843f45304fbdf7b42d349047a6a6a3435"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "50c9e944b38af0e27a1246edf9e98ff647aedeef1789acbaed85c0db67f39581"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "47fefb9a8946726d511d4855a9f02d0f5d612e9c31d6a8518f09049f6c509531"
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
