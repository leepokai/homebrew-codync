# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.33.6"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "e32ddc5aeeaff36623c8bf9b688e61e94054104583c07bd443f779c752d4a3b7"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "e12fafa4ad343a50294e60056355e39f161052b75f7aa621a46542d4b3d5ae1e"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "8ece336ebf2dc5352c948049126217e8bfd726f945747e23a69e52429e873f49"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "b47bd99d733a7d4b9452afc9420a493d6e5e3b541a80cb82db08ec60bef40db1"
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
