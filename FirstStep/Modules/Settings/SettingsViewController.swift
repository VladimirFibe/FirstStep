import UIKit
import Firebase

class SettingsViewController: BaseTableViewController {
    var action: Callback?
    @objc private func logoutTapped() {
        do {
            try Auth.auth().signOut()
        } catch {}
        action?()
    }
}

extension SettingsViewController {
    override func setupViews() {
        super.setupViews()

        let logout = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(logoutTapped))

        navigationItem.rightBarButtonItem = logout
    }
}
