# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.38.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "ca60ba73bac738bf89ae7ebc85a419786397258efd5debca6fbccebfed43fcfe"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "6d0246f2734028ed389e531b516fce94d0afbe373de569898e0cef2af66436f8"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "a6eded337c73f9ece74f545c496d41ca2b627edc2b52dc7e83131307291fa2d7"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "43e35d8a050801b457a0515ec9d704392b171286f5b5305c2e7989bf46870168"
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
