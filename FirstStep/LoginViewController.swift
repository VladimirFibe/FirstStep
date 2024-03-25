import UIKit

class LoginViewController: BaseViewController {
    private let loginView = LoginView()
    private let signInButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Sign In"
        config.cornerStyle = .medium
        config.imagePadding = 8
        $0.configuration = config

        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
}

extension LoginViewController {
    @objc private func signInTapped(_ sender: UIButton) {
        print(#function)
    }
}

extension LoginViewController {
    override func setupViews() {
        super.setupViews()
        [loginView, signInButton].forEach { view.addSubview($0)}
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
    }

    override func setupConstraints() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, 
                                               multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter:
                                            loginView.trailingAnchor, multiplier: 2),

            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, 
                                              multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
}
