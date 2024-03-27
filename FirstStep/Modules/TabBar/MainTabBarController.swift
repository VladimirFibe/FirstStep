import UIKit

final class MainTabBarController: UITabBarController {
    struct Model {
        let close: Callback?
    }
    private var model: Model
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        view.backgroundColor = .systemBackground
        let chats = UINavigationController(rootViewController: ChatsTableViewController())
        let channels = UINavigationController(rootViewController: ChannelsViewController())
        let users = UINavigationController(rootViewController: UsersViewControlller())
        let controller = SettingsViewController()
        controller.action = model.close
        let settings = UINavigationController(rootViewController: controller)

        chats.tabBarItem = tabItem(for: .chats)
        channels.tabBarItem = tabItem(for: .channels)
        users.tabBarItem = tabItem(for: .users)
        settings.tabBarItem = tabItem(for: .settings)
        setViewControllers([chats, channels, users, settings], animated: true)
        selectedIndex = 0
    }

    private func tabItem(for tab: Tab) -> UITabBarItem {
        let item = UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.image),
            tag: tab.rawValue
        )
        return item
    }

    deinit {
        print("\(String(describing: self)) dealloc" )
    }
}
