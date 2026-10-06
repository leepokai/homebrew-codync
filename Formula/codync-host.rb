# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.7.4"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "cd48e8b3c535a46100dbc62f22608f8383af735f26bb1e6806bfab2497c70bb3"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "7fe5273e391c6fe896155a2e772cd4ace83ccb3a1964f8012e0572ca9595f11f"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "c2fa49aef4e99bef4a610dd7b93d948609063352f02f4d3ab49e7c83664f0720"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "9aa72c3b6b6965a19f7600d159fec4c88091b6dadba3250c3ebc82223fc41021"
    end
  end

  def install
    bin.install "codync-host"
    # Linux: the Remote screen helper (needs the system's GStreamer and xdg-desktop-portal).
    bin.install "codync-screen" if OS.linux?
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
