import Foundation

protocol ProfileStatusUseCaseProtocol {
    func updateStatus(statuses: [String], current: Int)
}

final class ProfileStatusUseCase: ProfileStatusUseCaseProtocol {
    func updateStatus(statuses: [String], current: Int) {
        apiService.updateStatus(statuses: statuses, current: current)
    }
    
    private let apiService: ProfileStatusServiceProtocol
    init(apiService: ProfileStatusServiceProtocol) {
        self.apiService = apiService
    }
}
