# Homebrew cask template for the leepokai/homebrew-codync tap.
# The release job in .github/workflows/release-macos.yml fills in the version and the
# DMG's sha256 on every `v*` tag.
cask "codync" do
  version "2.4.3"
  sha256 "245a4f08186f3bb945d5bece926232f846e1ace428b486a209f70c0e558bff00"

  url "https://github.com/leepokai/Codync/releases/download/v#{version}/codync-macos.dmg"
  name "Codync"
  desc "Message your coding agents as bots from your phone, desktop or terminal"
  homepage "https://www.codync.dev/"

  auto_updates true
  depends_on macos: :sonoma

  app "Codync.app"
  binary "#{appdir}/Codync.app/Contents/MacOS/codync-host"

  # The app sets up the host service when it opens. Upgrades remove the service too;
  # Homebrew reopens the app afterwards, which sets it up again on the new version.
  uninstall early_script: {
              executable:   "#{appdir}/Codync.app/Contents/MacOS/codync-host",
              args:         ["uninstall"],
              must_succeed: false,
            },
            quit:         "com.pokai.Codync"

  zap trash: [
    "~/.codync",
    "~/Library/Preferences/com.pokai.Codync.plist",
  ]

  caveats "Open Codync to start the host, then choose Pair iPhone… in the menu bar."
end
