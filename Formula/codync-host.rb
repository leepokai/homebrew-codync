# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.17.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "c0e4b0db00716a759916fdefc198b3f8e53c19fa6a1d201ddaceab91b427f6b1"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "5ecd0e9d24416bb8ecd1d960dcb6b0be04848384d29817df50d9b0998996c86d"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "49cfd40abfbfd9d51c148fef32b738a6c66effb327f16f31d85f16983e539f03"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "76e57881e4fde0d5bd355a459ad2c22b5e3e6a8cec73f79523ddff1623ed3a52"
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
