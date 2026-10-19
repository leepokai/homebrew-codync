# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.17.5"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "d4ff57d07d006c11b930407982bdeed09aef390bc66ab03cdd6088f173773534"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "0ba5dbeab8e3bac7c088d7cd865f343a5ed81a7ab7b097d9e5ff269319d91d78"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "ba8a9ab4fdb265f53e8a8e0de64ddce4a6d09e72072d62b39c7ffee4a21061f9"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "96aa03eef265b7cdd136ecef4d725d8c0616e9ea3a710840d02e020d28e26e5f"
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
