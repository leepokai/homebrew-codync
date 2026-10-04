# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.6.4"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "9ac705da496aad3a37effb7e687085b3516824c1f2423d37e142caf78aff5aa5"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "a54c37dd488f7895b7e42ce992f78f528a152a07386f9c57dd6980e0d6c6f5e3"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "20cc4cc6cf88aa363ed21b83fc184b29d9c3caf6dbae09e9b9ed821c46a1998c"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "4e2d57221e9c37d931d68be337b71f61865a1847599576da3f7d6225e0bddd31"
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
