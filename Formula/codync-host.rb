# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.7.1"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "d26a8095af5f7a9709638e45da753005ed5395cbeebaea027aa4e7bd3445be43"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "3c72901dffed99b4536d85b21dbd451599f5bcca5b83a1574cb8fbe42fcd8e47"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "50b94db74676428be2414d7f2b3c3bf59c64b32378fbea1eaaebb7fa921d1010"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "c00e0a883e5a2920377e2e3116d8d52c606ce51e6bd9b6bbbebd98f90750626b"
    end
  end

  def install
    bin.install "codync-host"
    # Linux: the Remote screen helper (needs the system's GStreamer and xdg-desktop-portal).
    bin.install "codync-screen" if OS.linux?
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
