# Homebrew cask template for the leepokai/homebrew-codync tap.
# tools/release-gate.py fills in the version and the DMG's sha256 of the release it marks latest.
cask "codync" do
  version "2.34.1"
  sha256 "70b51161d76f9024da11a0af9ae4291c0dd5436846d3f2f011e5a6501c28b28b"

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
