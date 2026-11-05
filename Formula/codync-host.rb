# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.39.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "5c2667aae43a60ea70bd88952aa0dc049341abeeaac3e752a9ca25075ac16a5a"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f3134df121de6837235733d98751128f878dc66c9bc0a8990c3346623caf21ed"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "fef5c9eca89cf02bbee7ad2b2bb1edf7e23cb64a27c3135886cd197293441bc7"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "325d72f6da6d0c5ca73d3811e667e3c0dd1270f36ca70ca1e84b854c7eb6a884"
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
