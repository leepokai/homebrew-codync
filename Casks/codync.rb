cask "codync" do
  version "2.2.0"
  sha256 "9f1ac1abf7200ee21f66d264742d1176068df0aca78ce4adf65a7fb1bb623e78"

  url "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-macos.dmg"
  name "Codync"
  desc "Message your coding agents (Claude Code, Codex, OpenCode) from your iPhone"
  homepage "https://codync.dev"

  app "Codync.app"
  binary "#{appdir}/Codync.app/Contents/MacOS/codync-host"

  zap trash: [
    "~/Library/Preferences/com.pokai.Codync.plist",
    "~/.codync",
  ]
end
