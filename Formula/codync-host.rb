# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.41.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "fbd9db857e724a997f41451cd48a5477f8856082edf1b934523bc7d207cd2f0f"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5c64107825d70089b5dfc89dac993d4755cc6d423bccdadb0d9dfbec4f026b03"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "223d8e35ba88bdc2bd0ba91117ec9788ac48a363e7c381e2eeb3226b5079271c"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "b3a114597d6c5d218ca1a08b25689a770fde9793c84a05bb4a89d896b2e0c8cb"
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
