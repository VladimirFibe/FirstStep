import Foundation

enum EditProfileEvent {
    case done
}

enum EditProfileAction {
    case fetch
}

final class EditProfileStore: Store<EditProfileEvent, EditProfileAction> {
    private let useCase: EditProfileUseCase

    init(useCase: EditProfileUseCase) {
        self.useCase = useCase
    }

    override func handleActions(action: EditProfileAction) {
        switch action {
        case .fetch:
            statefulCall {
                weak var wSelf = self
                try await wSelf?.fetchPerson()
            }
        }
    }

    private func fetchPerson() async throws {
        try await useCase.fetchPerson()
        sendEvent(.done)
    }
}
