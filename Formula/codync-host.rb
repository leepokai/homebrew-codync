# Homebrew formula template for the leepokai/homebrew-codync tap.
# The `homebrew` job in .github/workflows/host.yml fills in the version and the four
# sha256 values (in this order: mac arm, mac intel, linux arm, linux intel) on every `v*` tag.
class CodyncHost < Formula
  desc "Host that runs coding agents (Claude Code, Codex, Cursor…) as Codync bots"
  homepage "https://www.codync.dev"
  version "2.4.0"
  license "MIT"

  base = "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-host"

  on_macos do
    on_arm do
      url "#{base}-macos-arm64.tar.gz"
      sha256 "3a523c6d596a5d171a85a9d5c038db097c53d2bd911fced1dedcc21856f01ca7"
    end
    on_intel do
      url "#{base}-macos-x86_64.tar.gz"
      sha256 "b26f82799179762b17cbcc3bdecc6acd272ab9f1f52c0957b3ecccba25ead68d"
    end
  end

  on_linux do
    on_arm do
      url "#{base}-linux-arm64.tar.gz"
      sha256 "a676f0bf7cfcaddc24629b6763dace1d8e388309c213bd21aa65dbcb78555641"
    end
    on_intel do
      url "#{base}-linux-x86_64.tar.gz"
      sha256 "4e5cc749e69c49f24af0d0bf7aea0971e108b8748bd889abe002a1703b33b545"
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
