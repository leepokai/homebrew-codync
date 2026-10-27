# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.30.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "65ca217e2320222f9ca5cfdd42ed34ed3b7eb138041f5083621acce216cfd07e"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "fd508efafdb6e5473768a44a1ad08690092555b7932c5901504f51bc84a72df7"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "18ecffbefd2bd3a97c7e86909c5ebe9ed6a2a9d0f319a3aa484239daf444e7f5"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "7e24c79a73fcd56d7a4bb52bb26ce2c2c65fa8af42c44d943459f805465586b0"
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
