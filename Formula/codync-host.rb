# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.20.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "0eced32dc4bdb56cd8cece62eabaffeacfae4d6a2678d9b1d04556053d328484"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "d4a6bcc47f17534944947e3cf010a2468b720c9b9ff8bce3609ae8691ca4339a"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "8982ac95ca92aa1f121dbd0455568dfc4f6c20543ad663407da2de1cd91af7c0"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "f5442dbb457c726260704018ad5286733bdd8aeb3ad22ece5041a6527425238a"
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
