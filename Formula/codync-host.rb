# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.11.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "64896bf437aff039053fa389b8aeb648f438f01d69e720ecbb46e12f193cb4eb"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f8ce4d398395d4222ee73f4dbfefe2194aa0d831af9c60a6c6f27f1eb09f7f13"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "d1e67c2d613019ce768f37e1673457d06b94442579e9a190152849bdb0271caf"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "e83c75fef9c0e7b8ac2df137349a31271b5fcd2b4466c00b8f209250cb1c56df"
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
