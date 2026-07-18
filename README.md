# SeniorTube

A single-purpose Android app for elderly viewers: launching it goes straight
to a fullscreen, auto-playing YouTube playlist matched to the device country.
No menu, no buttons, no accounts, no data collection by the app.

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

Private distribution only for now (family devices via sideloading).
