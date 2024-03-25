import UIKit

class LoginViewController: BaseViewController {
    private let loginView = LoginView()
}

extension LoginViewController {
    override func setupViews() {
        super.setupViews()
        view.addSubview(loginView)
    }

    override func setupConstraints() {
        loginView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
    }
}
