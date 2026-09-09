# Golden Browser — Homebrew tap

Homebrew tap for [**Golden Browser**](https://goldenbrowser.app) — a macOS app
for reviewing Flutter golden test images across git history.

## Install

```sh
brew trust golden-browser/tap
brew tap golden-browser/tap
brew install --cask golden-browser
```

`brew trust` comes first, and is not optional: Homebrew 6.0 stopped loading
casks from third-party taps without it, and `brew tap` fails with the
misleading `invalid syntax in tap!` until the tap is trusted.

Homebrew pulls in [`odiff`](https://github.com/dmtrKovalenko/odiff)
automatically — Golden Browser delegates pixel diffing to it.

Requires macOS 12 (Monterey) or newer. The app is Developer ID signed and
notarized, so Gatekeeper accepts it without a right-click-to-open dance.

## Upgrading

```sh
brew update && brew upgrade --cask golden-browser
```
