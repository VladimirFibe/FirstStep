import Foundation

protocol EditProfileUseCaseProtocol {
    func fetchPerson() async throws
}

final class EditProfileUseCase: EditProfileUseCaseProtocol {

    private let apiService: EditProfileServiceProtocol
    init(apiService: EditProfileServiceProtocol) {
        self.apiService = apiService
    }

    func fetchPerson() async throws {
        try await apiService.fetchPerson()
    }
}
