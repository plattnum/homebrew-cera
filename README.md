# homebrew-cera

Homebrew tap for [Cera](https://github.com/plattnum/cera), Notepad for Markdown on the Mac.

```sh
brew install --cask plattnum/cera/cera
```

## Releasing a new version

1. Tag and push the version in the `cera` repo (`git tag v0.2.0 && git push origin v0.2.0`);
   CI attaches `Cera.zip` to the release.
2. Get the checksum:
   `curl -sL https://github.com/plattnum/cera/releases/download/v0.2.0/Cera.zip | shasum -a 256`
3. Update `version` and `sha256` in `Casks/cera.rb`, commit, and push.
