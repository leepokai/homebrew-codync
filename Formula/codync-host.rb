# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.21.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "7caae07552f64d1297f1be3d87286c63edc61f0bc097d0c24843c7918e490185"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "3685a0e9e0e59717a530d364ba86c8afb9a1629c73dbec8121002483a26f3078"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "17e38b2acaf53e4d166fa5a78c5679ef1bdfca77994cb39f82aaf0c631167468"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "686060787fd34056e1f662318f4b4bbf10846e98060cd14c386d21f1833f3def"
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
