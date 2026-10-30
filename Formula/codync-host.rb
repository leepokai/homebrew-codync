# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.33.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "91ec82da512ec663c88724df88b96a04286600829ec65875c34a40ba5713942c"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "909a5c012f202c7c427f517ab48bb52a78fda680587c44377d5e2c334aebf65f"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "ea554dec38e98a9501468d7fc7135c1117dbafaafb997d1f0cb3696b1b9722bf"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "f5963c72f7b1f93f058d1417e808d980f76eeafd657cea28723111f9982a33ae"
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
