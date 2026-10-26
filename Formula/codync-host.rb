# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.28.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "b182115b21768abf84ba35b50cf592ed4bc141f68d30ea74b11ad9fcc6d9c3bb"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5173fc6a9541b071f62387cd94ae94977d9d4bcb049222171d31caec639e8cf2"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "d7ae580f29be5ba71716ded17b6eebc23c090827c8f06f00a638726e7598284b"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "eed622f55ae457d529b7a618b060847189c260345929252a839b70c56aa9f0e1"
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
