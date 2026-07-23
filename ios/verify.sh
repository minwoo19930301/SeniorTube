#!/bin/zsh
set -euo pipefail

SENIORTUBE_REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SENIORTUBE_VERIFY_DIR="$(mktemp -d "${TMPDIR:-/tmp}/seniortube-ios.XXXXXX")"

cleanup() {
  if [[ -n "${SENIORTUBE_VERIFY_DIR:-}" && -d "$SENIORTUBE_VERIFY_DIR" ]]; then
    rm -rf "$SENIORTUBE_VERIFY_DIR"
  fi
}
trap cleanup EXIT

cd "$SENIORTUBE_REPO_DIR"

find ios/SeniorTube -type f \( -name '*.plist' -o -name '*.xcprivacy' \) -print0 \
  | xargs -0 -n 1 plutil -lint
find ios/SeniorTube/Resources -type f -name '*.strings' -print0 \
  | xargs -0 -n 1 plutil -lint
xmllint --noout \
  ios/SeniorTube/Resources/Base.lproj/LaunchScreen.storyboard

swiftc -parse \
  ios/SeniorTube/AppDelegate.swift \
  ios/SeniorTube/SceneDelegate.swift \
  ios/SeniorTube/PlaylistSource.swift \
  ios/SeniorTube/PlayerViewController.swift

swiftc \
  ios/SeniorTube/PlaylistSource.swift \
  ios/SmokeTests/main.swift \
  -o "$SENIORTUBE_VERIFY_DIR/playlist-smoke"
"$SENIORTUBE_VERIFY_DIR/playlist-smoke" \
  app/src/main/assets/playlists/playlists.json

node - <<'NODE'
const fs = require("fs");
const html = fs.readFileSync(
  "ios/SeniorTube/Resources/player-ios.html",
  "utf8"
);
const matches = [...html.matchAll(/<script>([\s\S]*?)<\/script>/g)];
if (matches.length !== 1) {
  throw new Error(`Expected one inline script, found ${matches.length}`);
}
const script = matches[0][1]
  .replace("__SOURCE_JSON__", '{"videos":["example"]}')
  .replace("__APP_ORIGIN_JSON__", '"https://org.seniortube.app"');
new Function(script);

const catalog = JSON.parse(
  fs.readFileSync(
    "app/src/main/assets/playlists/playlists.json",
    "utf8"
  )
);
if (!catalog.default_country || !catalog.countries[catalog.default_country]) {
  throw new Error("Playlist catalog default country is invalid");
}
console.log("Player JavaScript and playlist JSON checks passed.");
NODE

SENIORTUBE_ICON_INFO="$(
  sips -g hasAlpha -g pixelWidth -g pixelHeight \
    ios/SeniorTube/Resources/Assets.xcassets/AppIcon.appiconset/Icon-1024.png
)"
if [[ "$SENIORTUBE_ICON_INFO" != *"hasAlpha: no"* \
  || "$SENIORTUBE_ICON_INFO" != *"pixelWidth: 1024"* \
  || "$SENIORTUBE_ICON_INFO" != *"pixelHeight: 1024"* ]]; then
  print -u2 "The App Store icon must be 1024×1024 with no alpha channel."
  exit 1
fi
print "App Store icon check passed."

if command -v xcodegen >/dev/null 2>&1; then
  xcodegen generate --spec ios/project.yml --quiet
fi

if [[ -d /Applications/Xcode.app ]]; then
  SENIORTUBE_DEV_DIR="/Applications/Xcode.app/Contents/Developer"
  SENIORTUBE_DERIVED="$SENIORTUBE_VERIFY_DIR/DerivedData"
  DEVELOPER_DIR="$SENIORTUBE_DEV_DIR" xcodebuild \
    -project ios/SeniorTube.xcodeproj \
    -scheme SeniorTube \
    -configuration Debug \
    -destination 'generic/platform=iOS Simulator' \
    -derivedDataPath "$SENIORTUBE_DERIVED" \
    CODE_SIGNING_ALLOWED=NO \
    build
else
  print "Xcode/iOS SDK not installed; project build check skipped."
fi
