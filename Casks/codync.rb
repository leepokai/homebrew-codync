cask "codync" do
  version "2.2.1"
  sha256 "c0223c6f85bef45b30ddc1f4bcc932a359ab43dd6e9f08f51ba6b26639f04a40"

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
