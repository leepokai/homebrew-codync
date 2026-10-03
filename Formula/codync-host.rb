# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.3.1"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "8ab5f939787263ed8abd29e8dd964ad2fdf6fe66e9dbf7a64484148d3dadb97e"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "1a91522b32d55cc1c710af2cba8f82af7433d31bd96f707bb8268b76399827b4"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "79b5854e766e7b9fcd52b3c2b06a1bb0c4ae384b9e98f075e6b949aa5fe261e3"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "40bf94f4f040f965d9b18bb8af3fa0175d7d9f8482d6861e1e082167ae60893a"
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
