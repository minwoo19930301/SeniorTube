# SeniorTube — Google Play Store Listing Kit

Package: `org.seniortube.app` · Launch countries with filled playlists: US, GB, KR, JP, IN, PK, BR, MX, DE, FR
Play limits: **title 30 chars · short description 80 chars · full description 4,000 chars.**

---

## 1. App title per country

Strategy: per-country **plain descriptive names** ("videos for seniors" in the local language), never the "SeniorTube" brand in any store surface, to avoid YouTube/"Tube" trademark friction. Backup latin brand if one is ever needed: **SeniorYT**.

> **Source of truth:** the final store title for each language must be copied from the app's localized `android:label` (per-locale `strings.xml` → `app_name`) so the launcher icon name and the store name always match. Note: `app/src/main/res/values/strings.xml` currently still says `SeniorTube` and has no locale variants — add `values-ko/`, `values-ja/`, etc. before submitting. The names below are the proposed values in that style, not final copy.

| Country | Play listing locale | Proposed title | Chars |
|---|---|---|---|
| US | en-US (default) | Videos for Seniors | 18 |
| GB | en-GB | Videos for Seniors | 18 |
| KR | ko-KR | 노인용 영상 | 6 |
| JP | ja-JP | シニア向け動画 | 7 |
| IN | hi-IN (+ keep en-IN = English title) | बुज़ुर्गों के लिए वीडियो | ~24 |
| PK | ur | بزرگوں کے لیے ویڈیوز | ~20 |
| BR | pt-BR | Vídeos para Idosos | 18 |
| MX | es-419 | Videos para Adultos Mayores | 27 |
| DE | de-DE | Videos für Senioren | 19 |
| FR | fr-FR | Vidéos pour Seniors | 19 |

Notes:
- Play store listings are keyed by **language**, not country. To force a specific name/text in a specific country (e.g., different Spanish for MX vs ES), use **Custom store listings** with country targeting; otherwise the language listing serves all countries with that language.
- Title policy: no emoji, no ALL CAPS words, no ranking/promo terms ("best", "#1", "free"), and do not put "YouTube" in the title. Factual mention of YouTube inside the description is fine (see §3 disclaimer line).

---

## 2. Short description (max 80 chars)

**English (74 chars):**
```
Fullscreen videos for seniors. Ads play, but no tap can reach a scam page.
```

**Korean (49 chars):**
```
실행하면 바로 영상. 광고는 나와도, 어떤 터치도 사기·피싱 페이지로 이동하지 않습니다.
```

---

## 3. Full description (max 4,000 chars)

### English (~1,900 chars)

```
Every day, seniors lose money to a single mistaken tap. An ad appears, a shaky finger touches the screen, and suddenly they are on a fake prize page, a phishing form, or an "install this app now" funnel — with no idea how they got there or how to get back.

This app exists to make that impossible.

HOW IT WORKS
Open the app and a fullscreen playlist of videos for your country starts playing immediately — old songs, nature scenery, gentle exercise, and more, chosen for older viewers. There are no menus, no buttons, no accounts, and nothing to set up.

Ads play exactly as normal. This app never blocks, hides, or skips ads. The difference is what happens after a tap: any attempt to leave the safe player — an ad's landing page, an app-install link, a popup, an external browser — is simply refused. The video keeps playing. A mistaken tap can never carry the viewer to a scam page.

MADE FOR SENIORS
• One tap on the icon → videos start playing, fullscreen
• No login, no registration, no menus, no settings
• The back gesture or the power button ends the session
• Every launch starts fresh — nothing to get stuck in
• Playlists matched to the device's country and language

BUILT ON THE OFFICIAL PLAYER
Videos are public YouTube playlists maintained by the developer, played through the official YouTube embedded player. This app is not affiliated with, sponsored by, or endorsed by YouTube or Google. YouTube is a trademark of Google LLC.

PRIVACY
The app itself collects no data at all: no analytics, no advertising SDK, no accounts. Its only permission is internet access, used to load the video player. YouTube may collect data as a third-party service under its own privacy policy, exactly as it would in any browser.

FOR FAMILIES
Install it on a parent's or grandparent's phone or tablet, and know that whatever they tap, they stay inside the player. That is the whole app.
```

### Korean (~950 chars)

```
어르신들이 화면을 잘못 한 번 눌렀다가 사기를 당하는 일이 매일 일어납니다. 광고가 나오고, 떨리는 손가락이 화면에 닿는 순간, 가짜 경품 페이지·피싱 입력창·"지금 이 앱을 설치하세요" 화면으로 끌려갑니다. 어떻게 왔는지도, 어떻게 돌아가는지도 알 수 없습니다.

이 앱은 그런 일이 아예 일어날 수 없게 만듭니다.

■ 어떻게 작동하나요
앱을 열면 곧바로 전체화면으로 영상이 재생됩니다. 옛날 가요, 자연 풍경, 가벼운 체조 등 어르신을 위해 고른 영상이 나라별로 준비되어 있습니다. 메뉴도, 버튼도, 회원가입도, 설정도 없습니다.

광고는 평소처럼 그대로 재생됩니다. 이 앱은 광고를 차단하거나 가리거나 건너뛰지 않습니다. 다른 점은 '터치한 다음'입니다. 광고 페이지, 앱 설치 링크, 팝업, 외부 브라우저 등 재생 화면을 벗어나려는 모든 이동을 거부합니다. 영상은 계속 재생되고, 잘못 누른 손가락이 어르신을 사기 페이지로 데려가는 일은 절대 없습니다.

■ 어르신을 위한 설계
• 아이콘 한 번 → 바로 전체화면 영상 재생
• 로그인·가입·메뉴·설정 없음
• 뒤로 가기 또는 화면 잠금으로 종료
• 실행할 때마다 처음부터 새로 시작 — 어딘가에 갇힐 일이 없음
• 기기 국가에 맞는 재생목록 자동 선택

■ 공식 플레이어 기반
영상은 개발자가 관리하는 공개 YouTube 재생목록이며, 공식 YouTube 임베드 플레이어로 재생됩니다. 이 앱은 YouTube 또는 Google과 제휴·후원·보증 관계가 없습니다. YouTube는 Google LLC의 상표입니다.

■ 개인정보
앱 자체는 어떤 데이터도 수집하지 않습니다. 분석 도구도, 광고 SDK도, 계정도 없습니다. 필요한 권한은 영상을 불러오기 위한 인터넷 접근뿐입니다. YouTube는 일반 브라우저에서와 마찬가지로 자체 개인정보처리방침에 따라 제3자로서 데이터를 수집할 수 있습니다.

■ 가족을 위해
부모님, 조부모님의 휴대폰이나 태블릿에 설치해 두세요. 무엇을 누르셔도 재생 화면 밖으로 나가지 않습니다. 이 앱이 하는 일은 그게 전부입니다.
```

---

## 4. App review notes (for Google reviewers)

Paste into "App access / notes for review" (and reuse in any policy-appeal reply):

> To the review team: This app plays developer-maintained public YouTube playlists exclusively through the **official YouTube embedded (IFrame) player**, loaded from youtube.com inside a WebView. It does **not** block, hide, mute, skip, or overlay ads in any way — ads render and play exactly as YouTube serves them — and it never simulates, injects, or automates any click, tap, or input on the user's behalf. The only intervention the app makes is at the **page-navigation layer**: because it is built for elderly users, who are frequent targets of ad-borne phishing pages and app-install funnels, the WebView refuses navigations that would leave the bundled player page (ad landing pages, `intent://` and `market://` links, popups/`window.open`, and hand-offs to external browsers). Nothing is removed or altered on the page; when a navigation is refused, the current video simply continues playing. This is a senior-safety measure, not an ad-related modification. The app has no login and no account system, bundles no third-party SDKs, collects no data of any kind, and requests only the `INTERNET` permission. It is not affiliated with YouTube or Google, and the store listing states this explicitly. No credentials are needed to review: install, launch, and the playlist for the device's country plays fullscreen; the back gesture exits.

---

## 5. Data safety form — cheat sheet (exact selections)

Play Console → App content → **Data safety**:

| Question | Select |
|---|---|
| Does your app collect or share any of the required user data types? | **No** |
| (All subsequent data-type / encryption / deletion questions) | *Not shown — questionnaire ends* |
| Resulting store badge | "No data collected" |

Supporting declarations elsewhere in **App content** (do these at the same time):

| Item | Select | Why |
|---|---|---|
| Privacy policy URL | **Provide one** (mandatory for every app) | Host a short page: "The app collects no data; only permission is INTERNET; content is loaded from youtube.com, where Google may collect data under its own privacy policy (link it)." |
| Ads → "Does your app contain ads?" | **Yes** ("Contains ads" label) | YouTube serves ads inside the embed. Declaring Yes is the safe, truthful answer and matches the listing copy ("ads play"). |
| App access | **All functionality available without special access** | No login exists. |
| Account creation / deletion question | **No, users can't create an account** | No accounts. |
| Target audience and content | Age groups: **18 and over only** | The app targets seniors; never tick any under-18 group or you enter Families policy review. |
| News app / COVID-19 app / Government app / Financial features / Health | **No / None** for all | N/A. |

WebView gray area, in case a reviewer asks: the Data safety form covers data collected by the app and by SDKs **bundled in the APK**. This app bundles nothing and transmits nothing itself; data collected by youtube.com inside the WebView is Google acting as an independent third party (same as a browser visiting the site). Disclose that in the privacy-policy text (as above), not in the form.

---

## 6. Category, tags, content rating

**Category** (Store settings):
- App type: **App**
- Category: **Video Players & Editors** (function-accurate; the app is a locked-down player). Acceptable alternative: Entertainment.

**Tags** (pick up to 5 from the console's fixed list; suggested, in priority order): Video streaming · Entertainment · Music streaming · TV / Video. Skip anything implying downloads or ad-blocking.

**Content rating questionnaire (IARC):**
- Email: your developer contact.
- Category: **"Utility, Productivity, Communication, or Other" (All Other App Types)** — not "Social/UGC sharing": users cannot browse, search, upload, or interact; they can only watch developer-curated playlists.
- Violence / sexuality / language / controlled substances / gambling themes: **No** to all (playlists are oldies music, nature, light exercise — keep curating to that standard, since you, not users, control content).
- Does the app allow users to interact or exchange information? **No**
- Does the app share the user's current location with others? **No**
- Does the app allow purchase of digital goods? **No**
- Does the app contain user-generated content? / unrestricted web access (e.g., a browser)? **No** — this is truthful precisely because of the navigation lock: users cannot reach any content outside the curated playlists; that lock is the product.
- Expected result: **Everyone / PEGI 3 / all-ages equivalents.**
- Honest caveat: if you ever add search, browsing, or user-chosen content, the UGC answer flips to Yes and the rating rises (typically Teen) — re-file the questionnaire then.

---

### Repo touchpoints
- `/Users/minwokim/Documents/SeniorTube/app/src/main/res/values/strings.xml` — `app_name` is still `SeniorTube`; add per-locale values matching the §1 table before store submission.
- `/Users/minwokim/Documents/SeniorTube/app/src/main/assets/playlists/playlists.json` — country → playlist map backing the §1 launch-country list.
- `/Users/minwokim/Documents/SeniorTube/README.md` — source for the navigation-lock behavior described in §3–§4.
