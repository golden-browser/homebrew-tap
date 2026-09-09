cask "golden-browser" do
  # Two-part version, comma-joined so `version.csv` can split it. The comma
  # form is required because the release tag and the artefact filename need
  # different pieces:
  #   tag      -> v0.3.0                            (marketing version only)
  #   artefact -> golden-browser-0.3.0+1-macos.zip  (both, joined with "+")
  #
  # NOTE: the build number is the GitHub Actions run number of the release
  # job, not something derived from the tag or from pubspec.yaml. Read it off
  # the published asset's filename rather than assuming it increments by one.
  version "0.3.3,18"
  sha256 "f457795270b4dadf9720fb386333c814d8ac06961ac435e18d6c7c558c401612"

  url "https://github.com/golden-browser/homebrew-tap/releases/download/v#{version.csv.first}/golden-browser-#{version.csv.first}+#{version.csv.second}-macos.zip"
  name "Golden Browser"
  desc "Reviewer for Flutter golden test images across git history"
  homepage "https://goldenbrowser.app/"

  # Not enabled yet: the tag carries only the marketing version, so the
  # run-number half has to be matched off the asset filename instead.
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
