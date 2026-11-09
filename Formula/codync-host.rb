# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.42.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "3bc9724609085698b25b1dcbd6e38c0df3a5cda65cfd2ea20e4bb25d68062e93"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "708e0a0d3ac0179e5304194cbbf5231de0978a372b5b3fd45d3142d5da72c239"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "759c0dad4fd5915b379aead4b7cb93b1c7a2838e74f473b6a4cab2e0169b2f68"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "2b7ae284ad4c998f4ef70a76709ccdf37840a160a037b34afed4410b5e9cd1a6"
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
