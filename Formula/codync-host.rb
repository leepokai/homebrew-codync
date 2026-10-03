# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.5.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "da896a2d7384b48c99af42dab91f830afba4b578e46caa2a061a777497eddc37"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "a49b72331868e4bd5a37bda647ed13bd8891ece455b1d2a49e344384c9aa2c7b"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "dd440b8148ac7ebf6c517e844dae982bdeea6b56ca2a97d4df9745a6b5acb9cc"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "99d2327746843425987ae39c1af2dd13cc3513dd048bcf24bcc6378a28e3e5db"
    end
  end

  def install
    bin.install "codync-host"
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
