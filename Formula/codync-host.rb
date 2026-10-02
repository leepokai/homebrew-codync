# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.2.3"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "ba0b0c1d7ba2bdb7719b13fa4ae53a8b85cbe9c256753745d3d2d0f9c786e5dd"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "d8adcfbb01a337014e2b381def83ec039d9a4ee72e737e49f87a975030998e93"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "3c740dd70dc111df879693574accdeb695c5c0f5648d600a4c40ca887a764531"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "01665090bd66ac42092cb9ac0af54e4b1d54e57615e51ed7d3963749cbcf88f7"
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
