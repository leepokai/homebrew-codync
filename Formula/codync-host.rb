# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.19.3"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "494a4d3b593bf7c5997201fbed3e609b7c3ee56d7af136db53048aa7d01f8bf2"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "8c58324ebde8e5b4768fc0d31a876be6cc18da83e9a315ffd8660e6ee1641e77"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "f067b4dcdd8dbdb421c32ec07bf06b927f33dc38ab2f7488da02fb8f85a06006"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "f204899fe7aab678fa01933ebff5b3d7f6f49de0d3a19d32f6e65c274474643f"
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
