# Privacy Policy / 개인정보처리방침

**App:** SeniorTube (Android package / iOS bundle: `org.seniortube.app`)
**Effective date:** [EFFECTIVE_DATE]
**Contact:** [CONTACT_EMAIL]

This app appears in Google Play and the Apple App Store under localized plain names. All platform and language versions refer to the same app, and this policy covers all of them.

이 앱은 Google Play와 Apple App Store에서 국가·언어별 이름으로 표시됩니다. 플랫폼과 표시 이름이 달라도 모두 같은 앱이며, 이 방침 하나가 전부에 적용됩니다.

---

# English

## What this app is

SeniorTube is a simple video player made for elderly users. When you open it, it plays a public YouTube playlist chosen for your device's country in fullscreen. There are no accounts, menus, or setup screens. On an iPhone that blocks audible autoplay, one tap may be required to start the first video.

Ads inside the videos play normally; the app does not block, cover, click, or skip them. The iPhone version keeps YouTube's links functional: when the viewer chooses an external link, iOS opens it in the YouTube app or the system browser and the current SeniorTube session ends. Returning to SeniorTube starts a new session.

## The short version

- **We collect no data about you. None.**
- No accounts. No sign-in. No analytics. No advertising SDK.
- The app's only network activity is loading YouTube's own embedded video player.
- Google/YouTube may process some data as a third party, under Google's own privacy policy.
- Your device's country setting is read **on your device only**, to pick a playlist. The app never sends the setting itself anywhere — though YouTube can naturally see which country's playlist it is asked to play.
- We do not sell or share any data, because we have none.
- The app itself remembers nothing between sessions. Every launch starts fresh. The Android system WebView may keep YouTube cookies; the iPhone version uses a non-persistent web session.

## Data collected by the developer: none

The app has no way to identify you and no place to store information about you. It does not collect, store, or transmit:

- your name, email, phone number, or any account information (there are no accounts),
- your location,
- your viewing history or usage statistics,
- device identifiers or advertising identifiers,
- crash reports or analytics of any kind.

There is no analytics library and no advertising SDK inside the app. Android requests only the **INTERNET** permission. The iPhone app requests no sensitive device permissions.

## The only network connection: YouTube's embedded player

To play videos, the app loads YouTube's official embedded player in a built-in web view. This connects to Google's YouTube services, which use domains such as:

- `youtube.com` (the video player),
- `ytimg.com` (thumbnails and player images),
- `googlevideo.com` (the video streams themselves),
- Google's ad-serving domains (for example `doubleclick.net`) — the ads inside videos are served by YouTube/Google, not by the developer.

When the player loads, **Google/YouTube acts as an independent third party** and may process data (such as your IP address, or cookies within the player) according to its own rules. That processing is described in the Google Privacy Policy:

**https://policies.google.com/privacy**

We, the developer, do not receive any of that data and have no access to it.

## Your device's country setting

To choose which playlist to play, the app reads the country/locale already set on your device. This happens entirely **on your device**. The app itself never sends your country or locale anywhere as data — it only uses it locally to decide which public playlist address to open.

One honest caveat: because each playlist corresponds to a country, YouTube can see which playlist is requested — and, like any internet service, it can see your IP address — so it may infer your country that way. The country setting itself is never transmitted by the app.

## No selling, no sharing

We do not sell data. We do not share data with anyone. We could not even if we wanted to, because the app gives us no data in the first place.

## Nothing is remembered by the app between sessions

The app itself keeps no state. It stores no history, no settings, no profiles, and no identifiers. Closing the app and opening it again starts the playlist fresh, as if for the first time.

One exception sits outside our code: the Android system WebView may keep YouTube's own cookies or cached files between sessions. That storage belongs to Google/YouTube's player and is covered by the Google Privacy Policy above; the developer never reads or uses it. It can be cleared in Android settings (Apps → this app → Storage → Clear data). The iPhone version uses a non-persistent `WKWebView` data store, so its web session is discarded when the player session ends.

## Children

This app is made for elderly users and is **not directed at children under 13**. We do not knowingly collect personal information from children — in fact, the app collects no personal information from anyone, of any age.

## Google Play Data safety summary

This matches what we declare in the Google Play "Data safety" form:

| Question | Answer |
|---|---|
| Does the developer collect any data? | **No** |
| Does the developer share any data with third parties? | **No** |
| Is any data sold? | **No** |
| Data encrypted in transit? | Video traffic to YouTube uses HTTPS; the developer transmits no data at all |
| Can users request data deletion? | There is nothing to delete — no data is collected by the developer |
| Third-party notice | The app embeds YouTube's player; Google/YouTube may process data under the [Google Privacy Policy](https://policies.google.com/privacy) |

## Apple App Store privacy notice

Apple treats data sent through a fixed in-app web view as app privacy
information even when the developer does not receive that data. The App
Store privacy label must therefore reflect Google/YouTube's current data
practices for the embedded player. The developer still receives, stores, and
sells none of that data.

## Changes to this policy

If we ever change this policy, we will post the updated version at this same page and change the effective date at the top. Significant changes will also be stated in the app's update notes in Google Play and the Apple App Store. Because the app has no accounts, we cannot notify you personally, so this page is the place to check.

## Contact

Questions about this policy or the app: **[CONTACT_EMAIL]**

---

# 한국어 (Korean)

## 이 앱은 무엇인가요

SeniorTube(한국 스토어 이름: **어르신 영상**)는 어르신을 위한 아주 단순한 동영상 재생 앱입니다. 앱을 열면 기기의 국가에 맞는 공개 YouTube 재생목록이 전체 화면으로 재생됩니다. 계정, 메뉴, 설정 화면은 없습니다. iPhone이 소리 있는 자동재생을 막는 경우에만 첫 영상 시작을 위해 화면을 한 번 눌러야 할 수 있습니다.

영상 속 광고는 정상적으로 재생되며 앱이 광고를 차단·가림·클릭·건너뛰기 하지 않습니다. iPhone에서는 YouTube 링크도 정상 동작합니다. 이용자가 외부 링크를 선택하면 YouTube 앱 또는 시스템 브라우저로 열리고 SeniorTube의 현재 재생 세션은 끝납니다. 앱으로 돌아오면 새 세션으로 다시 시작합니다.

## 요약

- **개발자는 이용자에 대한 어떤 데이터도 수집하지 않습니다.**
- 계정 없음, 로그인 없음, 분석 도구 없음, 광고 SDK 없음.
- 앱이 인터넷을 사용하는 유일한 이유는 YouTube 공식 내장 플레이어를 불러오기 위해서입니다.
- Google/YouTube는 제3자로서 자체 개인정보처리방침에 따라 일부 데이터를 처리할 수 있습니다.
- 기기의 국가 설정은 재생목록 선택을 위해 **기기 안에서만** 읽으며, 앱이 그 설정값 자체를 외부로 전송하는 일은 없습니다. 다만 어느 나라 재생목록을 여는지는 YouTube 쪽에서 자연히 알 수 있습니다.
- 데이터를 판매하거나 공유하지 않습니다. 애초에 가진 데이터가 없습니다.
- 앱 자체는 아무것도 기억하지 않습니다. 켤 때마다 처음처럼 새로 시작합니다. Android 웹뷰는 YouTube 쿠키를 남길 수 있고, iPhone판은 비영구 웹 세션을 사용합니다.

## 개발자가 수집하는 데이터: 없음

이 앱에는 이용자를 식별할 방법도, 이용자 정보를 저장할 공간도 없습니다. 다음과 같은 정보를 수집·저장·전송하지 않습니다.

- 이름, 이메일, 전화번호 등 계정 정보(계정 자체가 없습니다)
- 위치 정보
- 시청 기록이나 사용 통계
- 기기 식별자, 광고 식별자
- 오류 보고서나 각종 분석 데이터

앱 안에 분석 라이브러리나 광고 SDK가 전혀 들어 있지 않습니다. Android가 요청하는 권한은 영상 재생에 필요한 **인터넷(INTERNET)** 하나뿐이며, iPhone판은 민감한 기기 권한을 요청하지 않습니다.

## 유일한 인터넷 연결: YouTube 내장 플레이어

영상 재생을 위해 앱은 내장 웹뷰에서 YouTube 공식 임베디드 플레이어를 불러옵니다. 이때 Google의 YouTube 서비스에 연결되며, 다음과 같은 도메인이 사용됩니다.

- `youtube.com` (동영상 플레이어)
- `ytimg.com` (썸네일 등 플레이어 이미지)
- `googlevideo.com` (실제 영상 스트림)
- Google 광고 송출 도메인(예: `doubleclick.net`) — 영상 속 광고는 개발자가 아니라 YouTube/Google이 송출합니다

플레이어가 실행되면 **Google/YouTube는 독립적인 제3자로서** 자체 기준에 따라 데이터(예: IP 주소, 플레이어 내 쿠키)를 처리할 수 있습니다. 그 내용은 Google 개인정보처리방침에 설명되어 있습니다.

**https://policies.google.com/privacy**

개발자는 그 데이터를 전달받지 않으며, 접근할 수도 없습니다.

## 기기의 국가 설정

어떤 재생목록을 틀지 정하기 위해, 앱은 기기에 이미 설정된 국가/언어 정보를 읽습니다. 이 과정은 전부 **기기 안에서만** 이루어집니다. 앱이 국가나 언어 설정값을 데이터로 외부에 보내는 일은 없으며, 어떤 공개 재생목록 주소를 열지 기기 안에서 정하는 데에만 사용합니다.

솔직하게 한 가지 밝혀 둘 점이 있습니다. 재생목록이 국가별로 나뉘어 있으므로 어느 재생목록이 요청되었는지는 YouTube가 알 수 있고, 다른 모든 인터넷 서비스와 마찬가지로 IP 주소도 볼 수 있어 이를 통해 국가를 추정할 수는 있습니다. 다만 앱이 국가 설정값 자체를 전송하는 일은 없습니다.

## 판매·공유 없음

데이터를 판매하지 않고, 누구와도 공유하지 않습니다. 앱이 개발자에게 주는 데이터 자체가 없으므로, 하고 싶어도 할 수 없습니다.

## 앱은 세션 간에 아무것도 남기지 않습니다

앱 자체는 어떤 상태도 보관하지 않습니다. 시청 기록, 설정, 프로필, 식별자를 저장하지 않으며, 앱을 껐다 다시 켜면 재생목록이 처음처럼 새로 시작됩니다.

한 가지 예외는 개발자 코드 밖에 있습니다. Android 시스템 웹뷰는 YouTube 자체 쿠키나 캐시 파일을 세션 사이에 남길 수 있습니다. 이는 Google/YouTube 플레이어의 저장 공간이며(위의 Google 개인정보처리방침 적용), 개발자는 이를 읽거나 사용하지 않습니다. Android 설정(애플리케이션 → 이 앱 → 저장공간 → 데이터 삭제)에서 지울 수 있습니다. iPhone판은 비영구 `WKWebView` 데이터 저장소를 사용하므로 재생 세션이 끝날 때 해당 웹 세션도 폐기됩니다.

## 아동 관련 안내

이 앱은 어르신을 위해 만들어졌으며 **만 13세 미만 아동을 대상으로 하지 않습니다**. 아동의 개인정보를 의도적으로 수집하지 않습니다. 실제로는 나이와 관계없이 누구의 개인정보도 수집하지 않습니다.

## Google Play 데이터 보안(Data safety) 요약

Google Play "데이터 보안" 양식에 신고한 내용과 동일합니다.

| 항목 | 답변 |
|---|---|
| 개발자가 데이터를 수집하나요? | **아니요** |
| 개발자가 제3자와 데이터를 공유하나요? | **아니요** |
| 데이터를 판매하나요? | **아니요** |
| 전송 중 암호화 여부 | YouTube 영상 트래픽은 HTTPS를 사용하며, 개발자는 어떤 데이터도 전송하지 않습니다 |
| 데이터 삭제 요청 가능 여부 | 삭제할 데이터가 없습니다 — 개발자가 수집하는 데이터가 없기 때문입니다 |
| 제3자 고지 | 앱은 YouTube 플레이어를 내장하며, Google/YouTube는 [Google 개인정보처리방침](https://policies.google.com/privacy)에 따라 데이터를 처리할 수 있습니다 |

## Apple App Store 개인정보 표시

Apple은 고정된 앱 내 웹뷰를 통해 전송되는 정보도 개발자가 직접
받는지와 관계없이 App Store 개인정보 표시 대상에 포함합니다.
따라서 App Store의 개인정보 답변은 YouTube 내장 플레이어의 최신
데이터 처리 내용을 반영해야 합니다. 개발자는 해당 데이터를
전달받거나 저장·판매하지 않습니다.

## 방침 변경 시 안내

이 방침이 변경되면 같은 페이지에 새 버전을 게시하고 상단의 시행일을 갱신합니다. 중요한 변경은 Google Play와 Apple App Store 업데이트 노트에도 분명히 알리겠습니다. 이 앱에는 계정이 없어 개별 연락이 불가능하므로, 이 페이지가 공식 확인 창구입니다.

## 문의

이 방침이나 앱에 대한 문의: **[CONTACT_EMAIL]**
