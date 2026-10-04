# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.6.2"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "fcb1f318f74a1d2c117c1863d55153e7bc0bfb0269a359d731e3ae8032e9dacf"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "f03c291ef0294ccfbc3e79676ab2e423416898c0b857d0c5b4a9b0ad44721fc4"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "71af568e73aec52c619875703ab3772f749ec2887ecc1be7581f81335b26e254"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "2db82087d3d10878e3e7dd26d95b24c2fb6ed6de2d9cfaf79ee6f9e118d32c2d"
    end
  end

  def install
    bin.install "codync-host"
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
