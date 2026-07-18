package org.seniortube.app;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

/**
 * SeniorTube is only this screen: launching the app goes straight to a
 * fullscreen, auto-playing, auto-advancing playlist chosen by the device
 * country. There is no menu and there are no on-screen controls.
 *
 * The embedded player surface is never covered by any overlay. Runaway
 * protection is navigation-level instead: the WebViewClient refuses every
 * attempt to leave the bundled page (ad landing pages, intent:// and
 * market:// app-install links, external browsers, popup windows), so a tap
 * on an ad registers with the player but can never carry the viewer away
 * from the playlist. Ads are never blocked, skipped, hidden, or clicked by
 * the app itself; while one may be playing, a passive notice is shown.
 *
 * No picture-in-picture and no state between sessions: leaving the app in
 * any way ends the session, and the next launch starts fresh.
 */
public final class PlayerActivity extends Activity {

    private WebView webView;
    private TextView adNotice;
    private TextView unavailableNotice;
    private String sourceJson;

    @SuppressLint("SetJavaScriptEnabled")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_player);

        adNotice = findViewById(R.id.ad_notice);
        unavailableNotice = findViewById(R.id.unavailable_notice);
        webView = findViewById(R.id.player_webview);

        sourceJson = loadSourceForCountry();

        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setMediaPlaybackRequiresUserGesture(false);
        webView.getSettings().setSupportMultipleWindows(true); // popups get no window
        webView.getSettings().setJavaScriptCanOpenWindowsAutomatically(false);
        webView.addJavascriptInterface(new Bridge(), "SeniorTube");
        webView.setWebViewClient(new WebViewClient() {
            // The only page is our bundled player. Every navigation attempt —
            // links, redirects, intent:// and app deep links, the YouTube app,
            // external browsers — is ignored.
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return true;
            }
        });

        showAdNotice();
        // Any well-formed https origin works for the embed; claiming to be
        // youtube.com itself gets rejected by the player.
        webView.loadDataWithBaseURL(
                "https://seniortube.invalid",
                readAsset("player.html"),
                "text/html",
                "utf-8",
                null);
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus) {
            enterImmersiveMode();
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        // Screen lock, home, or task switch all end the session; re-entering
        // starts fresh. No state survives.
        finish();
    }

    @Override
    protected void onDestroy() {
        if (webView != null) {
            webView.loadUrl("about:blank");
            webView.destroy();
            webView = null;
        }
        super.onDestroy();
    }

    private void enterImmersiveMode() {
        getWindow().getDecorView().setSystemUiVisibility(
                View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                        | View.SYSTEM_UI_FLAG_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                        | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION);
    }

    private void showAdNotice() {
        runOnUiThread(() -> adNotice.setVisibility(View.VISIBLE));
    }

    /**
     * Builds the player source for this device's country (or the default):
     * {"playlistId": "..."} when a maintained public YouTube playlist is
     * configured — editable on YouTube without an app update — otherwise
     * {"videos": [...]} from the bundled list, shuffled per session.
     */
    private String loadSourceForCountry() {
        try {
            JSONObject root = new JSONObject(readAsset("playlists/playlists.json"));
            JSONObject countries = root.getJSONObject("countries");
            String preferred = Locale.getDefault().getCountry().toUpperCase(Locale.ROOT);
            String fallback = root.getString("default_country");
            JSONObject entry = pickCountryEntry(countries, preferred, fallback);
            JSONObject source = new JSONObject();
            String playlistId = entry.optString("playlist_id", "");
            if (!playlistId.isEmpty()) {
                source.put("playlistId", playlistId);
            } else {
                JSONArray videos = entry.optJSONArray("videos");
                List<String> ids = new ArrayList<>();
                if (videos != null) {
                    for (int i = 0; i < videos.length(); i++) {
                        ids.add(videos.getJSONObject(i).getString("id"));
                    }
                }
                Collections.shuffle(ids);
                source.put("videos", new JSONArray(ids));
            }
            return source.toString();
        } catch (Exception e) {
            return "{\"videos\":[]}";
        }
    }

    /** Prefer the device country; if missing or has no playlist/videos, use default. */
    private static JSONObject pickCountryEntry(
            JSONObject countries, String preferred, String fallback) throws Exception {
        if (countries.has(preferred) && hasPlayableContent(countries.getJSONObject(preferred))) {
            return countries.getJSONObject(preferred);
        }
        if (countries.has(fallback)) {
            return countries.getJSONObject(fallback);
        }
        // Last resort: first country that has anything playable.
        JSONArray names = countries.names();
        if (names != null) {
            for (int i = 0; i < names.length(); i++) {
                JSONObject entry = countries.getJSONObject(names.getString(i));
                if (hasPlayableContent(entry)) {
                    return entry;
                }
            }
        }
        return new JSONObject().put("playlist_id", "").put("videos", new JSONArray());
    }

    private static boolean hasPlayableContent(JSONObject entry) {
        if (!entry.optString("playlist_id", "").isEmpty()) {
            return true;
        }
        JSONArray videos = entry.optJSONArray("videos");
        return videos != null && videos.length() > 0;
    }

    private String readAsset(String name) {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(getAssets().open(name), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line).append('\n');
            }
        } catch (Exception e) {
            return "";
        }
        return sb.toString();
    }

    private final class Bridge {
        @JavascriptInterface
        public String getSourceJson() {
            return sourceJson;
        }

        /** Content clock advancing past ~1s means the actual video (not an ad)
         *  is playing, so the passive ad notice can come down. */
        @JavascriptInterface
        public void onContentProgress(double seconds) {
            if (seconds > 1.0) {
                runOnUiThread(() -> adNotice.setVisibility(View.GONE));
            }
        }

        @JavascriptInterface
        public void onVideoChanged() {
            showAdNotice();
        }

        @JavascriptInterface
        public void onAllVideosFailed() {
            runOnUiThread(() -> {
                adNotice.setVisibility(View.GONE);
                unavailableNotice.setVisibility(View.VISIBLE);
            });
        }
    }
}
