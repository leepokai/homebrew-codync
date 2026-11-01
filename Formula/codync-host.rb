# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.34.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "6951e2658c1c29c6ed6eb4772dec540c66e96ffdc40383a5012b8c91c4300461"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "dd428a865de06b37ab759e1d922487a0cc7a40ac80d5ed1c8b026961de4d3216"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "5c36a6103d18547121489ff965ffb358b596a1770c9ae5f6d8e0f58034f22d8d"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "74a438f1dcd082d15f79b618c91d1901668590814dccdfaf0f31d38c55461afb"
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
