# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.33.5"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "4898fc1583f61cc9c4e0d46a077d6c173754bfc680debf08b6361674dbdb6f49"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "dc39490bf46c44133bc648a9e255926097c70423f3e2fa9bd67431739697ff8a"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "92816bdb62b5a26e0c4f964a2689653f9590702be13143c7c2866545e1bd8c4c"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "e50d0b3e4be43d60c4b5f4bc739c79c0eb586aaf2bc16c98da497c8e3e38f3f5"
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
