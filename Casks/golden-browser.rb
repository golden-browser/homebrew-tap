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
  version "0.6.2,28"
  sha256 "ae48638783f8209b5dc8cf9302bf9b9b29119ccbca699e61894c95f386b72ae2"

  auto_updates true

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

  # odiff ships inside the app (Contents/Helpers) from 0.5.0 on.
  depends_on macos: :ventura

  app "Golden Browser.app"

  zap trash: [
    "~/Library/Application Support/me.wolszon.goldenBrowser",
    "~/Library/Caches/me.wolszon.goldenBrowser",
    "~/Library/HTTPStorages/me.wolszon.goldenBrowser",
    "~/Library/Preferences/me.wolszon.goldenBrowser.plist",
    "~/Library/Saved Application State/me.wolszon.goldenBrowser.savedState",
  ]
end
