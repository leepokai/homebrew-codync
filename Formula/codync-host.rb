# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.8.1"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "c6107438c746e92ed9032a90349e18bb31916616676698f06c31702434e0995b"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "de83830d24896e056bec53f9854448484688d0a3383f6e1481b795cdeb80284d"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "43d8e7eef58d56ce32e031c443491d04dad1bfe1249a2ac8a1843940afe9009e"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "8924e51db8951b5cfffef9fd0cef5980f3c31f077ec4d0a0d0af9f932dd9396d"
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
