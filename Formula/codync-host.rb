# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.26.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "af773bf0a0a45f4fbc9d08e66ef319864b6e3bb7fe29f8c64740269b46be119c"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f974d800e0c314cb45113c69333101e968d7f879016b7ce7f9c3c223d7b87aa9"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "b558c5c916e581f6941a9aeba420b04c83097d326ae5dcdc78f3f06843a37550"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "0de1b9b465d3f9debfbc6525269ecdc1d3fce1279ec338ae0013dd29c8e34df6"
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
