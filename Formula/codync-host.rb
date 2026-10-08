# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.11.2"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "50c963e5815cb25ac437b8ba0876d40a7b1f8198514e319522f3316fc1b57d4a"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5eeb387844a6f3a7de6f889f84741256d97a047843c9e6ffa90c22d180e4fa94"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "11948d2b48aa7dd027f0181fe692b7026f860e8ce8883ba84523735e99ed1f74"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "c29da5c9ea6625204cef50643605bc85fd81062239f1efeb613f90312b0f107b"
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
