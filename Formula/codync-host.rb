# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.25.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "8e11edc0571551228969d31c8cde4e0e7829f9ba18727d19e5d0e0486b27507b"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "088edde32c7b8cdb81dbf0e47e4f37e00565c7455d087dfae14db8fd4b3be471"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "bdd90c929d779b2bb941b1ada992c259d980bc9ccdc0f4276a94d09747436ea9"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "82ebd28bdc5fdb1aa220d4e33b6315b0a8838a8018e6352ede0fa7df50aff001"
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
