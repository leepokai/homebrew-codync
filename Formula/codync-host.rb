# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.22.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "62e1cb57806e495275ec14a26b4418a06568e317ca7e2603c0a7120fd6e9dabc"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "bb8414867aa4365dd61f2e65345a37369d9c45250e7dfb29c65ed98e722cf29c"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "9a43a2c7da56f9df979a9af576f010fc751b7a4994c848df51b351a5162cda85"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "f82e4c6aa169512c28a73f67e5c2cb84e08f3e235a6e456fd1ef1d55b697d135"
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
