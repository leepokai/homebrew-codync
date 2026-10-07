# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.9.2"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "3a6c825bd3b6bcd7e2365b4b1866da5fc873b178a0e2557741cc23729469720a"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "dfb90d36e313c03c6cb878cfde9b71dfbcc91a4263c149450a3389560b9acc12"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "d667f3267314471b49810a50dafed2744e5806a0b478384acce4cd653b89b3e8"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "d6784db84acf6e5edf083c6ddc8cadaecb8c259ae3154c478d3596adc367acd7"
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
