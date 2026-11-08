# Homebrew formula template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the four sha256 values (in this order: mac arm,
# mac intel, linux arm, linux intel) of the release it marks latest.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.42.0"
  license "Apache-2.0"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "eca6bb86053234cacfd628d94a547c9e71f1f4ba1e63cf3d73c6b9a5452859c7"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "51b33c6be277cb5f57c21a2a9bd83333cd1fa90ef9a7b90b1fd497ba3a068a6b"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "b9de81802924642db12426db14270cbce53b49883afb819878d514874fc2fda6"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "b70eea1dd6515fee40664e9fe9629b6b6aa83b2747cf4c1f73e600bd263eca7b"
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
