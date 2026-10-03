# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.4.2"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "be24b5ded03bdd80668f70f1cc518a22534c637616687e8890c00dfaf2e94088"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "d15f3f51c5a721ade13139d47ca28d08f45866db820c5f02d1a546d46ae628bf"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "599d015281b5042d1d76081af3bcba661ccd641ed0016e4ece2a216ba80430e9"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "4ab2de9276628b62c8f52ce83c1a9bf67e0f92e52b101d66d4c4a2baac339302"
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
