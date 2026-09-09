cask "golden-browser" do
  # ===========================================================================
  # PLACEHOLDER CASK — NOT INSTALLABLE YET
  #
  # Golden Browser has not had its first public release, so there is no
  # artefact behind `url` and no real checksum for `sha256`. The `sha256`
  # below is a deliberate all-zeros placeholder, so a `brew install --cask`
  # attempt fails fast on a download/checksum error instead of installing
  # something unverified.
  #
  # Do NOT use `sha256 :no_check` here: the docs reserve it for casks whose
  # `url` is stable across releases, and ours is versioned, so it would
  # silently accept whatever bytes the URL happens to serve.
  #
  # TODO(first release): after the release is published, update all three of
  #   1. `version` — marketing version + build number (see note below),
  #   2. `sha256`  — `shasum -a 256 golden-browser-<version>-macos.zip`,
  #   3. the `livecheck` block — uncomment and confirm it resolves.
  # ===========================================================================

  # Two-part version, comma-joined so `version.csv` can split it. The comma
  # form is required because the release tag and the artefact filename need
  # different pieces:
  #   tag      -> v0.3.0                            (marketing version only)
  #   artefact -> golden-browser-0.3.0+1-macos.zip  (both, joined with "+")
  #
  # NOTE: the build number is the GitHub Actions run number of the release
  # job, not something derived from the tag or from pubspec.yaml. Read it off
  # the published asset's filename rather than assuming it increments by one.
  version "0.3.0,1"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/golden-browser/homebrew-tap/releases/download/v#{version.csv.first}/golden-browser-#{version.csv.first}+#{version.csv.second}-macos.zip",
      verified: "github.com/golden-browser/homebrew-tap/"
  name "Golden Browser"
  desc "Reviewer for Flutter golden test images across git history"
  homepage "https://goldenbrowser.app/"

  # TODO(first release): the tag only carries the marketing version, so the
  # run-number half of `version` cannot be recovered from the tag alone.
  # Match the asset filename instead, then verify with `brew livecheck`.
  # livecheck do
  #   url :url
  #   strategy :github_latest do |json, regex|
  #     json["assets"]&.map { |asset| asset["name"][regex, 1]&.tr("+", ",") }
  #   end
  #   regex(/golden-browser[._-]v?(\d+(?:\.\d+)+\+\d+)-macos\.zip/i)
  # end

  # Pixel diffing is delegated to odiff, so Homebrew pulls it in for us.
  depends_on formula: "odiff"
  depends_on macos: :monterey

  app "Golden Browser.app"

  zap trash: [
    "~/Library/Application Support/me.wolszon.goldenBrowser",
    "~/Library/Caches/me.wolszon.goldenBrowser",
    "~/Library/HTTPStorages/me.wolszon.goldenBrowser",
    "~/Library/Preferences/me.wolszon.goldenBrowser.plist",
    "~/Library/Saved Application State/me.wolszon.goldenBrowser.savedState",
  ]
end
