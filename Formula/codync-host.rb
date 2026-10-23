# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.24.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "e6067beb5bbe505f5eeffc4653b35ba7f894ca41a001f1bd61a4a3549c1f5f9a"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "08e13d8eed82b955b9f84b2c803c331defc47789d83968697fceee1921a87ba6"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "23b497a36942edc441afd9ac1f51ec0e1d9bf813810a7651c1fdf8dd7fdd775f"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "fc07f996918802350656c6da4781f6a8d8e82cbe27dfdf3eebe9c19e943a737b"
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
