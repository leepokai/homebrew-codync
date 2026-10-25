# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.26.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "d4ea52d3a5c1500490d2f39e985827359ae89bc7f2456528bde0e981e90505b7"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "89e29c98f30ccbf828c94bc7038156a7e408c5bc4339e07543513bb22c2068b2"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "c9c57738c58434d94ace27c8bf593ee8fd1ff8497c28a3ecac9432e8f8f89e3b"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "0e77cd045a85450520a666dec692a945dec20b540cb4142627f2b8a16270865a"
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
