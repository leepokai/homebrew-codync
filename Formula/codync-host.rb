# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.16.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "335642f5b7dbb6ed5ce9ac092d999b0dae9afc282b2d8ada8ce9dff322891fd4"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "7fd1bab6c440367848687135abb951886fe38a8491410e2e14ea53d515b75c56"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "d81dbe806fc8bf4f94ca9e50c07f45889fb9134e41a1333d026ec5868c68c4b4"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "60d1c3ca1daffeb0c9364934b56cc70a3acdac85e30fa2f33710cb8b7eeacdcc"
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
