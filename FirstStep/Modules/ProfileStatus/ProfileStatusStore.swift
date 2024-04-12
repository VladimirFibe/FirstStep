import Foundation

enum ProfileStatusEvent {
    case done
}

enum ProfileStatusAction {
    case updateStatus(Person.Status)
}

final class ProfileStatusStore: Store<ProfileStatusEvent, ProfileStatusAction> {
    private let useCase: ProfileStatusUseCaseProtocol

    init(useCase: ProfileStatusUseCaseProtocol) {
        self.useCase = useCase
    }

    override func handleActions(action: ProfileStatusAction) {
        switch action {
        case .updateStatus(let status):
            updateStatus(status)
        }
    }

    private func updateStatus(_ status: Person.Status) {
        useCase.updateStatus(status)
    }
}
