# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.33.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "f9cefe90ea803423ad32ec003d06179eb0d330a401634b9ebf700d8c8c5d676a"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "0a670c3ccaf403f95fc6d5d5985925984639cd0273600b9bbc3532a6ba8b0193"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "11855dfd84e9cb28153061546a9db240b07827102404a71ef0453e11eb0570be"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "3421cceababc64a9272bb1373a0950c40f8377eb0403f249db33f2816a424638"
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
