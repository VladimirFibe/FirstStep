import Foundation

protocol ProfileStatusUseCaseProtocol {
    func updateStatus(_ status: Person.Status)
}

final class ProfileStatusUseCase: ProfileStatusUseCaseProtocol {
    private let apiService: ProfileStatusServiceProtocol

    init(apiService: ProfileStatusServiceProtocol) {
        self.apiService = apiService
    }

    func updateStatus(_ status: Person.Status) {
        apiService.updateStatus(status)
    }
}
