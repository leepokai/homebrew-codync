# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.4.1"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "fe5a618a2a4289f81c596aecba643e1e788136aedfbb17d26ba4efce9ed164f7"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "0cc7617119d5e3f1e1520d47a440ed3c31ce20883fe75a89d95dd6fd14f4a95c"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "b1f1d70f9af43db1353456eb8f6265f06647041e98d2c8eb0164575d0eed6e52"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "29d8fc129b9580c0ac1a1f82215980f4a3fd998e76f6bce2b0a636aac886b7d4"
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
