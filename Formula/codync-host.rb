# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Runs your coding-agent bots (Claude Code, Codex, OpenCode…) for the Codync app"
  homepage "https://github.com/leepokai/Codync"
  version "2.1.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host-#{version}"

  on_macos do
    on_arm do
      url "#{base}-aarch64-apple-darwin.tar.gz"
      sha256 "8dd48eca8b0e4cdbbc6fa40a027a0f2801241abd8d7d6917435e2a5603027a2b"
    end
    on_intel do
      url "#{base}-x86_64-apple-darwin.tar.gz"
      sha256 "fd4f190b115925799e4c0a2541b85da49f11e131192a7ac14c26befee19c76ab"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "23938afd665a936e333c66e3693910e0f9b9d732820dc1ace5e28d3608d88f8d"
    end
    on_intel do
      url "#{base}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "099a61bb44a3adb43164900f8884a9d7b93abd3fae8a308146c6652f0c145865"
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
