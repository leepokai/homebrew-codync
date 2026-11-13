# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.46.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "f8e7ac15d3756329286ff503cb59d54d3b8a3878ea12799cf05a94c17a1732aa"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "3903b73c1adbe450afe47104179ac2e2c19f0404465a4c9b49ae0432bf330351"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "6e52760e4452983f23b8f49acf0489eea1a65c905c044987381b5758854c6f81"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "2f09f289e2d4c9579a8373dc15c51c6ae38973cbef31d44df6b4abd1dbbe835b"
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
