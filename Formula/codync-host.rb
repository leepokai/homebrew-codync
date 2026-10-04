# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.6.3"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "aa8d777a05e9307413bc2b58bb5dd535ab5638ff2b2471d9c5b17c35df7cec59"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "7ddf4c8133466dc5d2a4d63a109ac81dd4852d58ebed874d92d5efd16ca65e90"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "75e2d3c911a56bd1ee3337c9bdaafc642e9c86a8750df0ed51f89efbe86c9363"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "26efb2f7ab7846d17d17d6183f73ba1829bb7a1596434686db57a487315d5e38"
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
