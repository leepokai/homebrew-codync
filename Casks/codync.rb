cask "codync" do
  version "1.0.5"
  sha256 "0429dbf03796e3974ac950f65a5abb3efbf68c2b21eefa771bae6f1e7c728497"

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
