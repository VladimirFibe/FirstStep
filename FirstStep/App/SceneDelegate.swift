import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        start()
    }

    private func setRootViewController(_ controller: UIViewController, animated: Bool = true) {
        if animated, let window {
            window.rootViewController = controller
            window.makeKeyAndVisible()
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil)
        } else {
            window?.rootViewController = controller
            window?.makeKeyAndVisible()
        }
    }

    private func start() {
        if let currentUser = Auth.auth().currentUser, currentUser.isEmailVerified {
            Task {
                do {
                    try await FirebaseClient.shared.fetchPerson()
                } catch {}
            }
            let controller = makeMainTabBar()
            setRootViewController(controller)
        } else {
            let controller = makeAuth()
            setRootViewController(controller)
        }
    }

    private func makeOnboarding() -> UIViewController {
        let controller = OnboardingContainer()
        controller.action = { [weak self] in self?.start()}
        return controller
    }

    private func makeAuth() -> UIViewController {
        let useCase = AuthUseCase(apiService: FirebaseClient.shared)
        let store = AuthStore(useCase: useCase)
        let model = AuthViewController.Model(close: { [weak self] in self?.start() })
        return UINavigationController(rootViewController: AuthViewController(store: store, model: model))
    }

    private func makeMainTabBar() -> UIViewController {
        let model = MainTabBarController.Model(close: { [weak self] in self?.start() })
        let controller = MainTabBarController(model: model)
        return controller
    }
}

