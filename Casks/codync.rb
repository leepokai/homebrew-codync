# Homebrew cask template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the DMG's sha256 of the release it marks latest.
cask "codync" do
  version "2.49.3"
  sha256 "811be81e80d2f3ff9af16800d213450e813ff6135059b3422cc27c4f7f2ad223"

  url "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-macos.dmg"
  name "Codync"
  desc "Message your coding agents as bots from your phone, desktop or terminal"
  homepage "https://www.codync.dev/"

  auto_updates true
  depends_on macos: :sonoma

  app "Codync.app"
  binary "#{appdir}/Codync.app/Contents/Resources/codync-host"

  # The app sets up the host service when it opens. Upgrades remove the service too;
  # Homebrew reopens the app afterwards, which sets it up again on the new version.
  uninstall early_script: {
              executable:   "#{appdir}/Codync.app/Contents/Resources/codync-host",
              args:         ["uninstall"],
              must_succeed: false,
            },
            quit:         "com.pokai.Codync"

  zap trash: [
    "~/.codync",
    "~/Library/Application Support/Codync",
    "~/Library/Preferences/com.pokai.Codync.plist",
  ]

  caveats "Open Codync to start the host, then choose Pair iPhone… in the menu bar."
end
