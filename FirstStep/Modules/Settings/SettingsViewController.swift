import UIKit
import Firebase

class SettingsViewController: BaseTableViewController {
    struct Model {
        let close: Callback?
    }
    private var store: SettingsStore
    private let model: Model
    init(store: SettingsStore, model: Model) {
        self.store = store
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let userInfoCell = SettingsNameTableViewCell()
    private let footerLabel: UILabel = {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        $0.text = "FirsStep from FibeApp\nApp version \(appVersion)"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 60)))

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.sendAction(.fetch)
    }
}
//MARK: - Actions
extension SettingsViewController {
    @objc private func logoutTapped() {
        store.sendAction(.signOut)
    }
}

extension SettingsViewController {
    override func setupViews() {
        super.setupViews()

        let logout = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(logoutTapped))

        navigationItem.rightBarButtonItem = logout
        tableView.register(
            SettingsNameTableViewCell.self,
            forCellReuseIdentifier: SettingsNameTableViewCell.identifier
        )
        tableView.tableFooterView = footerLabel
        setupObservers()
    }

    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink {[weak self] event in
                guard let self else { return }
                switch event {

                case .done:
                    self.showUserInfo()
                case .signOut:
                    self.model.close?()
                }
            }.store(in: &bag)
    }

    private func showUserInfo() {
        if let person = FirebaseClient.shared.person {
            userInfoCell.configure(with: person)
        }
    }
}

extension SettingsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        userInfoCell
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EditProfileViewController(style: .grouped)
        navigationController?.pushViewController(controller, animated: true)
    }
}
