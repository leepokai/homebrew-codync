# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.20.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "97ef88a77f2acb825bb684fce57a9ca2426d58e42d2b64b757baa90d68032d96"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "0cae6da4b4ea72639fe08325bcca0081f3a1d5b7e554607b2d96ecdff9f8ef5d"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "fd640150f4d28990d42b904c65854946ed46adebbfb3cec88719f00f59401a6e"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "e92c11cfa37862623fd3129d9e24a3e80474c3427f3cf008c162b406da34f048"
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
