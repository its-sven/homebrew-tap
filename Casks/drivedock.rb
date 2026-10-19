# typed: strict
# frozen_string_literal: true

cask "drivedock" do
  version "0.5.0"
  sha256 "adc714f54bdea34f83e25a85438b26fde48c60d60e9eec52b31bfa694637af6f"

  url "https://github.com/its-sven/DriveDock/releases/download/v#{version}/DriveDock-#{version}.zip"
  name "DriveDock"
  desc "Keeps SMB and WebDAV shares mounted in Finder, several users per server"
  homepage "https://github.com/its-sven/DriveDock"

  depends_on macos: ">= :tahoe"

  app "DriveDock.app"

  # Releases are not notarized (no Apple Developer ID yet). Clear the download
  # quarantine so Gatekeeper doesn't block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/DriveDock.app"]
  end

  uninstall quit: "io.github.its-sven.DriveDock"

  zap trash: [
    "~/Library/Application Support/DriveDock",
    "~/Library/Logs/DriveDock.log",
    "~/Library/Logs/DriveDock.log.old",
    "~/Library/Preferences/io.github.its-sven.DriveDock.plist",
  ]
end
