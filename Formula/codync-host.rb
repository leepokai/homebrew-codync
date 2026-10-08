# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.11.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "4bb55754c59a86fddb1a1251685ac23b37c74f90be2fb0dc2f0f32069f5edcea"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "989c128b539c70ffaf89bc3001e5b7f26c3b0b3bc4d4b56e78b942eea96c0d6c"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "ca214e5e093fede90436bc6d023c19930cb85d515b27bea926af89675e740d87"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "1c3453af5d86f08169db804eff55cb36bffce5b0d1b4cb5347678b6f4e56359d"
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
