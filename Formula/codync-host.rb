# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.44.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "2861579cd25477b2b781883cba53f8d7cb3dc8d7b640d87e250d59606f22a30b"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "738b5b983d5d9fb038b6fbed32e5d4fae166beb2c3cca62a171dd683efe5cbb8"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "56b9700cabc5d220c9725b78dd78767142bcbffe52b0b6ba31f4192599a89c71"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "ca91774a21c3bf75519a9884e10fb5275f4956428f8a6ea87a850be069e25be5"
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
