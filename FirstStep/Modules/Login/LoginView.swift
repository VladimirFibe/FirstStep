import UIKit

final class LoginView: BaseView {
    private let stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    private let usernameTextField: UITextField = {
        $0.placeholder = "Username"
        return $0
    }(UITextField())

    private let passwordTextField: UITextField = {
        $0.placeholder = "Password"
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())

    private let dividerView: UIView = {
        $0.backgroundColor = .secondarySystemFill
        return $0
    }(UIView())

    var username: String {
        usernameTextField.text ?? ""
    }

    var password: String {
        passwordTextField.text ?? ""
    }
}
//MARK: - Setup views
extension LoginView {
    override func setupViews() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubview(stackView)

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        [usernameTextField, dividerView, passwordTextField].forEach {
            stackView.addArrangedSubview($0)
        }
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        !(textField.text?.isEmpty ?? true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }
}
