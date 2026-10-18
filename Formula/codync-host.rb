# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.18.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "64c9ff7d9ef761072f2cb00b84319782e1f2323404c165e41e4ed7e18eb50fe6"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "e6dee714e5e411f1c74d390aaf3410e15396f1ff3ca5a0b1f580cde0458a3fad"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "290b683187bba25e1153b99e8902d5cd1666d46b3f763a64be159ba90144bf92"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "75a0738dcf50ae0df6649ad128219c77c1d8657a638c9823c1debec50da61e50"
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
