# SeniorTube

A single-purpose Android app for elderly viewers: launching it goes straight
to a fullscreen, auto-playing YouTube playlist matched to the device country.
No menu, no buttons, no accounts, no data collection by the app.

Positioning: **phishing and scam protection for seniors**. Ads play normally,
but no tap can leave the player, so a mistaken touch never reaches a scam
page or an app-install funnel. Store-facing name is localized per country
("Senior Videos", "어르신 영상", "シニア向け動画", …) — see
`app/src/main/res/values-*/strings.xml`; "SeniorTube" is only the internal
project name.

Playlists are public YouTube playlists maintained by the developer; editing
them on YouTube updates every device with no app update
(`app/src/main/assets/playlists/playlists.json` maps country → playlist ID).

Runaway protection is navigation-level, not overlay-level: the embedded
player is never covered, ads play normally, but every attempt to leave the
bundled page (ad landing pages, `intent://` / `market://` install links,
popups, external browsers) is refused, so a stray tap can never carry the
viewer away from the playlist. Leaving the app in any way ends the session;
the next launch starts fresh.

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
