# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.4.4"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "5a802b0e2e1bb8f105246ba261b1d6db78e84b4de52bac1410937e3723d80f73"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "3d0a18b2a992a96636ba0d0d7580b28b91d671b8202fa49c9d2e3d4b5f95c8c5"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "69bf0290a7b078acfbe96f9f9eee427bb0a1ab27999b3999408f0f6beebfe81c"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "27769a67223fcd0c288964c6dce1b0f45ac3f7e60ece118e77193707356e96e2"
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
