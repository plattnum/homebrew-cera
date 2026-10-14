cask "cera" do
  version "0.1.2"
  sha256 "c54ca7504411bd49be4c6e81695b2a8bcd0ac2fd36f6c633054866e354375480"

  url "https://github.com/plattnum/cera/releases/download/v#{version}/Cera.zip"
  name "Cera"
  desc "Quick WYSIWYG Markdown viewer and editor, like Notepad for Markdown"
  homepage "https://github.com/plattnum/cera"

  depends_on macos: :sequoia

  app "Cera.app"
  binary "#{appdir}/Cera.app/Contents/Resources/cera"

  zap trash: "~/Library/Preferences/local.cera.app.plist"

  caveats <<~EOS
    Cera is not signed with an Apple Developer ID. If macOS blocks the first launch,
    right-click Cera.app and choose Open, or run:
      xattr -dr com.apple.quarantine #{appdir}/Cera.app
  EOS
end
