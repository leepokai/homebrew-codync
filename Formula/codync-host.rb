# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.49.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "ea52537bfc3bd308507920c384ec1eb3f8b46d5db0d68081042fcffe9126100c"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "dfe830b35e999ff3a7be53dd54cd5a6fe577056ef7dbc6f112e16e5f1002c93f"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "522daaf8070e3c5ac1dbded4ba6aa6b8a4f8de0ace793419f2a30b172dacca43"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "c5c4235649171ee1f3d901ecabfe84b4fdd92f11678f0a402fea2c4a3388e057"
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
