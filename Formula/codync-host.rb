# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.9.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "d6c19221190dcaea157867fe1cf4e36fe0281277ccb1866d51521941f345b46d"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "e8c32258cb18f7c6d452363b399cf279c0168006587b5bd3233077eedbffbb10"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "53972c0429436e54e193fb93a8bc0fdd1b5151912593765d01a6db885f149d31"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "ab0b53c0bcf387084f5e8b956e426cd8b0f6b6b608e8986bac7a7c7002bae285"
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
