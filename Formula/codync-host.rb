# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.16.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "d1728c9a5d8b169b90d0d45d0fa8e126eb59b911c86eca38fe51e96296b47a1b"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "9958a9f6f8b35a3cb954396bcc5207a4f1cad8aaf40d379db8ac0b8c7a491cca"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "e84213330fda14be3ba5b57951a6730f7824e3959b86c70e1c410bf3ef249586"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "b3fd84c1c03e318f1a2e1d9d1ea8430c8648daf7e30b49bcd44fe01dd4825f6c"
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
