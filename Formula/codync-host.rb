# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.40.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "73e94ab57f5f223317fc833ad984c4b4cb1485c213299ab09e05111760c9c926"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "8626ff3cac74c7db8236387118374e40b981da48245901b4879df3bcf2bc10af"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "ca94fbf28ef9ae04afc5deeb172394c88a097e2e89d1c59991f9ff34d2c1960b"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "c514a9e3f4e342360376e66446ee7477ff6ed62e45884bcc27e25827b770e1b7"
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
