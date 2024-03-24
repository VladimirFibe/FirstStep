import Foundation

enum AuthEvent {
    case logout
}

enum AuthAction {
    case createUser(String, String)
    case signIn(String, String)
    case sendPasswordReset(String)
    case signOut
}

final class AuthStore: Store<AuthEvent, AuthAction> {
    private let useCase: AuthUseCaseProtocol

    init(useCase: AuthUseCaseProtocol) {
        self.useCase = useCase
    }

    override func handleActions(action: AuthAction) {
        switch action {
        case .createUser(let email, let password):
            statefulCall { [weak self] in
                try await self?.register(
                    withEmail: email,
                    password: password
                )
            }
        case .signIn(let email, let password):
            statefulCall { [weak self] in
                do {
                    try await self?.signIn(withEmail: email, password: password)
                    print("DEBUG: ", email, "Successfull")
                } catch {
                    print("DEBUG: ", error.localizedDescription)
                }
            }
        case .sendPasswordReset(let email):
            statefulCall { [weak self] in
                try await self?.sendPasswordReset(withEmail: email)
            }

        case .signOut: signOut()
        }
    }

    private func register(withEmail email: String, password: String) async throws {
        try await useCase.createUser(withEmail: email, password: password)
//        sendEvent(.registered)
    }

    private func signIn(withEmail email: String, password: String) async throws {
        let response = try await useCase.signIn(withEmail: email, password: password)
        try checkResponse(response)
    }

    private func sendPasswordReset(withEmail email: String) async throws {
        try await useCase.sendPasswordReset(withEmail: email)
//        sendEvent(.linkSended)
    }

    private func emailVerification() throws {
        guard let response = useCase.isEmailVerified else { return }
        try checkResponse(response)
    }

    private func checkResponse(_ response: Bool) throws {
        if response {
//            sendEvent(.emailVerified)
        } else {
            signOut()
//            sendEvent(.notVerified)
        }
    }

    private func signOut() {
        do {
            try useCase.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
