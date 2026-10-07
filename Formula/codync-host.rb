# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.9.1"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "c375f5efdd246a02d3d996b42e33673137443c82cc7e60811982561c6e32be54"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "fd5de13675138c9dfd51f3ca9d3fbddad14f536780f8d0ef5d2de4760637168d"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "795b43301c4a8b71660f2ab955d77283b90b9e37bb9962de918255cf307f17b9"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "e09c6eaa7baa17cf181bd32c97a231bfcaead5d2df20a7614cbcb7c9a78d3300"
    end
  end

  def install
    bin.install "codync-host"
    # Linux: the Remote screen helper (needs the system's GStreamer and xdg-desktop-portal).
    bin.install "codync-screen" if OS.linux?
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
