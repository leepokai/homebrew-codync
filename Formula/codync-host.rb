# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.13.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "be999908451e90b9b147cdefc53c93a563c1478552909be099c443242eac8ce3"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "7f4c17a462e81ae0f4e5136bd96c8cd1c4e30e0615b0bb187d21f3f55c45891e"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "1a2e83f356a21e18fb29540f40bed5ea3c82642600edbec791a040b12294ddcc"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "a20a81ca50aceb3b3504b55e022f6a8f00a988a9dd83f835719a760597aa701e"
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
