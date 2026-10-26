# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.29.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "2a0c30bf654f1d0b57385523f7928f208a9a3df8e074970cf930c3b241881632"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "2f1683a410464b6e3f89acfb6c66342088f089a772770ed50df2e968fc0acb58"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "17fd9cc725aba8ad31b372ca5989266ef98ed6f8a2190db2b405c4349de379cf"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "cc9cec0b4669eba386e405f43a9fbb46e791cb44a80310a9cbfc1f1d14da0e2e"
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
