# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.20.4"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "e41e31da11da332ddf2f809e44e018b4566d0881b39319cb8945e3dc41ac7148"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5cf4a1096eb610d2b90710deaf233061e667fcef76cca3dea1868d2d5c92c85e"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "19afb7c799949f5b7a09c2e3f95c49401e838cdea85c85559353e352c8298c8b"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "afd3d0bfc56699e1fe8fc8da5c134292d38f2975fbb14dd0b2b09c0841b81810"
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
