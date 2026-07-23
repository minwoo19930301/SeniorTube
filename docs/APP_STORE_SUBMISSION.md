# SeniorTube — App Store submission checklist

This checklist is for the native iPhone target in `ios/`.

## Before the first archive

- Install full Xcode and an iOS Simulator runtime.
- In **Signing & Capabilities**, choose the team's Apple Developer account.
- Choose a neutral public app identity that does not contain `YouTube`,
  `YT`, `Tube`, or a confusing variation. The localized launcher names are
  already neutral, but replace the placeholder `org.seniortube.app` with a
  bundle ID owned by your team **before** creating the App Store record.
- Fill `[CONTACT_EMAIL]` and `[EFFECTIVE_DATE]` in
  `docs/PRIVACY_POLICY.md`, publish it at a public HTTPS URL, and enter that
  URL in App Store Connect.
- Confirm every live public playlist and sampled video allows embedding,
  contains no political or unsafe material for its launch country, and is
  appropriate for the selected age rating.
- Test on a physical iPhone. Audible autoplay, ads, external links, rotation,
  interruption handling, and returning from Safari can differ from the
  Simulator.

## Product work still required for App Review

The current iPhone target intentionally preserves the no-menu, full-player
prototype. Before App Store submission, make and implement these product
decisions:

- Add an easily accessible native **Privacy / Help** route. Apple requires
  the privacy-policy link both in App Store Connect and inside the app.
  Place it beside the player or on a separate native screen; never overlay
  any part of the YouTube player.
- Add a visible way to report inappropriate videos or ads, plus a published
  contact/removal process. First verify on a physical iPhone which reporting
  controls YouTube already supplies.
- Resolve consent and tracking. If the embedded player tracks across apps or
  sites, implement Apple's App Tracking Transparency flow before loading it.
  For the EEA, UK, and Switzerland, also confirm Google's current cookie and
  ad-consent requirements.
- Add enough native value to pass guideline 4.2. A small caregiver setup for
  allowed countries, interests, or playlist categories is the strongest
  addition while keeping the elderly viewing screen simple.

These cannot be truthfully finalized in code until the team chooses its
public privacy URL, support contact, final bundle ID, consent regions, and
caregiver flow.

## App behavior reviewers should see

- The app opens directly to a country-matched, curated playlist in landscape.
- The official YouTube IFrame player fills the screen.
- Ads, YouTube branding, and player behavior are not covered or modified.
- If iOS blocks autoplay, the viewer can use YouTube's own visible play
  control; the app adds no overlay.
- A YouTube or ad link opens in the YouTube app or system browser. The
  current player session ends, and returning starts fresh.
- There is no account, tracking SDK, background playback, or PiP.

Suggested review note:

> Senior Videos is a senior-accessibility viewing app, not a general web
> wrapper. It selects a developer-maintained public playlist for the
> device's country and provides a zero-setup, landscape, fresh-session
> experience for elderly viewers. Playback uses only YouTube's official
> IFrame Player API. The app does not block, cover, click, or skip ads and
> does not obscure the player. YouTube links remain functional and open
> through the YouTube app or system browser. No login is required.

## App Privacy

Do not automatically choose **“No data collected.”** Apple says data sent
through a fixed in-app web view must be declared unless the user is simply
navigating the open web. SeniorTube opens a fixed YouTube player, so the App
Store Connect answers must include the current data practices of
Google/YouTube's embedded player, even though the SeniorTube developer
receives none of that data.

Before submitting, compare the player traffic and Google's current privacy
documentation with every App Store Connect data category. Keep the public
privacy policy consistent with those answers.

Do not add an empty `PrivacyInfo.xcprivacy` file as a substitute for these
answers. Add a privacy manifest only after Xcode's privacy report and the
actual WebView traffic establish which declarations belong in it.

Official references:

- [Apple App Privacy Details](https://developer.apple.com/app-store/app-privacy-details/)
- [Manage App Privacy in App Store Connect](https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy/)
- [Apple User Privacy and Data Use](https://developer.apple.com/app-store/user-privacy-and-data-use/)
- [Google Privacy Policy](https://policies.google.com/privacy)
- [Google EU User Consent Policy](https://www.google.com/about/company/user-consent-policy/)

## YouTube and App Review compliance

The iPhone target intentionally:

- uses Apple's `WKWebView`,
- identifies the app with an HTTPS base URL made from its bundle ID,
- leaves the player unobscured,
- does not block or skip advertisements,
- does not automate taps or clicks, and
- lets selected links open in the YouTube app or system browser.

Do not add a transparent touch shield, an “ad is playing” overlay, custom ad
skipping, or navigation cancellation for YouTube links. Those changes create
YouTube policy and App Review risks.

Official references:

- [YouTube Required Minimum Functionality](https://developers.google.com/youtube/terms/required-minimum-functionality)
- [YouTube Developer Policies Guide](https://developers.google.com/youtube/terms/developer-policies-guide)
- [Apple App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

Apple guideline 4.2 can reject a thin web wrapper. The review note,
screenshots, and demo should clearly show SeniorTube's independent value:
country-specific human curation, senior-focused zero-setup interaction,
fresh-session behavior, and accessibility.

## Final upload

1. Increment `MARKETING_VERSION` and `CURRENT_PROJECT_VERSION` when needed.
2. Run `ios/verify.sh`.
3. In Xcode, select **Any iOS Device (arm64)** and
   **Product → Archive**.
4. Validate the archive, then upload it to App Store Connect.
5. Complete content rights, age rating, privacy, export compliance,
   screenshots, description, support URL, and review notes truthfully.
6. Test the uploaded build through TestFlight with at least one elderly user
   before requesting App Review.
