# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.6.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "cda3e8efae2fb4b8dbc62fca665a0e46d604636c9b2af676d644cb272272e63b"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5c8dde822d1fb9e411450439f0578920b883d0e38841ed1c438b03c77c737528"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "85efe974a6bc396d1966cb5387788ac2c7e14882547518675c2f4179f210b6b2"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "5769c146dc91089706ec20fc07a3fe214c4457ea5b202fd24f957bac46139c72"
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
