# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Runs your coding-agent bots (Claude Code, Codex, OpenCode…) for the Codync app"
  homepage "https://github.com/leepokai/Codync"
  version "2.2.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "7556d313cb53768f65b3f3c46eb7bcde841ab8705e17f84d751375a17b4f9bab"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "910fc21ab7f044d2bc1e11dba90f3d9ef7e46c612d2a5e8b112df4f614a6e0e4"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "1fbf70c7536518f520add8bd3262a72d85186628ca1f9c139563630ddbffd759"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "0303b28a5d950157f75e1e725c007c0278c69e1c66817b7c46dcbfaa9a567943"
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
