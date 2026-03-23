cask "codync" do
  version "1.0.0"
  sha256 "957a9732a370b3ee8c9268a744a0bb40fa8a28bbb24677fa6fe7c1ac542847b9"

  url "https://github.com/leepokai/CodePulse/releases/download/v#{version}/Codync-macOS.zip"
  name "Codync"
  desc "Real-time Claude Code session monitor for macOS menu bar"
  homepage "https://codync.dev"

  app "Codync.app"

  zap trash: [
    "~/Library/Preferences/com.pokai.Codync.plist",
    "~/.codync",
  ]
end
