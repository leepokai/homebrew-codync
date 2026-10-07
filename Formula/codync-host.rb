# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.10.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "e6321d4720cf10fb2c6dbcdfc1496db48b74579fa93074aab13ebf51a48c6977"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "2b877b806c90bcba875f7a21b9aed30cd74a3f862880924baa45b0fa972c118b"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "23040389ea98e6fb2bb7f4e869700434da34b144132c64013e317e52a02150fa"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "64eec5cd833cb0fa08e8338c730e3f7ec4b4b9eb7ee93298fbd124411a2e7fe4"
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
