cask "cera" do
  version "0.6.8"
  sha256 "73b232943c0017999e36c5952ad347b66144fa7c659f405ff2180bb721a48e05"

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
end
