# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.39.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "257aceac88e7129ed4dd9a28362b7de5ec4e564f6a1da07f71442c2e0ff271ed"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5c2e34605f6596b9169e11562254734f80da66106a7e978c5f5ddebefbd68ff7"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "9749eb93dfee994c4eca19986f713f76df9d8ae6e3ad54b57106b3b633e2fdaf"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "ef982263f0c3b87a081ad4e3b303e854c1a72864727e19d15a2abf68846b29a3"
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
