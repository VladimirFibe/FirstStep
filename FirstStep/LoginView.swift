import UIKit

final class LoginView: BaseView {
    private let usernameTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Username"
        return $0
    }(UITextField())
}
//MARK: - Setup views
extension LoginView {
    override func setupViews() {
        usernameTextField.delegate = self
        [usernameTextField].forEach {
            addSubview($0)
        }
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            usernameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: usernameTextField.trailingAnchor, multiplier: 1)

        ])
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        !(textField.text?.isEmpty ?? true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }
}
