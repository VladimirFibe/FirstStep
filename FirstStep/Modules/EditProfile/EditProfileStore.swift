import Foundation

enum EditProfileEvent {
    case done
}

enum EditProfileAction {
    case fetch
    case updateUsername(String)
    case updateAvatarLink(String)
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
        case .updateUsername(let username):
            updateUsername(username)
        case .updateAvatarLink(let link):
            updateAvatar(link)
        }
    }

    private func fetchPerson() async throws {
        try await useCase.fetchPerson()
        sendEvent(.done)
    }

    private func updateUsername(_ username: String) {
        useCase.updateUsername(username)
    }

    private func updateAvatar(_ avatarLink: String) {
        useCase.updateAvatar(avatarLink)
    }
}
