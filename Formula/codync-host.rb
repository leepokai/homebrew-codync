# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.2.2"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "20b7790a42f41334a2a11b1a2418f38d91d22a0b96f5da2c3b0fe57681813b2a"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "200567983e8bff5142093414beb57eae87ef8d98c6397c56916f702aa425711b"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "d0f5a915d35e07cf9a23c912173b0391c0515336f7dd03b167d9a1b99e5525b9"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "7e7207c304268929566fa4139479f3dcb94f9f1df5b6ea9c4eae0f2b779331e2"
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
