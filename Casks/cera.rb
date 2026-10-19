cask "cera" do
  version "0.6.1"
  sha256 "d7ac81df1c420b919404c1085e13658d2532cc330f6244ba19a86b22d366b982"

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
