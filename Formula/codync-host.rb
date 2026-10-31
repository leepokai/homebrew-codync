# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.33.3"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "d6e9cb0faf9cbbf61e37f4123066a047840a7a6003769538098f8c7fb5971ce4"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "52ef291798eb4ad3facb75f1a8958e905bada41577afc63347a15c9d99955714"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "9b2897b28d826507e5c28f975c83950774a1a528a38c6da78d1b0b57dc27912a"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "22a6d89e3970cbdb67e7a6356236b6fe6872c43b82e40b792096bcdf0e6d830e"
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
