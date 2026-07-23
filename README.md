# SeniorTube

A single-purpose Android and iPhone app for elderly viewers. Launching it
goes straight to a fullscreen, auto-playing YouTube playlist matched to the
device country. There are no menus, accounts, or setup screens, and the app
itself collects no data.

Ads play normally and the official YouTube player is never covered by a
touch shield. Leaving the app ends the current session; returning starts a
fresh one. On iPhone, a user-selected YouTube or ad link opens through the
YouTube app or the system browser, as required by YouTube's player policy.

The store-facing name is localized per country ("Senior Videos", "어르신
영상", "シニア向け動画", …); "SeniorTube" is only the internal project
name.

Both apps share one source of truth for public playlists:
`app/src/main/assets/playlists/playlists.json`. Editing a maintained public
playlist on YouTube updates every device without an app update.

## Android: build and install

JDK 17 + Android command-line tools (no Android Studio needed):

```bash
./gradlew :app:assembleDebug
adb install -r app/build/outputs/apk/debug/app-debug.apk
adb shell am start -n org.seniortube.app/.PlayerActivity
```

## iPhone: open and run

The native UIKit/WKWebView project is committed at
`ios/SeniorTube.xcodeproj`; Expo and CocoaPods are not required.

1. Install full Xcode and an iOS Simulator runtime.
2. Open `ios/SeniorTube.xcodeproj`.
3. Choose the **SeniorTube** scheme and an iPhone simulator, then Run.

For a physical iPhone or App Store archive, select your Apple Developer team
under **Signing & Capabilities** and register the bundle ID
`org.seniortube.app` (or replace it with one owned by your team).

More details and verification commands are in
[`ios/README.md`](ios/README.md).

## Android release (Play Store)

```bash
./gradlew :app:bundleRelease   # signed AAB → app/build/outputs/bundle/release/
```

Signing reads `key.properties` + `seniortube-release.keystore` at the repo
root — both gitignored. **Back the keystore up privately; losing it means
losing the ability to update the app on Google Play.**

Store documents:

- [docs/PRIVACY_POLICY.md](docs/PRIVACY_POLICY.md) — bilingual (EN/KR)
  privacy policy; fill `[CONTACT_EMAIL]` and `[EFFECTIVE_DATE]`, host it
  publicly, and link it in each store.
- [docs/STORE_LISTING.md](docs/STORE_LISTING.md) — Play Store titles,
  descriptions, reviewer notes, and Data safety guidance.
- `store-assets/icon-512.png` — Play Console listing icon.

## iPhone release (App Store)

Archive the **SeniorTube** scheme in Xcode after choosing your signing team.
The iPhone target includes localized display names, a non-alpha 1024px App
Store icon, landscape-only presentation, and no sensitive permission
requests. Follow
[`docs/APP_STORE_SUBMISSION.md`](docs/APP_STORE_SUBMISSION.md) before
uploading a build.
