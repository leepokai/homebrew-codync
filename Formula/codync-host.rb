# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.3.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "fadf80aa91c1e900b4502d6ef41d82d6c7ebe40e628d7265c8950b2cad85ed16"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "1c04d84b40b1b77e1fb8128c033a2f0813dfc7b94983a02b9edc8f1188bea0e4"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "52afecb8c01878caa7737da07f3158c7af9b6cedbee44b821a5f2b637a46e968"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "19774f877653b1e7fa657deecca9cdc7ecb64d0fd44122fdb6d1b76b6f538bf2"
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
