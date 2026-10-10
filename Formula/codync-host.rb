# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.12.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "b6610f6186df71ad4c0ec05ef33c6cdf5e5bf727323552ea488b8a7a1e837c60"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "67037a9e3109174e790875ef7f46adc10c91cfa503f2fa6c19b0eb9e0d27e4ff"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "0b35701dd6d74776b16486f52062fe1d363f9be03a7d39d8895dd76287853241"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "a29991468f49f94a7ca300d7f05e8a1b4c942794e1c2e3b55b9a80d728b57dd2"
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
