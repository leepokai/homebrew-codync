cask "codync" do
  version "1.0.3"
  sha256 "f48bf39e704a822bfacb6656e2cd7aff6ee12dc7b1ad176a77a0710574a4484b"

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
