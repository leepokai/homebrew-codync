# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.34.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "ec8f424a95755651d1598611a0d7e12a5e367fbed976852ea42a23b8af44ca96"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "91db5ec10ab33a6177ffebae76506680cf3b5dd9ae1cc410a5fd9f390a470c50"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "496b0305dbbd7cacc380a9523967c4d328a3922d95a93e6e6f9ff53edd742951"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "27828d73adab7bd9c40f128efacc133a2d191d28f606e4e87e127cc4d182085d"
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
