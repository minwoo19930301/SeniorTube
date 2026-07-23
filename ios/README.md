# SeniorTube for iPhone

This is the native iPhone version of SeniorTube. It uses UIKit and Apple's
`WKWebView`; Expo and CocoaPods are not required.

## What it does

- Opens directly in landscape fullscreen.
- Chooses the same country playlist used by the Android app.
- Starts playback automatically, shuffles, loops, and advances by itself.
- Uses YouTube's official IFrame Player API. Ads are not blocked or skipped.
- Keeps the player touchable and never places a shield over it.
- Disables picture-in-picture and stores no app state between sessions.
- Ends the current session when the app becomes inactive. Returning starts a
  fresh session.
- Sends a user-selected YouTube or ad link to the YouTube app or the system
  browser, as required by YouTube's player policy.

iOS can occasionally block audible autoplay. In that case, YouTube's own
player remains visible so the viewer can use its standard play control; the
app does not place a custom overlay on top.

## Open and run

Requirements: full Xcode with an iOS Simulator runtime.

1. Open `ios/SeniorTube.xcodeproj`.
2. Select the **SeniorTube** scheme and an iPhone simulator.
3. Press Run.

For a real iPhone or App Store archive, open the target's **Signing &
Capabilities** page, select your Apple Developer team, and replace
`org.seniortube.app` if that bundle ID is not registered to your team.

The committed Xcode project is generated from `ios/project.yml`. After
changing that file, regenerate it with:

```bash
brew install xcodegen
xcodegen generate --spec ios/project.yml
```

## Verify

```bash
ios/verify.sh
```

The script validates all property lists, the shared playlist selection
logic, and the player JavaScript. When full Xcode is installed it also builds
the iPhone Simulator target without signing.

The playlist source is shared with Android:
`app/src/main/assets/playlists/playlists.json`. Edit it once for both apps.
