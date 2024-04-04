import Foundation

enum SettingsEvent {
    case done
    case signOut
}

enum SettingsAction {
    case fetch
    case signOut
}

final class SettingsStore: Store<SettingsEvent, SettingsAction> {
    private let useCase: SettingsUseCaseProtocol

    init(useCase: SettingsUseCaseProtocol) {
        self.useCase = useCase
    }

    override func handleActions(action: SettingsAction) {
        switch action {
        case .fetch:
            statefulCall {
                weak var wSelf = self
                try await wSelf?.fetchPerson()
            }
        case .signOut:
            statefulCall {
                weak var wSelf = self
                try wSelf?.signOut()
            }
        }
    }

    private func signOut() throws {
        try useCase.signOut()
        sendEvent(.signOut)
    }
    
    private func fetchPerson() async throws {
        try await useCase.fetch()
        sendEvent(.done)
    }
}
