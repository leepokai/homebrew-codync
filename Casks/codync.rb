cask "codync" do
  version "1.0.1"
  sha256 "9aed6ce75aebf71524521d05405443b3b024f3b9a4b49df6d16b013335078d70"

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
