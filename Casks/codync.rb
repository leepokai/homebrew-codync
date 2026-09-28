cask "codync" do
  version "2.2.1"
  sha256 "f213d8e1c916bbdc6434bc61811e7e707802ffcc5e100ce2d49f2d14d2a812bd"

  url "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-macos.dmg"
  name "Codync"
  desc "Message your coding agents as bots from iPhone, Mac, Linux or terminal"
  homepage "https://www.codync.dev"

  depends_on macos: :sonoma

  app "Codync.app"
  binary "#{appdir}/Codync.app/Contents/MacOS/codync-host"

  zap trash: [
    "~/Library/Preferences/com.pokai.Codync.plist",
    "~/.codync",
  ]
end
