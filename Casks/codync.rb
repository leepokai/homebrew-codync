cask "codync" do
  version "1.0.0"
  sha256 "35e2e15d8bcc08daf763c9374b191a38888882c04af12a425e4fbbd5878154f3"

  url "https://github.com/leepokai/CodePulse/releases/download/v#{version}/Codync-macOS.dmg"
  name "Codync"
  desc "Real-time Claude Code session monitor for macOS menu bar"
  homepage "https://codync.dev"

  app "Codync.app"

  zap trash: [
    "~/Library/Preferences/com.pokai.Codync.plist",
    "~/.codync",
  ]
end
