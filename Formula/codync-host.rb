# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.22.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "581de0e3a2119ef5be92c997bd49ee051c172a99fa9ecd908ada15962b8a8f6c"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "8b57ce44ea3caac292d6bfd50b208a755dbbc120dbee05d54f86442a57e19b0e"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "8481480ac08e90e597b177a94e6e29665cbf9f90c41847076f449c84cb44d0ad"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "e3dc211ca464bcd3b72df0d26921753d991bee73a3eb346c1a3d3c9bce12c90b"
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
