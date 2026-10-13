# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.15.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "a448124ebf9ac7078e427d7976b5360c4f2c92a09766677cdcb345077aa73412"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5276f8c49b8c07e27bfd21c235a7b3706f6d642bd382d93a515bab4979326279"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "d63e3979c44f5547ac28289a2b82b2425041ac6900eebbc25a583abb9f4e6bea"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "cf3775982426ea47375c66ee3f0a2016c5ac1c169d538d58563fb29078a560f3"
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
