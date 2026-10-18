# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.19.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "b4d82eaf81a21df642d2e0ba45c4ac2bba9d5db1c0051c690a22bb715c7bdcf9"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f4430e781b95486022f8f85603f0260e1d9247abb049c4c96cf2b490707562a9"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "43f39c4d1d55fc9d90eb886376795a353c9ec4f0babe54959f70885378a108f6"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "1c14dcab641b012720e8a8b962086d6439e4f7d84ce8e7121131e70bda34a18a"
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
