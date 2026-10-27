# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.31.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "5788cc05708d33dfc317c4a8abb486507ae932cc18abe08ce6a75688444b9a9a"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f3c99192d5d25491cf25d270520f68fa1d713a8acaf4131eafa827ba56dd4128"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "5131ee887f2bbf19f55547a23186830b9da81ad2a9480738b1ff468f9ee22647"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "6677f24fb5430a081b3dae1c0fe304562732218ccba76e2b139e571b1f8bb8b5"
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
