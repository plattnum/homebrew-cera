cask "cera" do
  version "0.2.0"
  sha256 "2d8cdd6ccad09774308b4c62c0f4da4e556bf872e512294ec735d7caede64fa4"

  url "https://github.com/plattnum/cera/releases/download/v#{version}/Cera.zip"
  name "Cera"
  desc "Quick WYSIWYG Markdown viewer and editor, like Notepad for Markdown"
  homepage "https://github.com/plattnum/cera"

  depends_on macos: :sequoia

  # The `cera` command runs the script bundled in the app through a shim Homebrew writes
  # itself, since macOS refuses to run the quarantined script directly.
  app "Cera.app"
  binary "#{staged_path}/cera.wrapper.sh", target: "cera"

  preflight_steps do
    write_file "cera.wrapper.sh", <<~EOS
      #!/bin/sh
      exec /bin/sh '{{appdir}}/Cera.app/Contents/Resources/cera' "$@"
    EOS
    set_permissions "cera.wrapper.sh", "0755"
  end

  zap trash: "~/Library/Preferences/local.cera.app.plist"

  caveats <<~EOS
    Cera is not signed with an Apple Developer ID. If macOS blocks the first launch,
    right-click Cera.app and choose Open, or run:
      xattr -dr com.apple.quarantine #{appdir}/Cera.app
  EOS
end
