import UIKit

class AuthViewController: BaseViewController {
    private let emailTextField = AuthTextField(placeholder: "Email")
    private let passwordTextField = AuthTextField(placeholder: "Password", isSecureTextEntry: true)
    private let rootStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView())
}

extension AuthViewController {
    override func setupViews() {
        super.setupViews()
        [rootStackView].forEach {
            view.addSubview($0)
        }
        setupRootStackView()
    }

    private func setupRootStackView() {
        [emailTextField, passwordTextField].forEach {
            rootStackView.addArrangedSubview($0)
        }
    }
    override func setupConstraints() {
        let padding = 20.0

        rootStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.leading.trailing.equalToSuperview().inset(padding)
        }
    }
}
