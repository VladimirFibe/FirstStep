import Foundation

enum ProfileStatusEvent {
    case done
}

enum ProfileStatusAction {
    case update([String], Int)
}

final class ProfileStatusStore: Store<ProfileStatusEvent, ProfileStatusAction> {
    private let useCase: ProfileStatusUseCaseProtocol

    init(useCase: ProfileStatusUseCaseProtocol) {
        self.useCase = useCase
    }

    override func handleActions(action: ProfileStatusAction) {
        switch action {
        case .update(let statuses, let current):
            updateStatus(statuses: statuses, current: current)
        }
    }

    private func updateStatus(statuses: [String], current: Int) {
        useCase.updateStatus(statuses: statuses, current: current)
    }
}
