# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.43.1"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "122a32a90269a01a1c2b1bfa3cac14833d7af695382df2bc53ebd9817e79cc24"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "aabcd4e8700d49803e9fa920bdbefebc7295e9fe8c067384270eaca6919b30f7"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "4b52577ce50b387a225804503919ed6da5d13008c62a31f5a682912744d00cd2"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "2be1b8a42002c9a110af7363f052c357554d6d807a6683bf426334d2e8050340"
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
