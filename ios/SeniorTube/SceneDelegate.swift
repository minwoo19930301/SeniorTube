import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var playerViewController: PlayerViewController? {
        window?.rootViewController as? PlayerViewController
    }

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .black
        window.rootViewController = PlayerViewController()
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        playerViewController?.sceneDidBecomeActive()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        playerViewController?.sceneWillResignActive()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        playerViewController?.sceneWillResignActive()
    }
}
