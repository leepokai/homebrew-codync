# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.19.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "a44692f04dd25f841fd4b9c2081899fbd8d0c836761f7a970e86da179a92521e"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "a601f8619bc27c5f9666caf60b4236423601bf360603e24fdc58685c171d2a4c"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "c7b03e6ed04ca3072cd8c1c4aa14dd946170c39e7dd6f7d81c9cb1bc2cb754b2"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "a3755a10adc21943529d2759949b6aca7b5f8c67e79392e1b34fa801d4cafe01"
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
