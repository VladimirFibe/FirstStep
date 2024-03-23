import UIKit

class AuthViewController: BaseViewController {
    private var store: AuthStore
    private var isLogin = true { didSet { updateUI() }}

    struct Model {
        let close: Callback?
    }

    enum Flow {
        case login
        case register
        case forgot
    }

    init(store: AuthStore, model: Model) {
        self.store = store
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let model: Model
    private let emailTextField = AuthTextField(placeholder: "Email")
    private let passwordTextField = AuthTextField(placeholder: "Password", isSecureTextEntry: true)
    private let repeatTextField = AuthTextField(placeholder: "Repeat Password", isSecureTextEntry: true)
    private let forgotButton: UIButton = {
        $0.contentHorizontalAlignment = .leading
        $0.setTitle("Forgot Password?", for: [])
        return $0
    }(UIButton(type: .system))
    private let resendButton: UIButton = {
        $0.contentHorizontalAlignment = .trailing
        $0.isHidden = true
        $0.setTitle("Resend Email", for: [])
        return $0
    }(UIButton(type: .system))
    private let middleView = UIView()

    private let actionButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Login"
        config.cornerStyle = .medium
        $0.configuration = config
        return $0
    }(UIButton(type: .system))
    private let rootStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView())
    private let authStatusSwitch = AuthStatusSwitch()
}
// MARK: - Actions
extension AuthViewController {
    @objc private func authSwitchTapped() {
        print(#function)
        isLogin.toggle()
    }

    @objc private func actionButtonTapped() {
        print(#function)
        store.sendAction(.signOut)
    }

    @objc private func forgotButtonTapped() {
        print(#function)
    }

    @objc private func resendButtonTapped() {
        print(#function)
    }

    @objc private func backgroundTapped() {
        view.endEditing(false)
    }

    private func logout() {
        model.close?()
    }

}
// MARK: - Setup Views
extension AuthViewController {
    override func setupViews() {
        super.setupViews()
        [rootStackView, actionButton, authStatusSwitch].forEach {
            view.addSubview($0)
        }
        authStatusSwitch.configure(self, action: #selector(authSwitchTapped))
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .primaryActionTriggered)
        forgotButton.addTarget(self, action: #selector(forgotButtonTapped), for: .primaryActionTriggered)
        resendButton.addTarget(self, action: #selector(resendButtonTapped), for: .primaryActionTriggered)
        setupRootStackView()
        updateUI()
        setupObservers()
    }

    private func setupRootStackView() {
        [emailTextField, passwordTextField, repeatTextField, middleView].forEach {
            rootStackView.addArrangedSubview($0)
        }
        middleView.addSubview(forgotButton)
        middleView.addSubview(resendButton)
    }

    private func updateUI() {
        authStatusSwitch.configure(with: isLogin)
        actionButton.configuration?.title = isLogin ? "Login" : "Register"
        navigationItem.title = isLogin ? "Login" : "Register"
        UIView.animate(withDuration: 0.5) {
            self.repeatTextField.isHidden = self.isLogin
            self.repeatTextField.alpha = self.isLogin ? 0 : 1
            self.middleView.isHidden = !self.isLogin
            self.middleView.alpha = self.isLogin ? 1 : 0
        }
    }

    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .logout:
                    self.logout()
                }
            }.store(in: &bag)
    }

    override func setupConstraints() {
        let padding = 20.0

        rootStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.leading.trailing.equalToSuperview().inset(padding)
        }

        actionButton.snp.makeConstraints {
            $0.top.equalTo(rootStackView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.height.equalTo(50)
        }

        authStatusSwitch.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
        }

        forgotButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }

        resendButton.snp.makeConstraints {
            $0.top.bottom.equalTo(forgotButton)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(forgotButton.snp.trailing)
            $0.width.equalTo(forgotButton.snp.width)
        }
    }
}
