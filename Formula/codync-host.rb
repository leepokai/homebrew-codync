# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.19.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "a7fb0894c15fa656bfef4fbf24d78acd36b75ac9cedb50d52ed70f9345caa351"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "40ed6d00889d3608d4e9c28f6ae1618f5312a6286773ce42e5b5b305b01a1e38"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "019a5fd2be26bdeac226c4524febd29e60692619642c1a5c17fc90cea0b6cd62"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "0f2a78aed8455c731070e7575e892cfce7219ff181bf1be6cb5f42e44bf01d03"
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
