# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.7.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "b72d32e4a1a014597f42386a15d6488d214ec498e0facba60f2bcc4920cdbfc5"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "0c137d2c81df5ed9270a7b9acdc69016f53dbcc5f7514392a96bfa23b80ef684"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "43a422632d4aab05a9b23363eb864af753c026ab9a6c2fafbf0ae637be4b8765"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "985767110e17a27df78a0faebcabacfac17df5ae15690f759e0ace463e6338d3"
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
