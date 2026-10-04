# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.6.1"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "d64c15ed95897220d1937bcd1b1943b877ec7052a8b26bf82594a0ced8550f27"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "c745babc149acee1a7573ddd13d8715c7925b0432c0333e83142f9df0c723698"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "65e482a0297ec9ec65d0130b2d9817db80b8a784e1368b37a8c47965c6f1f7c4"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "1b05e559fe465104e72d7e9b8c932e06eb2340e8ae100f59f925b5db2fc59882"
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
