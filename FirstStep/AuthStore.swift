import Foundation

enum AuthEvent {
    case logout
}

enum AuthAction {
    case signOut
}

final class AuthStore: Store<AuthEvent, AuthAction> {
    private let useCase: AuthUseCaseProtocol

    init(useCase: AuthUseCaseProtocol) {
        self.useCase = useCase
    }

    override func handleActions(action: AuthAction) {
        switch action {
        case .signOut:
            statefulCall { [weak self] in
                try await self?.signOut()
            }
        }
    }

    private func signOut() async throws {
        sendEvent(.logout)
    }
}
