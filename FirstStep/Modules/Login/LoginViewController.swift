import UIKit

class LoginViewController: BaseViewController {
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.text = "Bankey"
        return $0
    }(UILabel())
    private let subTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = "Your"
        return $0
    }(UILabel())
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
    private let errorMessageLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .systemRed
        $0.numberOfLines = 0
        $0.isHidden = true
        return $0
    }(UILabel())
}

extension LoginViewController {
    @objc private func signInTapped(_ sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }

    private func login() {
        if loginView.username.isEmpty || loginView.password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }

        if loginView.username == "Kevin" && loginView.password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }

    private func configureView(withMessage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
}

extension LoginViewController {
    override func setupViews() {
        super.setupViews()
        [titleLabel, subTitleLabel, loginView, signInButton, errorMessageLabel].forEach { view.addSubview($0)}
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
    }

    override func setupConstraints() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            titleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subTitleLabel.bottomAnchor, multiplier: 2),
            subTitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, 
                                               multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter:
                                            loginView.trailingAnchor, multiplier: 2),

            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, 
                                              multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),

            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
}
