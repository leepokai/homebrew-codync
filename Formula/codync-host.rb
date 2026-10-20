# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.20.3"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "4369b1c7677f6137b0050ac47734a63dcac8bcc2a97b03b78170d25004106c95"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "1226a4616432a3ae11be51c04c46284478613ad92ed3b0d7ea265a236b29d64c"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "e599dc41eed1c4cc1a27c3a323569328a742d71c45410a34a2a0018588a06795"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "c112b0905fd6da14e0288c05417095617235e447c3d0e56881ab1d7105fec50c"
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
