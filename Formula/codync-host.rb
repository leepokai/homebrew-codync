# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.17.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "5cea2893bb381787d6d81a11c73db55050bfc375461002a52e52161c3f93c3d6"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "36fe740b8798f6b753c9065d24e400c3602f4fb0bd61db9b447a96a2546c2f96"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "1d65fd3531dc8d42ab84cfe93d07c186472189eeff72de8218bbc4b332c919aa"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "0a4811e863cdadef9fc3985c334a27937af90b0e871d5c8f140890bed78fb2ba"
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
