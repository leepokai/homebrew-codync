# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.22.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "6d55aab5287628149941455f93dae9532ea93aca1e1853bb44ea8b5d527f8683"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "c9978fb53a0a99c0acc93d5bf8de935d16745355ad74cde50a1cdcc520d6de06"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "a743677c0888eacb3a0618f9bb53755ce50dd11bd71f5e619ebb5650f99fe4dc"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "3779fcd60c7dbea3e828b2042524edc8c08c96a07e9d197e67870a360f9d0164"
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
