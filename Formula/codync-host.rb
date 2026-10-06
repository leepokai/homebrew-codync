# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.8.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "ee334cae2fe7640bc05787ef5423cc9bec9759b5b199f08f00972129fdec776f"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5c0690dc18e1cab78d7daadbc513de22127e86b8a6e4082d33475f547ae005e5"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "011efb6a9cee28c2f70b62ce40db43a001a9a36ad90e52e9ea80ea26a26320e1"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "f0787b4dd5ce48ea5066925d9e658c8efb5ea20f70bf8282b54a198acd97ddd0"
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
