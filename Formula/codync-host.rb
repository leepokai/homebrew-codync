# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.2.1"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "cccaf2d375ff048bf9e6e6908c0a5bda7e7d754306eb4be06d7ab1739cfd6962"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "750959339b44dda38079bc6117a85b2c8963790a36b68e6b9314df0f5919a1b1"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "f750d45085fbce56c388eeb17a90f64366562fa7bafef47acd357df1fd5b1303"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "49e79962fc447f98fb478f891f1dd2fe73a20fa2f063f228eb85d85531a0c152"
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
