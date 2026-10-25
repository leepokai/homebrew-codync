# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.27.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "1967b334efceb7c2737169f3274ccdad5e04853bd8c7fe8f06c4031e79864f92"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "0de36cdf95a5ab59e0560fe956fde72036ade498a832e54f0534e4a587e13494"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "7b1b4d861ee59efce1a744e34952243e15609a99e3d3b3e638102d833f4afc90"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "03ee67a55204e81e41a00b4bf88286ba4eb5ca7097faa9367b47e1fdbb3db1cb"
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
