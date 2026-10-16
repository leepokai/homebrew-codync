# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.17.4"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "32f40ff394fed7b2d7df14fc78a89ad417e7c74f865238fd4786a5362e9a3a70"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "3e526cf9c401d5abe79c0f628135e15bdba29b7b32f2eae9736ff90ff778a5d5"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "7ab83835ac33d9be2b0781c4c7592dd6985f84288133229a1bc01a2b3fe8551f"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "7ba80277d978855fa635b6c842f5bc5aebe371a65493d3486947b72b913075ef"
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
