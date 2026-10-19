# typed: strict
# frozen_string_literal: true

cask "drivedock" do
  version "0.4.0"
  sha256 "9d780570a66814d6d5afc14cd64375632e3a6f93ff6d7613ab3582e4ca50222b"

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
