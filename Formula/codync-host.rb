# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.49.3"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "f4000b5127eab86a18ecf0abd4088cd25dad551ad1e741a1869f8079adb733cd"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "24c9ca84ae6d0f0107963020c6d13e3563c83017eb30067ee0a03c5259c70d48"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "b74b4828b76f6e140924f6c0e2e6a99e2483d4daccf675117bbab9dfb8333798"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "0943a61c4800d877a56af5987f0e914ef367fbfb90f665d7b4b07748895d12b7"
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
