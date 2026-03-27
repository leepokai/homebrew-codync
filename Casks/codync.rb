cask "codync" do
  version "1.0.2"
  sha256 "1e4d9e2b8e2862cc0079fcf8e2e92c840ace381b97d72fa5907269d6cf233792"

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
