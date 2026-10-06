# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.7.3"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "3450807a0b41ee9dbf3703f9064a0128a15c6947d1c5fd71ec8a1ddebe9d5a3f"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "d3a6ccdae0e2dd22f14637e0c1e5f64c90f1cd049c9788e16e1c86f48c92d0c4"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "1d6edf4b046cd1913d321bfc4ccfa44dbf820218564bf150d1f8723ed9a4bcee"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "ddcc5921dcfe2cfd330dfd4cd458c26b72a3ca8ff3432409ce61f9f973214e6a"
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
