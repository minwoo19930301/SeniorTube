# SeniorTube

An Android app that plays videos an older viewer wants to watch like a simple
favorites list. On launch, it opens a fullscreen, auto-playing YouTube playlist
maintained by the developer for the device country, repeats the playlist, and
handles unavailable videos by moving on to the next available item. There is
no menu, no account, and no data collection by the app.

The store release is still being prepared. Store-facing names are localized per
country ("Videos for Seniors", "어르신 영상", "シニア向け動画", …) — see
`app/src/main/res/values-*/strings.xml`; "SeniorTube" is the internal project
name.

Playlists are public YouTube playlists maintained by the developer; editing
them on YouTube updates every device with no app update
(`app/src/main/assets/playlists/playlists.json` maps country → playlist ID).

To keep the viewing flow simple, navigation is restricted at the WebView layer:
the embedded player is not covered and ads play normally, while attempts to
leave the bundled player page (ad landing pages, `intent://` / `market://`
install links, popups, and external browsers) are refused. Leaving the app in
any way ends the session; the next launch starts fresh.

## Build and install

JDK 17 + Android command-line tools (no Android Studio needed):

```bash
./gradlew :app:assembleDebug
adb install -r app/build/outputs/apk/debug/app-debug.apk
adb shell am start -n org.seniortube.app/.PlayerActivity
```

## Release (Play Store)

```bash
./gradlew :app:bundleRelease   # signed AAB → app/build/outputs/bundle/release/
```

Signing reads `key.properties` + `seniortube-release.keystore` at the repo
root — both gitignored. **Back the keystore up privately; losing it means
losing the ability to update the app on Google Play.**

Store documents:

- [docs/PRIVACY_POLICY.md](docs/PRIVACY_POLICY.md) — bilingual (EN/KR)
  privacy policy; fill `[CONTACT_EMAIL]` and `[EFFECTIVE_DATE]`, host it
  publicly, and link it in Play Console.
- [docs/STORE_LISTING.md](docs/STORE_LISTING.md) — per-country titles,
  short/full descriptions (EN/KR), reviewer notes, Data safety form
  cheat-sheet, content-rating guidance.
- `store-assets/icon-512.png` — Play Console listing icon.
