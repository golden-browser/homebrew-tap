# Golden Browser — Homebrew tap

Homebrew tap for [**Golden Browser**](https://goldenbrowser.app) — a macOS app for
reviewing Flutter golden test images across git history.

> [!WARNING]
> **The cask here is a placeholder.** Golden Browser has not had its first
> public release yet, so `Casks/golden-browser.rb` points at a release
> artefact that does not exist and carries an all-zeros `sha256`. Installing
> it will fail. See [Releasing](#releasing) for what to update.

## Install

```sh
brew tap golden-browser/tap
brew install --cask golden-browser
```

Homebrew pulls in [`odiff`](https://github.com/dmtrKovalenko/odiff) automatically
— Golden Browser delegates pixel diffing to it, so no separate install step.

Golden Browser requires macOS 12 (Monterey) or newer. The app is distributed
directly (Developer ID signed + notarized), not through the App Store, so
Gatekeeper accepts it without a right-click-to-open dance.

## This repo also hosts the release binaries

Unusually for a tap, this repository holds **both the cask and the downloads**.
The application source lives in the private `golden-browser/app` repo, and a
private repo cannot serve anonymous release downloads — but `brew tap` and
`brew install` clone and fetch anonymously, so every artefact the cask points
at has to be publicly reachable. Hence: the binaries are attached to
[this repo's GitHub Releases](https://github.com/golden-browser/homebrew-tap/releases),
and the cask's `url` points back at its own repository.

Each release carries two assets, built by fastlane in the app repo:

| Asset | Purpose |
| --- | --- |
| `golden-browser-<version>+<build>-macos.zip` | The signed, notarized `Golden Browser.app`. What the cask installs. |
| `golden-browser-<version>+<build>-macos-symbols.zip` | Dart obfuscation symbols, for `flutter symbolize` on crash reports. Not installed by the cask. |

## Releasing

Versions have two parts — a marketing version from the app's `pubspec.yaml`
(`0.3.0`) and a build number that is **the GitHub Actions run number** of the
release job, not a value derived from the tag or from `pubspec.yaml`. The two
show up in different places:

- release tag: `v0.3.0` — marketing version only
- asset filename: `golden-browser-0.3.0+1-macos.zip` — both, joined with `+`

The cask therefore stores them comma-joined as `version "0.3.0,1"` and splits
them with `version.csv.first` / `version.csv.second` when building the `url`.
(`before_comma` / `after_comma` are deprecated; use `csv`.)

For each release:

1. Publish the GitHub Release **in this repo** and attach the two zips.
2. Read the build number off the published asset's filename — do not assume it
   incremented by one, since it tracks Actions run numbers across the project.
3. Update `version` in `Casks/golden-browser.rb` to `"<marketing>,<build>"`.
4. **Update `sha256`** — this must be redone every release, or installs fail
   with a checksum mismatch:

   ```sh
   shasum -a 256 golden-browser-<version>+<build>-macos.zip
   ```

5. Check style and, once a real release exists, the download and cask contents:

   ```sh
   brew style Casks/golden-browser.rb
   brew audit --cask --new golden-browser/tap/golden-browser
   brew install --cask --force golden-browser/tap/golden-browser   # smoke test
   ```

6. Commit and push. `brew update` picks the tap change up on users' machines.

### Outstanding setup

- The app repo's `.github/workflows/release-macos.yml` currently creates its
  release in the **app** repo (`gh release create` with no `--repo`). It needs
  to target `golden-browser/homebrew-tap` instead, otherwise the artefacts
  land somewhere the cask cannot reach.
- The cask's `livecheck` block is commented out until a real release exists to
  validate the regex against.

## Licence

Golden Browser itself is proprietary software; the released binaries are
covered by their own end-user licence.
