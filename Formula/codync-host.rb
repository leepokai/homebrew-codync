# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.18.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "3289f85a6e523c5fa27389aa922a51a71f98e20afb6d768139c9b6b67180d13b"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "3e48c920fa538031425f415220633edb0d6db46a6c054c6abf934842753c54eb"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "41e758e758309d84b9d30dc051f50d699aa396b3d8efa03008eaf145e846f427"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "005c427e4adf65ad9af4470f35d7f7888900dcb52ac8ed460eafb4ca002e52ca"
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
