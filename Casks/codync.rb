cask "codync" do
  version "1.0.4"
  sha256 "e491dd905eae7c621caee55f6cb41fe14a2fad3e17abef0f5544a17b306bb8f6"

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
