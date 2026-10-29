# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.32.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "29cb0b1285a35cd27e5a530bdb25c083d2332ff426cfffc3620d6be6387c48d6"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "55830aaf84f6958ffdbd4d7a1edf142b45e3c8cb9abca6f04f2da6bda36e7654"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "24e6185404a5d6ccd5dafe68420f54a4eafd896b1cf36b2337a9acdcd77a7a7b"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "aaf7b63a8ad35f856d08977a3584e09e7e66fca77e6f6f389a040524c0c9484a"
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
