cask "cera" do
  version "0.1.2"
  sha256 "c54ca7504411bd49be4c6e81695b2a8bcd0ac2fd36f6c633054866e354375480"

  url "https://github.com/plattnum/cera/releases/download/v#{version}/Cera.zip"
  name "Cera"
  desc "Quick WYSIWYG Markdown viewer and editor, like Notepad for Markdown"
  homepage "https://github.com/plattnum/cera"

  depends_on macos: :sequoia

  # The `cera` command runs the script bundled in the app through a shim Homebrew writes
  # itself, since macOS refuses to run the quarantined script directly.
  shimscript = "#{staged_path}/cera.wrapper.sh"

  app "Cera.app"
  binary shimscript, target: "cera"

  preflight do
    File.write shimscript, <<~EOS
      #!/bin/sh
      exec /bin/sh '#{appdir}/Cera.app/Contents/Resources/cera' "$@"
    EOS
  end

  zap trash: "~/Library/Preferences/local.cera.app.plist"

  caveats <<~EOS
    Cera is not signed with an Apple Developer ID. If macOS blocks the first launch,
    right-click Cera.app and choose Open, or run:
      xattr -dr com.apple.quarantine #{appdir}/Cera.app
  EOS
end
