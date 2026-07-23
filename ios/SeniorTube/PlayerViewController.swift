import UIKit
import WebKit

final class PlayerViewController: UIViewController {
    private enum PlayerEvent: String {
        case allVideosFailed
    }

    private var playerWebView: WKWebView?
    private var sessionIsRunning = false
    private var sceneIsActive = false

    private lazy var unavailableNotice = makeNoticeLabel(
        text: NSLocalizedString(
            "unavailable",
            comment: "Shown when no videos can be played"
        ),
        fontSize: 28
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        installUnavailableNotice()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .landscapeRight
    }

    override var prefersStatusBarHidden: Bool {
        true
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        true
    }

    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        .all
    }

    func sceneDidBecomeActive() {
        sceneIsActive = true
        startFreshSession()
    }

    func sceneWillResignActive() {
        sceneIsActive = false
        endSession()
    }

    private func startFreshSession() {
        loadViewIfNeeded()
        guard !sessionIsRunning else {
            return
        }

        unavailableNotice.isHidden = true
        guard let html = makePlayerHTML() else {
            unavailableNotice.isHidden = false
            return
        }

        let configuration = makeWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false

        view.insertSubview(webView, at: 0)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        playerWebView = webView
        sessionIsRunning = true
        UIApplication.shared.isIdleTimerDisabled = true

        webView.loadHTMLString(html, baseURL: applicationOrigin)
    }

    private func endSession() {
        guard sessionIsRunning || playerWebView != nil else {
            return
        }

        sessionIsRunning = false
        UIApplication.shared.isIdleTimerDisabled = false

        playerWebView?.evaluateJavaScript(
            "if (window.SeniorTubeStop) { window.SeniorTubeStop(); }"
        )
        playerWebView?.stopLoading()
        playerWebView?.navigationDelegate = nil
        playerWebView?.uiDelegate = nil
        playerWebView?.removeFromSuperview()
        playerWebView = nil
    }

    private var applicationOrigin: URL {
        let identifier = Bundle.main.bundleIdentifier?
            .lowercased() ?? "org.seniortube.app"
        return URL(string: "https://\(identifier)")!
    }

    private func makePlayerHTML() -> String? {
        guard
            let htmlURL = Bundle.main.url(
                forResource: "player-ios",
                withExtension: "html"
            ),
            let catalogURL = Bundle.main.url(
                forResource: "playlists",
                withExtension: "json"
            ),
            let template = try? String(contentsOf: htmlURL, encoding: .utf8),
            let catalogData = try? Data(contentsOf: catalogURL),
            let sourceJSON = try? PlaylistSourceBuilder.makeSourceJSON(
                catalogData: catalogData,
                regionCode: Locale.current.regionCode
            ),
            let originData = try? JSONEncoder().encode(
                applicationOrigin.absoluteString
            )
        else {
            return nil
        }

        let originJSON = String(decoding: originData, as: UTF8.self)
        return template
            .replacingOccurrences(of: "__SOURCE_JSON__", with: sourceJSON)
            .replacingOccurrences(of: "__APP_ORIGIN_JSON__", with: originJSON)
    }

    private func makeWebViewConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.allowsPictureInPictureMediaPlayback = false
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.websiteDataStore = .nonPersistent()
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.userContentController.add(
            WeakScriptMessageHandler(delegate: self),
            name: "SeniorTube"
        )
        return configuration
    }

    private func installUnavailableNotice() {
        view.addSubview(unavailableNotice)
        NSLayoutConstraint.activate([
            unavailableNotice.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            unavailableNotice.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            unavailableNotice.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 24
            ),
            unavailableNotice.trailingAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -24
            ),
        ])
        unavailableNotice.isHidden = true
    }

    private func makeNoticeLabel(text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.black.withAlphaComponent(0.82)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.text = "  \(text)  "
        label.textColor = .white
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        label.accessibilityLabel = text
        return label
    }

    private func handlePlayerEvent(_ event: PlayerEvent) {
        switch event {
        case .allVideosFailed:
            endSession()
            unavailableNotice.isHidden = false
        }
    }

    private func openOutsidePlayer(_ url: URL) {
        endSession()
        UIApplication.shared.open(url, options: [:]) { [weak self] didOpen in
            guard !didOpen, self?.sceneIsActive == true else {
                return
            }
            self?.startFreshSession()
        }
    }
}

extension PlayerViewController: WKScriptMessageHandler {
    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        guard
            message.name == "SeniorTube",
            let body = message.body as? [String: Any],
            let eventName = body["event"] as? String,
            let event = PlayerEvent(rawValue: eventName)
        else {
            return
        }
        handlePlayerEvent(event)
    }
}

extension PlayerViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }

        let targetIsMainFrame = navigationAction.targetFrame?.isMainFrame == true
        let isNewWindow = navigationAction.targetFrame == nil
        let isApplicationPage =
            url.scheme == "about"
            || (
                url.scheme?.lowercased() == "https"
                && url.host?.lowercased() == applicationOrigin.host
            )

        if targetIsMainFrame && isApplicationPage {
            decisionHandler(.allow)
            return
        }

        // YouTube's player needs its own subframe redirects, scripts and ads.
        // A user-selected link must remain functional, so it leaves the
        // embedded player through the YouTube app or the system browser.
        let isUserLink = navigationAction.navigationType == .linkActivated
        if isNewWindow || targetIsMainFrame || isUserLink {
            decisionHandler(.cancel)
            if ["http", "https", "youtube"].contains(url.scheme?.lowercased() ?? "") {
                DispatchQueue.main.async { [weak self] in
                    self?.openOutsidePlayer(url)
                }
            }
            return
        }

        let allowedSubframeSchemes = ["http", "https", "about", "data", "blob"]
        if allowedSubframeSchemes.contains(url.scheme?.lowercased() ?? "") {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
        }
    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        endSession()
        guard sceneIsActive else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.startFreshSession()
        }
    }
}

extension PlayerViewController: WKUIDelegate {
    func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        // New-window requests are handled by decidePolicyFor and never become
        // an uncontained in-app browser.
        nil
    }
}

private final class WeakScriptMessageHandler: NSObject, WKScriptMessageHandler {
    private weak var delegate: WKScriptMessageHandler?

    init(delegate: WKScriptMessageHandler) {
        self.delegate = delegate
        super.init()
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        delegate?.userContentController(
            userContentController,
            didReceive: message
        )
    }
}
