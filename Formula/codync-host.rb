# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.31.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "db5428699563b26fe32a5cfb7a063ce3d23d712f142287e73fcde60f3763fe66"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "bde6b9a73863bb5c67df78dedf91c7414346d0fe51f4163bbdb11fc420da936b"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "dba9dbe2e295cb7fab527f1f49fc39c3d2593eff4991e4cb6d286abe295382f6"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "13c0f9033c7a3729111f94ca07c0f7b458864b3d7981ac295c16f9e614cec51b"
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
