# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.5.1"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "b8a055bc7e48d7b5d37ac45acecc65a0ab9f9b56a63861f4b2489ed176454298"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "0faaef8c1fef3ab1027eef5890183d2ec5304d63eaf783657a2ba154625fa979"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "59b8270820a6d8252ba89bbf8809375a6091bca913516df31d4b22e30e6f36f3"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "86b65f86c56387215295445890e0f4b93455ce55cca0d80274985bbcaa5f874f"
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
