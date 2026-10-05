# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.7.2"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "5499eecfb01bc7c7b4f7131343d412b1f295e6e5b8cf2268c7aa304354c53a84"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "fea1712a1bd01cc80ccba1f2519acbb20d7dee0ccb8d210490e3e98bf44a50ef"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "8a002d0d1ce723ec7c4bfb802f2b265d2c84520e4653c9a9dd42c8166982f6c8"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "1f7f3f0c95bc4e4a6d3ccf02bacb6297a3ca6e9858c3a71b9a6f813c37765bd1"
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
