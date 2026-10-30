# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.33.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "8589babc3521da33168a56d0ba87d5992e38b3b7f5e37eeec9807891d158cbff"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "1e8719dd547badfee0890896681fc334d3d1ffe9facd626b4d4512957427d6be"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "d19c2108c052e4f018e9d553e66f6633893dce02861dc248183c8f9f4473fba2"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "7641668ce50684d9dae4956cd6a3a670dae022cae8ab667b8b69806c291f516b"
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
