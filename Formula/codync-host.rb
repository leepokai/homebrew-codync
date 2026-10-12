# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.14.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "5fe0cab10065cc84eb5df918a5f6b4f55f8a8f2b7508cc065e271d4050139956"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "cefca75e7e18403ff0566afbbd479abafa04a02a0b4d23b5a435e9f34a54f581"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "93b0672705fca2cdb2ae30e140d7d6aceb6e4ccd32d088bb3366544f26823a62"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "9e3084c5a270b779646c63dc90fefee6e891f9043775fa420fca498cb9a10e4c"
    end
  end

  def install
    bin.install "codync-host"
    # Linux: the Remote screen helper (needs the system's GStreamer and xdg-desktop-portal).
    bin.install "codync-screen" if OS.linux?
    # Linux: the computer-use driver bots act through (MIT, cua-driver.LICENSE).
    bin.install "cua-driver" if OS.linux?
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
