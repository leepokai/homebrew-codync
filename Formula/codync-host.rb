# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.40.3"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "3f1492f68a62eaffa06ed8fdce5b9bc381c15b636608be629edff6d09af2a1a8"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "ff515977015281c5bda6d0cc99662cf609debe86a06561651878e4356265045d"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "431493ef32e8698d49f3c90d416cc1d29b47d430177e085f1d8b739d9fdbabea"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "6fc4c623828bf07fb90eeb6ad2a1f970aa9979c464065c5ca2045dbb955756ad"
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
