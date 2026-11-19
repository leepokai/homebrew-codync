# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.50.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "070cd93d56f70c8fcfffcc0c6549c1556bef4209067c3d00b5c77fbf9478c97e"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "08cdf75165818c47625729bb308dd3ce05e009e00671e816dcbaf2484351e53b"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "4bcd2b7e49589e44b797c0f9605ee2f78210a3169904c7e6b46afb3470ccc5ca"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "07ab7b34eddf69b031551947dbb3a5c136276ba5de4aea1db4bde6d188e89c45"
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
