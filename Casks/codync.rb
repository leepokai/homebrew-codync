cask "codync" do
  version "1.0.3"
  sha256 "4ee347b5746cd0f2ad35ee5e6a4fc81c7ce7af5e3cf20ce05e097cc8a902934d"

  url "https://github.com/leepokai/Codync/releases/download/v#{version}/Codync-macOS.dmg"
  name "Codync"
  desc "Real-time Claude Code session monitor for macOS menu bar"
  homepage "https://codync.dev"

  app "Codync.app"

  zap trash: [
    "~/Library/Preferences/com.pokai.Codync.plist",
    "~/.codync",
  ]
end
