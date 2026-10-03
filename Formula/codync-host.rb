# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.4.3"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "aef6c81159e15c8bba3944abd0bffd0ed10d76889ce72bfa454f852578d9d12d"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f26f884b8b7c88d957c67b1c8f49ccf3ee0397b6a438dd4085c3d4dc6cfaaa34"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "dd9a891935df8c056dbcf11dd7d82f9d4582a0246d59915afc0790e9e2c68224"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "e5436e303b8887febe0de829075d9b11ba56763d4888b947db7fe0bbcd4f158f"
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
