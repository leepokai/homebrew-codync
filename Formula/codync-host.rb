# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.23.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "4668b19664440486c4f033f6d7de283f6cb2d08c467cc1d6d55f43c044008cb5"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "6161e52a78ec1095ab22c0ebc3d028fa40b6b31f5e477dea2c4a761855acc2fb"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "33552fe7cbe627ca08d1a68852800679d48596383c99dfbd5b01dea031ea2e94"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "c563c28eb6eff6bb7d93435f4ed716de91423a5c716717ef3c61f0c7b0743f59"
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
