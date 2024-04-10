import Foundation

protocol EditProfileUseCaseProtocol {
    func fetchPerson() async throws
    func updateUsername(_ username: String)
    func updateAvatar(_ avatarLink: String)
}

final class EditProfileUseCase: EditProfileUseCaseProtocol {

    private let apiService: EditProfileServiceProtocol
    init(apiService: EditProfileServiceProtocol) {
        self.apiService = apiService
    }

    func fetchPerson() async throws {
        try await apiService.fetchPerson()
    }

    func updateUsername(_ username: String) {
        apiService.updateUsername(username)
    }

    func updateAvatar(_ avatarLink: String) {
        apiService.updateAvatar(avatarLink)
    }
}
