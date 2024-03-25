import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        let useCase = AuthUseCase(apiService: FirebaseClient.shared)
//        let store = AuthStore(useCase: useCase)
//        let model = AuthViewController.Model(close: {
//            print("Close! Yess!!!")
//        })
//        let controller = AuthViewController(store: store, model: model)
        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        window?.makeKeyAndVisible()
    }
}

