# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.43.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "8667c874336cc29d7a85a663d077074172f36ed22923c050c276fa66440faa29"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "602f0717d59f083778efff0162425acf538ad98700760849c49b77f75852e377"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "83508949f9c2fecf5eed164882d27c6ed204fb64d19b3c30002ac1cff5172b95"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "97ab8749e9b8490cf4e99b3f74b65dfe6693e728f5e939f704b1cb8fc3601e65"
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
